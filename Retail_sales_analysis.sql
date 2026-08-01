(1)
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(Order_Date, '%Y-%m') AS Sales_Month,
        ROUND(SUM(Net_Sales_INR), 2) AS Total_Net_Sales
    FROM sales_data
    WHERE Is_Returned = 'No'
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT 
    Sales_Month,
    Total_Net_Sales,
    LAG(Total_Net_Sales, 1) OVER (ORDER BY Sales_Month) AS Previous_Month_Sales,
    ROUND(
        ((Total_Net_Sales - LAG(Total_Net_Sales, 1) OVER (ORDER BY Sales_Month)) / 
        LAG(Total_Net_Sales, 1) OVER (ORDER BY Sales_Month)) * 100, 2
    ) AS MoM_Growth_Percentage
FROM MonthlySales;


(2)
SELECT 
    Customer_ID,
    Customer_Segment,
    DATEDIFF('2025-12-31', MAX(Order_Date)) AS Recency_Days,
    COUNT(Transaction_ID) AS Frequency_Orders,
    ROUND(SUM(Net_Sales_INR), 2) AS Monetary_Value
FROM sales_data
WHERE Is_Returned = 'No'
GROUP BY Customer_ID, Customer_Segment
HAVING SUM(Net_Sales_INR) > 50000
ORDER BY Monetary_Value DESC;

(3)
SELECT 
    Category,
    ROUND(SUM(Gross_Amount_INR), 2) AS Total_Gross_Sales,
    ROUND(SUM(Discount_Amount_INR), 2) AS Total_Discounts_Given,
    ROUND(AVG(Discount_Amount_INR / NULLIF(Gross_Amount_INR, 0)) * 100, 2) AS Avg_Discount_Pct,
    ROUND(SUM(Profit_Margin_INR), 2) AS Total_Net_Profit,
    ROUND((SUM(Profit_Margin_INR) / SUM(Net_Sales_INR)) * 100, 2) AS Profit_Margin_Pct
FROM sales_data
GROUP BY Category
ORDER BY Total_Net_Profit DESC;

(4)
SELECT 
    Category,
    COUNT(Transaction_ID) AS Total_Orders,
    SUM(CASE WHEN Is_Returned = 'Yes' THEN 1 ELSE 0 END) AS Returned_Orders,
    ROUND(
        (SUM(CASE WHEN Is_Returned = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(Transaction_ID), 2
    ) AS Return_Rate_Pct,
    ROUND(SUM(CASE WHEN Is_Returned = 'Yes' THEN COGS_INR ELSE 0 END), 2) AS Total_Loss_From_Returns
FROM sales_data
GROUP BY Category
ORDER BY Return_Rate_Pct DESC;

(5)
SELECT 
    Store_Type,
    Payment_Method,
    COUNT(Transaction_ID) AS Total_Transactions,
    ROUND(SUM(Net_Sales_INR), 2) AS Total_Revenue
FROM sales_data
WHERE Is_Returned = 'No'
GROUP BY Store_Type, Payment_Method
ORDER BY Store_Type, Total_Revenue DESC;
