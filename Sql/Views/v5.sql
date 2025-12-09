CREATE VIEW v_customer_clv AS
WITH CustomerTotalSpending AS(
SELECT
    oo.customer_id,
    SUM(op.payment_value) as Total_Spend
FROM
    olist_orders oo
INNER JOIN
    olist_order_payments op ON op.order_id=oo.order_id
GROUP BY
    oo.customer_id)
SELECT
    oc.customer_unique_id,
    oc.customer_city,
    oc.customer_state,
    SUM(cts.Total_Spend) AS Customer_Lifetime_Spend
FROM
    olist_customers oc 
INNER JOIN
    CustomerTotalSpending cts ON cts.customer_id=oc.customer_id
GROUP BY
    oc.customer_unique_id,
    oc.customer_city,
    oc.customer_state
ORDER BY
    Customer_Lifetime_Spend DESC;