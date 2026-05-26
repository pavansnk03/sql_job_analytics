-- Skills Reqd for top paying jobs

WITH top_paying_jobs as(
    SELECT  
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name as company_name
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON company_dim.company_id = job_postings_fact.company_id

    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere'   AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*, 
    skills
FROM top_paying_jobs
inner join 
    skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
inner join 
skills_dim on skills_dim.skill_id = skills_job_dim.skill_id

ORDER BY salary_year_avg DESC








