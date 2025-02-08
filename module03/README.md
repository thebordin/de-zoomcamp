# de-zoomcamp
Let's do it.

HOMEWORK 3 
https://courses.datatalks.club/de-zoomcamp-2025/homework/hw3


### Question 1.
SELECT count(*)  FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized`; 

    Answer
    20.332.093

### Question 2.
SELECT COUNT(DISTINCT PULocationID)
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_external`;

SELECT COUNT(DISTINCT PULocationID)
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized`;

    Answer
    0 MB for the External Table and 155.12 MB for the Materialized Table

### Question 3.
SELECT PULocationID
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized`;

SELECT PULocationID, DOLocationID
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized`;

    Answer
    BigQuery is a columnar database, and it only scans the specific columns requested in the query. 
    Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), 
    leading to a higher estimated number of bytes processed.

### Question 4.
SELECT count(*) FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized` 
WHERE fare_amount = 0;

    Answer
    8.333

### Question 5.
CREATE OR REPLACE TABLE `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_optimized`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
SELECT *  
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized`;

    Answer
    Partition by tpep_dropoff_datetime and Cluster on VendorID

### Question 6.
SELECT DISTINCT VendorID
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_materialized`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

SELECT DISTINCT VendorID
FROM `kestra-project-449120.zoomcamp.hw3_yellow_tripdata_optimized`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

    Answer
    310.24 MB for non-partitioned table and 26.84 MB for the partitioned table