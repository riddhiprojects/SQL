WITH numbered_orders AS (
  SELECT 
    order_id,
    item,
    ROW_NUMBER() OVER (ORDER BY order_id) AS rn,
    COUNT(1) OVER () AS total_rows
  FROM orders
),
swapped AS (
  SELECT
    n1.order_id AS corrected_order_id,
    CASE 
      -- If last row with odd order_id, keep item unchanged
      WHEN n1.rn = n1.total_rows AND MOD(n1.order_id, 2) = 1 THEN n1.item
      
      -- If odd row , take item from the next row
      WHEN MOD(n1.rn, 2) = 1 THEN n2.item
      
      -- If even row (2, 4, 6...), take item from the previous row
      ELSE n1_prev.item
    END AS item
  FROM numbered_orders n1
  LEFT JOIN numbered_orders n2 ON n1.rn % 2 = 1 AND n1.rn + 1 = n2.rn
  LEFT JOIN numbered_orders n1_prev ON n1.rn % 2 = 0 AND n1.rn - 1 = n1_prev.rn
)
SELECT corrected_order_id, item
FROM swapped
ORDER BY corrected_order_id;
