# de-zoomcamp
Let's do it.

HOMEWORK 1 
https://courses.datatalks.club/de-zoomcamp-2025/homework/hw1

### Question 1.
docker run -it --entrypoint bash python:3.12.8
pip -version
pip 24.3.1 from /usr/local/lib/python3.12/site-packages/pip (python 3.12)

    Answer
    24.3.1

### Question 2.
Since service name works as a hostname, Postgres server is at db.
And the port map is for external connection, so inside the docker, the right port is 5432

    Answer
    db:5432 

### Question 3.
SELECT 
    CASE 
        WHEN trip_distance <= 1 THEN '1 - Up to 1 mile'
        WHEN trip_distance > 1 AND trip_distance <= 3 THEN '2 - Between 1 and 3 miles'
        WHEN trip_distance > 3 AND trip_distance <= 7 THEN '3 - Between 3 and 7 miles'
        WHEN trip_distance > 7 AND trip_distance <= 10 THEN '4 - Between 7 and 10 miles'
        ELSE '5 - Over 10 miles'
    END AS distance_category,
    COUNT(1) AS trip_count
FROM green_taxi_trips
WHERE 
    lpep_pickup_datetime >= '2019-10-01'
    AND lpep_dropoff_datetime < '2019-11-01'
GROUP BY distance_category
ORDER BY distance_category;

    Answer
    "1 - Up to 1 mile"	104802
    "2 - Between 1 and 3 miles"	198924
    "3 - Between 3 and 7 miles"	109603
    "4 - Between 7 and 10 miles"	27678
    "5 - Over 10 miles"	35189   
    104,802; 198,924; 109,603; 27,678; 35,189

### Question 4
SELECT MAX(trip_distance), lpep_pickup_datetime
FROM green_taxi_trips
GROUP BY 2
ORDER BY 1 DESC
LIMIT 1;
    
    Answer
    2019-10-31

### Question 5
SELECT z."Zone", SUM(t."total_amount")
FROM green_taxi_trips t
JOIN zones z
ON t."PULocationID" = z."LocationID"
WHERE 
    DATE(t.lpep_pickup_datetime) = '2019-10-18'
GROUP BY 
    z."Zone", t."PULocationID"
HAVING SUM(t.total_amount) > 13000
ORDER BY 
    2 DESC;

    Answer
    East Harlem North, East Harlem South, Morningside Heights

### Question 6
SELECT dz."Zone" AS dropoff_zone, MAX(t."tip_amount") AS largest_tip
FROM green_taxi_trips t
JOIN zones pz ON t."PULocationID" = pz."LocationID"
JOIN zones dz ON t."DOLocationID" = dz."LocationID"
WHERE 
    DATE(t."lpep_pickup_datetime") BETWEEN '2019-10-01' AND '2019-10-31'
    AND pz."Zone" = 'East Harlem North'
GROUP BY dz."Zone"
ORDER BY largest_tip DESC
LIMIT 1;

    Answer
    JFK Airport

### Quertion 7

    Answer
    terraform init, terraform apply -auto-approve, terraform destroy