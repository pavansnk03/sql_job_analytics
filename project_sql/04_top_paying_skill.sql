-- Top paying skills


SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
inner join 
    skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join 
    skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    -- AND job_work_from_home = True
group by skills
ORDER BY 
    avg_salary DESC
limit 10