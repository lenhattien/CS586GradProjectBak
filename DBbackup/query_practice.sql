--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: qtype; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE qtype (
    qt_id integer NOT NULL,
    qt_name character varying(20)
);


ALTER TABLE public.qtype OWNER TO postgres;

--
-- Name: query; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE query (
    q_id integer NOT NULL,
    sql character varying(500),
    eng_stmt character varying(500),
    ra character varying(500)
);


ALTER TABLE public.query OWNER TO postgres;

--
-- Name: queryqtyperel; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE queryqtyperel (
    q_id integer NOT NULL,
    qt_id integer NOT NULL
);


ALTER TABLE public.queryqtyperel OWNER TO postgres;

--
-- Data for Name: qtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY qtype (qt_id, qt_name) FROM stdin;
1	SELECT
2	PROJECT
3	UNION
4	UNION ALL
5	INTERSECT
6	INTERSECT ALL
7	EXCEPT
8	EXCEPT ALL
9	EXISTS
10	CROSS PRODUCT
11	JOIN
12	FULL OUTER JOIN
13	LEFT OUTER JOIN
14	RIGHT OUTER JOIN
15	DUPELIM
16	MIN
17	MAX
18	AVG
19	COUNT
20	SORT
21	GROUP BY
22	SUBQUERY
\.


--
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY query (q_id, sql, eng_stmt, ra) FROM stdin;
1	SELECT * <br> FROM car <br> WHERE car.number_of_doors > 4;	List all cars that have more than 4 doors.	q1.png
2	SELECT customer.last <br> FROM customer;	List all customers' last names.	q2.png
3	(SELECT customer.customer_id <br> FROM customer) UNION ALL (SELECT contract.customer_id FROM contract);	List all customer IDs that are in table customer or in table contract (bag operation).	q3.png
4	(SELECT customer.customer_id <br> FROM customer) <br> INTERSECT ALL <br> (SELECT contract.customer_id <br> FROM contract);	List all the customer IDs in table customer that are also in the contract table (bag operation).	q4.png
5	(SELECT customer.customer_id <br> FROM customer) <br> EXCEPT ALL <br> (SELECT contract.customer_id <br> FROM contract);	List all the customer IDs from table customer apart from customer IDs that are in table contract (bag operation).	q5.png
6	SELECT * <br> FROM store, employee;	List all possible combinations between store and employee.	q6.png
7	SELECT * <br> FROM car <br> JOIN contract ON car.car_id = contract.car_id;	List all possible combinations between car and contract for only the cars that are in a contract.	q7.png
8	SELECT * <br> FROM car <br> FULL OUTER JOIN contract ON car.car_id = contract.car_id;	List all possible combinations between car and contract for only the cars that are in a contract, the cars that are not in a contract, and the cars that were in a contract but are no longer exists.	q8.png
9	SELECT * <br> FROM car <br> LEFT OUTER JOIN contract ON car.car_id = contract.car_id;	List all possible combinations between car and contract for only the cars that are in a contract, and the cars that are not in the contract.	q9.png
10	SELECT * <br> FROM car <br> RIGHT OUTER JOIN contract ON car.car_id = contract.car_id;	List all possible combinations between car and contract for only the cars that are in a contract, and the cars that were in a contract but are no longer exists.	q10.png
11	SELECT DISTINCT customer.last <br> FROM customer;	List a set of customers' last names.	q11.png
12	SELECT MIN(employee.age) <br> FROM employee;	Return the minimum age of the employees.	q12.png
13	SELECT MAX(employee.age) <br> FROM employee;	Return the maximum age of the employees.	q13.png
14	SELECT AVG(employee.age) <br> FROM employee;	Return the average age of the employees.	q14.png
15	SELECT COUNT(employee.age) <br> FROM employee;	Return the count of the ages of the employees (bag operation).	q15.png
16	SELECT * <br> FROM store <br> ORDER BY store.city;	Return the list of stores sorted by City.	q16.png
17	SELECT car.make, AVG(car.number_of_doors) <br> FROM car <br> GROUP BY car.make;	Get the list of average number of doors for each car make.	q17.png
18	SELECT COUNT(*) <br> FROM car c <br> JOIN store s ON c.store_id = s.store_id <br> WHERE c.make = 'Mercedes' AND s.city = 'Portland';	Return the amount of cars whose make is Mercedes that the company has in Portland.	q18.png
19	SELECT c1.first, c1.middle, c1.last, COUNT(*) <br> FROM customer c1, contract c2 <br> WHERE c1.customer_id = c2.customer_id GROUP BY c1.customer_id HAVING c1.gender = 'm';	Return the amount of cars that were being rented by each male customer.	q19.png
20	SELECT COUNT(*) <br> FROM employee e1 <br> JOIN contract c ON e1.employee_id = c.employee_id <br> WHERE e1.age = (SELECT MIN(e2.age) <br> FROM employee e2);	Return the amount of contracts that the youngest employee is currently in possession.	q20.png
21	SELECT * <br> FROM customer c1 <br> WHERE c1.last = 'William' AND <br> EXISTS (SELECT * <br> FROM contract c2, car c3 <br> WHERE c1.customer_id = c2.customer_id AND c2.car_id = c3.car_id AND c3.make = 'Nissan');	Return customer information whose last name is William and that customer has rented a car whose make is Nissan.	q21.png
22	SELECT c1.customer_id, c1.first, c1.middle, c1.last, c1.gender <br> FROM customer c1 <br> JOIN contract c2 ON c1.customer_id = c2.customer_id <br> JOIN car c3 ON c2.car_id = c3.car_id <br> WHERE c1.last = 'William' AND c3.make = 'Nissan';	Return customer information whose last name is William and that customer has rented a car whose make is Nissan.	q22.png
\.


--
-- Data for Name: queryqtyperel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY queryqtyperel (q_id, qt_id) FROM stdin;
1	1
2	2
3	2
3	4
4	2
4	6
5	2
5	8
6	10
7	11
8	12
9	13
10	14
11	2
11	15
12	2
12	16
13	2
13	17
14	2
14	18
15	2
15	19
16	20
17	2
17	21
17	18
18	2
18	9
18	1
19	2
19	19
19	1
19	21
19	10
20	2
20	16
20	11
20	22
20	1
20	19
21	1
21	9
21	10
21	22
22	2
22	11
22	1
\.


--
-- Name: qtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qtype
    ADD CONSTRAINT qtype_pkey PRIMARY KEY (qt_id);


--
-- Name: query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY query
    ADD CONSTRAINT query_pkey PRIMARY KEY (q_id);


--
-- Name: queryqtyperel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY queryqtyperel
    ADD CONSTRAINT queryqtyperel_pkey PRIMARY KEY (q_id, qt_id);


--
-- Name: queryqtyperel_q_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY queryqtyperel
    ADD CONSTRAINT queryqtyperel_q_id_fkey FOREIGN KEY (q_id) REFERENCES query(q_id);


--
-- Name: queryqtyperel_qt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY queryqtyperel
    ADD CONSTRAINT queryqtyperel_qt_id_fkey FOREIGN KEY (qt_id) REFERENCES qtype(qt_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

