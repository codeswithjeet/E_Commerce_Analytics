CREATE VIEW v_yearly_sales_summary AS
SELECT
    o.order_purchase_year AS Sales_Year,
    o.order_purchase_month AS Sales_Month,
    COUNT(o.order_id) AS Total_Orders,
    SUM(op.payment_value) AS total_revenue,
    ROUND((SUM(op.payment_value)/COUNT(o.order_id)),2) AS AVG_Order_Value
FROM
    olist_orders o 
INNER JOIN
    olist_order_payments op ON o.order_id=op.order_id
WHERE
    o.order_status='delivered'
GROUP BY
    o.order_purchase_year,
    o.order_purchase_month
ORDER BY
    Sales_Year,Sales_Month;