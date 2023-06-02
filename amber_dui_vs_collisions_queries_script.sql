SELECT * FROM collisions;

-- What is the percentage of collisions involving drivers under the influence?
SELECT ROUND((COUNT(CASE WHEN UNDERINFL = '1' OR UNDERINFL = 'Y' THEN 1 END) * 100.0) / COUNT(*), 2) AS DUI_percentage
FROM collisions;
	
-- What are the percentages of collisions involving DUI for each severity code?
SELECT c.SeverityCode, s.SEVERITYDESC,
	   ROUND((COUNT(CASE WHEN (c.UNDERINFL = '1' OR c.UNDERINFL = 'Y') THEN 1 END) * 100.0) / COUNT(*), 2) AS DUI_percentage
FROM collisions c
JOIN severity s ON c.SeverityCode = s.SeverityCode
WHERE c.SEVERITYCODE IN ('3', '2b', '2', '1', '0')
GROUP BY c.SeverityCode, s.SEVERITYDESC;
	


	
	
	
-- What is the percentage of collisions involving distracted driving?
SELECT ROUND((COUNT(CASE WHEN INATTENTIONIND = 'Y' THEN 1 END) * 100.0) / COUNT(*), 2) AS distracted_driving_percentage
FROM collisions;

-- percentages of distracted driving for each severity code
SELECT c.SeverityCode, s.SEVERITYDESC,
	   ROUND((COUNT(CASE WHEN (c.INATTENTIONIND = 'Y') THEN 1 END) * 100.0) / COUNT(*), 2) AS DUI_percentage
FROM collisions c
JOIN severity s ON c.SeverityCode = s.SeverityCode
WHERE c.SEVERITYCODE IN ('3', '2b', '2', '1', '0')
GROUP BY c.SeverityCode, s.SEVERITYDESC;
