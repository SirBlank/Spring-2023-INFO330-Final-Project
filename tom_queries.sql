-- This finds the overall proportion distrobution of collision types - 
with descCount AS 
(SELECT SDOT_COLCODE,
count(SDOT_COLCODE) AS cnt, 
(SELECT count(OBJECTID) FROM collisions) AS total
FROM collisions
GROUP BY SDOT_COLCODE)

SELECT dc.SDOT_COLCODE
,st.SDOT_COLDESC
,dc.cnt
,dc.total
, ROUND(((CAST(dc.cnt AS float))/dc.total * 100), 2) AS percentage

FROM descCount dc 
    JOIN SDOT_type st ON dc.SDOT_COLCODE = st.SDOT_COLCODE
ORDER BY cnt DESC;

-- Finds the above, but only under wet road conditions 
with descCount AS 
(SELECT col.SDOT_COLCODE,
count(SDOT_COLCODE) AS cnt, 
(SELECT count(OBJECTID) FROM collisions) AS total
FROM collisions col join conditions cond ON col.condit_id = cond.condit_id
WHERE cond.ROADCOND = 'Wet'
GROUP BY SDOT_COLCODE)

SELECT dc.SDOT_COLCODE
,st.SDOT_COLDESC
,dc.cnt
,dc.total
,(CAST(dc.cnt AS float))/dc.total AS prop

FROM descCount dc 
    JOIN SDOT_type st ON dc.SDOT_COLCODE = st.SDOT_COLCODE 
ORDER BY cnt DESC;


-- Find proportion of all incidents that involve a pedestrian
WITH overallPed AS
    (SELECT PEDCOUNT,
    count(PEDCOUNT) as num,
    (SELECT count(OBJECTID) FROM collisions) AS total
    FROM collisions
    WHERE PEDCOUNT > 0)

SELECT op.num
,op.total
,(CAST(op.num AS float))/op.total AS overall_involving_peds 

FROM overallPed AS op;


-- find proportion of fatal incidents involving a pedestrian
WITH fatalPed AS
    (SELECT PEDCOUNT,
    FATALITIES,
    count(PEDCOUNT) as num,
    (SELECT count(OBJECTID) FROM collisions WHERE FATALITIES > 0) AS total
    FROM collisions
    WHERE FATALITIES > 0 AND PEDCOUNT > 0)

SELECT fp.num
,fp.total
,(CAST(fp.num AS float))/fp.total AS fatal_involving_peds 

FROM fatalPed AS fp;
