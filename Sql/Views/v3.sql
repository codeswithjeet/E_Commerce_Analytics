CREATE VIEW v_delivery_performance AS
SELECT
    customer_state AS State,
    COUNT(order_id) as Total_Delivered_Orders,
    ROUND(AVG(delivery_time_days),0) AS Avg_Delivery_Time,
    SUM(CASE WHEN oo.is_late='Yes' THEN 1 ELSE 0 END)AS Total_late_deliveries,
    (SUM(CASE WHEN oo.is_late='Yes' Then 1 ELSE 0 END)*100)/COUNT(oo.order_id) AS Delay_percentage
FROM
    olist_customers oc 
INNER JOIN
    olist_orders oo ON oo.customer_id=oc.customer_id
WHERE
    oo.order_status='delivered'
GROUP BY
    State
ORDER BY
    DELay_percentage DESC;