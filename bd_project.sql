--TASK 3
DROP SCHEMA IF EXISTS my_project CASCADE;
CREATE SCHEMA my_project;
set search_path = my_project, public;

CREATE TABLE Company (
  company_nm         VARCHAR(30) NOT NULL,
  company_id         SERIAL PRIMARY KEY,
  foundation_dt      DATE,
  founder_nm         VARCHAR(30),
  country_nm         VARCHAR(30)
);


CREATE TABLE Product (
  product_nm         VARCHAR(25) NOT NULL,
  product_id         INT PRIMARY KEY
);

CREATE TABLE Product_Type (
  product_id         INT PRIMARY KEY,
  type_value         VARCHAR(10) CHECK ( type_value IN ('good', 'service') )
);

CREATE TABLE Product_X_Company (
  company_id         INT REFERENCES Company(company_id),
  product_id         INT REFERENCES Product(product_id),
  PRIMARY KEY (company_id, product_id)
);

CREATE TABLE Position (
  position_nm        VARCHAR(50) NOT NULL,
  position_id        SERIAL PRIMARY KEY
);


CREATE TABLE Employee (
  full_name_nm       VARCHAR(50) NOT NULL,
  employee_id        INT PRIMARY KEY,
  birth_date_dt      DATE NOT NULL CHECK ( birth_date_dt > '0001-01-01' ),
  phone_number_txt   VARCHAR(16) CHECK( phone_number_txt LIKE '+%-___-___-____' ),
  work_record_value  INT CHECK ( work_record_value >= 0 ),
  position_id        INT REFERENCES Position(position_id),
  premium_amt        INT,
  company_id         INT REFERENCES Company(company_id)
);


CREATE TABLE Location (
  company_id         INT REFERENCES Company(company_id),
  country_nm         VARCHAR(25),
  city_nm            VARCHAR(25),
  adress_txt         VARCHAR(50) CHECK ( adress_txt LIKE ('% street, % bld') ),
  office_type_value  VARCHAR(10) CHECK ( office_type_value IN ('main', 'branch') ),
  PRIMARY KEY (company_id, country_nm, city_nm, adress_txt)
);

CREATE TABLE Income(
  company_id         INT REFERENCES Company(company_id),
  year_value         SMALLINT CHECK( year_value BETWEEN 0 and EXTRACT(year from current_date) ),
  income_amt         INT NOT NULL,
  PRIMARY KEY (company_id, year_value)
);

CREATE TABLE Position_X_Company(
  position_id        INT REFERENCES Position(position_id),
  company_id         INT REFERENCES Company(company_id),
  PRIMARY KEY (position_id, company_id)
);

CREATE TABLE Position_X_Salary(
  position_id        INT REFERENCES Position(position_id),
  company_id         INT REFERENCES Company(company_id),
  work_record_value  INT  CHECK ( work_record_value >= 0 ),
  salary_amt         INT NOT NULL,
  PRIMARY KEY (position_id, company_id, work_record_value)
);

CREATE TABLE Vacancy(
  company_id         INT REFERENCES Company(company_id),
  position_id        INT REFERENCES Position(position_id),
  country_nm         VARCHAR(25),
  city_nm            VARCHAR(25),
  vacancy_cnt        INT NOT NULL DEFAULT 0 CHECK ( vacancy_cnt >= 0 ),
  PRIMARY KEY (company_id, position_id, country_nm, city_nm)
);



--TASK 4

INSERT INTO Position VALUES ('Frontend developer');
INSERT INTO Position VALUES ('C++ developer');
INSERT INTO Position VALUES ('Data scientist');
INSERT INTO Position VALUES ('Java developer');
INSERT INTO Position VALUES ('Python developer');
INSERT INTO Position VALUES ('Recruiter');
INSERT INTO Position VALUES ('Janitor');
INSERT INTO Position VALUES ('Designer');
INSERT INTO Position VALUES ('CEO');
INSERT INTO Position VALUES ('Frontend developer');

UPDATE Position SET position_nm = 'Guard' where position_nm = 'CEO';


INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('Yandex', '1997-09-23', 'Arkady Volozh', 'Russia');
INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('Google', '1996-01-04', 'Larry Page', 'USA');
INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('Facebook', '2004-02-04', 'Mark Zuckerberg', 'USA');
INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('Tinkoff', '2006-01-21', 'Oleg Tinkof', 'Russia');
INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('ABBYY', '1989-08-28', 'David Yang', 'Russia');
INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('Telegram', '2013-08-14', 'Pavel Durov', 'Russia');


--imrort from Employee.csv
UPDATE Employee SET premium_amt = premium_amt * 1000;

--import from income_% (6 files)
UPDATE Income SET year_value = year_value + 1996 WHERE company_id = 1;
UPDATE Income SET year_value = year_value + 1995 WHERE company_id = 2;
UPDATE Income SET year_value = year_value + 2003 WHERE company_id = 3;
UPDATE Income SET year_value = year_value + 2005 WHERE company_id = 4;
UPDATE Income SET year_value = year_value + 1988 WHERE company_id = 5;
UPDATE Income SET year_value = year_value + 2012 WHERE company_id = 6;
UPDATE Income SET income_amt = income_amt * 10;


INSERT INTO Location VALUES (1, 'Russia', 'Moscow', 'Lev Tolstoy street, 16 bld', 'main');
INSERT INTO Location VALUES (1, 'Russia', 'St.Petersburg', 'Piskarevskaya street, 2 bld', 'branch');
INSERT INTO Location VALUES (1, 'Russia', 'Novosibirsk', 'Krasnoyarskaya street, 35 bld', 'branch');
INSERT INTO Location VALUES (1, 'Belorus', 'Minsk', 'Dzerzhinskaya street, 5 bld', 'branch');
INSERT INTO Location VALUES (1, 'China', 'Shanghai', 'Yanping street, 135 bld', 'branch');

INSERT INTO Location VALUES (2, 'USA', 'Mountain View', 'Amphitheatre street, 1600 bld', 'main');
INSERT INTO Location VALUES (2, 'Germany', 'Berlin', 'Tucholskystrabe street, 2 bld', 'branch');
INSERT INTO Location VALUES (2, 'Switzerland', 'Zurich', 'Brandschenkestrasse street, 110 bld', 'branch');
INSERT INTO Location VALUES (2, 'France', 'Paris', 'Rue de Londres street, 8 bld', 'branch');
INSERT INTO Location VALUES (2, 'China', 'Shanghai', 'Century Avenue street, 100 bld', 'branch');

INSERT INTO Location VALUES (3, 'USA', 'Palo Alto', 'Stanford Research street, 1 bld', 'main');
INSERT INTO Location VALUES (3, 'UK', 'London', 'Brok street, 10 bld', 'main');

INSERT INTO Location VALUES (4, 'Russia', 'Moscow', 'Golovinskaya street, 5A bld', 'main');

INSERT INTO Location VALUES (5, 'Russia', 'Moscow', 'Dorozhnaya street, 60B bld', 'main');
INSERT INTO Location VALUES (5, 'Russia', 'St.Petersburg', 'Otradnaya street, 2B bld', 'branch');

INSERT INTO Location VALUES (6, 'Russia', 'Dolgoprudny', 'Pervomayskaya street, 32 bld', 'main');


--Import from position_x_company.csv

--Import from position_x_salary.csv
--Import from position_x_salary2.csv
WITH q AS
       (
         SELECT position_id,
                company_id,
                work_record_value,
                min(salary_amt) OVER (PARTITION BY position_id, company_id) as min_salary
         FROM Position_X_Salary
       )
UPDATE Position_X_Salary pxs
SET salary_amt = q.min_salary * (1 + CAST(LOG(2.5, pxs.work_record_value + 1) AS INT))
FROM q
WHERE pxs.position_id = q.position_id AND pxs.company_id = q.company_id AND pxs.work_record_value = q.work_record_value;

UPDATE Position_X_Salary SET salary_amt = salary_amt * 10000;



INSERT INTO Product VALUES ('Taxi' , 1);
INSERT INTO Product VALUES ('Search' , 2);
INSERT INTO Product VALUES ('Weather' , 3);
INSERT INTO Product VALUES ('Food' , 4);
INSERT INTO Product VALUES ('Credit Cards' , 5);
INSERT INTO Product VALUES ('Deposit' , 6);
INSERT INTO Product VALUES ('Messenger' , 7);
INSERT INTO Product VALUES ('Social Network' , 8);
INSERT INTO Product VALUES ('FineReader' , 9);
INSERT INTO Product VALUES ('YouTube' , 10);
INSERT INTO Product VALUES ('Maps' , 11);
INSERT INTO Product VALUES ('Compreno' , 12);


INSERT INTO Product_Type VALUES (1 , 'service');
INSERT INTO Product_Type VALUES (2 , 'service');
INSERT INTO Product_Type VALUES (3 , 'service');
INSERT INTO Product_Type VALUES (4 , 'service');
INSERT INTO Product_Type VALUES (5 , 'good');
INSERT INTO Product_Type VALUES (6 , 'service');
INSERT INTO Product_Type VALUES (7 , 'service');
INSERT INTO Product_Type VALUES (8 , 'service');
INSERT INTO Product_Type VALUES (9 , 'good');
INSERT INTO Product_Type VALUES (10 , 'service');
INSERT INTO Product_Type VALUES (11 , 'service');
INSERT INTO Product_Type VALUES (12 , 'good');


INSERT INTO Product_X_Company VALUES (1 , 1);
INSERT INTO Product_X_Company VALUES (1 , 2);
INSERT INTO Product_X_Company VALUES (1 , 3);
INSERT INTO Product_X_Company VALUES (1 , 4);
INSERT INTO Product_X_Company VALUES (1 , 11);
INSERT INTO Product_X_Company VALUES (2 , 2);
INSERT INTO Product_X_Company VALUES (2 , 10);
INSERT INTO Product_X_Company VALUES (2 , 11);
INSERT INTO Product_X_Company VALUES (3 , 8);
INSERT INTO Product_X_Company VALUES (4 , 5);
INSERT INTO Product_X_Company VALUES (4 , 6);
INSERT INTO Product_X_Company VALUES (5 , 9);
INSERT INTO Product_X_Company VALUES (5 , 12);
INSERT INTO Product_X_Company VALUES (6 , 7);


--import from vacancy.csv
DELETE FROM Vacancy v
WHERE (v.company_id, v.city_nm) NOT IN
      (SELECT
         company_id,
         city_nm
       FROM
         location);
--Удаляем вакансии компаний в городах, где у них нет офисов




--TASK 5

-- 1 Запрос. Найти компании, занимающиеся картами (Maps)
WITH q AS (
  SELECT
    company_id,
    product_nm
  FROM
    Product_X_Company pxc INNER JOIN Product p
                                     ON pxc.product_id = p.product_id
  WHERE product_nm = 'Maps'
)
SELECT
  c.company_nm
FROM
  Company c INNER JOIN q
                       ON q.company_id = c.company_id;

-- 2 Запрос. Найти Российсие компании. Вывести их название и доход за 2014 год
WITH q AS (
  SELECT
    *
  FROM
    Company c
  WHERE
      c.country_nm = 'Russia'
)

SELECT
  q.company_nm,
  i.income_amt
FROM
  q INNER JOIN Income i
               ON q.company_id = i.company_id
WHERE i.year_value = 2014;

--3 Запрос. Найти количество вакансий в Санкт-Петербурге на позицию C++ разработчика (C++ developer). Вывести компанию и количество
WITH q AS
       (
         SELECT company_id,
                position_id,
                vacancy_cnt
         FROM Vacancy v
         WHERE v.city_nm = 'St.Petersburg'
           AND v.position_id = (SELECT DISTINCT position_id FROM Position WHERE position_nm = 'C++ developer')
       )
SELECT
  c.company_nm,
  q.vacancy_cnt
FROM Company c INNER JOIN q ON c.company_id = q.company_id;

--4 Запрос. Найти зарплату (с нулевым стажем) дата саентиста во всех компаниях
WITH q AS (
  SELECT company_id,
         salary_amt
  FROM Position_X_Salary
  WHERE work_record_value = 0
    AND position_id = (SELECT position_id FROM Position WHERE UPPER(position_nm) = 'DATA SCIENTIST')
)
SELECT
  c.company_nm,
  q.salary_amt
FROM
  Company c INNER JOIN q ON c.company_id = q.company_id;

--5 Запрос. У всех всех компаний, у которых есть офисы в Китае, найти зарплату уборщика(Janitor) Со стажем 4 года
WITH q AS
       (
         SELECT
           company_id
         FROM
           Location
         WHERE country_nm = 'China'
       )
SELECT
  (SELECT company_nm FROM Company c WHERE c.company_id = q.company_id) AS company_nm,
  max(salary_amt) AS salary
FROM
  q INNER JOIN Position_X_Salary pxs
  ON q.company_id = pxs.company_id
WHERE
  work_record_value <= 4 AND
      pxs.position_id = (SELECT position_id FROM Position WHERE position_nm = 'Janitor')
GROUP BY q.company_id;





-- TASK 6

--Create
INSERT INTO Company(company_nm, foundation_dt, country_nm) VALUES ('MIPT', '1951-08-06', 'Russia');
--Read
SELECT * FROM Company;
--UPDATE
UPDATE Company SET founder_nm = 'Ivan Erlich'
WHERE company_nm = 'MIPT';
--DELETE
DELETE FROM Company
WHERE company_nm = 'MIPT';

INSERT INTO Position VALUES ('Teacher');
--Read
SELECT * FROM Position;
--UPDATE
UPDATE Position SET position_nm = 'tutor'
WHERE position_nm = 'Teacher';
--DELETE
DELETE FROM Position
WHERE position_nm = 'tutor';


--Task 7

CREATE OR REPLACE VIEW v_Company AS
  SELECT
    company_nm,
    foundation_dt,
    founder_nm,
    country_nm
  FROM Company;

CREATE OR REPLACE VIEW v_Employee AS
  SELECT
    full_name_nm,
    birth_date_dt,
    (SUBSTRING (phone_number_txt, 0, 5) ||'**********') AS phone_number_txt,
    work_record_value,
    (SELECT position_nm FROM Position p WHERE p.position_id = e.position_id) AS position_nm,
    premium_amt,
    (SELECT company_nm FROM Company c WHERE c.company_id = e.company_id) AS company_nm
  FROM Employee e;


DROP VIEW v_Income;
CREATE OR REPLACE VIEW v_Income AS
  SELECT
    c.company_nm,
    i.year_value,
    i.income_amt
  FROM Income i INNER JOIN Company c on i.company_id = c.company_id;

CREATE OR REPLACE  VIEW v_Location AS
  SELECT
    (SELECT company_nm FROM Company c WHERE c.company_id = l.company_id) AS company_nm,
    country_nm,
    city_nm,
    adress_txt,
    office_type_value
  FROM Location l;


CREATE OR REPLACE VIEW v_Position_x_Company AS
  SELECT
    (SELECT position_nm FROM Position p WHERE p.position_id = pxc.position_id) as position_nm,
    (SELECT company_nm FROM Company c WHERE c.company_id = pxc.company_id) AS company_nm
  FROM Position_x_Company pxc;

CREATE OR REPLACE VIEW v_Position_x_Salary AS
  SELECT
    (SELECT position_nm FROM Position p WHERE p.position_id = pxs.position_id) as position_nm,
    (SELECT company_nm FROM Company c WHERE c.company_id = pxs.company_id) AS company_nm,
    work_record_value,
    salary_amt
  FROM Position_x_Salary pxs;

CREATE OR REPLACE VIEW v_Product_Type AS
    SELECT
      (SELECT Product_nm FROM Product p WHERE p.product_id = pt.product_id) as product_nm,
      type_value
    FROM
      Product_Type pt;

CREATE OR REPLACE VIEW v_Product_x_Company AS
  SELECT
    (SELECT product_nm FROM Product p WHERE p.product_id = pxc.product_id) as product_nm,
    (SELECT company_nm FROM Company c WHERE c.company_id = pxc.company_id) AS company_nm
  FROM Product_x_Company pxc;

CREATE OR REPLACE VIEW v_Vacancy AS
  SELECT
    (SELECT company_nm FROM Company c WHERE c.company_id = v.company_id) AS company_nm,
    (SELECT position_nm FROM Position p WHERE p.position_id = v.position_id) as position_nm,
    country_nm,
    city_nm,
    vacancy_cnt
  FROM Vacancy v;




--TASK 8
CREATE OR REPLACE VIEW v_full_salary AS
  (
    WITH q AS
           (
             SELECT DISTINCT e.full_name_nm,
                             e.company_id,
                             e.position_id,
                             e.premium_amt,
                             max(p.work_record_value) OVER (PARTITION BY full_name_nm) AS wlv
             FROM Employee e
                    INNER JOIN Position_X_Salary p on e.position_id = P.position_id AND e.company_id = p.company_id AND
                                                      e.work_record_value > p.work_record_value
           )
    SELECT
      q.full_name_nm,
      (SELECT company_nm FROM Company c WHERE c.company_id = q.company_id) AS company_nm,
      (SELECT position_nm FROM Position p WHERE p.position_id = q.position_id) as position_nm,
      q.premium_amt + p.salary_amt as sum_salary
    FROM
      q INNER JOIN Position_X_Salary p on q.position_id = P.position_id AND q.company_id = p.company_id AND
                                          q.wlv = p.work_record_value
);


CREATE OR REPLACE VIEW v_avg_margin AS
  WITH avg_inc AS(
    SELECT DISTINCT
      C.company_nm,
      avg(income_amt) OVER (PARTITION BY i.company_id) as avg_income
    FROM Income i INNER JOIN Company C on i.company_id = C.company_id),
       sum_salaries AS (
         SELECT DISTINCT
           company_nm,
           sum(sum_salary) OVER (PARTITION BY company_nm) as sum_all_salaries
         From v_full_salary
       )
  SELECT
    sum_salaries.company_nm,
    CAST((avg_income - sum_all_salaries * 12) AS NUMERIC(15,2)) as margin
  FROM
    avg_inc INNER JOIN sum_salaries ON avg_inc.company_nm = sum_salaries.company_nm;


CREATE TABLE Company (
  company_nm         VARCHAR(30) NOT NULL,
  company_id         SERIAL PRIMARY KEY,
  foundation_dt      DATE,
  founder_nm         VARCHAR(30),
  country_nm         VARCHAR(30)
);


--TASKS 9-10

DROP TABLE logs;
CREATE TABLE logs (
  type_value         VARCHAR(25),
  table_nm           VARCHAR(25),
  date_dt            TIMESTAMP PRIMARY KEY
);

CREATE OR REPLACE FUNCTION add_to_log_upd_comp() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logs values ('Update', 'Company', now()::timestamp);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_to_log_ins_comp() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logs values ('Insert', 'Company', now()::timestamp);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER logging_update_company
  BEFORE UPDATE ON Company
  FOR EACH ROW
  EXECUTE PROCEDURE add_to_log_upd_comp();

CREATE TRIGGER logging_insert_company
  AFTER INSERT ON Company
  FOR EACH ROW
  EXECUTE PROCEDURE add_to_log_ins_comp();


UPDATE Company SET company_nm = 'Yandex' WHERE company_nm = 'Y';
INSERT INTO Company (company_nm, foundation_dt, founder_nm, country_nm) VALUES ('bd_lessons', '2019-05-18', 'Alexander Khalyapov', 'Russia');
DELETE from Company WHERE company_nm = 'bd_lessons';
