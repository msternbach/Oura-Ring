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

### When did I Sleep the Best:

What month did I have the best average readiness score? The worst?

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

What month did I have the best average sleep score? The worst?
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



What day of the week do I get the best sleep? 
| Day of Week | Avg Sleep Score | Std Sleep Score | Avg Readiness Score | Std Readiness Score |
|-------------|-----------------|-----------------|---------------------|---------------------|
| Tuesday     | 70.56           | 5.63            | 81.29               | 4.77                |
| Monday      | 70.54           | 4.88            | 81.79               | 5.44                |
| Saturday    | 69.89           | 6.51            | 79.89               | 6.69                |
| Wednesday   | 69.17           | 5.55            | 81.44               | 5.18                |
| Thursday    | 68.67           | 5.82            | 80.50               | 6.30                |
| Friday      | 68.20           | 5.00            | 79.37               | 6.14                |
| Sunday      | 67.92           | 7.46            | 80.87               | 5.91                |


### What Contributors Affected my Sleep the Most:


What sleep factors do I normally score highest on? Lowest?
| Contributor     | Avg   | Min  | Max  |
|-----------------|-------|------|------|
| Latency         | 84.39 | 22.00| 99.00|
| Timing          | 56.72 | 1.00 | 100.00|
| Deep Sleep      | 66.73 | 21.00| 98.00|
| REM Sleep       | 66.74 | 28.00| 97.00|
| Efficiency      | 80.23 | 46.00| 96.00|
| Total Sleep     | 73.86 | 31.00| 96.00|
| Sleep Score     | 69.28 | 44.00| 85.00|
| Restfulness     | 53.07 | 21.00| 82.00|


What sleep contributors do I struggle with the most?


What readiness factors do I normally score highest on? Lowest?
| Contributor           | Avg   | Min  | Max  |
|-----------------------|-------|------|------|
| Previous Day Activity  | 79.57 | 1.00 | 99.00|
| Activity Balance       | 82.69 | 44.00| 100.00|
| HRV Balance            | 79.12 | 1.00 | 100.00|
| Recovery Index         | 91.75 | 1.00 | 100.00|
| Previous Night         | 69.71 | 39.00| 92.00|
| Sleep Balance          | 76.81 | 47.00| 98.00|
| Body Temperature       | 97.57 | 66.00| 100.00|
| Readiness Score        | 80.76 | 56.00| 91.00|
| Resting Heart Rate     | 85.00 | 10.00| 100.00|


What readiness contributors do I struggle with the most?


What is sleep like after high activity?
| Activity Type | Avg Score | Std Score |
|---------------|-----------|-----------|
| Low Activity  | 69.26     | 5.96      |
| High Activity | 71.28     | 6.54      |


### Sleep Streaks:


What is my average sleep the day after a good sleep score? The day after a bad one?
| Sleep Quality | Avg Score | Std Score |
|---------------|-----------|-----------|
| Good Sleep    | 70.01     | 5.34      |
| Bad Sleep     | 68.55     | 6.47      |


Longest streak of good sleep scores?
| Streak Length |
|---------------|
| 11            |
| 7             |
| 6             |
| 6             |
| 5             |
| 5             |
| 5             |
| 5             |


Longest streak of good readiness scores?
| Streak Length |
|---------------|
| 9             |
| 8             |
| 7             |
| 6             |
| 6             |
| 6             |


### Timing and Sleep:


Average time I go to sleep and wake up at?
| Bedtime Start        | Bedtime End          |
|----------------------|----------------------|
| 12:13:44.316804      | 08:54:32.278237      |


Sleep Score based on what time I went to bed?
| Bedtime Hour | Count | Bedtime End      | Avg Sleep Score | Std Sleep Score | Avg Duration |
|--------------|-------|------------------|-----------------|-----------------|--------------|
| 22           | 28    | 07:49:39.964286  | 75.39           | 5.70            | 7.14         |
| 23           | 114   | 08:24:56.938596  | 71.46           | 5.01            | 6.91         |
| 0            | 161   | 09:07:16.15528   | 68.59           | 4.88            | 6.75         |
| 1            | 49    | 09:33:21.122449  | 64.61           | 5.73            | 6.41         |
| 2            | 9     | 10:05:57.333333  | 63.67           | 6.00            | 6.22         |
| 3            | 4     | 11:30:38.5       | 61.25           | 7.76            | 6.25         |



## Analysis:

Before doing this project I knew that I had a lot of room for improvement when it came to my sleep, but now I know what areas to focus on. Timing is clearly a big weakness for me. I’m consistently scoring low on that metric, and the data shows that not only do I score better on my sleep when I go to sleep earlier, but I also sleep longer on average too. I need to get myself to start going to sleep between 10pm - 11pm consistently. 
  
Another area for improvement is restfulness. There isn’t as simple a quick fix for this as timing, so I will have to do some research into this. One possible cause for low restfulness is heavy meals close to sleep, so I need to monitor how much I’m eating for dinner and if I’m snacking at all after. 

Also, I need to be more conscious of my sleep patterns on days where I have lower scores on average such as Sunday night and Friday night. My goal is for my average sleep score to be relatively the same every night, so I need to identify variations in my days/nights that could be causing differences in scores. There are certainly other areas to improve upon, but this is a good start for now. I hope to see some improvements when I run these queries again a year from now.

