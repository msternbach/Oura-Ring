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


What month did I have the best average sleep score? The worst?


What day of the week do I get the best sleep? 


### What Contributors Affected my Sleep the Most:


What sleep factors do I normally score highest on? Lowest?


What sleep contributors do I struggle with the most?


What readiness factors do I normally score highest on? Lowest?


What readiness contributors do I struggle with the most?


What is sleep like after high activity?


### Sleep Streaks:


What is my average sleep the day after a good sleep score? The day after a bad one?


Longest streak of good sleep scores?


Longest streak of good readiness scores?


### Timing and Sleep:


Average time I go to sleep and wake up at?


Sleep Score based on what time I went to bed?



## Analysis:

Before doing this project I knew that I had a lot of room for improvement when it came to my sleep, but now I know what areas to focus on. Timing is clearly a big weakness for me. I’m consistently scoring low on that metric, and the data shows that not only do I score better on my sleep when I go to sleep earlier, but I also sleep longer on average too. I need to get myself to start going to sleep between 10pm - 11pm consistently. 
  
Another area for improvement is restfulness. There isn’t as simple a quick fix for this as timing, so I will have to do some research into this. One possible cause for low restfulness is heavy meals close to sleep, so I need to monitor how much I’m eating for dinner and if I’m snacking at all after. 

Also, I need to be more conscious of my sleep patterns on days where I have lower scores on average such as Sunday night and Friday night. My goal is for my average sleep score to be relatively the same every night, so I need to identify variations in my days/nights that could be causing differences in scores. There are certainly other areas to improve upon, but this is a good start for now. I hope to see some improvements when I run these queries again a year from now.

