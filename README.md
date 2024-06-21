# Bike-Rental-System
A bike Rental service is economically beneficial to users as they can purchase a subscription or to use a pay-per-ride system. The cost of bike sharing has been found to be more affordable than other forms of transportation. Buses, trains, and ride sharing can all be more expensive than bike sharing. Furthermore, sharing a bike will also eliminate the need for the users to maintain and repair their own bike.
Another benefit is that bike sharing is a very ecologically friendly means of transportation. It contributes much less to air and noise pollution than automobiles. Lower levels of noise and air pollution are beneficial to both the environment and to city residents. It also decreases the traffic and congestion often found in major cities. Depending on the size and traffic patterns of the city, using a bike could possibly be quicker than driving, riding a bus or riding a train.
The dataset consists of 17 columns, with the following key features:
- `instant`: A unique sequential ID for each row.
- `date day`: The date of the data in yyyy-mm-dd format.
- `season`: The season (1 = spring, 2 = summer, 3 = fall, 4 = winter).
- `year`: The year (0 = 2011, 1 = 2012).
- `month`: The month (1 to 12).
- `hour`: The hour of the day (0 to 23).
- `holiday`: A binary feature indicating whether it's a holiday (1) or not (0).
- `weekday`: The day of the week (0 to 6).
- `working day`: A binary feature indicating whether it's a working day (1) or not (0).
- `weather sit`: The weather situation (1 = clear, 2 = mist, 3 = light rain, 4 = heavy rain).
- `temp`: The normalized temperature in Celsius.
- `a temp`: The normalized "feels-like" temperature in Celsius.
- `hum`: The normalized humidity.
- `windspeed`: The normalized wind speed.
- `casual`: The number of casual (non-registered) bike rentals
- `registered`: The number of registered bike rentals.
- `count`: The total count of bike rentals (casual + registered).

DATA SET LINK: https://archive.ics.uci.edu/dataset/275/bike+sharing+dataset

QUESTIONS ANSWERED

We have done the data analysis of this dataset starting from cleaning and transformation to the use of various Clustering and Regressions techniques like K-Means, KNN, Linear Regression, Logistic Regression and answered the following questions about the relationship between various variables and their impact on Rentals.

•	Is there a correlation between environmental factors and overall user count? 

•	Is a registered or casual user more likely to rent a bike during non-optimal weather (too hot or too cold)?

•	Is there a time of day that a registered or casual user is more likely to use a bike?

•	Is there a time of year where users are more or less likely to rent a bike?

•	Do holidays impact usage? If so, how?

•	Is there a threshold at which these factors significantly affect demand?

•	Are there any noticeable trends in bike rental demand between the years 2011 and 2012?
