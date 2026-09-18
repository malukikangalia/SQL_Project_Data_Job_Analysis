/* Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Engineer roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data engineering */

SELECT 
    s.skill_id,
    s.skills skill_name,
    COUNT(sj.job_id) demand_count,
    ROUND(AVG(salary_year_avg), 2) avg_salary
FROM job_postings_fact AS jp
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE 
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY s.skill_id
HAVING COUNT(sj.job_id) > 30
ORDER BY 
    avg_salary DESC, 
    demand_count DESC
LIMIT 25;

/* A few trends stand out looking at the top 25 in-demand, high-paying skills for remote Data Engineer roles:

Kubernetes tops the list on salary but isn't near the top on demand. $158,189 average with
only 56 postings — the highest pay in this set, but a relatively modest demand count next to
skills like AWS (367) or Python (535). That's the clearest "narrow but well-paid specialty"
signal in the whole list.

SQL and Python — the two most in-demand skills by far (568 and 535 postings) — sit dead last
on salary. This matches a pattern seen in earlier queries: the most universally-required
skills tend to average the lowest pay, likely because they're expected across every
seniority level (junior through staff), which pulls the average down, while more specialized
skills only show up on higher-level postings.

The distributed-data / streaming cluster holds up as a real, repeatable pattern. Kafka,
Spark, PySpark, Hadoop, and Airflow all land in the upper-middle of this list with both
solid demand (64-237 postings) and above-average pay ($137K-$150K). This is the third time
this exact cluster has appeared across different queries in this analysis - not a fluke.

Cloud platforms are common but not a pay differentiator. AWS (367 postings), Azure (254),
and GCP (76) all rank in the bottom third on salary despite strong demand. Cloud familiarity
appears to be table stakes at this point, not something that commands a premium on its own.

Infrastructure/DevOps tools carry a real premium. Kubernetes, Docker, and Terraform all sit
in the upper half on salary despite not being "core data" tools in the traditional sense -
suggestive of data engineering blending into platform/DevOps work at the higher end.

One data-quality flag worth checking before trusting this list: "mongodb" appears twice
(skill_id 62 and 18) with identical demand (32) and identical salary ($138,568.83) both
times - almost certainly two different skill_id rows in skills_dim mapped to the same skill
text, not two genuinely different things, and worth deduplicating before drawing conclusions
from counts that involve it. 

[
  {
    "skill_id": 213,
    "skill_name": "kubernetes",
    "demand_count": "56",
    "avg_salary": "158189.73"
  },
  {
    "skill_id": 98,
    "skill_name": "kafka",
    "demand_count": "134",
    "avg_salary": "150549.04"
  },
  {
    "skill_id": 212,
    "skill_name": "terraform",
    "demand_count": "44",
    "avg_salary": "146057.28"
  },
  {
    "skill_id": 93,
    "skill_name": "pandas",
    "demand_count": "38",
    "avg_salary": "144656.21"
  },
  {
    "skill_id": 3,
    "skill_name": "scala",
    "demand_count": "113",
    "avg_salary": "141777.32"
  },
  {
    "skill_id": 92,
    "skill_name": "spark",
    "demand_count": "237",
    "avg_salary": "139837.61"
  },
  {
    "skill_id": 95,
    "skill_name": "pyspark",
    "demand_count": "64",
    "avg_salary": "139428.36"
  },
  {
    "skill_id": 62,
    "skill_name": "mongodb",
    "demand_count": "32",
    "avg_salary": "138568.83"
  },
  {
    "skill_id": 18,
    "skill_name": "mongodb",
    "demand_count": "32",
    "avg_salary": "138568.83"
  },
  {
    "skill_id": 96,
    "skill_name": "airflow",
    "demand_count": "151",
    "avg_salary": "138518.31"
  },
  {
    "skill_id": 4,
    "skill_name": "java",
    "demand_count": "139",
    "avg_salary": "138087.11"
  },
  {
    "skill_id": 97,
    "skill_name": "hadoop",
    "demand_count": "98",
    "avg_salary": "137707.03"
  },
  {
    "skill_id": 2,
    "skill_name": "nosql",
    "demand_count": "93",
    "avg_salary": "136429.66"
  },
  {
    "skill_id": 6,
    "skill_name": "shell",
    "demand_count": "34",
    "avg_salary": "135499.07"
  },
  {
    "skill_id": 80,
    "skill_name": "snowflake",
    "demand_count": "202",
    "avg_salary": "134372.91"
  },
  {
    "skill_id": 214,
    "skill_name": "docker",
    "demand_count": "64",
    "avg_salary": "134286.25"
  },
  {
    "skill_id": 81,
    "skill_name": "gcp",
    "demand_count": "76",
    "avg_salary": "133387.63"
  },
  {
    "skill_id": 78,
    "skill_name": "redshift",
    "demand_count": "141",
    "avg_salary": "132980.20"
  },
  {
    "skill_id": 76,
    "skill_name": "aws",
    "demand_count": "367",
    "avg_salary": "132865.28"
  },
  {
    "skill_id": 1,
    "skill_name": "python",
    "demand_count": "535",
    "avg_salary": "132199.96"
  },
  {
    "skill_id": 75,
    "skill_name": "databricks",
    "demand_count": "130",
    "avg_salary": "130072.32"
  },
  {
    "skill_id": 74,
    "skill_name": "azure",
    "demand_count": "254",
    "avg_salary": "129574.46"
  },
  {
    "skill_id": 56,
    "skill_name": "mysql",
    "demand_count": "53",
    "avg_salary": "129287.62"
  },
  {
    "skill_id": 0,
    "skill_name": "sql",
    "demand_count": "568",
    "avg_salary": "129190.85"
  },
  {
    "skill_id": 210,
    "skill_name": "git",
    "demand_count": "74",
    "avg_salary": "128352.39"
  }
]*/