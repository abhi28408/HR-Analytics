CREATE TABLE hr_data (
    attrition TEXT,
    business_travel TEXT,
    cf_age_band TEXT,
    cf_attrition_label TEXT,
    department TEXT,
    education_field TEXT,
    emp_no TEXT,
    employee_number INTEGER,
    gender TEXT,
    job_role TEXT,
    marital_status TEXT,
    over_time TEXT,
    over18 TEXT,
    training_times_last_year INTEGER,
    age INTEGER,
    cf_current_employee TEXT,
    daily_rate INTEGER,
    distance_from_home INTEGER,
    education TEXT,  -- ✅ FIXED from INTEGER to TEXT
    employee_count INTEGER,
    environment_satisfaction INTEGER,
    hourly_rate INTEGER,
    job_involvement INTEGER,
    job_level INTEGER,
    job_satisfaction INTEGER,
    monthly_income INTEGER,
    monthly_rate INTEGER,
    num_companies_worked INTEGER,
    percent_salary_hike INTEGER,
    performance_rating INTEGER,
    relationship_satisfaction INTEGER,
    standard_hours INTEGER,
    stock_option_level INTEGER,
    total_working_years INTEGER,
    work_life_balance INTEGER,
    years_at_company INTEGER,
    years_in_current_role INTEGER,
    years_since_last_promotion INTEGER,
    years_with_curr_manager INTEGER
);
select * from hr_data;

-- Total employees
SELECT COUNT(*) AS total_employees FROM hr_data;

-- Employees who left
SELECT COUNT(*) AS attrition_count FROM hr_data WHERE "attrition" = 'Yes';

-- Active employees
SELECT COUNT(*) AS active_employees FROM hr_data WHERE "attrition" = 'No';

-- Attrition rate
SELECT 
  ROUND(100.0 * COUNT(*) FILTER (WHERE "attrition" = 'Yes') / COUNT(*), 2) AS attrition_rate
FROM hr_data;

--> Average Age Group (Using CF_age band)
SELECT 
  "cf_age_band",
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE "attrition" = 'Yes') AS attrition_count,
  ROUND(100.0 * COUNT(*) FILTER (WHERE "attrition" = 'Yes') / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY "cf_age_band"
ORDER BY "cf_age_band";

--> Attrition by Gender
SELECT 
  "gender",
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE "attrition" = 'Yes') AS attrition_count,
  ROUND(100.0 * COUNT(*) FILTER (WHERE "attrition" = 'Yes') / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY "gender";

--> Attrition by Department
SELECT 
  "department",
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE "attrition" = 'Yes') AS attrition_count,
  ROUND(100.0 * COUNT(*) FILTER (WHERE "attrition" = 'Yes') / COUNT(*), 2) AS attrition_rate
FROM hr_data
GROUP BY "department";

--> Attrition by Education field
SELECT 
  "education_field",
  COUNT(*) FILTER (WHERE "attrition" = 'Yes') AS attrition_count
FROM hr_data
GROUP BY "education_field"
ORDER BY attrition_count DESC;

--> Job Role vs Job Satisfaction
SELECT 
  "job_role",
  "job_satisfaction",
  COUNT(*) AS employee_count
FROM hr_data
GROUP BY "job_role", "job_satisfaction"
ORDER BY "job_role", "job_satisfaction";

--> Number of employee by age group
SELECT
  CONCAT(FLOOR((age - 16) / 4) * 4 + 16, '-', FLOOR((age - 16) / 4) * 4 + 19) AS age_group,
  COUNT(*) AS employee_count
FROM hr_data
WHERE age >= 16
GROUP BY age_group
ORDER BY MIN(age);

