CREATE TABLE SDOT_TYPE (
    SDOT_COLCODE INT,
    SDOT_COLDESC VARCHAR(255)
);

INSERT INTO SDOT_TYPE (SDOT_COLCODE, SDOT_COLDESC)
SELECT DISTINCT SDOT_COLCODE, SDOT_COLDESC
FROM test
ORDER BY SDOT_COLCODE ASC;


--------------------------------------------------------------------------------------


-- Creating a temp_conditions table for the purpose of grouping based on (weather, roadcond, lightcond) to get unique combinations 

CREATE TABLE IF NOT EXISTS temp_conditions1 AS SELECT WEATHER, ROADCOND, LIGHTCOND FROM test GROUP BY WEATHER, ROADCOND, LIGHTCOND;



-- Creating temp_conditions to assign a unique ID number (CONDIT_ID) to each distinct combination of WEATHER, ROADCOND, LIGHTCOND
-- NOTE: There are 447 unique combinations of weather/road/light conditions

CREATE TABLE IF NOT EXISTS CONDITIONS('CONDIT_ID' INTEGER PRIMARY KEY NOT NULL, 'WEATHER' TEXT, 'ROADCOND' TEXT, 'LIGHTCOND' TEXT); 
INSERT INTO conditions(WEATHER, ROADCOND, LIGHTCOND) SELECT WEATHER, ROADCOND, LIGHTCOND FROM temp_conditions1;

DROP TABLE temp_conditions1; -- Not needed anymore 



-- Doing it this way since doing 'SELECT *' is forbidden (?)
-- Includes an extra column 'CONDIT_ID' to hold the condit_id taken from the temp_conditions table
CREATE TABLE IF NOT EXISTS 'test_2'(
'X' TEXT, 'Y' TEXT, 'OBJECTID' TEXT, 'INCKEY' TEXT,
 'COLDETKEY' TEXT, 'REPORTNO' TEXT, 'STATUS' TEXT, 'ADDRTYPE' TEXT,
 'INTKEY' TEXT, 'LOCATION' TEXT, 'EXCEPTRSNCODE' TEXT, 'EXCEPTRSNDESC' TEXT,
 'SEVERITYCODE' TEXT, 'SEVERITYDESC' TEXT, 'COLLISIONTYPE' TEXT, 'PERSONCOUNT' TEXT,
 'PEDCOUNT' TEXT, 'PEDCYLCOUNT' TEXT, 'VEHCOUNT' TEXT, 'INJURIES' TEXT,
 'SERIOUSINJURIES' TEXT, 'FATALITIES' TEXT, 'INCDATE' TEXT, 'INCDTTM' TEXT,
 'JUNCTIONTYPE' TEXT, 'SDOT_COLCODE' TEXT, 'SDOT_COLDESC' TEXT, 'INATTENTIONIND' TEXT,
 'UNDERINFL' TEXT, 'WEATHER' TEXT, 'ROADCOND' TEXT, 'LIGHTCOND' TEXT, 'CONDIT_ID' INT,
 'PEDROWNOTGRNT' TEXT, 'SDOTCOLNUM' TEXT, 'SPEEDING' TEXT, 'ST_COLCODE' TEXT,
 'ST_COLDESC' TEXT, 'SEGLANEKEY' TEXT, 'CROSSWALKKEY' TEXT, 'HITPARKEDCAR' TEXT,
 'SOURCE' TEXT, 'SOURCEDESC' TEXT, 'ADDBY' TEXT, 'ADDDTTM' TEXT,
 'MODBY' TEXT, 'MODDTTM' TEXT, 'ST_PARTCPNT_TYPE' TEXT, 'ST_PARTCPNT_TYPE_DESC' TEXT,
 'ST_AGE' TEXT, 'ST_CITED' TEXT, 'ST_VEH_TYPE_CD' TEXT, 'ST_VEH_TYPE_DESC' TEXT,
 'ST_INJRY_CLSS_DESC' TEXT, FOREIGN KEY(CONDIT_ID) REFERENCES conditions(CONDIT_ID));



-- Now filling test_2 with data from test and temp_conditions

INSERT INTO test_2(X, Y, OBJECTID, INCKEY,
COLDETKEY, REPORTNO, STATUS, ADDRTYPE,
INTKEY, LOCATION, EXCEPTRSNCODE, EXCEPTRSNDESC,
SEVERITYCODE, SEVERITYDESC, COLLISIONTYPE, PERSONCOUNT,
PEDCOUNT, PEDCYLCOUNT, VEHCOUNT, INJURIES,
SERIOUSINJURIES, FATALITIES, INCDATE, INCDTTM,
JUNCTIONTYPE, SDOT_COLCODE, SDOT_COLDESC, INATTENTIONIND,
UNDERINFL, WEATHER, ROADCOND, LIGHTCOND, CONDIT_ID,
PEDROWNOTGRNT, SDOTCOLNUM, SPEEDING, ST_COLCODE,
ST_COLDESC, SEGLANEKEY, CROSSWALKKEY, HITPARKEDCAR,
SOURCE, SOURCEDESC, ADDBY, ADDDTTM,
MODBY, MODDTTM, ST_PARTCPNT_TYPE, ST_PARTCPNT_TYPE_DESC,
ST_AGE, ST_CITED, ST_VEH_TYPE_CD, ST_VEH_TYPE_DESC,
ST_INJRY_CLSS_DESC)

SELECT X, Y, OBJECTID, INCKEY,
COLDETKEY, REPORTNO, STATUS, ADDRTYPE,
INTKEY, LOCATION, EXCEPTRSNCODE, EXCEPTRSNDESC,
SEVERITYCODE, SEVERITYDESC, COLLISIONTYPE, PERSONCOUNT,
PEDCOUNT, PEDCYLCOUNT, VEHCOUNT, INJURIES,
SERIOUSINJURIES, FATALITIES, INCDATE, INCDTTM,
JUNCTIONTYPE, SDOT_COLCODE, SDOT_COLDESC, INATTENTIONIND,
UNDERINFL, t.WEATHER, t.ROADCOND, t.LIGHTCOND, c.CONDIT_ID,
PEDROWNOTGRNT, SDOTCOLNUM, SPEEDING, ST_COLCODE,
ST_COLDESC, SEGLANEKEY, CROSSWALKKEY, HITPARKEDCAR,
SOURCE, SOURCEDESC, ADDBY, ADDDTTM,
MODBY, MODDTTM, ST_PARTCPNT_TYPE, ST_PARTCPNT_TYPE_DESC,
ST_AGE, ST_CITED, ST_VEH_TYPE_CD, ST_VEH_TYPE_DESC,
ST_INJRY_CLSS_DESC FROM test as t, conditions as c
WHERE (t.WEATHER = c.WEATHER AND t.ROADCOND = c.ROADCOND AND t.LIGHTCOND = c.LIGHTCOND);

-- Cleaning up test_2; since we have condit_id and the conditions table, remove the (WEATHER, ROADCOND, LIGHTCOND) columns from the main table
ALTER TABLE test_2 DROP COLUMN WEATHER;
ALTER TABLE test_2 DROP COLUMN ROADCOND;
ALTER TABLE test_2 DROP COLUMN LIGHTCOND;

DROP TABLE test;
ALTER TABLE test_2 RENAME TO test;


--------------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ST_SEVERITY (
  ST_SEVERITY_CODE VARCHAR(50),
  ST_SEVERITY_DESC VARCHAR(255)
);

INSERT INTO ST_SEVERITY (ST_SEVERITY_CODE, ST_SEVERITY_DESC)
SELECT DISTINCT SEVERITYCODE, SEVERITYDESC
FROM test
ORDER BY SEVERITYCODE ASC;


--------------------------------------------------------------------------------------


CREATE TABLE ST_TYPE (
    ST_COLCODE INT, 
    ST_COLDESC VARCHAR(200)
);

INSERT INTO ST_TYPE (ST_COLCODE, ST_COLDESC)
SELECT DISTINCT ST_COLCODE, ST_COLDESC
FROM test 
ORDER BY ST_COLCODE ASC;
	

--------------------------------------------------------------------------------------


ALTER TABLE test DROP COLUMN SDOT_COLDESC;
ALTER TABLE test DROP COLUMN SEVERITYDESC;
ALTER TABLE test DROP COLUMN ST_COLDESC;

ALTER TABLE test RENAME TO COLLISIONS