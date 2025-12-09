-- Rank sellers based on their average review score and the total number of reviews they received.
SELECT
    t.seller_id,
    t.Avg_Review_Score,
    t.Total_Reviews,
    RANK() OVER(ORDER BY t.Avg_Review_Score DESC,t.Total_Reviews DESC) AS Review_Ranking
FROM(
    SELECT
        os.seller_id,
        ROUND(AVG(oo.review_score),0) AS Avg_Review_Score,
        COUNT(oo.review_id) AS Total_Reviews
    FROM
        olist_order_review oo 
    INNER JOIN
        olist_orders o ON oo.order_id=o.order_id
    INNER JOIN
        olist_order_items oi ON o.order_id=oi.order_id
    INNER JOIN
        olist_sellers os ON oi.seller_id=os.seller_id
    GROUP BY
        os.seller_id
    HAVING 
        COUNT(oo.review_id)>=10
)t;