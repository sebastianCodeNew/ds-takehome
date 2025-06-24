-- ================================================
-- BAGIAN A – SQL ANALYTICS
-- RFM, Segmentasi, Repeat Buyer, dan EXPLAIN
-- ================================================

-- STEP 1: Hitung Recency
WITH recency_calc AS (
  SELECT
    customer_id,
    JULIANDAY('2025-06-30') - JULIANDAY(MAX(order_date)) AS recency
  FROM e_commerce_transactions
  GROUP BY customer_id
),

-- STEP 2: Hitung Frequency
frequency_calc AS (
  SELECT
    customer_id,
    COUNT(order_id) AS frequency
  FROM e_commerce_transactions
  GROUP BY customer_id
),

-- STEP 3: Hitung Monetary
monetary_calc AS (
  SELECT
    customer_id,
    SUM(payment_value) AS monetary
  FROM e_commerce_transactions
  GROUP BY customer_id
),

-- STEP 4: Segmentasi Pelanggan Berdasarkan RFM
segmentasi AS (
  SELECT
    r.customer_id,
    recency,
    frequency,
    monetary,
    CASE
      WHEN recency <= 30 AND frequency >= 5 AND monetary >= 3000 THEN 'Champion'
      WHEN recency <= 60 AND frequency >= 5 THEN 'Loyal'
      WHEN monetary >= 3000 THEN 'Big Spender'
      WHEN recency <= 90 AND frequency >= 2 THEN 'Potential'
      WHEN recency BETWEEN 91 AND 180 THEN 'Needs Attention'
      ELSE 'Lost'
    END AS segment
  FROM recency_calc r
  JOIN frequency_calc f ON r.customer_id = f.customer_id
  JOIN monetary_calc m ON r.customer_id = m.customer_id
),

-- STEP 5: Daftar Tetap Semua Segmen (agar tampil meskipun kosong)
segment_list AS (
  SELECT 'Champion' AS segment UNION ALL
  SELECT 'Loyal' UNION ALL
  SELECT 'Big Spender' UNION ALL
  SELECT 'Potential' UNION ALL
  SELECT 'Needs Attention' UNION ALL
  SELECT 'Lost'
)

-- OUTPUT: Jumlah pelanggan per segmen (≥6 segmen tampil)
SELECT
  s.segment,
  COUNT(seg.customer_id) AS jumlah_pelanggan
FROM segment_list s
LEFT JOIN segmentasi seg ON s.segment = seg.segment
GROUP BY s.segment
ORDER BY jumlah_pelanggan DESC;

-- ================================================
-- STEP 6: Repeat Purchase Bulanan
-- Pelanggan yang beli lebih dari 1x dalam sebulan
-- ================================================

WITH bulanan AS (
  SELECT
    customer_id,
    STRFTIME('%Y-%m', order_date) AS bulan,
    COUNT(*) AS jumlah_order
  FROM e_commerce_transactions
  GROUP BY customer_id, bulan
),
repeat_buyer AS (
  SELECT bulan, COUNT(DISTINCT customer_id) AS repeat_customers
  FROM bulanan
  WHERE jumlah_order > 1
  GROUP BY bulan
)

SELECT * FROM repeat_buyer
ORDER BY bulan;

-- ================================================
-- STEP 7: EXPLAIN QUERY PLAN untuk repeat_buyer
-- ================================================

EXPLAIN QUERY PLAN
SELECT * FROM repeat_buyer;
