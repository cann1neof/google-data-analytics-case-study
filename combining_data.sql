DROP TABLE IF EXISTS `cnne-case-studies.case_1.combined-tripdata`;

CREATE TABLE IF NOT EXISTS `cnne-case-studies.case_1.combined-tripdata` AS (
  SELECT * FROM `cnne-case-studies.case_1.2023-03-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-04-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-05-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-06-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-07-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-08-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-09-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-10-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-11-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2023-12-tripdata`
  UNION ALL

  SELECT * FROM `cnne-case-studies.case_1.2024-01-tripdata`
  UNION ALL
  
  SELECT * FROM `cnne-case-studies.case_1.2024-02-tripdata`
);

SELECT COUNT(*)
FROM `cnne-case-studies.case_1.combined-tripdata`;