CREATE TABLE salary_history (
  employee_id INT,
  first_name VARCHAR(50),
  old_salary DECIMAL(10,2),
  new_salary DECIMAL(10,2),
  department_id INT
);
INSERT INTO salary_history (employee_id, first_name, old_salary, new_salary, department_id)
VALUES
  (1, 'John', 50000.00, 55000.00, 101),
  (2, 'Jane', 60000.00, 65000.00, 102),
  (3, 'Bob', 45000.00, 48000.00, 103);
INSERT INTO salary_history (employee_id, first_name, old_salary, new_salary, department_id)
VALUES
  (101, 'John', 50000.00, 55000.00, 101),
  (201, 'Jane', 60000.00, 65000.00, 102),
  (301, 'Bob', 45000.00, 48000.00, 103);
  
  SELECT * FROM salary_history ;