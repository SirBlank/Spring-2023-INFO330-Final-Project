-- *REQUIRES THE linked_conditions VIEW CREATED IN THE quang_conditions_queries FILE*

-- Code for exporting a table from SQLITE into a CSV
CREATE TABLE temp_vis AS SELECT LIGHTCOND, COUNT(LIGHTCOND) FROM linked_conditions GROUP BY LIGHTCOND ORDER BY COUNT(LIGHTCOND) DESC;

.headers on
.mode csv
.output testdata.csv
SELECT * FROM temp_vis;

-- Then clean up the "unknown" and "blank" columns, plug that into PowerBI