{{
    config(
        materialized='table'
    )
}}

WITH quarterly_revenue AS (
    SELECT
        -- Extrai o ano e o trimestre de pickup_datetime
        DATE_TRUNC(pickup_datetime, QUARTER) AS quarter,
        EXTRACT(YEAR FROM pickup_datetime) AS year,
        EXTRACT(QUARTER FROM pickup_datetime) AS quarter_number,
        service_type,

        -- Soma os valores totais (total_amount) por trimestre
        SUM(total_amount) AS total_revenue
    FROM
        {{ ref('fact_trips') }} -- Referencia o modelo fact_trips no dbt
    GROUP BY
        service_type,
        quarter,
        year,
        quarter_number
),
yoy_growth AS (
    SELECT
        a.quarter AS quarter,
        a.year AS year,
        a.quarter_number AS quarter_number,
        a.service_type AS service_type,
        a.total_revenue AS current_revenue,
        b.total_revenue AS previous_year_revenue,

        -- Calcula o crescimento YoY em porcentagem
        CASE
            WHEN b.total_revenue IS NULL THEN NULL
            ELSE ((a.total_revenue - b.total_revenue) / b.total_revenue) * 100
        END AS yoy_growth_percentage
    FROM
        quarterly_revenue a
    LEFT JOIN
        quarterly_revenue b
    ON
        a.quarter_number = b.quarter_number
        AND a.year = b.year + 1
        AND a.service_type = b.service_type
)
SELECT
    quarter,
    year,
    quarter_number,
    service_type,
    current_revenue,
    previous_year_revenue,
    yoy_growth_percentage
FROM
    yoy_growth
ORDER BY
    year,
    quarter_number,
    service_type