how could i use 
current timestamp 

CREATE TABLE example_table (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(50),
    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO example_table (event_name) VALUES ('example event');


CREATE TABLE example_table (
    id SERIAL PRIMARY KEY,
    event_name VARCHAR(50),
    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO example_table (event_name) VALUES ('example event');


SELECT * FROM example_table WHERE event_timestamp >= (CURRENT_TIMESTAMP - INTERVAL '1 day');


Remove 2 leading rows query 
UPDATE your_table SET your_column = SUBSTR(your_column, 3) WHERE SUBSTR(your_column, 1, 2) = '00';

SELECT SUBSTR('hello world', 3);
SELECT SUBSTR('hello world', 1, 5);
SUBSTR(str, pos, len)
SELECT 
  CASE WHEN SUBSTR(your_column, 1, 2) = '00' THEN SUBSTR(your_column, 3) ELSE your_column END AS modified_column
FROM your_table;


if any of the stock_movement_type_code ,purchasing_doc_type_code ,sales_order_type_code is matching with the lookup
record to be moved to "idp table"
if any of the stock_movement_type_code ,purchasing_doc_type_code ,sales_order_type_code is not  matching with the lookup
record to be moved to "Wait table"


-- Create idp table
CREATE TABLE idp (
  id INT NOT NULL AUTO_INCREMENT,
  stock_movement_type_code VARCHAR(50) NOT NULL,
  purchasing_doc_type_code VARCHAR(50) NOT NULL,
  sales_order_type_code VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

-- Create Wait table
CREATE TABLE Wait (
  id INT NOT NULL AUTO_INCREMENT,
  stock_movement_type_code VARCHAR(50) NOT NULL,
  purchasing_doc_type_code VARCHAR(50) NOT NULL,
  sales_order_type_code VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

-- Insert sample data
INSERT INTO idp (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
VALUES ('code1', 'code2', 'code3');

INSERT INTO idp (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
VALUES ('code4', 'code5', 'code6');

INSERT INTO Wait (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
VALUES ('code7', 'code8', 'code9');

-- Move records to idp or Wait table based on lookup
INSERT INTO idp (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
SELECT stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code
FROM your_table
WHERE (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code) IN 
  (SELECT stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code FROM lookup_table);

INSERT INTO Wait (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
SELECT stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code
FROM your_table
WHERE (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code) NOT IN 
  (SELECT stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code FROM lookup_table);





-- Create idp table
CREATE TABLE idp (
  id INT NOT NULL AUTO_INCREMENT,
  stock_movement_type_code VARCHAR(50) NOT NULL,
  purchasing_doc_type_code VARCHAR(50) NOT NULL,
  sales_order_type_code VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

-- Create Wait table
CREATE TABLE Wait (
  id INT NOT NULL AUTO_INCREMENT,
  stock_movement_type_code VARCHAR(50) NOT NULL,
  purchasing_doc_type_code VARCHAR(50) NOT NULL,
  sales_order_type_code VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);

-- Insert sample data
INSERT INTO idp (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
VALUES ('code1', 'code2', 'code3');

INSERT INTO idp (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
VALUES ('code4', 'code5', 'code6');

INSERT INTO Wait (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
VALUES ('code7', 'code8', 'code9');

-- Move records to idp or Wait table based on lookup
INSERT INTO idp (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
SELECT stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code
FROM your_table
WHERE stock_movement_type_code IN (SELECT stock_movement_type_code FROM lookup_table)
   OR purchasing_doc_type_code IN (SELECT purchasing_doc_type_code FROM lookup_table)
   OR sales_order_type_code IN (SELECT sales_order_type_code FROM lookup_table);

INSERT INTO Wait (stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code)
SELECT stock_movement_type_code, purchasing_doc_type_code, sales_order_type_code
FROM your_table
WHERE stock_movement_type_code NOT IN (SELECT stock_movement_type_code FROM lookup_table)
   AND purchasing_doc_type_code NOT IN (SELECT purchasing_doc_type_code FROM lookup_table)
   AND sales_order_type_code NOT IN (SELECT sales_order_type_code FROM lookup_table);
