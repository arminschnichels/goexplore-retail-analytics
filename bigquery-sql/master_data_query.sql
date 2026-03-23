-- GoExplore: Master Data Query
-- Joins all source tables and calculates revenue, margin, and margin %
-- Dataset: GoExplore (Google BigQuery)
-- Note: Excludes 524 zero-price orders (0.35% of data) to enable margin % calculation

SELECT
  r.`Retailer name`       AS retailer_name,
  r.country               AS retailer_country,
  p.`Product line`        AS product_line,
  p.Product,
  p.`Product brand`       AS product_brand,
  ds.Date,
  ds.Quantity,
  ds.`Unit price`         AS unit_price,
  ds.`Unit sale price`    AS unit_sale_price,
  p.`unit cost`           AS unit_cost,

  ROUND(ds.Quantity * ds.`Unit sale price`, 2)
    AS revenue,

  ROUND(ds.Quantity * (ds.`Unit sale price` - p.`unit cost`), 2)
    AS margin,

  ROUND(
    (ds.Quantity * (ds.`Unit sale price` - p.`unit cost`))
    / (ds.Quantity * ds.`Unit sale price`) * 100,
  2)
    AS margin_perc

FROM
  `GoExplore.daily_sales` AS ds
JOIN
  `GoExplore.products` AS p
  ON ds.`product number` = p.`product number`
JOIN
  `GoExplore.retailers` AS r
  ON ds.`Retailer code` = r.`Retailer code`

WHERE
  ds.`Unit sale price` > 0;
