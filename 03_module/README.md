# de-zoomcamp
Let's do it.

HOMEWORK 3 
https://courses.datatalks.club/de-zoomcamp-2025/homework/hw3


### Question 1.
!dlt --version

    Answer
    dlt 1.6.1

### Question 2.
conn.sql("DESCRIBE").df()

    Answer
    4

### Question 3.
print(len(df))

    Answer
    10000

### Question 4.
with pipeline.sql_client() as client:
    res = client.execute_sql(
            """
            SELECT
            AVG(date_diff('minute', trip_pickup_date_time, trip_dropoff_date_time))
            FROM ny_taxi_rides;
            """
        )
    print(res)

    Answer
    12.3049
    