-- Data Exploration

SELECT 
  COUNT(*) - COUNT(ride_id) AS ride_id,
  COUNT(*) - COUNT(rideable_type) AS rideable_type,
  COUNT(*) - COUNT(started_at) AS started_at,
  COUNT(*) - COUNT(ended_at) AS ended_at,
  COUNT(*) - COUNT(start_station_name) AS start_station_name,
  COUNT(*) - COUNT(start_station_id) AS start_station_id,
  COUNT(*) - COUNT(end_station_name) AS end_station_name,
  COUNT(*) - COUNT(end_station_id) AS end_station_id,
  COUNT(*) - COUNT(start_lat) AS start_lat,
  COUNT(*) - COUNT(start_lng) AS start_lng,
  COUNT(*) - COUNT(end_lat) AS end_lat,
  COUNT(*) - COUNT(end_lng) AS end_lng,
  COUNT(*) - COUNT(member_casual) AS member_casual
FROM 
  `cnne-case-studies.case_1.combined-tripdata`;

SELECT 
  COUNT(ride_id) - COUNT(DISTINCT ride_id) AS amount_of_dublicates
FROM 
  `cnne-case-studies.case_1.combined-tripdata`;

SELECT 
  LENGTH(ride_id) AS ride_id_len, 
  COUNT(ride_id) AS amount
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
GROUP BY
  ride_id_len;

SELECT 
  DISTINCT rideable_type,
  COUNT(rideable_type) AS amount
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
GROUP BY
  rideable_type;

SELECT 
  COUNT(*) AS longer_than_a_day
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at))+
  EXTRACT(SECOND FROM (ended_at - started_at))/60) >= (24*60);

SELECT COUNT(*) AS less_than_a_minute
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60+
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at))/ 60) <= 1;

SELECT 
  COUNT(ride_id) AS amount_of_nulls          -- return 866105 rows
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
WHERE
  start_station_name IS NULL OR 
  start_station_id IS NULL;

SELECT
  COUNT(ride_id) AS amount_of_nulls          -- return 920524 rows
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
WHERE 
  end_station_name IS NULL OR 
  end_station_id IS NULL;

SELECT                                      -- return 7353 rows
  COUNT(ride_id) AS amount_of_nulls
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
WHERE
  end_lat IS NULL OR
  end_lng IS NULL;

SELECT
  DISTINCT member_casual,
  COUNT(member_casual) AS amount
FROM 
  `cnne-case-studies.case_1.combined-tripdata`
GROUP BY 
  member_casual;



