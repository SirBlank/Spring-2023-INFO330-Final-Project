-- Creating a VIEW (links conditions table and DUI, speeding, and inattention from the main collisions table) 
CREATE VIEW linked_conditions AS SELECT m.OBJECTID, m.SeverityCode, m.UNDERINFL, m.INATTENTIONIND, m.SPEEDING, m.CONDIT_ID, c.WEATHER, c.ROADCOND, c.LIGHTCOND
FROM collisions as m, conditions as c WHERE m.condit_id = c.condit_id;

--------------------------------------------------------------------------------------------------

-- Which light condition is connected to the most collisions in Seattle?
-- Results indicate that daylight is the most common light condition for accidents, maybe because of sunlight blinding + most driving happening during the day
-- Create a pie chart out of this table, combine " " and "unknown" into one slice 
SELECT LIGHTCOND, COUNT(LIGHTCOND) FROM linked_conditions GROUP BY LIGHTCOND ORDER BY COUNT(LIGHTCOND) DESC;


-- Which light condition is connected to the most serious or fatal collisions?
-- Results: 'Dark - Street Lights Off' has the highest ratio (2.62%) of serious collisions, followed closely by 'Dawn' (2.60%)

-- Daylight serious percentage
-- 1.72%
SELECT ROUND((COUNT(CASE WHEN SEVERITYCODE = '3' OR SEVERITYCODE = '2b' THEN 1 END) * 100.0) / COUNT(*), 2) AS serious_daylight_percentage
FROM linked_conditions WHERE LIGHTCOND = 'Daylight';

-- Dark - Street Lights On serious percentage
-- 2.55%
SELECT ROUND((COUNT(CASE WHEN SEVERITYCODE = '3' OR SEVERITYCODE = '2b' THEN 1 END) * 100.0) / COUNT(*), 2) AS serious_dark_w_lights_percentage
FROM linked_conditions WHERE LIGHTCOND = 'Dark - Street Lights On';

-- Dark - Street Lights Off serious percentage
-- 2.62%
SELECT ROUND((COUNT(CASE WHEN SEVERITYCODE = '3' OR SEVERITYCODE = '2b' THEN 1 END) * 100.0) / COUNT(*), 2) AS serious_dark_lightsoff_percentage
FROM linked_conditions WHERE LIGHTCOND = 'Dark - Street Lights Off';

-- Dark - No Street Lights serious percentage
-- 1.83%
SELECT ROUND((COUNT(CASE WHEN SEVERITYCODE = '3' OR SEVERITYCODE = '2b' THEN 1 END) * 100.0) / COUNT(*), 2) AS serious_dark_no_lights_percentage
FROM linked_conditions WHERE LIGHTCOND = 'Dark - No Street Lights';

-- Dusk serious percentage
-- 2.14%
SELECT ROUND((COUNT(CASE WHEN SEVERITYCODE = '3' OR SEVERITYCODE = '2b' THEN 1 END) * 100.0) / COUNT(*), 2) AS serious_dusk_percentage
FROM linked_conditions WHERE LIGHTCOND = 'Dusk';

-- Dawn serious percentage
-- 2.6%
SELECT ROUND((COUNT(CASE WHEN SEVERITYCODE = '3' OR SEVERITYCODE = '2b' THEN 1 END) * 100.0) / COUNT(*), 2) AS serious_dawn_percentage
FROM linked_conditions WHERE LIGHTCOND = 'Dawn';


--------------------------------------------------------------------------------------------------
-- Which junction type is associated with the most collisions?
-- Result: 'Mid-Block (not related to intersection) 
SELECT JUNCTIONTYPE, COUNT(*) FROM collisions GROUP BY JUNCTIONTYPE ORDER BY COUNT(*) DESC;

--------------------------------------------------------------------------------------------------






--------------------------
-- EVERYTHING BELOW IS EXTRA || EVERYTHING BELOW IS EXTRA || EVERYTHING BELOW IS EXTRA -- 


-- Is speeding, inattention, or DUI more dangerous in terms of serious accidents? 
-- Results indicate that speeding is associated with the most serious (2b and 3) collisions.


-- Number of 2b / 3 severity collisions that involved speeding
SELECT severitycode, COUNT(*), SPEEDING FROM linked_conditions WHERE  SPEEDING = 'Y'  AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;


-- Number of 2b / 3 severity collisions that involved inattention 
SELECT severitycode, COUNT(*), INATTENTIONIND FROM linked_conditions WHERE INATTENTIONIND = 'Y' AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;

-- Number of 2b / 3 seveirt collisions that involved DUI
SELECT severitycode, COUNT(*), UNDERINFL FROM linked_conditions WHERE  (UNDERINFL = 'Y' OR UNDERINFL = '1')  AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;

-------------------------------------------------------------------

-- More road-related queries
-- Road conditions that aren't listed here didn't have any 2b / 3 severity collisions
-- Results suggest that wet roads have the most serious collisions, but that might be because they're the most common road conditions in Seattle 
	-- About 10% of wet road collisions were of severity 3, while about 5% of ice road collisions were of severity 3

-- Number of 2b / 3 severity collisions where roads were icy
SELECT severitycode, COUNT(*), ROADCOND FROM linked_conditions WHERE ROADCOND = 'Ice'  AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;

-- Number of 2b / 3 severity collisions where roads were snow/slush
SELECT severitycode, COUNT(*), ROADCOND FROM linked_conditions WHERE ROADCOND = 'Snow/Slush'  AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;

-- Number of 2b / 3 severity collisions where roads were wet
SELECT severitycode, COUNT(*), ROADCOND FROM linked_conditions WHERE ROADCOND = 'Wet'  AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;

-- Number of 2b / 3 severity collisions where roads had standing water
SELECT severitycode, COUNT(*), ROADCOND FROM linked_conditions WHERE ROADCOND = 'Standing Water'  AND (severitycode = '3' OR severitycode = '2b') GROUP BY severitycode;









