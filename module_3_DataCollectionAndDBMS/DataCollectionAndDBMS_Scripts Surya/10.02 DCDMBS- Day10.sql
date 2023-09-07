USE hr;
SET GLOBAL log_bin_trust_function_creators=1;
SELECT get_emp_name(110);
SELECT GET_TOTAL_SALARY_MANAGER(102);
SELECT * FROM employees;
SELECT fetch_salary("Steven", "King");