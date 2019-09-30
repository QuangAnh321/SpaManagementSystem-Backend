--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-09-30 10:33:05

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
-- TOC entry 204 (class 1255 OID 16451)
-- Name: set_updated_timestamp(); Type: FUNCTION; Schema: public; Owner: -
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
-- TOC entry 196 (class 1259 OID 16452)
-- Name: branch; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 197 (class 1259 OID 16460)
-- Name: branch_branch_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.branch_branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2866 (class 0 OID 0)
-- Dependencies: 197
-- Name: branch_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.branch_branch_id_seq OWNED BY public.branch.id;


--
-- TOC entry 198 (class 1259 OID 16462)
-- Name: facility; Type: TABLE; Schema: public; Owner: -
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
-- TOC entry 199 (class 1259 OID 16470)
-- Name: facility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2867 (class 0 OID 0)
-- Dependencies: 199
-- Name: facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.facility_id_seq OWNED BY public.facility.id;


--
-- TOC entry 200 (class 1259 OID 16472)
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    product_id integer NOT NULL,
    name character varying(50) NOT NULL,
    price double precision NOT NULL,
    description text,
    brand_name character varying(50),
    photo_dir character varying(200),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    product_category_id integer
);


--
-- TOC entry 201 (class 1259 OID 16480)
-- Name: product_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_category (
    product_category_id integer NOT NULL,
    name character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 202 (class 1259 OID 16485)
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2868 (class 0 OID 0)
-- Dependencies: 202
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.product_category_id;


--
-- TOC entry 203 (class 1259 OID 16487)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2869 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.product_id;


--
-- TOC entry 2709 (class 2604 OID 16489)
-- Name: branch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_branch_id_seq'::regclass);


--
-- TOC entry 2712 (class 2604 OID 16490)
-- Name: facility id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility ALTER COLUMN id SET DEFAULT nextval('public.facility_id_seq'::regclass);


--
-- TOC entry 2715 (class 2604 OID 16491)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 2718 (class 2604 OID 16492)
-- Name: product_category product_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category ALTER COLUMN product_category_id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- TOC entry 2853 (class 0 OID 16452)
-- Dependencies: 196
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) FROM stdin;
1	Hoa Lan Cau Giay	113	196 Cay Giay	\N	\N	2019-09-18 11:22:55.638863	2019-09-23 11:11:32.878096	\N
2	Hoa Lan Thanh Xuan	0999888777	350 Nguyen Trai	Gan dai hoc khoa hoc tu nhien	\N	2019-09-22 16:26:29.359371	2019-09-24 10:22:31.649469	\N
7	Hoa Lan Bac Tu Liem	117	200 Vo Chi Cong	\N	\N	2019-09-27 00:05:52.754763	2019-09-27 00:05:52.754763	\N
\.


--
-- TOC entry 2855 (class 0 OID 16462)
-- Dependencies: 198
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) FROM stdin;
Quat dien	3000000	Dung de lam mat	1960	\N	0	3	2019-09-22 16:45:50.165715	2019-09-22 16:45:57.983674
May say toc	5000000	De say toc	69	\N	1	1	2019-09-22 16:45:50.165715	2019-09-22 16:56:54.326725
May hap toc	1000000	Dung de hap toc	20	\N	1	5	2019-09-22 16:45:50.165715	2019-09-24 10:30:34.278837
\.


--
-- TOC entry 2857 (class 0 OID 16472)
-- Dependencies: 200
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product (product_id, name, price, description, brand_name, photo_dir, created_at, updated_at, product_category_id) FROM stdin;
2	Clear toc dau	50000	\N	\N	\N	2019-09-28 16:22:41.398048	2019-09-28 16:22:41.398048	3
3	Clear toc kho	30000	\N	\N	\N	2019-09-28 17:19:13.470831	2019-09-28 17:19:13.470831	3
4	Dau xa dove	40000	\N	\N	\N	2019-09-28 17:23:32.16259	2019-09-28 17:23:32.16259	4
\.


--
-- TOC entry 2858 (class 0 OID 16480)
-- Dependencies: 201
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_category (product_category_id, name, created_at, updated_at) FROM stdin;
4	Dau xa	2019-09-27 21:42:27.799288	2019-09-27 21:42:27.799288
3	Dau goi	2019-09-27 21:34:52.246957	2019-09-27 21:44:05.782901
\.


--
-- TOC entry 2870 (class 0 OID 0)
-- Dependencies: 197
-- Name: branch_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.branch_branch_id_seq', 7, true);


--
-- TOC entry 2871 (class 0 OID 0)
-- Dependencies: 199
-- Name: facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.facility_id_seq', 6, true);


--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 202
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_category_id_seq', 5, true);


--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_id_seq', 5, true);


--
-- TOC entry 2720 (class 2606 OID 16494)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (id);


--
-- TOC entry 2722 (class 2606 OID 16496)
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (id);


--
-- TOC entry 2726 (class 2606 OID 16498)
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (product_category_id);


--
-- TOC entry 2724 (class 2606 OID 16500)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 2728 (class 2620 OID 16501)
-- Name: branch branch_table_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER branch_table_update_timestamp BEFORE UPDATE ON public.branch FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2729 (class 2620 OID 16502)
-- Name: facility facility_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER facility_update_timestamp BEFORE UPDATE ON public.facility FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2731 (class 2620 OID 16508)
-- Name: product_category product_category_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_category_update_timestamp BEFORE UPDATE ON public.product_category FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2730 (class 2620 OID 16509)
-- Name: product product_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_update_timestamp BEFORE UPDATE ON public.product FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2727 (class 2606 OID 16503)
-- Name: product pk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product_category_id FOREIGN KEY (product_category_id) REFERENCES public.product_category(product_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-09-30 10:33:05

--
-- PostgreSQL database dump complete
--

