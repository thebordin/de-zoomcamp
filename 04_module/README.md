# de-zoomcamp
Let's do it.

HOMEWORK 4
https://courses.datatalks.club/de-zoomcamp-2025/homework/hw4


### Question 5.
SELECT
  t0.year,
  t0.quarter_number,
  t0.service_type,
  t0.yoy_growth_percentage
FROM
  `taxi-rides-ny-00`.`zoomcamp`.`fct_taxi_trips_quarterly_revenue` AS t0
WHERE
  t0.year = 2020
group by 1,2,3, 4
order by 3,4

    Answer
    green: {best: 2020/Q1, worst: 2020/Q2}, yellow: {best: 2020/Q1, worst: 2020/Q2}

### Question 6.
service_type	year	month	p97_fare_amount	p95_fare_amount	p90_fare_amount
Green	        2020	    4	    28	                23	        18
Yellow	        2020	    4	    31,5	            26	        19

    Answer
    Closest : green: {p97: 40.0, p95: 33.0, p90: 24.5}, yellow: {p97: 31.5, p95: 25.5, p90: 19.0}


### Question 7.
pickup_zone	    dropoff_zone	                trip_duration
Newark Airport	Williamsburg (South Side)	    10304
Newark Airport	NV	                            9265
Newark Airport	LaGuardia Airport	            7251  ****3rd
SoHo	        East Chelsea	                27268
SoHo	        Greenwich Village South	        26928
SoHo	        Chinatown	                    19496 **** 3rd
Yorkville East	Sutton Place/Turtle Bay North	44233
Yorkville East	Garment District	            13846 **** 2nd
Yorkville East	Yorkville East	                11401


    Answer
    Closest : LaGuardia Airport, Chinatown, Garment District