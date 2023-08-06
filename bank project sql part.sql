Create database Bank_loan;

use bank_loan;

ALTER TABLE finance_11 RENAME f1;
ALTER TABLE finance_2 RENAME f2;

SELECT * FROM F1;
SELECT * FROM F2;

##### KPI 1 (YEAR WISE LOAN AMOUNT STATS) #####
select issue_d as year, sum(loan_amnt) as Total_Loan_amnt from F1 group by year;


##### KPI 2 (GRADE AND SUB GRADE WISE REVOL_BAL) #####
select grade, sub_grade,sum(revol_bal) as total_revol_bal
from F1 inner join F2 
on(F1.id = F2.id) 
group by grade,sub_grade
order by grade, sub_grade asc;


##### KPI 3 (Total Payment for Verified Status Vs Total Payment for Non Verified Status) #####
select verification_status, round(sum(total_pymnt),2) as Total_payment
from F1 inner join F2
on(F1.id = F2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

##### KPI 4 (State wise and last_credit_pull_d wise loan status) #####
select addr_state, last_credit_pull_d ,loan_status
from F1 inner join F2
on(F1.id = F2.id) 
group by addr_state, last_credit_pull_d ,loan_status
order by addr_state;

##### KPI 5 (Home ownership Vs last payment date stats) #####
SELECT home_ownership, last_pymnt_d as last_payment_date,
round(sum(last_pymnt_amnt), 2) AS Amount
FROM f1 INNER JOIN f2 ON (F1.id = F2.id) 
WHERE last_pymnt_d
IN (SELECT (f2.last_pymnt_d) FROM f2)  GROUP BY last_pymnt_d, home_ownership
ORDER BY sum(last_pymnt_amnt) DESC;
