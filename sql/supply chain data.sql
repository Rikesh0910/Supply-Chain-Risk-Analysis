USE db_supply_chain_risk;

-- Creating a Table

CREATE TABLE supply_data (
    Shipment_ID VARCHAR(50) PRIMARY KEY,
    Date DATE,
    Origin_Port VARCHAR(50),
    Destination_Port VARCHAR(50),
    Transport_Mode VARCHAR(50),
    Product_Category VARCHAR(50),
    Distance_km DECIMAL(10,2),
    Weight_MT DECIMAL(10,2),
    Fuel_Price_Index DECIMAL(10,2),
    Geopolitical_Risk_Score DECIMAL(5,2),
    Weather_Condition VARCHAR(50),
    Carrier_Reliability_Score DECIMAL(5,2),
    Lead_Time_Days DECIMAL(5,2),
    Disruption_Occurred INT,
    Month INT,
    Day INT,
    Month_Name VARCHAR(20)
);

-- Imported Data to the table using import wizard

-- Examining Data / Deep Analysis

SELECT
	*
FROM
	supply_data;
    
SELECT
	COUNT(*)
FROM
	supply_data;
    
SELECT DISTINCT 
	Transport_Mode
FROM
	supply_data;
    
ALTER TABLE supply_data
DROP COLUMN risk_score;

ALTER TABLE supply_data
ADD COLUMN risk_score VARCHAR(50); 

    
UPDATE supply_data
SET risk_score =
CASE
    WHEN Geopolitical_Risk_Score <= 3 THEN 'Stable'
    WHEN Geopolitical_Risk_Score > 3 AND Geopolitical_Risk_Score <= 6 THEN 'Moderate'
    WHEN Geopolitical_Risk_Score > 6 THEN 'High'
END;

SELECT
	MIN(Carrier_Reliability_Score) AS min_reliability_score,
    MAX(Carrier_Reliability_Score) AS max_reliability_score,
    AVG(Carrier_Reliability_Score) AS avg_reliability_score
FROM
	supply_data;
    
SELECT
	risk_score,
    COUNT(*) AS all_transaction
FROM
	supply_data
GROUP BY risk_score;

SELECT
	COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS disruption_occurred_shipments,
    ROUND(SUM(Disruption_Occurred) / COUNT(*) * 100.0, 2) AS pct_of_disruption
FROM
	supply_data;
    
SELECT
	Transport_Mode,
	SUM(Disruption_Occurred) AS total_disruptions
FROM
	supply_data
GROUP BY Transport_Mode
ORDER BY total_disruptions DESC;

SELECT
	Transport_Mode,
    AVG(Lead_Time_Days) AS avg_lead_time
FROM
	supply_data
GROUP BY Transport_Mode
ORDER BY avg_lead_time DESC;

SELECT
	Origin_Port,
    Destination_Port,
    AVG(Geopolitical_Risk_Score) AS avg_risk_score
FROM
	supply_data
GROUP BY Origin_Port, Destination_Port
ORDER BY avg_risk_score DESC;

SELECT 
    Weather_Condition,
    AVG(Lead_Time_Days) AS avg_lead_time,
    SUM(Disruption_Occurred) AS disruptions
FROM supply_data
GROUP BY Weather_Condition
ORDER BY disruptions DESC;

SELECT
	Carrier_Reliability_Score,
	AVG(Lead_Time_Days) AS avg_lead_time,
    SUM(Disruption_Occurred) AS Disruption_Occurred
FROM
	supply_data
GROUP BY Carrier_Reliability_Score
ORDER BY Carrier_Reliability_Score DESC;

SELECT
	month_name,
    COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS total_disruptions
FROM
	supply_data
GROUP BY month_name
ORDER BY total_disruptions DESC;

SELECT
    MAX(Distance_km) AS max_distance,
    MIN(Distance_km) AS min_distance,
    AVG(Distance_km) AS avg_distance
FROM
	supply_data;
    
SELECT
    ROUND(AVG(Distance_km),2) AS avg_distance,
    ROUND(AVG(Lead_Time_Days),2) AS avg_lead_time
FROM supply_data;

SELECT
    CASE
        WHEN Distance_km < 2000 THEN 'Short'
        WHEN Distance_km BETWEEN 2000 AND 5000 THEN 'Medium'
        ELSE 'Long'
    END AS distance_category,
    AVG(Lead_Time_Days) AS avg_lead_time
FROM supply_data
GROUP BY distance_category;


SELECT
    Transport_Mode,
    COUNT(*) AS total,
    SUM(Disruption_Occurred) AS disruptions,
    ROUND(SUM(Disruption_Occurred)*100.0 / COUNT(*),2) AS disruption_rate
FROM supply_data
GROUP BY Transport_Mode
ORDER BY disruption_rate DESC;


SELECT
    risk_score,
    COUNT(*) AS total,
    SUM(Disruption_Occurred) AS disruptions,
    ROUND(SUM(Disruption_Occurred)*100.0 / COUNT(*),2) AS disruption_rate
FROM supply_data
GROUP BY risk_score
ORDER BY disruption_rate DESC;


SELECT
    CASE
        WHEN Carrier_Reliability_Score >= 0.9 THEN 'High'
        WHEN Carrier_Reliability_Score BETWEEN 0.6 AND 0.8 THEN 'Medium'
        ELSE 'Low'
    END AS reliability_level,
    COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS disruptions
FROM supply_data
GROUP BY reliability_level
ORDER BY disruptions DESC;


SELECT
    CASE
        WHEN Distance_km < 2000 THEN 'Short'
        WHEN Distance_km BETWEEN 2000 AND 5000 THEN 'Medium'
        ELSE 'Long'
    END AS distance_category,
    COUNT(*) AS total,
    SUM(Disruption_Occurred) AS disruptions
FROM supply_data
GROUP BY distance_category
ORDER BY disruptions DESC;


SELECT
    Transport_Mode,
    risk_score,
    COUNT(*) AS total,
    SUM(Disruption_Occurred) AS disruptions
FROM supply_data
GROUP BY Transport_Mode, risk_score
ORDER BY disruptions DESC;

SELECT
    Origin_Port,
    Destination_Port,
    COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS disruptions
FROM supply_data
GROUP BY Origin_Port, Destination_Port
ORDER BY disruptions DESC
LIMIT 10;


SELECT
    Transport_Mode,
    AVG(Distance_km / Lead_Time_Days) AS km_per_day
FROM supply_data
GROUP BY Transport_Mode
ORDER BY km_per_day DESC;


SELECT
    Weather_Condition,
    Transport_Mode,
    SUM(Disruption_Occurred) AS disruptions
FROM supply_data
GROUP BY Weather_Condition, Transport_Mode
ORDER BY disruptions DESC;

-- Creating Views

CREATE VIEW overview_summary AS
SELECT
    COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS total_disruptions,
    ROUND(SUM(Disruption_Occurred)*100.0 / COUNT(*),2) AS disruption_rate,
    AVG(Lead_Time_Days) AS avg_lead_time
FROM supply_data;

SELECT
	*
FROM
	overview_summary;
    

CREATE VIEW transport_performance AS
SELECT
    Transport_Mode,
    COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS disruptions,
    ROUND(SUM(Disruption_Occurred)*100.0 / COUNT(*),2) AS disruption_rate,
    AVG(Lead_Time_Days) AS avg_lead_time,
    AVG(Distance_km / Lead_Time_Days) AS km_per_day
FROM supply_data
GROUP BY Transport_Mode;


CREATE VIEW risk_analysis AS
SELECT
    risk_score,
    COUNT(*) AS total_shipments,
    SUM(Disruption_Occurred) AS disruptions,
    ROUND(SUM(Disruption_Occurred)*100.0 / COUNT(*),2) AS disruption_rate
FROM supply_data
GROUP BY risk_score;
    
SELECT DATE_FORMAT(Date, '%M-%Y') AS formatted_date
FROM supply_data;

CREATE VIEW ml_supply_chain_data AS
SELECT
    Shipment_ID,
    Distance_km,
    Weight_MT,
    Fuel_Price_Index,
    Geopolitical_Risk_Score,
    Carrier_Reliability_Score,
    Lead_Time_Days,
    Transport_Mode,
    Weather_Condition,
    Product_Category,
    Origin_Port,
    Destination_Port,
    Disruption_Occurred
FROM
    supply_data;
    
SELECT
	*
FROM
	ml_supply_chain_data;
    
    