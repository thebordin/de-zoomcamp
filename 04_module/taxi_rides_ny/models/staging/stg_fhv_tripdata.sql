{{ config(materialized='view') }}

SELECT
    dispatching_base_num,
    PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', pickup_datetime) AS pickup_datetime,
    PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', dropoff_datetime) AS dropoff_datetime,
    PUlocationID AS pickup_location_id,
    DOlocationID AS dropoff_location_id
FROM {{ source('staging', 'fhv_tripdata') }}
WHERE dispatching_base_num IS NOT NULL