SELECT* 
FROM financial_loan;

-- LOAN REPAYMENT SUCCESS RATE BY STATE
SELECT address_state,
COUNT(*) AS TOTAL_LOANS, 
SUM(CASE WHEN loan_status = 'Fully paid' THEN 1 ELSE 0 END) AS SuccessfuL,
SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END ) AS Failed,
ROUND (100.0 * SUM(CASE WHEN loan_status = 'Fully paid' THEN 1 ELSE 0 END) /COUNT(*), 2) AS SUCCESS_RATE,
ROUND (100.0 * SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END ) / COUNT(*), 2) AS FAILURE_RATE
FROM financial_loan
GROUP BY address_state
ORDER BY SUCCESS_RATE DESC;

-- DEFUALT RATE BY EMPLOYMENT LENGTH
SELECT emp_length,
COUNT(*) AS TOTAL_APPLICANTS,
SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END) AS DEFUALT,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS DEFUALT_RATE
FROM financial_loan
GROUP BY emp_length
ORDER BY DEFUALT_RATE DESC;

SELECT home_ownership,
SUM(CASE WHEN loan_status = 'Fully paid' THEN 1 ELSE 0 END) AS SUCCESSFUL_PAYMENTS,
SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END ) AS FAILED_PAYMENTS,
ROUND (100.0 * SUM(CASE WHEN loan_status = 'Fully paid' THEN 1 ELSE 0 END) /COUNT(*), 2) AS SUCCESS_RATE,
ROUND (100.0 * SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END ) / COUNT(*), 2) AS FAILURE_RATE
FROM financial_loan
GROUP BY home_ownership
ORDER BY SUCCESS_RATE DESC;

SELECT purpose,
SUM(CASE WHEN loan_status = 'Fully paid' THEN 1 ELSE 0 END) AS SUCCESSFUL_PAYMENTS,
SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END ) AS FAILED_PAYMENTS,
ROUND (100.0 * SUM(CASE WHEN loan_status = 'Fully paid' THEN 1 ELSE 0 END) /COUNT(*), 2) AS SUCCESS_RATE,
ROUND (100.0 * SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END ) / COUNT(*), 2) AS FAILURE_RATE
FROM financial_loan
GROUP BY purpose
ORDER BY FAILURE_RATE DESC;

-- Default Rate by Credit Grade
SELECT 
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off,
    ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS failure_rate
FROM financial_loan
GROUP BY grade
ORDER BY failure_rate DESC;

-- DTI & Income Risk Correlation
SELECT 
    CASE 
        WHEN `debt-to-income ratio` < 0.10 THEN 'Low DTI'
        WHEN `debt-to-income ratio` BETWEEN 0.10 AND 0.20 THEN 'Moderate DTI'
        WHEN `debt-to-income ratio` BETWEEN 0.20 AND 0.30 THEN 'High DTI'
        ELSE 'Very High DTI'
    END AS dti_band,
    
    AVG(annual_income) AS avg_income, -- my avg income kept coming as 0 ( find out what's wrong with this query, ufuoma don't forget!!!)
    COUNT(*) AS total_loans,
    
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaults,
    
    ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS failure_rate

FROM financial_loan
GROUP BY dti_band
ORDER BY failure_rate DESC;


-- Verification Status vs Default
SELECT verification_status,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off,
    ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS failure_rate
FROM financial_loan
GROUP BY verification_status
ORDER BY failure_rate DESC;

-- Sub-Grade Performance
SELECT sub_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Fully Paid' THEN 1 ELSE 0 END) AS fully_paid,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS charged_off,
    ROUND(100.0 * SUM(CASE WHEN loan_status = 'Fully Paid' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate,
    ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS failure_rate
FROM financial_loan
GROUP BY sub_grade
ORDER BY failure_rate DESC;

SELECT MAX(`debt-to-income ratio`)
FROM financial_loan;

SELECT MIN(`debt-to-income ratio`)
FROM financial_loan;

-- 0.2999 MAX 0 MIN


