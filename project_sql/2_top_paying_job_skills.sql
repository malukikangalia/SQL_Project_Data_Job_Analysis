/* Question: What skills are required for the top paying Data Engineering jobs?
- Use the top 10 highest paying Data Engineering roles from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high paying jobs 
  demand certain skills, helping job seekers understand which 
  skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM job_postings_fact jp
    LEFT JOIN company_dim c ON jp.company_id = c.company_id
    WHERE 
        job_title_short = 'Data Engineer'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    tpj.*,
    s.skills AS skill_name
FROM top_paying_jobs AS tpj
INNER JOIN skills_job_dim AS sj ON tpj.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
ORDER BY tpj.salary_year_avg DESC;

/* A few things stand out looking at these 10 postings and their 22 distinct skills:

These are the highest-paying remote postings specifically, not top-paying Data
Engineer jobs overall. Query 1 filtered on job_location = 'Anywhere', so everything
below describes the top of the remote-work slice — not necessarily what the highest
salaries look like for in-office or hybrid roles.

Python is the one near-universal requirement. It shows up in 7 of the 10 highest-paying
postings, more than any other skill by a wide margin.

The "big data trio" travels together. Spark shows up 5 times; Hadoop and Kafka show up
3 times each — and notably, almost always on the same postings as one another. A company
asking for one of these three tends to ask for all three. That's the classic
distributed-data-processing stack (batch + streaming), not three independent skills.

One job was completely distinct from the rest. The Twitch posting (Director of
Engineering – Data Platform, $251K) is the only one listing TensorFlow, Keras, and
PyTorch — alongside Spark, Hadoop, and Kafka. This role reads closer to ML
infrastructure/MLOps than classic ETL-style data engineering, despite carrying a
similar "data engineer" label.

At the very top salary level, no single cloud platform stands out. AWS, Azure, and GCP
each appear exactly once, across three different companies. That's surprising, since
cloud skills usually show up a lot in data engineering job postings overall — but among
these 10 highest-paying jobs, there's no clear favorite.

Two pairs of postings are essentially duplicates, which changes how the counts above
should be read. Job IDs 21321 and 157003 (both "Data Engineer" at Engtal, $325K) have
identical skill lists, and 595768/543728 (Signify Technology, $250K) also share an
identical skill set despite different titles (Principal vs. Staff). Collapsing those
duplicates, this is really 8 unique postings, not 10 — so Python's "7 of 10" is closer
to "5 of 8 unique roles," and several of the counts above are modestly inflated by the
same requirement being counted twice.

Knowing more tools doesn't automatically mean more money. The #1 job (Engtal, $325K)
lists 8 skills — but the #2 job (Durlston Partners, $300K) lists only 2 (SQL, Python),
and Handshake's Staff Data Engineer at $245K lists just one (Go). At the very top of the
pay scale, company and role scope seem to matter more than how many tools are
name-checked in the listing.

SQL is underrepresented for a "foundational" skill, appearing in only 2 of 10 postings.
That's probably because at this level, companies assume you already know SQL, so 
they don't bother listing it, while the specialized tools — the ones that actually 
differentiate one high-paying role from another — are what get called out.

One caveat worth keeping in mind throughout: this is a sample of just 10 postings (8
once duplicates are collapsed), so patterns like "no cloud consensus" or "SQL is rare"
describe this specific top-paying slice, not the broader Data Engineer market — a larger
sample (say, all 2023 postings) would likely show different, more stable percentages.

[
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "python"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "spark"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "pandas"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "numpy"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "pyspark"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "hadoop"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "kafka"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "kubernetes"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "python"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "spark"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "pandas"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "numpy"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "pyspark"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "hadoop"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "kafka"
  },
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "salary_year_avg": "325000.0",
    "skill_name": "kubernetes"
  },
  {
    "job_id": 270455,
    "job_title": "Data Engineer",
    "company_name": "Durlston Partners",
    "salary_year_avg": "300000.0",
    "skill_name": "sql"
  },
  {
    "job_id": 270455,
    "job_title": "Data Engineer",
    "company_name": "Durlston Partners",
    "salary_year_avg": "300000.0",
    "skill_name": "python"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "salary_year_avg": "251000.0",
    "skill_name": "spark"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "salary_year_avg": "251000.0",
    "skill_name": "hadoop"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "salary_year_avg": "251000.0",
    "skill_name": "kafka"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "salary_year_avg": "251000.0",
    "skill_name": "tensorflow"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "salary_year_avg": "251000.0",
    "skill_name": "keras"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "salary_year_avg": "251000.0",
    "skill_name": "pytorch"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "python"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "scala"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "databricks"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "spark"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "python"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "scala"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "databricks"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "company_name": "Signify Technology",
    "salary_year_avg": "250000.0",
    "skill_name": "spark"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "company_name": "AI Startup",
    "salary_year_avg": "250000.0",
    "skill_name": "python"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "company_name": "AI Startup",
    "salary_year_avg": "250000.0",
    "skill_name": "scala"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "company_name": "AI Startup",
    "salary_year_avg": "250000.0",
    "skill_name": "r"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "company_name": "AI Startup",
    "salary_year_avg": "250000.0",
    "skill_name": "azure"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "company_name": "Movable Ink",
    "salary_year_avg": "245000.0",
    "skill_name": "nosql"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "company_name": "Movable Ink",
    "salary_year_avg": "245000.0",
    "skill_name": "aws"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "company_name": "Movable Ink",
    "salary_year_avg": "245000.0",
    "skill_name": "gcp"
  },
  {
    "job_id": 204320,
    "job_title": "Staff Data Engineer",
    "company_name": "Handshake",
    "salary_year_avg": "245000.0",
    "skill_name": "go"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "company_name": "Meta",
    "salary_year_avg": "242000.0",
    "skill_name": "sql"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "company_name": "Meta",
    "salary_year_avg": "242000.0",
    "skill_name": "python"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "company_name": "Meta",
    "salary_year_avg": "242000.0",
    "skill_name": "java"
  },
  {
    "job_id": 609418,
    "job_title": "Data Engineering Manager",
    "company_name": "Meta",
    "salary_year_avg": "242000.0",
    "skill_name": "perl"
  }
] 
 */