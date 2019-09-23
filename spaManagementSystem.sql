--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-09-22 19:40:58

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

--
-- TOC entry 204 (class 1255 OID 16488)
-- Name: set_updated_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_updated_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END;
$$;



SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 16449)
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone_number character varying(255) NOT NULL,
    address character varying(200) NOT NULL,
    description text,
    email character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    photo_dir character varying(200)
);



--
-- TOC entry 198 (class 1259 OID 16447)
-- Name: branch_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branch_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branch_branch_id_seq;

--
-- TOC entry 2865 (class 0 OID 0)
-- Dependencies: 198
-- Name: branch_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branch_branch_id_seq OWNED BY public.branch.id;


--
-- TOC entry 196 (class 1259 OID 16426)
-- Name: facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facility (
    name character varying(50) NOT NULL,
    price numeric NOT NULL,
    description text,
    quantity integer NOT NULL,
    photo_dir character varying(200),
    status integer NOT NULL,
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 197 (class 1259 OID 16436)
-- Name: facility_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2866 (class 0 OID 0)
-- Dependencies: 197
-- Name: facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facility_id_seq OWNED BY public.facility.id;


--
-- TOC entry 203 (class 1259 OID 16468)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(50),
    price double precision,
    description text,
    brand_name character varying(50),
    photo_dir character varying(200),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    product_category_id integer NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 16460)
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id integer NOT NULL,
    name character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 200 (class 1259 OID 16458)
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2867 (class 0 OID 0)
-- Dependencies: 200
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- TOC entry 202 (class 1259 OID 16466)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 2868 (class 0 OID 0)
-- Dependencies: 202
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- TOC entry 2710 (class 2604 OID 16452)
-- Name: branch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_branch_id_seq'::regclass);


--
-- TOC entry 2707 (class 2604 OID 16438)
-- Name: facility id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility ALTER COLUMN id SET DEFAULT nextval('public.facility_id_seq'::regclass);


--
-- TOC entry 2716 (class 2604 OID 16471)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 2713 (class 2604 OID 16463)
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- TOC entry 2854 (class 0 OID 16449)
-- Dependencies: 199
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (1, 'Hoa Lan Cau Giay', '113', '169 Cay Giay', NULL, NULL, '2019-09-18 11:22:55.638863', '2019-09-18 11:22:55.638863', NULL);
INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (2, 'Hoa Lan Thanh Xuan', '0999888777', '350 Thanh Xuan', NULL, NULL, '2019-09-22 16:26:29.359371', '2019-09-22 16:27:10.177883', NULL);


--
-- TOC entry 2851 (class 0 OID 16426)
-- Dependencies: 196
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('Quat dien', 3000000, 'Dung de lam mat', 1960, NULL, 0, 3, '2019-09-22 16:45:50.165715', '2019-09-22 16:45:57.983674');
INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('May say toc', 5000000, 'De say toc', 69, NULL, 1, 1, '2019-09-22 16:45:50.165715', '2019-09-22 16:56:54.326725');
INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('May hap toc', 1000000, 'Dung de say toc', 6969, NULL, 1, 5, '2019-09-22 16:45:50.165715', '2019-09-22 16:59:22.709837');


--
-- TOC entry 2858 (class 0 OID 16468)
-- Dependencies: 203
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2856 (class 0 OID 16460)
-- Dependencies: 201
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2869 (class 0 OID 0)
-- Dependencies: 198
-- Name: branch_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branch_branch_id_seq', 2, true);


--
-- TOC entry 2870 (class 0 OID 0)
-- Dependencies: 197
-- Name: facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facility_id_seq', 5, true);


--
-- TOC entry 2871 (class 0 OID 0)
-- Dependencies: 200
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_category_id_seq', 1, false);


--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 202
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 1, false);


--
-- TOC entry 2722 (class 2606 OID 16480)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (id);


--
-- TOC entry 2720 (class 2606 OID 16446)
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (id);


--
-- TOC entry 2724 (class 2606 OID 16482)
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- TOC entry 2726 (class 2606 OID 16478)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 2729 (class 2620 OID 16489)
-- Name: branch branch_table_update_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER branch_table_update_timestamp BEFORE UPDATE ON public.branch FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2728 (class 2620 OID 16499)
-- Name: facility facility_update_timestamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER facility_update_timestamp BEFORE UPDATE ON public.facility FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2727 (class 2606 OID 16483)
-- Name: product pk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product_category_id FOREIGN KEY (product_category_id) REFERENCES public.product_category(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-09-22 19:40:58

--
-- PostgreSQL database dump complete
--

