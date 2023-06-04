-- QUERY #1 Percentage of fatalities at certain JUNCTIONTYPEs
CREATE TABLE JUNCTIONTYPE_FATALITIES AS
SELECT JUNCTIONTYPE, COUNT(FATALITIES) AS FATALITIES
FROM collisions
WHERE JUNCTIONTYPE IS NOT NULL AND FATALITIES IS NOT NULL AND FATALITIES > 0
GROUP BY JUNCTIONTYPE;

UPDATE JUNCTIONTYPE_FATALITIES
SET JUNCTIONTYPE = NULL
WHERE JUNCTIONTYPE = '';

DELETE FROM JUNCTIONTYPE_FATALITIES
WHERE JUNCTIONTYPE IS NULL;

-- Table with the total amount of fatalities that happened at specific intersections
CREATE TABLE temp_total AS
SELECT COUNT(FATALITIES) AS total_count
FROM collisions
WHERE FATALITIES > 0;

-- Update the JUNCTIONTYPE_FATALITIES and adding percentage column
ALTER TABLE JUNCTIONTYPE_FATALITIES
ADD COLUMN percentage INT;

UPDATE JUNCTIONTYPE_FATALITIES
SET percentage = (JUNCTIONTYPE_FATALITIES.FATALITIES * 1.0 / temp_total.total_count) * 100
FROM temp_total;

DROP TABLE temp_total;
SELECT * FROM JUNCTIONTYPE_FATALITIES;

-- #QUERY 2
-- Create table to hold values: collision type and resulting fatalities
CREATE TABLE COLLISION_FATALITIES AS
SELECT COLLISIONTYPE, COUNT(FATALITIES) AS FATALITIES
FROM collisions
WHERE COLLISIONTYPE IS NOT NULL AND FATALITIES IS NOT NULL
GROUP BY COLLISIONTYPE;

UPDATE COLLISION_FATALITIES
SET COLLISIONTYPE = NULL
WHERE COLLISIONTYPE = '';

DELETE FROM COLLISION_FATALITIES
WHERE COLLISIONTYPE IS NULL;

SELECT * FROM COLLISION_FATALITIES;
