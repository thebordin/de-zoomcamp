{{ config(materialized='table') }}

WITH fhv_data AS (
    SELECT
        *,
        EXTRACT(YEAR FROM pickup_datetime) AS year,
        EXTRACT(MONTH FROM pickup_datetime) AS month
    FROM {{ ref('stg_fhv_tripdata') }}
)

SELECT
    fhv.*,
    pickup_zone.zone AS pickup_zone,
    dropoff_zone.zone AS dropoff_zone
FROM fhv_data AS fhv
INNER JOIN {{ ref('dim_zones') }} AS pickup_zone
    ON fhv.pickup_location_id = pickup_zone.locationid
INNER JOIN {{ ref('dim_zones') }} AS dropoff_zone
    ON fhv.dropoff_location_id = dropoff_zone.locationid