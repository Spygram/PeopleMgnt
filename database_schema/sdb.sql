--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: person; Type: TABLE; Schema: public; Owner: sd
--

CREATE TABLE public.person (
    serial_number integer NOT NULL,
    name character varying(100),
    age integer
);


ALTER TABLE public.person OWNER TO sd;

--
-- Name: person_serial_number_seq; Type: SEQUENCE; Schema: public; Owner: sd
--

CREATE SEQUENCE public.person_serial_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_serial_number_seq OWNER TO sd;

--
-- Name: person_serial_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sd
--

ALTER SEQUENCE public.person_serial_number_seq OWNED BY public.person.serial_number;


--
-- Name: person serial_number; Type: DEFAULT; Schema: public; Owner: sd
--

ALTER TABLE ONLY public.person ALTER COLUMN serial_number SET DEFAULT nextval('public.person_serial_number_seq'::regclass);


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: sd
--

COPY public.person (serial_number, name, age) FROM stdin;
55	user1	12
56	user2	23
57	user3	34
\.


--
-- Name: person_serial_number_seq; Type: SEQUENCE SET; Schema: public; Owner: sd
--

SELECT pg_catalog.setval('public.person_serial_number_seq', 57, true);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: sd
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (serial_number);


--
-- PostgreSQL database dump complete
--

