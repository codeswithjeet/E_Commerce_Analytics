CREATE VIEW v_top_product_category AS
WITH CategoryRevenue AS (
    SELECT
        t.product_category_name_english AS Category_Name,
        SUM(oi.item_total_cost) AS Category_Gross_Revenue
    FROM
        olist_order_items oi
    JOIN
        olist_products p ON oi.product_id = p.product_id
    JOIN
        olist_product_category_translation t ON p.product_category_name = t.product_category_name
    GROUP BY
        Category_Name
)
SELECT
    Category_Name,
    Category_Gross_Revenue,
    ROUND(((Category_Gross_Revenue / (SELECT SUM(Category_Gross_Revenue) FROM CategoryRevenue)) * 100),2) AS Revenue_Percent
FROM
    CategoryRevenue
ORDER BY
    Category_Gross_Revenue DESC
LIMIT 5;