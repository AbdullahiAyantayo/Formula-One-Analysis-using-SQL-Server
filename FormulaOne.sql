CREATE DATABASE FormulaOne
GO

USE FormulaOne
GO


select *
from drivers

select *
from lap_times

select *
from races

select *
from sprint_results

select *
from status

select * 
from seasons

CREATE VIEW driverslap_times
AS
SELECT 
	d.driverId,
	l.raceId,
	l.lap,
	l.time,
	l.milliseconds
FROM [dbo].[drivers] AS d
INNER JOIN [dbo].[lap_times] AS l
    ON d.driverId = l.driverId;
GO

SELECT 
	*
FROM driverslap_times



-- fastest time for each lap
SELECT
	lap,
	MIN(time) AS fastest_time
FROM driverslap_times
GROUP BY lap
ORDER BY lap DESC



DROP TABLE seasons
GO

-- Countries and the number of drivers
WITH DriverCounts AS (
	SELECT 
		nationality, 
		COUNT(nationality) AS driver_country_count
	FROM drivers
	GROUP BY nationality
)
SELECT *
FROM DriverCounts
ORDER BY driver_country_count DESC;


--Country that has the most number of drivers
SELECT 
	TOP(1)
	nationality, 
	COUNT(nationality) AS driver_country_count
FROM drivers
GROUP BY nationality
ORDER BY driver_country_count DESC;


CREATE VIEW status_result
AS
SELECT 
	sp.statusId,
	st.status
FROM [dbo].[sprint_results] AS sp
INNER JOIN [dbo].[status] AS st
    ON st.statusId = sp.statusId;
GO

--Status Count
SELECT status, COUNT(statusId) AS status_count
FROM status_result
GROUP BY status
ORDER BY status_count DESC
