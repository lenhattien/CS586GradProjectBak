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
-- Name: car; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE car (
    car_id bigint NOT NULL,
    make character varying(255),
    model character varying(255),
    number_of_doors bigint,
    color character varying(255),
    car_type_id bigint,
    store_id bigint
);


ALTER TABLE public.car OWNER TO postgres;

--
-- Name: car_type; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE car_type (
    car_type_id bigint NOT NULL,
    type character varying(255)
);


ALTER TABLE public.car_type OWNER TO postgres;

--
-- Name: contract; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE contract (
    contract_id bigint NOT NULL,
    employee_id bigint,
    customer_id bigint,
    car_id bigint,
    daily_rate double precision,
    start_date date,
    number_of_days bigint,
    is_car_returned boolean DEFAULT true NOT NULL
);


ALTER TABLE public.contract OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE customer (
    customer_id bigint NOT NULL,
    first character varying(255),
    middle character varying(255),
    last character varying(255),
    gender character varying(1),
    CONSTRAINT customer_gender_check CHECK (((gender)::text = ANY ((ARRAY['m'::character varying, 'f'::character varying])::text[])))
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE employee (
    employee_id bigint NOT NULL,
    first character varying(255),
    middle character varying(255),
    last character varying(255),
    gender character varying(1),
    age bigint,
    store_id bigint,
    CONSTRAINT employee_gender_check CHECK (((gender)::text = ANY ((ARRAY['m'::character varying, 'f'::character varying])::text[])))
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: store; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE store (
    store_id bigint NOT NULL,
    address character varying(255),
    city character varying(255),
    country character varying(255)
);


ALTER TABLE public.store OWNER TO postgres;

--
-- Data for Name: car; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY car (car_id, make, model, number_of_doors, color, car_type_id, store_id) FROM stdin;
1	Mercedes	GLK350W2	5	black	2	1
2	Nissan	370Z Roadster	2	blue	4	3
3	Mercedes	CLA45 AMG	4	white	1	1
4	Toyota	Avalon 2014	4	white	3	4
5	Subaru	Forester 2014	5	silver	1	2
6	BMW	Z4 Roadster	2	grey	2	2
7	Chevrolet	Cruze Sedan 2014	4	red	1	3
8	Honda	CR-V	4	white	1	4
9	Hyundai	Sonata i45	4	grey	2	1
\.


--
-- Data for Name: car_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY car_type (car_type_id, type) FROM stdin;
1	compact
2	midsize
3	fullsize
4	convertible
\.


--
-- Data for Name: contract; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contract (contract_id, employee_id, customer_id, car_id, daily_rate, start_date, number_of_days, is_car_returned) FROM stdin;
1	1	1	1	123	2013-01-17	63	t
2	2	1	2	752.200000000000045	2013-12-21	51	f
3	5	4	3	542.200000000000045	2013-08-05	27	f
4	4	5	4	789.200000000000045	2014-02-01	96	f
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY customer (customer_id, first, middle, last, gender) FROM stdin;
1	James	White	William	m
2	Elizabeth	Miller	Parker	f
3	Kevin	\N	Garcia	m
4	Linda	Robinson	Collins	f
5	Allen	Perez	Walker	m
6	Michael	Jones	Baker	m
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employee (employee_id, first, middle, last, gender, age, store_id) FROM stdin;
1	Fiona	Green	Young	f	24	4
2	Edward	\N	Harris	m	36	1
3	Barbara	White	Wright	f	54	2
4	Clark	\N	Ken	m	32	3
5	Peter	\N	Parker	m	41	3
6	Tony	\N	Stark	m	25	3
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY store (store_id, address, city, country) FROM stdin;
1	1825 SW Broadway	Portland	USA
2	101 Sproul Hall	Berkeley	USA
3	307 N University Blvd	Mobile	USA
4	1207 Washington Ave	Golden	USA
\.


--
-- Name: car_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY car
    ADD CONSTRAINT car_pkey PRIMARY KEY (car_id);


--
-- Name: car_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY car_type
    ADD CONSTRAINT car_type_pkey PRIMARY KEY (car_type_id);


--
-- Name: car_type_type_u; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY car_type
    ADD CONSTRAINT car_type_type_u UNIQUE (type);


--
-- Name: contract_car_id_u; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_car_id_u UNIQUE (car_id);


--
-- Name: contract_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (contract_id);


--
-- Name: customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


--
-- Name: car_car_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY car
    ADD CONSTRAINT car_car_type_id_fk FOREIGN KEY (car_type_id) REFERENCES car_type(car_type_id);


--
-- Name: car_store_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY car
    ADD CONSTRAINT car_store_id_fk FOREIGN KEY (store_id) REFERENCES store(store_id);


--
-- Name: contract_car_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_car_id_fk FOREIGN KEY (car_id) REFERENCES car(car_id);


--
-- Name: contract_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id);


--
-- Name: contract_employee_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contract
    ADD CONSTRAINT contract_employee_id_fk FOREIGN KEY (employee_id) REFERENCES employee(employee_id);


--
-- Name: employee_store_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_store_id_fk FOREIGN KEY (store_id) REFERENCES store(store_id);


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

