-- What month did I have the best average readiness score? The worst?

SELECT 
	EXTRACT (month FROM day) AS month, 
	ROUND(AVG(readiness_score),2) AS avg_readiness_score,
	ROUND(STDDEV(readiness_score),2) AS std_readiness_score
FROM
	(SELECT 
		r.day, 
		r.score AS readiness_score, 
		s.score AS sleep_score
	FROM daily_readiness_data r
	JOIN daily_sleep_data s ON r.day = s.day) AS joined_data
GROUP BY month
ORDER BY avg_readiness_score DESC;

"month"	"avg_readiness_score"	"std_readiness_score"
3	84.19	4.72
10	83.62	3.97
11	83.40	3.51
12	83.00	4.76
7	82.37	3.57
5	81.13	8.19
8	80.29	4.91
4	80.18	5.44
1	79.48	6.38
9	78.73	4.11
2	76.41	4.72
6	75.83	6.77

-- What month did I have the best average sleep score? The worst?

SELECT 
	EXTRACT (month FROM day) AS month, 
	ROUND(AVG(sleep_score),2) AS avg_sleep_score,
	ROUND(STDDEV(sleep_score),2) AS std_sleep_score
FROM
	(SELECT 
		r.day, 
		r.score AS readiness_score, 
		s.score AS sleep_score
	FROM daily_readiness_data r
	JOIN daily_sleep_data s ON r.day = s.day) AS joined_data
GROUP BY month
ORDER BY avg_sleep_score DESC;

"month"	"avg_sleep_score"	"std_sleep_score"
6	71.50	6.97
8	70.84	4.79
5	70.77	8.34
3	70.35	4.97
7	69.77	4.60
4	69.15	4.72
2	68.93	7.01
10	68.55	5.25
11	68.23	4.61
1	67.90	6.55
9	67.83	5.90
12	67.55	5.64

/* My best average readiness score was in March and the other top scores were in the fall months. My worst score was in June. My best average sleep score was in June and the other top scores were around the Spring/Summer. My worst score was in December.
Very interesting that my sleep and readiness scores seem to be inversely correlated with each other. The months with the best average readiness scores had the worst average sleep scores for the most part. Part of this could be that
my readiness scores were boosted when I first got my Oura ring which was in October 2023. Another reason might be that I exert less energy in the winter, so I need less sleep to be ready for the day. I'll see if this trend continues the following year. */


-- What day of the week do I get the best sleep? 
  
-- Best Score? The worst?

SELECT 
    CASE 
	-- Lag each day since sleep score is based on day you wake up. Want to see which nights give me best sleep
        WHEN EXTRACT(DOW FROM day) = 1 THEN 'Sunday'
        WHEN EXTRACT(DOW FROM day) = 2 THEN 'Monday'
        WHEN EXTRACT(DOW FROM day) = 3 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM day) = 4 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM day) = 5 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM day) = 6 THEN 'Friday'
        WHEN EXTRACT(DOW FROM day) = 0 THEN 'Saturday'
    END AS day_of_week,
    ROUND(AVG(sleep_score), 2) AS avg_sleep_score,
    ROUND(STDDEV(sleep_score), 2) AS std_sleep_score,
	ROUND(AVG(readiness_score),2) AS avg_readiness_score,
	ROUND(STDDEV(readiness_score),2) AS std_readiness_score
FROM
    (SELECT 
        r.day, 
        r.score AS readiness_score, 
        s.score AS sleep_score
    FROM daily_readiness_data r
    JOIN daily_sleep_data s ON r.day = s.day) AS joined_data
GROUP BY day_of_week
ORDER BY avg_sleep_score DESC;

"day_of_week"	"avg_sleep_score"	"std_sleep_score"	"avg_readiness_score"	"std_readiness_score"
"Tuesday"	70.56	5.63	81.29	4.77
"Monday"	70.54	4.88	81.79	5.44
"Saturday"	69.89	6.51	79.89	6.69
"Wednesday"	69.17	5.55	81.44	5.18
"Thursday"	68.67	5.82	80.50	6.30
"Friday"	68.20	5.00	79.37	6.14
"Sunday"	67.92	7.46	80.87	5.91

-- Longest duration?

SELECT
	CASE
	WHEN EXTRACT(DOW FROM day) = 1 THEN 'Sunday'
        WHEN EXTRACT(DOW FROM day) = 2 THEN 'Monday'
        WHEN EXTRACT(DOW FROM day) = 3 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM day) = 4 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM day) = 5 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM day) = 6 THEN 'Friday'
        WHEN EXTRACT(DOW FROM day) = 0 THEN 'Saturday'
    END AS day_of_week,
	ROUND(AVG(total_sleep),2) AS avg_total,
	ROUND(AVG(deep_sleep),2) AS avg_deep,
	ROUND(AVG(rem_sleep),2) AS avg_rem
FROM
(SELECT 
	day, 
	CAST(total_sleep_duration AS numeric)/3600 AS total_sleep, 
	CAST(deep_sleep_duration AS numeric)/3600 AS deep_sleep,
	CAST(rem_sleep_duration AS numeric)/3600 AS rem_sleep
FROM sleep_data
WHERE type = 'long_sleep') AS sleep_types
GROUP BY day_of_week
ORDER BY avg_total DESC;

"day_of_week"	"avg_total"	"avg_deep"	"avg_rem"
"Wednesday"	7.42	1.07	1.46
"Saturday"	7.37	1.26	1.46
"Monday"	7.32	1.18	1.39
"Tuesday"	7.27	1.23	1.39
"Thursday"	7.21	1.22	1.39
"Friday"	7.19	1.22	1.37
"Sunday"	7.03	1.15	1.33

/* I score best at the beginning of the work week as Tuesday and Mondays are my two highest average scores. I have the worst sleep on average on Sunday night which is something I need to work on as I'd like to start my weeks with the best sleep. The readiness
scores don't seem to have any correlation either way with the sleep scores interestingly. 

I get the longest sleep on Wednesday night on average and lowest on Sunday. Very interesting is that although I have my longest sleep on Wednesday I have my shortest amount of deep sleep which most likely factors into why it isn't the day with my highest sleep score. I
tend to exercise less often on Wednesdays so perhaps that's why. 

My goal is to have everyday of the week to have a similar average, so I need to make an extra effort to get good sleep on Sunday and Friday where my average scores are lowest. */


-- What sleep factors do I normally score highest on? Lowest?

WITH contributors_list AS (
    SELECT contributor, 
           CASE 
               WHEN contributor = 'sleep_score' THEN score::TEXT
               ELSE contributors->>contributor 
           END AS value
    FROM daily_sleep_data,
    UNNEST(ARRAY['deep_sleep', 'efficiency', 'latency', 'restfulness', 
                  'rem_sleep', 'total_sleep', 'timing', 'sleep_score']) AS contributor
)
SELECT 
    contributor,
    ROUND(AVG(value::INTEGER), 2) AS avg,
    ROUND(MIN(value::INTEGER), 2) AS min,
    ROUND(MAX(value::INTEGER), 2) AS max
FROM contributors_list
GROUP BY contributor;

"contributor"	"avg"	"min"	"max"
"latency"	84.39	22.00	99.00
"timing"	56.72	1.00	100.00
"deep_sleep"	66.73	21.00	98.00
"rem_sleep"	66.74	28.00	97.00
"efficiency"	80.23	46.00	96.00
"total_sleep"	73.86	31.00	96.00
"sleep_score"	69.28	44.00	85.00
"restfulness"	53.07	21.00	82.00

/* My highest average on sleep contributors is latency and efficiency. Timing and restfulness are the lowest. My max restfulness was only 82 while every other contributor has maxes of 95+, so restfulness seems like the clear biggest issue.
I've achieved scores of 95 or higher on every contributor, so if I can can improve my restfulness,  it is possible for me to achieve a 95+ sleep score. */

  
-- What sleep contributors do I struggle with the most?

WITH contributors_list AS (
    SELECT contributor, 
           CAST(contributors->>contributor AS INTEGER) AS value
    FROM daily_sleep_data,
    UNNEST(ARRAY['deep_sleep', 'efficiency', 'latency', 'restfulness', 'rem_sleep', 
                  'total_sleep', 'timing']) AS contributor
)
SELECT 
    contributor,
    -- Create bins with a length of 20 for each contributor
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_0_to_20,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_21_to_40,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_41_to_60,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 4 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_61_to_80,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_81_to_100
FROM contributors_list
GROUP BY contributor;

"contributor"	"score_0_to_20"	"score_21_to_40"	"score_41_to_60"	"score_61_to_80"	"score_81_to_100"
"latency"	0.00	0.55	3.85	21.43	74.18
"timing"	4.67	20.05	30.22	29.40	15.66
"deep_sleep"	0.00	8.52	27.47	38.74	25.27
"rem_sleep"	0.00	3.85	31.04	45.33	19.78
"efficiency"	0.00	0.00	1.92	43.13	54.95
"total_sleep"	0.00	0.55	6.59	73.08	19.78
"restfulness"	0.00	15.93	58.52	25.27	0.27

/* From this I can see that total sleep, efficiency, and latency are not the main problems as more than 90% of their values fall into the 4th and 5th quintiles. Timing and restfulness are the biggest issue as less than 50% of the values fall
into the 4th and 5th quintile and also timing is the only contributor that appears in the 1st quintile with about 5% of its values being there. None of the contributors appear in the 5th quintile more than 80% of the time which shows I still need
to get better with everything */


-- What readiness factors do I normally score highest on? Lowest?

WITH contributors_list AS (
    SELECT contributor, 
           CASE 
               WHEN contributor = 'readiness_score' THEN score::TEXT
               ELSE contributors->>contributor 
           END AS value
    FROM daily_readiness_data,
    UNNEST(ARRAY['hrv_balance', 'sleep_balance', 'previous_night', 'recovery_index', 
                  'activity_balance', 'body_temperature', 'resting_heart_rate', 
                  'previous_day_activity', 'readiness_score']) AS contributor
)
SELECT 
    contributor,
    ROUND(AVG(value::INTEGER), 2) AS avg,
    ROUND(MIN(value::INTEGER), 2) AS min,
    ROUND(MAX(value::INTEGER), 2) AS max
FROM contributors_list
GROUP BY contributor;

"contributor"	"avg"	"min"	"max"
"previous_day_activity"	79.57	1.00	99.00
"activity_balance"	82.69	44.00	100.00
"hrv_balance"	79.12	1.00	100.00
"recovery_index"	91.75	1.00	100.00
"previous_night"	69.71	39.00	92.00
"sleep_balance"	76.81	47.00	98.00
"body_temperature"	97.57	66.00	100.00
"readiness_score"	80.76	56.00	91.00
"resting_heart_rate"	85.00	10.00	100.00

/* At first glance my readiness factors are much better than those of my sleep data. Every average is above 75 other than previous night sleep, and all of them have maxes of 92, meaning it is possible for me to get consistent readiness scores in
the high 90s if I put everything together. My lowest contributor is previous night at 69.87 and highest is body temperature at 97.56 */


-- What readiness contributors do I struggle with the most?
  
WITH contributors_list AS (
    SELECT contributor, 
           CAST(contributors->>contributor AS INTEGER) AS value
    FROM daily_readiness_data,
    UNNEST(ARRAY['hrv_balance', 'sleep_balance', 'previous_night', 'recovery_index', 
                  'activity_balance', 'body_temperature', 'resting_heart_rate', 
                  'previous_day_activity'
]) AS contributor
)
SELECT 
    contributor,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_0_to_20,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_21_to_40,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_41_to_60,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 4 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_61_to_80,
    ROUND(SUM(CASE WHEN WIDTH_BUCKET(value, 0, 101, 5) = 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS score_81_to_100
FROM contributors_list
GROUP BY contributor;

/* There isn't any clear readiness contributor that I struggle with the most. Every single one has at least 80% of their values in the 4th and 5th quintile. HRV_balance has about 18% of its values in the lower three quintiles so there is area for
improvement there. Also, my sleep related factors (sleep balance and previous night) are the only two factors without 60% of their values in the 5th quintile. The only way to improve those factors is to improve my sleep which I can do my addressing the
findings from my other queries */


-- What is sleep like after high activity?

WITH joined_data AS (SELECT 
	a.day, 
	a.score AS activity_score, 
	a.active_calories, 
	LEAD(s.score,1) OVER(ORDER BY a.day) AS sleep_score
FROM daily_activity_data a
LEFT JOIN daily_sleep_data s ON a.day = s.day)

SELECT
	ROUND(AVG(sleep_score),2) AS avg_score,
	ROUND(STDDEV(sleep_score),2) AS std_score
FROM joined_data

UNION

SELECT 
	ROUND(AVG(sleep_score),2) AS avg_score,
	ROUND(STDDEV(sleep_score),2) AS std_score
FROM joined_data
-- setting 850 as my threshold for high activity
WHERE active_calories > 850

"avg_score"	"std_score"
69.26	5.96
71.28	6.54

/* I do seem to sleep slightly better when I have a day where I exert high activity. Being more highly active might help me
sleep better */


-- What is my average sleep the day after a good sleep score? The day after a bad one?

SELECT 
  -- Setting 70 as my threshold for good sleep
	CASE WHEN score >= 70 THEN 'good_sleep' ELSE 'bad_sleep' END AS sleep_quality, 
	ROUND(AVG(score_next_day),2) AS avg_score,
	ROUND(STDDEV(score_next_day),2) AS std_score
FROM(
SELECT 
	score, 
	LEAD(score,1) OVER(ORDER BY day) AS score_next_day
FROM daily_sleep_data) AS day_after
GROUP BY sleep_quality;

"sleep_quality"	"avg_score"	"std_score"
"good_sleep"	70.01	5.34
"bad_sleep"	68.55	6.47

/* It seems that I marginally sleep better on average the next day when I have sleep score of over 70, but not enough
of a difference to draw conclusions */


-- What percent of the time do I get good sleeep after a good sleep score?

SELECT 
    CASE WHEN score >= 70 THEN 'good_sleep' ELSE 'bad_sleep' END AS sleep_quality, 
    ROUND((COUNT(*) FILTER (WHERE score_next_day >= 70) * 100.0) / COUNT(*),2) AS percent_good_next_day
FROM (
    SELECT
        day,
        score, 
        LEAD(score, 1) OVER(ORDER BY day) AS score_next_day
    FROM daily_sleep_data
) AS day_after
GROUP BY sleep_quality;

"sleep_quality"	"percent_good_next_day"
"good_sleep"	55.14
"bad_sleep"	46.37

/* I get a good sleep score 55% of the time the day after a good sleep score and 45% of the time after a bad sleep score.
Same as the last in that there's not much of a difference. These numbers both need to be much higher */


-- Longest streak of good sleep scores?

WITH streaks AS (
    SELECT
        day,
        score,
        CASE 
            WHEN score >= 70 THEN 1 
            ELSE 0 
        END AS is_good_sleep,
        ROW_NUMBER() OVER (ORDER BY day) - 
        ROW_NUMBER() OVER (PARTITION BY CASE WHEN score >= 70 THEN 1 ELSE 0 END ORDER BY day) AS streak_group
    FROM daily_sleep_data
)
SELECT 
streak_length
FROM (
    SELECT 
        streak_group,
        COUNT(*) AS streak_length
    FROM streaks
    WHERE is_good_sleep = 1 
    GROUP BY streak_group
) AS streak_lengths
WHERE streak_length >= 5
ORDER BY streak_length DESC;

"streak_length"
11
7
6
6
5
5
5
5

/* My longest streak was 11 and I've had 8 streaks of 5+ days */


-- Longest streak of good readiness scores?

WITH streaks AS (
    SELECT
        day,
        score,
        CASE 
            WHEN score >= 85 THEN 1 
            ELSE 0 
        END AS is_good_readiness,
        ROW_NUMBER() OVER (ORDER BY day) - 
        ROW_NUMBER() OVER (PARTITION BY CASE WHEN score >= 85 THEN 1 ELSE 0 END ORDER BY day) AS streak_group
    FROM daily_readiness_data
)
SELECT 
streak_length
FROM (
    SELECT 
        streak_group,
        COUNT(*) AS streak_length
    FROM streaks
    WHERE is_good_readiness = 1 
    GROUP BY streak_group
) AS streak_lengths
WHERE streak_length >= 5
ORDER BY streak_length DESC;

"streak_length"
9
8
7
6
6
6

/* My longest streak was 9 and I've had 6 streaks of 5+ days */


-- Average time I go to sleep and wake up at?

SELECT
  -- Need to subtract 12 for the average calculation to work correctly
  AVG(CAST(bedtime_start AS TIME) - INTERVAL '12 hours') AS bedtime_start,
  AVG(CAST(bedtime_end AS TIME)) AS bedtime_end
FROM sleep_data
WHERE total_sleep_duration > 10000;

"bedtime_start"	"bedtime_end"
"12:13:44.316804"	"08:54:32.278237"

/* On average I go to sleep at 12:14 and wake up at 8:54 */


-- Sleep Score based on what time I went to bed?

SELECT
  EXTRACT(HOUR FROM bedtime_start) AS bedtime_hour,
  COUNT(*) AS count,
  AVG(CAST(bedtime_end AS TIME)) AS bedtime_end,
  ROUND(AVG(score),2) AS avg_sleep_score,
  ROUND(STDDEV(score),2) AS std_sleep_score,
  ROUND(AVG(total_sleep_duration/3600),2) AS avg_duration
FROM sleep_data s1
LEFT JOIN daily_sleep_data s2 ON s1.day = s2.day
WHERE total_sleep_duration > 10000
GROUP BY bedtime_hour
ORDER BY avg_sleep_score DESC;

"bedtime_hour"	"count"	"bedtime_end"	"avg_sleep_score"	"std_sleep_score"	"avg_duration"
22	28	"07:49:39.964286"	75.39	5.70	7.14
23	114	"08:24:56.938596"	71.46	5.01	6.91
0	161	"09:07:16.15528"	68.59	4.88	6.75
1	49	"09:33:21.122449"	64.61	5.73	6.41
2	9	"10:05:57.333333"	63.67	6.00	6.22
3	4	"11:30:38.5"	61.25	7.76	6.25

/* This is some very interesting data. For one I'm surprised that I only went to sleep after 2am a total of 13 times. I don't want to go to sleep later than 1 at all, but that used to be a bigger issue for me, so I'm proud of this information.

It’s clear that the earlier I go to sleep, the better the sleep score on average. The difference between each of the hours is about 4 points until after 1am where there isn't much difference. Which shows that just 1 hour can make a big difference in my sleep.

What's really interesting is my duration also increases the earlier I go to sleep. The sleep score was already going to be higher due to scoring better with the timing contributor, but it's very interesting that I'm sleeping longer on average too. Really shows that
I need to go to sleep earlier. */


