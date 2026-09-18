/* Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data engineer.
- Focus on all job postings.
- Why? Retrievs the top 5 skills with the highest demand in the 
  job market, providing insights into the most valuable skills 
  for job seekers 
*/

SELECT 
    skills skill_name,
    COUNT(sj.job_id) demand_count
FROM job_postings_fact AS jp
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE 
    job_title_short = 'Data Engineer'
    AND job_work_from_home = TRUE
GROUP BY skill_name
ORDER BY demand_count DESC
LIMIT 5;

/* A few things stand out looking at the top 5 in-demand skills across all Data Engineer postings:

SQL and Python are nearly tied for the top spot. SQL leads with 14,213 mentions,
just narrowly ahead of Python's 13,893 — a gap of only about 2%. Together they
form a clear top tier, well ahead of everything else on the list.

There's a real drop-off after the top two. AWS, sitting at #3, has 8,570
mentions — over 5,000 fewer than Python. That gap suggests SQL and Python are
closer to "essential for the role," while the remaining three are common, but
a step below.

Cloud platforms take two of the five spots. AWS (8,570) and Azure (6,997) both
made the list, and neither one dominates — Azure trails AWS by roughly 1,600
mentions, with both sitting well behind SQL and Python.

Spark is the only specialized tool to break into the top 5. SQL, Python, AWS,
and Azure are all broad, foundational skills — Spark is a distributed data
processing framework, so its 6,612 mentions are notable for a much more
specialized tool to be sitting this high on an all-postings list.

Compared against the top-paying postings from query 2, the picture flips in
an interesting way: SQL and the two cloud platforms are the most in-demand
skills overall, yet they barely showed up in the highest-paying jobs — SQL in
just 2 of 10, AWS and Azure in only 1 posting each. Python and Spark, by
contrast, showed up disproportionately in both lists. That pattern suggests
SQL and basic cloud knowledge are treated as baseline expectations across the
market, while Python and Spark are closer to what actually distinguishes the
highest-paying roles. 

[
  {
    "skill_name": "sql",
    "demand_count": "14213"
  },
  {
    "skill_name": "python",
    "demand_count": "13893"
  },
  {
    "skill_name": "aws",
    "demand_count": "8570"
  },
  {
    "skill_name": "azure",
    "demand_count": "6997"
  },
  {
    "skill_name": "spark",
    "demand_count": "6612"
  }
]*/