/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

Possible Errors: 
- ERROR >>  duplicate key value violates unique constraint "company_dim_pkey"
- ERROR >> could not open file "C:\Users\...\company_dim.csv" for reading: Permission denied

1. Drop the Database 
            DROP DATABASE IF EXISTS sql_course;
2. Repeat steps to create database and load table schemas
            - 1_create_database.sql
            - 2_create_tables.sql
3. Open pgAdmin
4. In Object Explorer (left-hand pane), navigate to `sql_course` database
5. Right-click `sql_course` and select `PSQL Tool`
            - This opens a terminal window to write the following code
6. Get the absolute file path of your csv files
            1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
7. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding
COPY company_dim
FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\HP\Desktop\Coding_Stuff\PostgreSQL\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


SELECT '2023-02-19'::DATE,
    '123'::INTEGER

select
    job_title_short AS job_title, 
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'IST' as date_time,
    EXTRACT(MONTH FROM job_posted_date ) AS date_month,
    EXTRACT(YEAR FROM job_posted_date ) AS date_year
FROM 
    job_postings_fact
limit 10;

select
    COUNT(job_id), 
    EXTRACT(MONTH FROM job_posted_date ) AS month
FROM 
    job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month


select
    avg(salary_year_avg) as yearly,
    avg(salary_hour_avg) as hourly,
    job_schedule_type
FROM 
    job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type 
ORDER BY hourly DESC



select
    count(job_id), 
    EXTRACT(MONTH FROM job_posted_date ) AS date_month,
    EXTRACT(YEAR FROM job_posted_date ) AS date_year
FROM 
    job_postings_fact
where EXTRACT(YEAR FROM job_posted_date ) = 2023
group by date_month,date_year 


select
    job_postings_fact.job_id,
    company_dim.company_id,
    company_dim.name,
    job_postings_fact.job_health_insurance,
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date ) AS date_month,
    EXTRACT(YEAR FROM job_postings_fact.job_posted_date ) AS date_year
FROM 
    job_postings_fact
left join company_dim 
    on job_postings_fact.company_id = company_dim.company_id
where 
    job_postings_fact.job_health_insurance = true AND
    (EXTRACT(YEAR FROM job_postings_fact.job_posted_date ) = 2023 ) AND
    (EXTRACT(MONTH FROM job_postings_fact.job_posted_date ) between 3 and 6)




