# Introduction
This case study is part of Google Data Analytics Professional Certificate and was suggested to complete based on the learnt material and scenario. While completing the project has been followed these steps: Act, Prepare, Process, Analyze, Share and Act.
## Scenario
You are a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.
## About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. 

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members. 

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers.

Moreno believes there is a solid opportunity to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs. Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.

## Stakeholders 
* **Cyclistic**: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use the bikes to commute to work each day. 
* **Lily Moreno**: The director of marketing and your manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program. These may include email, social media, and other channels.
* **Cyclistic marketing analytics team**: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy learning about Cyclistic’s mission and business goals—as well as how you, as a junior data analyst, can help Cyclistic achieve them.
* **Cyclistic executive team**: The notoriously detail-oriented executive team will decide whether to approve the recommended marketing program.

# Ask
## Business task
Suggest new marketing strategies to increase conversion of casual users into members.

## Objectives
Three questions will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

# Prepare
## Data source

In this project trip data collected from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) available by Motivate International Inc. under following [license](https://www.divvybikes.com/data-license-agreement) is used. Chosen observation period is from Feb 2023 to Mar 2024. 

Collected data will be used to explore different user behavior. Private and sensitive data has been deleted from the dataset before uploading to the Internet, therefore we won't deal with anonymization process. We have to count on the data collection team, that all of the metrics has been recognized correctly, for instance, we may assume that user's type hasn't been mistaken while collecting data.

## Data organization

In provided dataset there are 12 `.csv` files named by following convention: `YYYYMM-divvy-tripdata` and each file includes information for one month. The structure of each table is:
* `ride_id` - unique id of each ride
* `rideable_type` - type of bike
* `started_at` - timestamp of start of the ride
* `ended_at` - timestamp of end of the ride
* `start_station_name` - name of start station 
* `start_station_id` - id of start station
* `end_station_name` - name of end station
* `end_station_id` - id of end station
* `start_lat` and `start_lng` - coordinates of start station
* `end_lat` and  `end_lng` - coordinates of end station
* `member_casual` - user type

# Process 
In this step the content of the dataset will be analyzed.

The amount of data doesn't allow us to use spreadsheets, therefore procced with using the BigQuery. 

## Combining the data
The query is available [here](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/combining_data.sql).
All of the data is combined to single table `combined-tripdata`. Amount of records is $5,707,168$.
## Exploring the data
The query is available [here](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/exploring_data.sql).
1. Amount of nulls in the dataset by columns:
	* `ride_id` - $0$
	* `rideable_type` - $0$
	* `started_at` - $0$
	* `ended_at` - $0$
	* `start_station_name` - $866,105$ 
	* `start_station_id` - $866,105$
	* `end_station_name` - $920,524$
	* `end_station_id` - $920,524$
	* `start_lat` and `start_lng` - $0$
	* `end_lat` and  `end_lng` - $7,353$
	* `member_casual` - $0$
	All null values should be removed before analyzing.
2. Checking for duplicate rows. None of the rows is duplicated.
3. Checking length of `ride_id`. All values are the same length. 
4. Checking values of `rideable_type`. $3$ unique values for this field.
5. Checking ride duration
   There are $6,888$ rides longer than a day and $147,168$ less than a minute. These values are not indicative for analysis, so we'll delete them.
6. Total $866,105$ values of `start_station_name` and `start_station_id` combined are missing.
7. Total $920,524$ values of `end_station_name` and `end_station_id` combined are missing.
8. Total $7,353$ values of `end_lat` and `end_lng` combined are missing.
### Result of data exploration
Following fields need to be cleaned: `start_station_name`, `start_station_id`, `end_station_name`, `end_station_id`, `end_lat`, `end_lng`. New field `ride_length` will contain values only longer than a minute and less than a day. 

## Data cleaning and transformation
The query is available [here](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/cleaning_data.sql).
1. All rows with invalid values (missing values and rides less than a minute or longer than a day) are removed.
2. Columns `ride_length`, `month` and `day_of_week` are added.
### Result of data cleaning and transformation
New table is created with $4,245,876$ rows. Overall $1,461,292$ rows are deleted. 

# Analyze
To answer given questions we choose to analyze following metrics:
1. Share of users by rideable type.
2. Rides per day of week and per hour.
3. Rides and average ride duration per hour by day of week. 
The query is available [here](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/extracting_data.sql).

# Share
Data visualization.

### Share of users by rideable type.
This viz shows us the preferences of our customers. The absolute majority of Docked Bikes is used by casual customers. For Classic Bikes and Electrics Bikes, the majority is members. This may lead to misunderstanding, that our customers prefer Docked Bikes, when deciding to have a ride. But the absolute values show that amount of these rides is small in comparison to two other rideable types. Casual members make up 35.3% of our annual users.
![Share of users](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/plots/share%20of%20users.png)

### Rides per month
Following chart shows total amount of rides per month. We can see, that peak of users' activity is April-October. With maximum members' activity in August and casual riders' activity in July. Behavior of both members and casual users is almost the same.
![rides per month](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/plots/rides%20per%20month.png)
### Rides per day of week
Casual riders make more trips on weekends, while activity of members decreases at holidays.
![rides per day of week](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/plots/rides%20per%20day%20of%20week.png)

### Rides per hour
At this chart we can see the peaks of daily activity of our users: from 6:00 to 9:00 AM and 3:00 to 7:00 PM. More rides are being made at this time period, than at the rest of the hours. This leads to needing a deeper analysis. At the following charts we'll provide more exact analysis of customer behavior.
![rides per hour overall](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/plots/rides%20per%20hour%20overall.png)

### Rides per hour by day of week
We'll compare customers' activity at Thursday and Saturday, because peaks of members and casual riders activity happens at these day. 
Thursday is the day of maximum activity of our members. We see here the usual peaks of activity from 6:00 AM to 9:00 AM and from 3:00 PM to 7:00 PM. And if we add new metric - average ride duration, we'll find a new insight. The average ride duration of casual users at morning is almost the same as members' one. Moreover, average ride duration of members is almost the same throughout the day, but casual riders prefer start their longer journeys at 10:00 AM.
![rides per hour thrursday](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/plots/rides%20per%20hour%20thursday.png)
In comparison, we see almost the same activity of our customers at Saturday. They make almost the same amount of trips each hour but the duration of these trips is still  different. Casual riders use our bikes to make longer journeys, while the rides duration of members stays the same.
![rides per hour saturday](https://github.com/cann1neof/google-data-analytics-case-study/blob/main/plots/rides%20per%20hour%20saturday.png)
## Summary of observation
Now we can define differences between casual riders and members. 
Casual riders:
1. Make less rides but on longer distances.
2. Use bikes more during weekends. 
Members:
1. Make the majority of rides but on shorter distances.
2. Use bikes on week days during commute hours. 

We can divide casual users into three groups. 
#### First group - Late to work
Everyone of us occasionally is late to work and in order to come faster, we cut corners. So instead of going by public transport or by car, some people chose to ride a bike. This behavior is assumed from ride duration during week days mornings. 
#### Second group - Recreational
Longest rides are made during midday. Casual riders use bikes for recreational purposes on this time of the day.
#### Third group - Weekenders 
This group is characterized by higher activity during weekends, almost the same as members'.
# Act
Our recommendations:
1. Start new marketing campaign in early spring to explain benefits of using bikes this season.
2. In this campaign each group should be targeted differently.
	1. First group should be rewarded for returning to our service with discounts and loyalty system. We can remind them about traffic in the downtown or weather conditions using app notifications.
	2. Value of recreational use of the bikes should be advertised throughout the day for second group. We can sell them season pass to increase interest in using *our* bikes.
	3. The third group could be interested in weekend subscription, with unlimited rides on weekends.
3. We must also think about the balance between prices for new users and old ones, so as not to create an outflow of existing users who are disappointed with such marketing strategy.
