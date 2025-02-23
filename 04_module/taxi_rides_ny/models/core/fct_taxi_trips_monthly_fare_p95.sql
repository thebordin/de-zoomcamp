{{
    config(
        materialized='table'
    )
}}

with filtered_trips as (
    select
        service_type,
        pickup_datetime,
        fare_amount
    from {{ ref('fact_trips') }}
    where
        fare_amount > 0
        and trip_distance > 0
        and payment_type_description in ('Cash', 'Credit Card')
)

select
    service_type,
    extract(year from pickup_datetime) as year,
    extract(month from pickup_datetime) as month,
    approx_quantiles(fare_amount, 100)[offset(97)] as p97_fare_amount,
    approx_quantiles(fare_amount, 100)[offset(95)] as p95_fare_amount,
    approx_quantiles(fare_amount, 100)[offset(90)] as p90_fare_amount
from filtered_trips
group by
    service_type,
    extract(year from pickup_datetime),
    extract(month from pickup_datetime)