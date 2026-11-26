-- LOAN PERFORMANCE AND CREDIT RISK ANALYSIS
-- Dataset: loan_data


-- 1. What is the overall approval rate?

SELECT
    COUNT(*) AS total_applications,
    SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(
        SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS approval_rate
FROM loan_data;


-- 2. What is the approval rate per loan intent?

SELECT
    loan_intent,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(
        SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) * 100.00 / COUNT(*),
        2
    ) AS approval_rate
FROM loan_data
GROUP BY loan_intent
ORDER BY approval_rate DESC;


-- 3. How do approval rate and average interest rate change across credit score bands?

SELECT
    credit_score_band,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(
        SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) * 100.00 / COUNT(*),
        2
    ) AS approval_rate,
    ROUND(AVG(loan_int_rate), 2) AS average_interest_rate
FROM loan_data
GROUP BY credit_score_band
ORDER BY approval_rate DESC;


-- 4. What is the approval rate by home ownership type?

SELECT
    person_home_ownership,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(
        SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) * 100.00 / COUNT(*),
        2
    ) AS approval_rate
FROM loan_data
GROUP BY person_home_ownership
ORDER BY approval_rate DESC;


-- 5. Does a previous default on file change the approval rate?

SELECT
    previous_loan_defaults_on_file,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(
        SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) * 100.00 / COUNT(*),
        2
    ) AS approval_rate
FROM loan_data
GROUP BY previous_loan_defaults_on_file
ORDER BY approval_rate DESC;


-- 6. What is the average loan amount and interest rate per education level?

SELECT
    person_education,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(
        SUM(CASE WHEN recoded_loan_status = 'Approved' THEN 1 ELSE 0 END) * 100.00 / COUNT(*),
        2
    ) AS approval_rate,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(loan_int_rate), 2) AS avg_loan_interest_rate
FROM loan_data
GROUP BY person_education
ORDER BY avg_loan_amount DESC;


-- 7. Which income band borrows the most relative to income?

SELECT
    income_band,
    COUNT(*) AS total_applicants,
    ROUND(AVG(loan_percent_income), 2) AS avg_loan_percent_income
FROM loan_data
GROUP BY income_band
ORDER BY avg_loan_percent_income DESC;


-- 8. What is the total loan value approved vs not approved?

SELECT
    recoded_loan_status,
    COUNT(*) AS total_applications,
    ROUND(SUM(loan_amnt), 2) AS total_loan_value
FROM loan_data
GROUP BY recoded_loan_status
ORDER BY total_loan_value DESC;
