CREATE TABLE employee (
  employee_id INT PRIMARY KEY,
  name VARCHAR(50),
  salary FLOAT
);
INSERT INTO employee (employee_id, name, salary)
VALUES
  (1, 'John Smith', 50000.0),
  (2, 'Jane Doe', 60000.0),
  (3, 'Bob Johnson', 55000.0),
  (4, 'Mary Brown', 65000.0),
  (5, 'Tom Davis', 70000.0);