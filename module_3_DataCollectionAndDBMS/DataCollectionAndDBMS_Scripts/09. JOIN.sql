CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- Inserting customer data
INSERT INTO customers (customer_id, name, email, phone) VALUES
  (1, 'John Smith', 'john.smith@email.com', '555-1234'),
  (2, 'Jane Doe', 'jane.doe@email.com', '555-5678'),
  (3, 'Bob Johnson', 'bob.johnson@email.com', '555-9012'),
  (4, 'Alice Brown', 'alice.brown@email.com', '555-3456'),
  (5, 'Charlie Davis', 'charlie.davis@email.com', '555-7890'),
  (6, 'Emily Wilson', 'emily.wilson@email.com', '555-2345'),
  (7, 'Frank Lee', 'frank.lee@email.com', '555-6789'),
  (8, 'Grace Kim', 'grace.kim@email.com', '555-1234'),
  (9, 'Henry Chen', 'henry.chen@email.com', '555-5678'),
  (10, 'Isabella Rodriguez', 'isabella.rodriguez@email.com', '555-9012'),
  (11, 'Jackie Wang', 'jackie.wang@email.com', '555-3456'),
  (12, 'Kevin Nguyen', 'kevin.nguyen@email.com', '555-7890'),
  (13, 'Linda Hernandez', 'linda.hernandez@email.com', '555-2345'),
  (14, 'Mike Patel', 'mike.patel@email.com', '555-6789'),
  (15, 'Nancy Gupta', 'nancy.gupta@email.com', '555-1234'),
  (16, 'Oliver Brown', 'oliver.brown@email.com', '555-5678'),
  (17, 'Paul Kim', 'paul.kim@email.com', '555-9012'),
  (18, 'Quincy Lee', 'quincy.lee@email.com', '555-3456'),
  (19, 'Rachel Chen', 'rachel.chen@email.com', '555-7890'),
  (20, 'Samantha Davis', 'samantha.davis@email.com', '555-2345');

-- Inserting order data
INSERT INTO orders (order_id, customer_id, order_date, total) VALUES
  (1, 1, '2022-01-01', 100.00),
  (2, 1, '2022-02-01', 150.00),
  (3, 2, '2022-03-01', 75.00),
  (4, 3, '2022-04-01', 200.00),
  (5, 4, '2022-05-01', 50.00),
  (6, 5, '2022-06-01', 300.00),
  (7, 6, '2022-07-01', 75.00),
  (8, 7, '2022-08-01', 125.00);