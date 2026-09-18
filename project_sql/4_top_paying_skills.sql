/* Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Engineer positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Engineers and 
  helps identify the most financially rewarding skills to acquire or improve */

SELECT
    skills skill_name,
    ROUND(AVG(salary_year_avg), 2) avg_salary
FROM job_postings_fact AS jp
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE 
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skill_name
ORDER BY avg_salary DESC
LIMIT 25;

/* A few things stand out looking at the top 25 highest-paying skills for Data Engineers:

Weird, rare coding languages are at the very top of the list. Things like Assembly
($192.5K), Rust ($172.8K), Clojure ($170.9K), and Julia ($160.5K) aren't languages most
programmers know. Not many people can use them, but some companies really need someone
who can — so those companies end up paying a lot to find that one person.

Tools for storing huge amounts of messy data pay well. MongoDB, Neo4j, Cassandra, and
Redis are all tools for storing data in ways that aren't the usual "neat rows and
columns" style. These keep showing up near the top, which is a real pattern — not just
luck.

Kafka shows up again, just like before. It popped up earlier when we looked at
top-paying jobs, and now it shows up again here too. That's good evidence that this
specific skill really is tied to higher pay, since it keeps showing up in different
lists.

Perl pays well probably because almost nobody wants to use it anymore. Perl is a really
old programming language. It's not that companies love it — it's more like some
companies are stuck with really old systems built in Perl years ago, and they're willing
to pay extra because barely anyone still knows how to work with it.

Two of these don't really make sense, and that's important to notice: Zoom and Trello.
Zoom is just a video call app, and Trello is just a to-do-list app. It's very unlikely
that knowing Zoom actually makes you worth $159,000. What's probably happening: only a
few job posts mention "Zoom" at all, and those happen to be fancy, high-paying jobs that
also ask for a bunch of other hard skills — Zoom just happened to be listed too. It's not
really causing the high pay.

Some "data" jobs are turning into "building websites/apps" jobs. Things like GraphQL,
FastAPI, and Express are usually used to build the backend of websites and apps — not to
just move and organize data. Seeing these on the list means some of these "Data
Engineer" jobs actually involve building things regular apps use, not just handling
spreadsheets of data.

Popular, well-known tools like Kubernetes and NumPy pay a bit less than expected. These
are super useful tools that tons of data engineers use every day. But that's kind of the
reason they don't pay as much extra — since so many people know them, companies don't
have to pay a big bonus to find someone who does.

One important thing to keep in mind: all these numbers are pretty close together — from
about $150K to $192K. That's a much smaller gap than what we saw before with the top 10
highest-paying jobs. This probably means some of these averages — especially Assembly or
Zoom — are based on just a handful of job listings. So if even 1 or 2 more listings got
added, the numbers could jump around a lot. Meanwhile, something like Python or SQL is
based on thousands of listings, so those numbers are way more solid and trustworthy. 

[
  {
    "skill_name": "assembly",
    "avg_salary": "192500.00"
  },
  {
    "skill_name": "mongo",
    "avg_salary": "182222.81"
  },
  {
    "skill_name": "ggplot2",
    "avg_salary": "176250.00"
  },
  {
    "skill_name": "rust",
    "avg_salary": "172819.17"
  },
  {
    "skill_name": "clojure",
    "avg_salary": "170866.50"
  },
  {
    "skill_name": "perl",
    "avg_salary": "169000.00"
  },
  {
    "skill_name": "neo4j",
    "avg_salary": "166559.44"
  },
  {
    "skill_name": "solidity",
    "avg_salary": "166250.00"
  },
  {
    "skill_name": "graphql",
    "avg_salary": "162546.88"
  },
  {
    "skill_name": "julia",
    "avg_salary": "160500.00"
  },
  {
    "skill_name": "splunk",
    "avg_salary": "160397.14"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "160333.33"
  },
  {
    "skill_name": "zoom",
    "avg_salary": "159000.00"
  },
  {
    "skill_name": "kubernetes",
    "avg_salary": "158189.73"
  },
  {
    "skill_name": "numpy",
    "avg_salary": "157592.32"
  },
  {
    "skill_name": "mxnet",
    "avg_salary": "157500.00"
  },
  {
    "skill_name": "fastapi",
    "avg_salary": "157500.00"
  },
  {
    "skill_name": "redis",
    "avg_salary": "157000.00"
  },
  {
    "skill_name": "trello",
    "avg_salary": "155000.00"
  },
  {
    "skill_name": "jquery",
    "avg_salary": "151666.67"
  },
  {
    "skill_name": "express",
    "avg_salary": "151635.71"
  },
  {
    "skill_name": "cassandra",
    "avg_salary": "151282.18"
  },
  {
    "skill_name": "unify",
    "avg_salary": "151000.00"
  },
  {
    "skill_name": "kafka",
    "avg_salary": "150549.04"
  },
  {
    "skill_name": "vmware",
    "avg_salary": "150000.00"
  }
]
*/

