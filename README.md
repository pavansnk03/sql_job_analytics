````md
# SQL Job Analytics

A PostgreSQL SQL project for analyzing job postings, salaries, and skills demand.  
This project explores which jobs pay the most, which skills are most requested, and which skills offer the best balance between demand and salary.

## Overview

The goal of this project is to practice SQL by answering real-world job market questions using job posting data.  
It includes:

- database creation scripts
- table creation and schema modification scripts
- analytical SQL queries for insights on jobs and skills

The project is structured so you can run the setup scripts first, load the data, and then execute the analysis queries.

---

## Features

- Create a PostgreSQL database for job analytics
- Build tables for job postings, skills, and related mappings
- Load and prepare data for analysis
- Find top-paying jobs
- Identify most in-demand skills
- Compare skill demand with salary potential
- Search for the best skills to learn for a data analyst role

---

## Repository Structure

```bash
sql_job_analytics/
├── sql_load/
│   ├── 1_create_database.sql
│   ├── 2_create_tables.sql
│   └── 3_modify_tables.sql
├── project_sql/
│   ├── 01_top_pay_jobs.sql
│   ├── 02_reqd_skills.sql
│   ├── 03_in_demand_skills.sql
│   ├── 04_top_paying_skill.sql
│   └── 05_optimal_skill.sql
└── README.md
````

---

## Dataset / Tables

This project is built around a job postings dataset with skill mapping tables.
Typical tables used in this kind of setup include:

* `job_postings_fact`
* `skills_dim`
* `skills_job_dim`

These tables support analysis such as:

* job title
* salary
* work-from-home flag
* required skills
* skill frequency
* skill salary comparisons

---

## Prerequisites

Before running the scripts, make sure you have:

* PostgreSQL installed
* pgAdmin or psql available
* CSV files or data source ready for loading
* basic knowledge of SQL

---

## Setup Instructions

### 1. Create the database

Run:

```sql
\i sql_load/1_create_database.sql
```

or execute the file inside pgAdmin.

### 2. Create the tables

Run:

```sql
\i sql_load/2_create_tables.sql
```

This will create the base schema required for the analysis.

### 3. Modify the tables

Run:

```sql
\i sql_load/3_modify_tables.sql
```

This file is used for schema updates such as adding or adjusting columns, keys, or constraints.

---

## Loading Data

After creating the tables, load the CSV data into the database.

If you are using `psql`, use `\copy` for local files:

```sql
\copy job_postings_fact FROM 'path/to/job_postings_fact.csv' DELIMITER ',' CSV HEADER;
\copy skills_dim FROM 'path/to/skills_dim.csv' DELIMITER ',' CSV HEADER;
\copy skills_job_dim FROM 'path/to/skills_job_dim.csv' DELIMITER ',' CSV HEADER;
```

If you are using pgAdmin, you can import the CSV files through the table import option.

---

## Running the Analysis Queries

The main analytical scripts are inside the `project_sql/` folder.

### 01_top_pay_jobs.sql

Finds the highest-paying jobs in the dataset.

Questions it helps answer:

* Which jobs offer the highest salary?
* Which companies pay the most?
* Which roles are worth targeting first?

### 02_reqd_skills.sql

Analyzes the most commonly requested skills.

Questions it helps answer:

* Which skills appear most often in job descriptions?
* What skills are companies asking for most?

### 03_in_demand_skills.sql

Looks at the most in-demand skills for a target role.

Questions it helps answer:

* Which skills are most requested for a specific job type?
* What should a candidate prioritize while preparing?

### 04_top_paying_skill.sql

Finds which skills are associated with the highest salaries.

Questions it helps answer:

* Which skills tend to appear in high-paying roles?
* What technical skills may lead to better compensation?

### 05_optimal_skill.sql

Combines demand and salary to find the best overall skills.

Questions it helps answer:

* Which skills are both popular and well paid?
* What should a learner focus on first?

---

## Example Use Case

This project is especially useful for someone trying to become a data analyst.

You can use it to answer questions like:

* What salary range should I expect?
* Which tools should I learn first?
* Which skills are best for remote jobs?
* Which skills improve both employability and pay?

---

## SQL Concepts Used

This project uses common and important SQL techniques, including:

* `SELECT`
* `JOIN`
* `INNER JOIN`
* `WHERE`
* `GROUP BY`
* `COUNT`
* `AVG`
* `ROUND`
* `CTE` with `WITH`
* `ORDER BY`
* `EXTRACT`
* filtering by salary and remote work conditions

---

## Example Query Pattern

A common analysis pattern in this project is:

1. join job data with skill mapping data
2. filter by role, salary, or work type
3. group by skill
4. calculate demand count or average salary
5. sort by the result

Example:

```sql
WITH skill_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim 
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id,
        skills_dim.skills
)
SELECT *
FROM skill_demand;
```

---

## How to Customize the Analysis

You can easily modify the scripts to explore other roles or filters.

Examples:

* change `'Data Analyst'` to another job title
* filter by country or location
* remove the remote work condition
* analyze monthly or yearly trends
* compare different salary bands

---

## What I Learned

This project is good practice for:

* relational database design
* writing reusable SQL queries
* working with real-world job data
* combining salary and skills analysis
* turning raw data into useful insights

---

## Future Improvements

Possible next steps for this project:

* add dashboards using Power BI, Tableau, or Python
* include more job roles
* analyze trends by year or month
* add more detailed salary segmentation
* create exported summary tables for reporting
* document the exact dataset source and schema

---

## Notes

* Make sure all CSV file paths are correct before importing.
* Run the setup scripts in order.
* If a query fails, check column names, table names, and data types.
* Use `\copy` instead of `COPY` for local file imports in PostgreSQL when needed.

