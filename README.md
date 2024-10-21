# Oura-Ring

## Introduction:
The Oura ring is one of the leading fitness trackers for monitoring sleep, utilizing sensors to measure metrics such as heart rate variability (HRV), respiratory rate, and body temperature. I began using my Oura ring in October 2023 to improve my sleep quality and gain a better understanding of my sleep patterns.

While the ring provides helpful day-to-day feedback, I wanted to apply my data analytics skills to discover deeper trends and patterns within my sleep data from the past year. This analysis will guide me in making informed changes to improve my overall sleep performance.


## Objective:
Find trends and patterns from my sleep over the past year, and then make actionable changes based on any weaknesses I found.

## Data Collection:
Using a jupyter notebook, I extracted the data using my Oura Ring API key, and ended up with four CSV files:

- Daily_sleep_data
- Daily_readiness_data
- Daily_activity_data
- Sleep_data

Daily_sleep_data contains data of the sleep score and sleep contributors for each day. Daily_readiness_data is the same thing except readiness score and readiness contributors. Daily_activity_data contains data on various activity metrics for each day, and Sleep_data contains sleep metrics for each day.

I got the code for extracting the API data from [this repository](https://github.com/crystoll/oura-ring). 


## Questions and Results:

Check out the code and analysis for each query [here](https://github.com/msternbach/Oura-Ring/blob/main/Oura_ring.sql).

### When did I Sleep the Best:

#### What month did I have the best average readiness score? The worst?

| Month | Avg Readiness Score | Std Readiness Score |
|-------|---------------------|---------------------|
| 3     | 84.19               | 4.72                |
| 10    | 83.62               | 3.97                |
| 11    | 83.40               | 3.51                |
| 12    | 83.00               | 4.76                |
| 7     | 82.37               | 3.57                |
| 5     | 81.13               | 8.19                |
| 8     | 80.29               | 4.91                |
| 4     | 80.18               | 5.44                |
| 1     | 79.48               | 6.38                |
| 9     | 78.73               | 4.11                |
| 2     | 76.41               | 4.72                |
| 6     | 75.83               | 6.77                |

My best average readiness score was in March and the other top scores were in the fall months. My worst score was in June. 

#### What month did I have the best average sleep score? The worst?
| Month | Avg Sleep Score | Std Sleep Score |
|-------|-----------------|-----------------|
| 6     | 71.50           | 6.97            |
| 8     | 70.84           | 4.79            |
| 5     | 70.77           | 8.34            |
| 3     | 70.35           | 4.97            |
| 7     | 69.77           | 4.60            |
| 4     | 69.15           | 4.72            |
| 2     | 68.93           | 7.01            |
| 10    | 68.55           | 5.25            |
| 11    | 68.23           | 4.61            |
| 1     | 67.90           | 6.55            |
| 9     | 67.83           | 5.90            |
| 12    | 67.55           | 5.64            |

My best average sleep score was in June and the other top scores were around the Spring/Summer. My worst score was in December.
Very interesting that my sleep and readiness scores seem to be inversely correlated with each other. The months with the best average readiness scores had the worst average sleep scores for the most part. Part of this could be that
my readiness scores were boosted when I first got my Oura ring which was in October 2023. Another reason might be that I exert less energy in the winter, so I need less sleep to be ready for the day. I'll see if this trend continues the following year.


#### What day of the week do I get the best sleep? 
| Day of Week | Avg Sleep Score | Std Sleep Score | Avg Readiness Score | Std Readiness Score |
|-------------|-----------------|-----------------|---------------------|---------------------|
| Tuesday     | 70.56           | 5.63            | 81.29               | 4.77                |
| Monday      | 70.54           | 4.88            | 81.79               | 5.44                |
| Saturday    | 69.89           | 6.51            | 79.89               | 6.69                |
| Wednesday   | 69.17           | 5.55            | 81.44               | 5.18                |
| Thursday    | 68.67           | 5.82            | 80.50               | 6.30                |
| Friday      | 68.20           | 5.00            | 79.37               | 6.14                |
| Sunday      | 67.92           | 7.46            | 80.87               | 5.91                |

I score best at the beginning of the work week as Tuesday and Mondays are my two highest average scores. I have the worst sleep on average on Sunday night which is something I need to work on as I'd like to start my weeks with the best sleep. The readiness
scores don't seem to have any correlation either way with the sleep scores interestingly. My goal is to have everyday of the week to have a similar average, so I need to make an extra effort to get good sleep on Sunday and Friday where my average scores are lowest.

### What Contributors Affected my Sleep the Most:


#### What sleep factors do I normally score highest on? Lowest?
| Contributor     | Avg   | Min  | Max  |
|-----------------|-------|------|------|
| Latency         | 84.39 | 22.00| 99.00|
| Efficiency      | 80.23 | 46.00| 96.00|
| Total Sleep     | 73.86 | 31.00| 96.00|
| Sleep Score     | 69.28 | 44.00| 85.00|
| REM Sleep       | 66.74 | 28.00| 97.00|
| Deep Sleep      | 66.73 | 21.00| 98.00|
| Timing          | 56.72 | 1.00 | 100.00|
| Restfulness     | 53.07 | 21.00| 82.00|

My highest average on sleep contributors is latency and efficiency. Timing and restfulness are the lowest. My max restfulness was only 82 while every other contributor has maxes of 95+, so restfulness seems like the clear biggest issue.
I've achieved scores of 95 or higher on every contributor, so if I can can improve my restfulness, it is possible for me to achieve a 95+ sleep score.

#### What sleep contributors do I struggle with consistently?
| Contributor    |Percent Score 0-20 | Percent Score 21-40 | Percent Score 41-60 | Percent Score 61-80 | Percent Score 81-100 |
|----------------|------------|-------------|-------------|-------------|--------------|
| Latency        | 0.00       | 0.55        | 3.85        | 21.43       | 74.18        |
| Timing         | 4.67       | 20.05       | 30.22       | 29.40       | 15.66        |
| Deep Sleep     | 0.00       | 8.52        | 27.47       | 38.74       | 25.27        |
| REM Sleep      | 0.00       | 3.85        | 31.04       | 45.33       | 19.78        |
| Efficiency     | 0.00       | 0.00        | 1.92        | 43.13       | 54.95        |
| Total Sleep    | 0.00       | 0.55        | 6.59        | 73.08       | 19.78        |
| Restfulness    | 0.00       | 15.93       | 58.52       | 25.27       | 0.27         |

Total sleep, efficiency, and latency are not the main problems as more than 90% of their values fall into the 4th and 5th quintiles. Timing and restfulness are the biggest issue as less than 50% of the values fall
into the 4th and 5th quintile and also timing is the only contributor that appears in the 1st quintile with about 5% of its values being there. None of the contributors appear in the 5th quintile more than 80% of the time which shows I still need
to get better with everything.

#### What readiness factors do I normally score highest on? Lowest?
| Contributor           | Avg   | Min  | Max  |
|-----------------------|-------|------|------|
| Body Temperature       | 97.57 | 66.00| 100.00|
| Recovery Index         | 91.75 | 1.00 | 100.00|
| Resting Heart Rate     | 85.00 | 10.00| 100.00|
| Activity Balance       | 82.69 | 44.00| 100.00|
| Readiness Score        | 80.76 | 56.00| 91.00|
| Previous Day Activity  | 79.57 | 1.00 | 99.00|
| HRV Balance            | 79.12 | 1.00 | 100.00|
| Sleep Balance          | 76.81 | 47.00| 98.00|
| Previous Night         | 69.71 | 39.00| 92.00|

My readiness factors are much better than those of my sleep data. Every average is above 75 other than previous night sleep, and all of them have maxes of 92, meaning it is possible for me to get consistent readiness scores in
the high 90s if I put everything together. My lowest contributor is previous night at 69.87 and highest is body temperature at 97.56


#### What readiness contributors do I struggle with consistently?
| Contributor    |Percent Score 0-20 | Percent Score 21-40 | Percent Score 41-60 | Percent Score 61-80 | Percent Score 81-100 |
|-----------------------|------------|-------------|-------------|-------------|--------------|
| Previous Day Activity  | 1.65       | 1.37        | 3.30        | 27.47       | 63.19        |
| Activity Balance       | 0.00       | 0.00        | 6.59        | 26.37       | 65.11        |
| HRV Balance            | 1.65       | 3.85        | 12.09       | 20.05       | 60.16        |
| Recovery Index         | 0.55       | 1.37        | 2.20        | 12.09       | 83.79        |
| Previous Night         | 0.00       | 0.27        | 12.36       | 78.02       | 9.34         |
| Sleep Balance          | 0.00       | 0.00        | 1.65        | 62.91       | 33.24        |
| Body Temperature       | 0.00       | 0.00        | 0.00        | 2.20        | 97.80        |
| Resting Heart Rate     | 0.27       | 1.65        | 8.79        | 19.78       | 69.51        |

There isn't any clear readiness contributor that I struggle with the most. Every single one has at least 80% of their values in the 4th and 5th quintile. HRV_balance has about 18% of its values in the lower three quintiles so there is area for
improvement there. Also, my sleep related factors (sleep balance and previous night) are the only two factors without 60% of their values in the 5th quintile. The only way to improve those factors is to improve my sleep which I can do my addressing the
findings from my other queries.

#### What is sleep like after high activity?
| Activity Type | Avg Score | Std Score |
|---------------|-----------|-----------|
| Low Activity  | 69.26     | 5.96      |
| High Activity | 71.28     | 6.54      |

I do seem to sleep slightly better when I have a day where I exert high activity. Being more highly active might help me sleep better.

### Sleep Streaks:


#### What is my average sleep the day after a good sleep score? The day after a bad one?
| Sleep Quality | Avg Score | Std Score |
|---------------|-----------|-----------|
| Good Sleep    | 70.01     | 5.34      |
| Bad Sleep     | 68.55     | 6.47      |

It seems that I marginally sleep better on average the next day when I have sleep score of over 70, but not enough
of a difference to draw conclusions.

#### Longest streak of good sleep scores?
| Streak Length |
|---------------|
| 11            |

#### Longest streak of good readiness scores?
| Streak Length |
|---------------|
| 9             |


### Timing and Sleep:


#### Average time I go to sleep and wake up at?
| Bedtime Start        | Bedtime End          |
|----------------------|----------------------|
| 12:13:44.316804      | 08:54:32.278237      |


#### Sleep Score based on what time I went to bed?
| Bedtime Hour | Count | Bedtime End      | Avg Sleep Score | Std Sleep Score | Avg Duration |
|--------------|-------|------------------|-----------------|-----------------|--------------|
| 22           | 28    | 07:49:39.964286  | 75.39           | 5.70            | 7.14         |
| 23           | 114   | 08:24:56.938596  | 71.46           | 5.01            | 6.91         |
| 0            | 161   | 09:07:16.15528   | 68.59           | 4.88            | 6.75         |
| 1            | 49    | 09:33:21.122449  | 64.61           | 5.73            | 6.41         |
| 2            | 9     | 10:05:57.333333  | 63.67           | 6.00            | 6.22         |
| 3            | 4     | 11:30:38.5       | 61.25           | 7.76            | 6.25         |

This is some very interesting data. For one I'm surprised that I only went to sleep after 2am a total of 13 times. I don't want to go to sleep later than 1 at all, but that used to be a bigger issue for me, so I'm proud of this information.

It’s clear that the earlier I go to sleep, the better the sleep score on average. The difference between each of the hours is about 4 points until after 1am where there isn't much difference. Which shows that just 1 hour can make a big difference in my sleep.

What's really interesting is my duration also increases the earlier I go to sleep. The sleep score was already going to be higher due to scoring better with the timing contributor, but it's very interesting that I'm sleeping longer on average too. Really shows that
I need to go to sleep earlier.



## Conclusion:

Before doing this project I knew that I had a lot of room for improvement when it came to my sleep, but now I know what areas to focus on. Timing is clearly a big weakness for me. I’m consistently scoring low on that metric, and the data shows that not only do I score better on my sleep when I go to sleep earlier, but I also sleep longer on average too. I need to get myself to start going to sleep between 10pm - 11pm consistently. 
  
Another area for improvement is restfulness. There isn’t as simple a quick fix for this as timing, so I will have to do some research into this. One possible cause for low restfulness is heavy meals close to sleep, so I need to monitor how much I’m eating for dinner and if I’m snacking at all after. 

Also, I need to be more conscious of my sleep patterns on days where I have lower scores on average such as Sunday night and Friday night. My goal is for my average sleep score to be relatively the same every night, so I need to identify variations in my days/nights that could be causing differences in scores. There are certainly other areas to improve upon, but this is a good start for now. I hope to see some improvements when I run these queries again a year from now.

