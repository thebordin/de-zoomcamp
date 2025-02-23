{{ config(materialized='table') }}

WITH fhv_trips AS (
    SELECT
        *,
        DATETIME_DIFF(dropoff_datetime, pickup_datetime, SECOND) AS trip_duration
    FROM {{ ref('dim_fhv_trips') }}
    WHERE dropoff_datetime >= pickup_datetime
)

SELECT
    year,
    month,
    pickup_location_id,
    pickup_zone,
    dropoff_location_id,
    dropoff_zone,
    APPROX_QUANTILES(trip_duration, 100)[OFFSET(90)] AS trip_duration
FROM fhv_trips
GROUP BY 1, 2, 3, 4, 5, 6