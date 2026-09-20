/* QUestion: What are the top paying jobs?
- Identify the top 10 highest paying Data Engineering roles that are avilable remotely.
- Focuses on job postings with specified salaries (remove nulls).
Why? Highlight the top paying opportunities for Data Engineers, offering insights into employment opportunities and location flexibility.
*/

SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    job_posted_date,
    salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Engineer'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10

/* A few things stand out looking at these 10 postings:

The pay drops off fast, then flattens out. Two jobs at Engtal pay way more than everyone
else, at $325,000 each. The next highest job (Durlston Partners) already drops to
$300,000, a $25,000 gap. After that, 6 of the remaining 7 jobs are bunched close
together, between $242,000 and $251,000 -- only a $9,000 difference between all of them.

The two Engtal jobs look the same, but might be two separate real job posts. Both pay
exactly $325,000 with the same job title, which could look like a mistake at first. But
the posted dates are 3 weeks apart (Jan 27 vs. Feb 17), so it's possible Engtal really
did post the job twice after not finding someone the first time -- worth checking rather
than assuming it's duplicate data.

One company posted two different job levels for the exact same pay. Signify Technology
has both a "Principal" and a "Staff" engineer job -- usually different seniority levels
-- but both pay exactly $250,000, which is a bit unusual.

The highest-paying job isn't from a famous company. Engtal, a smaller and less
well-known company, has the #1 highest-paying job at $325K. Meta -- a huge, famous tech
company -- is actually at the bottom of this list, at $242K.

You don't have to become a manager to reach the top of the pay scale. Most jobs on this
list are hands-on engineering roles (Data Engineer, Staff, Principal), not management.
But 2 of the 10 are leadership roles (a Director at Twitch, a Manager at Meta), showing
both career paths can lead to top pay.

Jobs seem to lean toward being posted early in the year, though 10 jobs is a small
sample. The postings span the whole year (January to December), but 6 of the 10 --
including both of the highest-paying jobs -- were posted in the first three months
(Jan-Mar). Not strong proof of a real pattern with only 10 data points, but worth
checking again with more data later.

[
  {
    "job_id": 21321,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-01-27 18:10:51",
    "salary_year_avg": "325000.0"
  },
  {
    "job_id": 157003,
    "job_title": "Data Engineer",
    "company_name": "Engtal",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-02-17 18:11:49",
    "salary_year_avg": "325000.0"
  },
  {
    "job_id": 270455,
    "job_title": "Data Engineer",
    "company_name": "Durlston Partners",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-07-17 11:10:55",
    "salary_year_avg": "300000.0"
  },
  {
    "job_id": 230458,
    "job_title": "Director of Engineering - Data Platform",
    "company_name": "Twitch",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-01-30 11:07:32",
    "salary_year_avg": "251000.0"
  },
  {
    "job_id": 595768,
    "job_title": "Principal Data Engineer",
    "company_name": "Signify Technology",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-02-14 15:24:07",
    "salary_year_avg": "250000.0"
  },
  {
    "job_id": 561728,
    "job_title": "Data Engineer",
    "company_name": "AI Startup",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-03-24 23:32:42",
    "salary_year_avg": "250000.0"
  },
  {
    "job_id": 543728,
    "job_title": "Staff Data Engineer",
    "company_name": "Signify Technology",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-03-28 13:11:42",
    "salary_year_avg": "250000.0"
  },
  {
    "job_id": 151972,
    "job_title": "Principal Data Engineer (Remote)",
    "company_name": "Movable Ink",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-05-25 15:05:38",
    "salary_year_avg": "245000.0"
  },
  {
    "job_id": 204320,
    "job_title": "Staff Data Engineer",
    "company_name": "Handshake",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-01-08 15:05:16",
    "salary_year_avg": "245000.0"
  },
  {
    "job_id": 2446,
    "job_title": "Data Engineering Manager",
    "company_name": "Meta",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "job_posted_date": "2023-12-12 15:56:17",
    "salary_year_avg": "242000.0"
  }
] */