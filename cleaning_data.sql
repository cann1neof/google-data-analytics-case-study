-- Data Cleaning

DROP TABLE IF EXISTS `cnne-case-studies.case_1.combined-tripdata-cleaned`;

CREATE TABLE IF NOT EXISTS `cnne-case-studies.case_1.combined-tripdata-cleaned` AS (
  SELECT 
    table_a.ride_id,
    rideable_type,
    started_at,
    ended_at, 
    ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name,
    end_station_name, 
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
  FROM `cnne-case-studies.case_1.combined-tripdata` AS table_a      -- table for adding new fields
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) * 60 +
      EXTRACT(SECOND FROM (ended_at - started_at))) AS ride_length  --duration of ride in seconds
    FROM `cnne-case-studies.case_1.combined-tripdata`
  ) AS table_b                                                      -- table for cleaning nulls
  ON table_a.ride_id = table_b.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 60 AND ride_length < 24*60*60
);

ALTER TABLE `cnne-case-studies.case_1.combined-tripdata-cleaned`     -- set ride_id as primary key
ADD PRIMARY KEY(ride_id) NOT ENFORCED;

SELECT COUNT(ride_id) AS no_of_rows                                  -- returned 4,245,876 rows
FROM `cnne-case-studies.case_1.combined-tripdata-cleaned`;