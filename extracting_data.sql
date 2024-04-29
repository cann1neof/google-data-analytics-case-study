SELECT 
  COUNT(ride_id) AS rides_amount,
  AVG(ride_length / 60) AS avg_ride_length_in_minutes,
  member_casual,
  month
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  member_casual,
  month
ORDER BY
  member_casual;

SELECT 
  COUNT(ride_id) AS rides_amount,
  AVG(ride_length / 60) AS avg_ride_length_in_minutes,
  member_casual,
  day_of_week
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  member_casual,
  day_of_week
ORDER BY
  member_casual;

SELECT 
  COUNT(ride_id) AS rides_amount,
  AVG(ride_length / 60) AS avg_ride_length_in_minutes,
  member_casual,
  EXTRACT(HOUR FROM started_at) AS hour_of_day
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  member_casual,
  hour_of_day
ORDER BY
  member_casual;

SELECT 
  count(ride_id) AS rides_amount,
  member_casual,
  rideable_type
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  member_casual,
  rideable_type
ORDER BY
  member_casual;

SELECT 
  count(ride_id) AS rides_amount,
  member_casual,
  rideable_type
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  member_casual,
  rideable_type
ORDER BY
  member_casual;

SELECT
  (SELECT COUNT(ride_id) FROM `cnne-case-studies.case_1.combined-tripdata-cleaned`) AS total_rides_amount,
  COUNT(ride_id) AS rides_amount,
  start_station_name,
  AVG(start_lat) AS start_lat,
  AVG(start_lng) AS start_lng
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  start_station_name
ORDER BY
  rides_amount DESC
LIMIT
  20;


SELECT
  (SELECT COUNT(ride_id) FROM `cnne-case-studies.case_1.combined-tripdata-cleaned`) AS total_rides_amount,
  COUNT(ride_id) AS rides_amount,
  end_station_name,
  AVG(end_lat) AS end_lat,
  AVG(end_lng) AS end_lng
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  end_station_name
ORDER BY
  rides_amount DESC
LIMIT
  20;

SELECT
  AVG(ride_length / 60) AS avg_ride_length,
  start_station_name,
  AVG(start_lat) AS start_lat,
  AVG(start_lng) AS start_lng
FROM
  `cnne-case-studies.case_1.combined-tripdata-cleaned`
GROUP BY
  start_station_name
ORDER BY
  avg_ride_length DESC
LIMIT
  20;