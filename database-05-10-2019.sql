--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-10-05 22:04:31

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
-- TOC entry 210 (class 1255 OID 16451)
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
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    description text,
    email character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    photo_dir character varying(255)
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
-- TOC entry 2911 (class 0 OID 0)
-- Dependencies: 197
-- Name: branch_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.branch_branch_id_seq OWNED BY public.branch.id;


--
-- TOC entry 198 (class 1259 OID 16462)
-- Name: facility; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facility (
    name character varying(255) NOT NULL,
    price numeric NOT NULL,
    description text,
    quantity integer NOT NULL,
    photo_dir character varying(255),
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
-- TOC entry 2912 (class 0 OID 0)
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
    name character varying(255) NOT NULL,
    price double precision NOT NULL,
    description text,
    photo_dir character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    product_category_id integer,
    product_brand_id integer
);


--
-- TOC entry 205 (class 1259 OID 16517)
-- Name: product_brand; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_brand (
    product_brand_id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 204 (class 1259 OID 16515)
-- Name: product_brand_product_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_brand_product_brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2913 (class 0 OID 0)
-- Dependencies: 204
-- Name: product_brand_product_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_brand_product_brand_id_seq OWNED BY public.product_brand.product_brand_id;


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
-- TOC entry 2914 (class 0 OID 0)
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
-- TOC entry 2915 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.product_id;


--
-- TOC entry 209 (class 1259 OID 16542)
-- Name: service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service (
    service_id integer NOT NULL,
    name character varying(255) NOT NULL,
    "time" integer,
    price double precision NOT NULL,
    description text,
    photo_dir character varying(255),
    service_group_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 207 (class 1259 OID 16533)
-- Name: service_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_group (
    service_group_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 206 (class 1259 OID 16531)
-- Name: service_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.service_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2916 (class 0 OID 0)
-- Dependencies: 206
-- Name: service_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_group_id_seq OWNED BY public.service_group.service_group_id;


--
-- TOC entry 208 (class 1259 OID 16540)
-- Name: service_service_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.service_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2917 (class 0 OID 0)
-- Dependencies: 208
-- Name: service_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_service_id_seq OWNED BY public.service.service_id;


--
-- TOC entry 2728 (class 2604 OID 16489)
-- Name: branch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_branch_id_seq'::regclass);


--
-- TOC entry 2731 (class 2604 OID 16490)
-- Name: facility id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility ALTER COLUMN id SET DEFAULT nextval('public.facility_id_seq'::regclass);


--
-- TOC entry 2734 (class 2604 OID 16491)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 2738 (class 2604 OID 16520)
-- Name: product_brand product_brand_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_brand ALTER COLUMN product_brand_id SET DEFAULT nextval('public.product_brand_product_brand_id_seq'::regclass);


--
-- TOC entry 2737 (class 2604 OID 16492)
-- Name: product_category product_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category ALTER COLUMN product_category_id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- TOC entry 2744 (class 2604 OID 16545)
-- Name: service service_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service ALTER COLUMN service_id SET DEFAULT nextval('public.service_service_id_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 16536)
-- Name: service_group service_group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_group ALTER COLUMN service_group_id SET DEFAULT nextval('public.service_group_id_seq'::regclass);


--
-- TOC entry 2892 (class 0 OID 16452)
-- Dependencies: 196
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (1, 'Hoa Lan Cau Giay', '113', '196 Cay Giay', NULL, NULL, '2019-09-18 11:22:55.638863', '2019-09-23 11:11:32.878096', NULL);
INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (2, 'Hoa Lan Thanh Xuan', '0999888777', '350 Nguyen Trai', 'Gan dai hoc khoa hoc tu nhien', NULL, '2019-09-22 16:26:29.359371', '2019-09-24 10:22:31.649469', NULL);
INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (7, 'Hoa Lan Bac Tu Liem', '117', '200 Vo Chi Cong', NULL, NULL, '2019-09-27 00:05:52.754763', '2019-09-27 00:05:52.754763', NULL);


--
-- TOC entry 2894 (class 0 OID 16462)
-- Dependencies: 198
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('Quat dien', 3000000, 'Dung de lam mat', 1960, NULL, 0, 3, '2019-09-22 16:45:50.165715', '2019-09-22 16:45:57.983674');
INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('May say toc', 5000000, 'De say toc', 69, NULL, 1, 1, '2019-09-22 16:45:50.165715', '2019-09-22 16:56:54.326725');
INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('May hap toc', 1000000, 'Dung de hap toc', 20, NULL, 1, 5, '2019-09-22 16:45:50.165715', '2019-09-24 10:30:34.278837');


--
-- TOC entry 2896 (class 0 OID 16472)
-- Dependencies: 200
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product (product_id, name, price, description, photo_dir, created_at, updated_at, product_category_id, product_brand_id) VALUES (3, 'Clear toc kho', 30000, NULL, NULL, '2019-09-28 17:19:13.470831', '2019-10-01 23:24:32.752698', 3, 2);
INSERT INTO public.product (product_id, name, price, description, photo_dir, created_at, updated_at, product_category_id, product_brand_id) VALUES (2, 'Clear toc dau', 50000, NULL, NULL, '2019-09-28 16:22:41.398048', '2019-10-01 23:24:37.343685', 3, 2);
INSERT INTO public.product (product_id, name, price, description, photo_dir, created_at, updated_at, product_category_id, product_brand_id) VALUES (4, 'Dau xa dove', 50000, NULL, NULL, '2019-09-28 17:23:32.16259', '2019-10-05 17:50:18.375554', 4, 1);


--
-- TOC entry 2901 (class 0 OID 16517)
-- Dependencies: 205
-- Data for Name: product_brand; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_brand (product_brand_id, name, created_at, updated_at) VALUES (1, 'Dove', '2019-10-01 23:12:01.094524', '2019-10-01 23:12:01.094524');
INSERT INTO public.product_brand (product_brand_id, name, created_at, updated_at) VALUES (2, 'Clear', '2019-10-01 23:23:49.579038', '2019-10-01 23:23:49.579038');


--
-- TOC entry 2897 (class 0 OID 16480)
-- Dependencies: 201
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_category (product_category_id, name, created_at, updated_at) VALUES (4, 'Dau xa', '2019-09-27 21:42:27.799288', '2019-09-27 21:42:27.799288');
INSERT INTO public.product_category (product_category_id, name, created_at, updated_at) VALUES (3, 'Dau goi', '2019-09-27 21:34:52.246957', '2019-09-27 21:44:05.782901');


--
-- TOC entry 2905 (class 0 OID 16542)
-- Dependencies: 209
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.service (service_id, name, "time", price, description, photo_dir, service_group_id, created_at, updated_at) VALUES (2, 'Triet long chan', 60, 50000, NULL, NULL, 1, '2019-10-05 21:34:55.620905', '2019-10-05 21:39:04.682053');
INSERT INTO public.service (service_id, name, "time", price, description, photo_dir, service_group_id, created_at, updated_at) VALUES (3, 'Mat xa bung', 30, 60000, NULL, NULL, 3, '2019-10-05 21:42:19.4254', '2019-10-05 21:43:09.277107');


--
-- TOC entry 2903 (class 0 OID 16533)
-- Dependencies: 207
-- Data for Name: service_group; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.service_group (service_group_id, name, created_at, updated_at) VALUES (1, 'Triet long', '2019-10-05 17:28:53.500146', '2019-10-05 17:28:53.500146');
INSERT INTO public.service_group (service_group_id, name, created_at, updated_at) VALUES (3, 'Mat xa', '2019-10-05 21:36:31.534907', '2019-10-05 21:36:31.534907');


--
-- TOC entry 2918 (class 0 OID 0)
-- Dependencies: 197
-- Name: branch_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.branch_branch_id_seq', 7, true);


--
-- TOC entry 2919 (class 0 OID 0)
-- Dependencies: 199
-- Name: facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.facility_id_seq', 6, true);


--
-- TOC entry 2920 (class 0 OID 0)
-- Dependencies: 204
-- Name: product_brand_product_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_brand_product_brand_id_seq', 2, true);


--
-- TOC entry 2921 (class 0 OID 0)
-- Dependencies: 202
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_category_id_seq', 5, true);


--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_id_seq', 5, true);


--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 206
-- Name: service_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_group_id_seq', 3, true);


--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 208
-- Name: service_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_service_id_seq', 4, true);


--
-- TOC entry 2748 (class 2606 OID 16494)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (id);


--
-- TOC entry 2750 (class 2606 OID 16496)
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (id);


--
-- TOC entry 2756 (class 2606 OID 16525)
-- Name: product_brand product_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_brand
    ADD CONSTRAINT product_brand_pkey PRIMARY KEY (product_brand_id);


--
-- TOC entry 2754 (class 2606 OID 16498)
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (product_category_id);


--
-- TOC entry 2752 (class 2606 OID 16500)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 2758 (class 2606 OID 16554)
-- Name: service_group service_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_group
    ADD CONSTRAINT service_group_pkey PRIMARY KEY (service_group_id);


--
-- TOC entry 2760 (class 2606 OID 16552)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- TOC entry 2764 (class 2620 OID 16501)
-- Name: branch branch_table_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER branch_table_update_timestamp BEFORE UPDATE ON public.branch FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2765 (class 2620 OID 16502)
-- Name: facility facility_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER facility_update_timestamp BEFORE UPDATE ON public.facility FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2768 (class 2620 OID 16523)
-- Name: product_brand product_brand_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_brand_update_timestamp BEFORE UPDATE ON public.product_brand FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2767 (class 2620 OID 16508)
-- Name: product_category product_category_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_category_update_timestamp BEFORE UPDATE ON public.product_category FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2766 (class 2620 OID 16509)
-- Name: product product_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_update_timestamp BEFORE UPDATE ON public.product FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2769 (class 2620 OID 16539)
-- Name: service_group service_group_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER service_group_update_timestamp BEFORE UPDATE ON public.service_group FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2770 (class 2620 OID 16560)
-- Name: service service_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER service_update_timestamp BEFORE UPDATE ON public.service FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2763 (class 2606 OID 16555)
-- Name: service fk_service_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT fk_service_group_id FOREIGN KEY (service_group_id) REFERENCES public.service_group(service_group_id);


--
-- TOC entry 2762 (class 2606 OID 16526)
-- Name: product pk_product_brand_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product_brand_id FOREIGN KEY (product_brand_id) REFERENCES public.product_brand(product_brand_id);


--
-- TOC entry 2761 (class 2606 OID 16503)
-- Name: product pk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product_category_id FOREIGN KEY (product_category_id) REFERENCES public.product_category(product_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-10-05 22:04:32

--
-- PostgreSQL database dump complete
--

