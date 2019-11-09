--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-11-09 22:52:13

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 228 (class 1255 OID 16451)
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
-- TOC entry 225 (class 1259 OID 16702)
-- Name: booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    "time" character varying(255) NOT NULL,
    email character varying(255),
    address character varying(255),
    description text,
    service_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 224 (class 1259 OID 16700)
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 224
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.booking_id;


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
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 197
-- Name: branch_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.branch_branch_id_seq OWNED BY public.branch.id;


--
-- TOC entry 219 (class 1259 OID 16643)
-- Name: coupon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon (
    coupon_id integer NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    offer integer NOT NULL,
    service_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    expire_date character varying(255) NOT NULL,
    CONSTRAINT coupon_offer_check CHECK ((offer > 0)),
    CONSTRAINT coupon_offer_check1 CHECK ((offer <= 100))
);


--
-- TOC entry 218 (class 1259 OID 16641)
-- Name: coupon_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 218
-- Name: coupon_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_coupon_id_seq OWNED BY public.coupon.coupon_id;


--
-- TOC entry 213 (class 1259 OID 16594)
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    address character varying(255),
    email character varying(255),
    gender character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 212 (class 1259 OID 16592)
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 212
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- TOC entry 217 (class 1259 OID 16619)
-- Name: equipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment (
    equipment_id integer NOT NULL,
    name character varying(255) NOT NULL,
    status character varying(10) NOT NULL,
    price double precision NOT NULL,
    description text,
    photo_dir character varying(255),
    equipment_category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 215 (class 1259 OID 16608)
-- Name: equipment_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment_category (
    equipment_category_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 214 (class 1259 OID 16606)
-- Name: equipment_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equipment_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 214
-- Name: equipment_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equipment_category_id_seq OWNED BY public.equipment_category.equipment_category_id;


--
-- TOC entry 216 (class 1259 OID 16617)
-- Name: equipment_equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equipment_equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 216
-- Name: equipment_equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equipment_equipment_id_seq OWNED BY public.equipment.equipment_id;


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
-- TOC entry 3061 (class 0 OID 0)
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
    description text,
    photo_dir character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    product_category_id integer NOT NULL,
    brand character varying(255),
    sale_price double precision NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 16480)
-- Name: product_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_category (
    product_category_id integer NOT NULL,
    name character varying(255) NOT NULL,
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
-- TOC entry 3062 (class 0 OID 0)
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
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.product_id;


--
-- TOC entry 207 (class 1259 OID 16542)
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
-- TOC entry 205 (class 1259 OID 16533)
-- Name: service_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_group (
    service_group_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 204 (class 1259 OID 16531)
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
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 204
-- Name: service_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_group_id_seq OWNED BY public.service_group.service_group_id;


--
-- TOC entry 206 (class 1259 OID 16540)
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
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 206
-- Name: service_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_service_id_seq OWNED BY public.service.service_id;


--
-- TOC entry 211 (class 1259 OID 16572)
-- Name: staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staff (
    staff_id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    email character varying(255),
    photo_dir character varying(255),
    staff_category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 209 (class 1259 OID 16563)
-- Name: staff_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staff_category (
    staff_category_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 208 (class 1259 OID 16561)
-- Name: staff_category_staff_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.staff_category_staff_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 208
-- Name: staff_category_staff_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.staff_category_staff_category_id_seq OWNED BY public.staff_category.staff_category_id;


--
-- TOC entry 210 (class 1259 OID 16570)
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 210
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.staff_id;


--
-- TOC entry 227 (class 1259 OID 16721)
-- Name: storage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.storage (
    storage_id integer NOT NULL,
    is_import boolean NOT NULL,
    price double precision NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    quantity integer
);


--
-- TOC entry 226 (class 1259 OID 16719)
-- Name: storage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 226
-- Name: storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.storage_id_seq OWNED BY public.storage.storage_id;


--
-- TOC entry 223 (class 1259 OID 16677)
-- Name: supplier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.supplier (
    supplier_id integer NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    supplier_category_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 221 (class 1259 OID 16666)
-- Name: supplier_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.supplier_category (
    supplier_category_id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 220 (class 1259 OID 16664)
-- Name: supplier_category_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.supplier_category_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 220
-- Name: supplier_category_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.supplier_category_supplier_id_seq OWNED BY public.supplier_category.supplier_category_id;


--
-- TOC entry 222 (class 1259 OID 16675)
-- Name: supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 222
-- Name: supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.supplier_id_seq OWNED BY public.supplier.supplier_id;


--
-- TOC entry 2830 (class 2604 OID 16705)
-- Name: booking booking_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- TOC entry 2788 (class 2604 OID 16489)
-- Name: branch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_branch_id_seq'::regclass);


--
-- TOC entry 2819 (class 2604 OID 16646)
-- Name: coupon coupon_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon ALTER COLUMN coupon_id SET DEFAULT nextval('public.coupon_coupon_id_seq'::regclass);


--
-- TOC entry 2810 (class 2604 OID 16597)
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- TOC entry 2816 (class 2604 OID 16622)
-- Name: equipment equipment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment ALTER COLUMN equipment_id SET DEFAULT nextval('public.equipment_equipment_id_seq'::regclass);


--
-- TOC entry 2813 (class 2604 OID 16611)
-- Name: equipment_category equipment_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment_category ALTER COLUMN equipment_category_id SET DEFAULT nextval('public.equipment_category_id_seq'::regclass);


--
-- TOC entry 2791 (class 2604 OID 16490)
-- Name: facility id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility ALTER COLUMN id SET DEFAULT nextval('public.facility_id_seq'::regclass);


--
-- TOC entry 2794 (class 2604 OID 16491)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 2797 (class 2604 OID 16492)
-- Name: product_category product_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category ALTER COLUMN product_category_id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- TOC entry 2801 (class 2604 OID 16545)
-- Name: service service_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service ALTER COLUMN service_id SET DEFAULT nextval('public.service_service_id_seq'::regclass);


--
-- TOC entry 2798 (class 2604 OID 16536)
-- Name: service_group service_group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_group ALTER COLUMN service_group_id SET DEFAULT nextval('public.service_group_id_seq'::regclass);


--
-- TOC entry 2807 (class 2604 OID 16575)
-- Name: staff staff_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff ALTER COLUMN staff_id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- TOC entry 2804 (class 2604 OID 16566)
-- Name: staff_category staff_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff_category ALTER COLUMN staff_category_id SET DEFAULT nextval('public.staff_category_staff_category_id_seq'::regclass);


--
-- TOC entry 2833 (class 2604 OID 16724)
-- Name: storage storage_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storage ALTER COLUMN storage_id SET DEFAULT nextval('public.storage_id_seq'::regclass);


--
-- TOC entry 2827 (class 2604 OID 16680)
-- Name: supplier supplier_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier ALTER COLUMN supplier_id SET DEFAULT nextval('public.supplier_id_seq'::regclass);


--
-- TOC entry 2824 (class 2604 OID 16669)
-- Name: supplier_category supplier_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier_category ALTER COLUMN supplier_category_id SET DEFAULT nextval('public.supplier_category_supplier_id_seq'::regclass);


--
-- TOC entry 3046 (class 0 OID 16702)
-- Dependencies: 225
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.booking (booking_id, name, phone_number, "time", email, address, description, service_id, created_at, updated_at) VALUES (1, 'Cuoc hen 1', '113', '20/10/2019', NULL, NULL, NULL, 2, '2019-10-19 17:43:42.705651', '2019-10-19 17:43:42.705651');
INSERT INTO public.booking (booking_id, name, phone_number, "time", email, address, description, service_id, created_at, updated_at) VALUES (2, 'Cuoc hen 2', '114', '20/11/2019', NULL, NULL, NULL, 2, '2019-10-20 23:13:01.210325', '2019-10-20 23:13:01.210325');
INSERT INTO public.booking (booking_id, name, phone_number, "time", email, address, description, service_id, created_at, updated_at) VALUES (3, 'Cuoc hen 3', '115', '20/11/2021', NULL, NULL, 'Bac si', 3, '2019-10-20 23:27:12.009728', '2019-10-20 23:31:13.737511');


--
-- TOC entry 3017 (class 0 OID 16452)
-- Dependencies: 196
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (1, 'Hoa Lan Cau Giay', '113', '196 Cay Giay', NULL, NULL, '2019-09-18 11:22:55.638863', '2019-09-23 11:11:32.878096', NULL);
INSERT INTO public.branch (id, name, phone_number, address, description, email, created_at, updated_at, photo_dir) VALUES (2, 'Hoa Lan Thanh Xuan', '0999888777', '350 Nguyen Trai', 'Gan dai hoc khoa hoc tu nhien', NULL, '2019-09-22 16:26:29.359371', '2019-09-24 10:22:31.649469', NULL);


--
-- TOC entry 3040 (class 0 OID 16643)
-- Dependencies: 219
-- Data for Name: coupon; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.coupon (coupon_id, code, name, description, offer, service_id, created_at, updated_at, expire_date) VALUES (1, '123abc', 'Ma giam gia 1', NULL, 50, 2, '2019-10-15 22:59:41.971569', '2019-10-15 22:59:41.971569', '11/11/2019');
INSERT INTO public.coupon (coupon_id, code, name, description, offer, service_id, created_at, updated_at, expire_date) VALUES (2, 'aaaaaaa', 'Ma giam gia 777777', NULL, 70, 2, '2019-10-15 23:05:16.602037', '2019-10-19 12:26:26.532394', '12/11/2019');


--
-- TOC entry 3034 (class 0 OID 16594)
-- Dependencies: 213
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.customer (customer_id, name, phone_number, address, email, gender, created_at, updated_at) VALUES (2, 'Vu Van B', '0123456788', 'Ha Noi', NULL, 'NAM', '2019-10-07 16:26:02.817643', '2019-10-07 16:26:02.817643');
INSERT INTO public.customer (customer_id, name, phone_number, address, email, gender, created_at, updated_at) VALUES (1, 'Vu Thi B', '0123456789', NULL, NULL, 'NU', '2019-10-07 16:24:45.89503', '2019-10-09 13:31:08.771996');


--
-- TOC entry 3038 (class 0 OID 16619)
-- Dependencies: 217
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.equipment (equipment_id, name, status, price, description, photo_dir, equipment_category_id, created_at, updated_at) VALUES (1, 'Trang bi 1', 'ACTIVE', 50000, NULL, NULL, 1, '2019-10-14 22:22:36.065444', '2019-10-14 22:22:36.065444');
INSERT INTO public.equipment (equipment_id, name, status, price, description, photo_dir, equipment_category_id, created_at, updated_at) VALUES (8, 'Trang bi 2', 'INACTIVE', 60000, 'Day la trang bi so 2', NULL, 3, '2019-10-14 22:33:34.994093', '2019-10-14 22:42:59.546791');


--
-- TOC entry 3036 (class 0 OID 16608)
-- Dependencies: 215
-- Data for Name: equipment_category; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.equipment_category (equipment_category_id, name, created_at, updated_at) VALUES (1, 'loại 1', '2019-10-14 17:02:34.811778', '2019-10-14 17:02:34.811778');
INSERT INTO public.equipment_category (equipment_category_id, name, created_at, updated_at) VALUES (3, 'loại 3', '2019-10-14 17:02:46.630988', '2019-10-14 17:02:46.630988');


--
-- TOC entry 3019 (class 0 OID 16462)
-- Dependencies: 198
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('Ban', 3000000, 'Dung de lam dat do vat', 1960, NULL, 0, 3, '2019-09-22 16:45:50.165715', '2019-10-10 09:44:00.878094');
INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('Ghe go', 5000000, 'Dung de ngoi', 69, NULL, 1, 1, '2019-09-22 16:45:50.165715', '2019-10-10 09:44:53.963861');
INSERT INTO public.facility (name, price, description, quantity, photo_dir, status, id, created_at, updated_at) VALUES ('Binh hoa', 1000000, 'Dung de cam hoa', 20, NULL, 1, 5, '2019-09-22 16:45:50.165715', '2019-10-10 09:45:31.599604');


--
-- TOC entry 3021 (class 0 OID 16472)
-- Dependencies: 200
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product (product_id, name, description, photo_dir, created_at, updated_at, product_category_id, brand, sale_price) VALUES (3, 'Clear toc kho', NULL, NULL, '2019-09-28 17:19:13.470831', '2019-11-09 22:37:25.345334', 3, NULL, 50000);
INSERT INTO public.product (product_id, name, description, photo_dir, created_at, updated_at, product_category_id, brand, sale_price) VALUES (2, 'Clear toc dau', NULL, NULL, '2019-09-28 16:22:41.398048', '2019-11-09 22:37:25.345334', 3, NULL, 20000);
INSERT INTO public.product (product_id, name, description, photo_dir, created_at, updated_at, product_category_id, brand, sale_price) VALUES (6, 'Pantene sieu muot', NULL, NULL, '2019-10-09 22:43:29.068418', '2019-11-09 22:37:25.345334', 4, 'Pantene', 50000);
INSERT INTO public.product (product_id, name, description, photo_dir, created_at, updated_at, product_category_id, brand, sale_price) VALUES (11, 'Clear toc gi do', 'Cho toc gi do', NULL, '2019-10-28 22:50:36.000768', '2019-11-09 22:37:25.345334', 3, NULL, 20000);
INSERT INTO public.product (product_id, name, description, photo_dir, created_at, updated_at, product_category_id, brand, sale_price) VALUES (12, 'Clear 2', 'Cho toc 2', NULL, '2019-10-28 23:06:18.183462', '2019-11-09 22:37:25.345334', 3, NULL, 50000);
INSERT INTO public.product (product_id, name, description, photo_dir, created_at, updated_at, product_category_id, brand, sale_price) VALUES (13, 'Dau goi head and shoulder', NULL, NULL, '2019-11-09 22:50:21.372666', '2019-11-09 22:50:21.372666', 3, NULL, 20000);


--
-- TOC entry 3022 (class 0 OID 16480)
-- Dependencies: 201
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_category (product_category_id, name, created_at, updated_at) VALUES (4, 'Dau xa', '2019-09-27 21:42:27.799288', '2019-09-27 21:42:27.799288');
INSERT INTO public.product_category (product_category_id, name, created_at, updated_at) VALUES (3, 'Dau goi', '2019-09-27 21:34:52.246957', '2019-09-27 21:44:05.782901');


--
-- TOC entry 3028 (class 0 OID 16542)
-- Dependencies: 207
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.service (service_id, name, "time", price, description, photo_dir, service_group_id, created_at, updated_at) VALUES (2, 'Triet long chan', 60, 50000, NULL, NULL, 1, '2019-10-05 21:34:55.620905', '2019-10-05 21:39:04.682053');
INSERT INTO public.service (service_id, name, "time", price, description, photo_dir, service_group_id, created_at, updated_at) VALUES (3, 'Mat xa bung', 30, 60000, NULL, NULL, 3, '2019-10-05 21:42:19.4254', '2019-10-05 21:43:09.277107');
INSERT INTO public.service (service_id, name, "time", price, description, photo_dir, service_group_id, created_at, updated_at) VALUES (5, 'Mat xa bung 2', 30, 60000, NULL, NULL, 3, '2019-11-04 00:45:48.339553', '2019-11-04 00:45:48.339553');


--
-- TOC entry 3026 (class 0 OID 16533)
-- Dependencies: 205
-- Data for Name: service_group; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.service_group (service_group_id, name, created_at, updated_at) VALUES (1, 'Triet long', '2019-10-05 17:28:53.500146', '2019-10-05 17:28:53.500146');
INSERT INTO public.service_group (service_group_id, name, created_at, updated_at) VALUES (3, 'Mat xa', '2019-10-05 21:36:31.534907', '2019-10-05 21:36:31.534907');


--
-- TOC entry 3032 (class 0 OID 16572)
-- Dependencies: 211
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.staff (staff_id, name, phone_number, address, email, photo_dir, staff_category_id, created_at, updated_at) VALUES (1, 'Nguyen van a', '0123456789', 'Ba Dinh, Ha Noi', NULL, NULL, 1, '2019-10-06 21:55:26.111691', '2019-10-06 21:55:26.111691');
INSERT INTO public.staff (staff_id, name, phone_number, address, email, photo_dir, staff_category_id, created_at, updated_at) VALUES (2, 'Nguyen thi b', '0123456799', 'Thanh Xuan, Ha Noi', NULL, NULL, 2, '2019-10-06 21:56:11.175543', '2019-10-06 21:56:11.175543');


--
-- TOC entry 3030 (class 0 OID 16563)
-- Dependencies: 209
-- Data for Name: staff_category; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.staff_category (staff_category_id, name, created_at, updated_at) VALUES (1, 'Bao ve', '2019-10-06 20:58:02.977946', '2019-10-06 20:58:02.977946');
INSERT INTO public.staff_category (staff_category_id, name, created_at, updated_at) VALUES (2, 'Nhan vien mat xa', '2019-10-06 20:58:24.861845', '2019-10-06 20:58:53.184823');


--
-- TOC entry 3048 (class 0 OID 16721)
-- Dependencies: 227
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.storage (storage_id, is_import, price, product_id, created_at, updated_at, quantity) VALUES (1, true, 50000, 2, '2019-10-31 22:53:52.060926', '2019-10-31 22:53:52.060926', 50);
INSERT INTO public.storage (storage_id, is_import, price, product_id, created_at, updated_at, quantity) VALUES (2, true, 20000, 3, '2019-10-31 23:18:28.805426', '2019-10-31 23:18:28.805426', 100);
INSERT INTO public.storage (storage_id, is_import, price, product_id, created_at, updated_at, quantity) VALUES (3, false, 20000, 3, '2019-10-31 23:21:17.573357', '2019-10-31 23:22:18.13534', 150);
INSERT INTO public.storage (storage_id, is_import, price, product_id, created_at, updated_at, quantity) VALUES (5, true, 20000, 3, '2019-11-01 10:15:15.629196', '2019-11-01 23:24:18.534603', 1750);


--
-- TOC entry 3044 (class 0 OID 16677)
-- Dependencies: 223
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.supplier (supplier_id, code, name, phone_number, address, supplier_category_id, created_at, updated_at) VALUES (1, '765765656', 'Nha phan phoi abc', '0987654321', 'Cau Giay, Ha Noi', 1, '2019-10-19 11:54:31.419812', '2019-10-19 11:54:31.419812');
INSERT INTO public.supplier (supplier_id, code, name, phone_number, address, supplier_category_id, created_at, updated_at) VALUES (3, 'bvgy6565', 'Nha phan phoi xyz', '0987676', 'Cau Giay, Ha Noi', 2, '2019-10-19 12:03:17.718196', '2019-10-19 12:03:17.718196');
INSERT INTO public.supplier (supplier_id, code, name, phone_number, address, supplier_category_id, created_at, updated_at) VALUES (6, '767676767', 'Nha phan phoi xyzhhhhhhhhhh', '0987676', 'Cau Giay, Ha Noi fdjfhfhdfd', 2, '2019-10-19 12:16:34.629197', '2019-10-19 12:19:36.191292');


--
-- TOC entry 3042 (class 0 OID 16666)
-- Dependencies: 221
-- Data for Name: supplier_category; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.supplier_category (supplier_category_id, name, created_at, updated_at) VALUES (1, 'Nha phan phoi 1', '2019-10-17 18:19:56.658487', '2019-10-17 18:19:56.658487');
INSERT INTO public.supplier_category (supplier_category_id, name, created_at, updated_at) VALUES (2, 'Nha phan phoi 2', '2019-10-17 18:20:03.237681', '2019-10-17 18:20:03.237681');
INSERT INTO public.supplier_category (supplier_category_id, name, created_at, updated_at) VALUES (3, 'Nha phan phoi 3', '2019-10-17 18:20:17.729726', '2019-10-17 18:20:17.729726');


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 224
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_id_seq', 52106, true);


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 197
-- Name: branch_branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.branch_branch_id_seq', 7, true);


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 218
-- Name: coupon_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_coupon_id_seq', 3, true);


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 212
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 3, true);


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 214
-- Name: equipment_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_category_id_seq', 4, true);


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 216
-- Name: equipment_equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.equipment_equipment_id_seq', 9, true);


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 199
-- Name: facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.facility_id_seq', 6, true);


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 202
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_category_id_seq', 5, true);


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 203
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_id_seq', 13, true);


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 204
-- Name: service_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_group_id_seq', 3, true);


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 206
-- Name: service_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_service_id_seq', 5, true);


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 208
-- Name: staff_category_staff_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staff_category_staff_category_id_seq', 3, true);


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 210
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staff_id_seq', 3, true);


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 226
-- Name: storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.storage_id_seq', 5, true);


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 220
-- Name: supplier_category_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.supplier_category_supplier_id_seq', 4, true);


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 222
-- Name: supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.supplier_id_seq', 6, true);


--
-- TOC entry 2869 (class 2606 OID 16713)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 2837 (class 2606 OID 16494)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (id);


--
-- TOC entry 2859 (class 2606 OID 16655)
-- Name: coupon coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (coupon_id);


--
-- TOC entry 2853 (class 2606 OID 16604)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 2855 (class 2606 OID 16616)
-- Name: equipment_category equipment_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment_category
    ADD CONSTRAINT equipment_category_pkey PRIMARY KEY (equipment_category_id);


--
-- TOC entry 2857 (class 2606 OID 16630)
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);


--
-- TOC entry 2839 (class 2606 OID 16496)
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (id);


--
-- TOC entry 2843 (class 2606 OID 16498)
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (product_category_id);


--
-- TOC entry 2841 (class 2606 OID 16500)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 2845 (class 2606 OID 16554)
-- Name: service_group service_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_group
    ADD CONSTRAINT service_group_pkey PRIMARY KEY (service_group_id);


--
-- TOC entry 2847 (class 2606 OID 16552)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- TOC entry 2849 (class 2606 OID 16586)
-- Name: staff_category staff_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff_category
    ADD CONSTRAINT staff_category_pkey PRIMARY KEY (staff_category_id);


--
-- TOC entry 2851 (class 2606 OID 16583)
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- TOC entry 2871 (class 2606 OID 16729)
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (storage_id);


--
-- TOC entry 2863 (class 2606 OID 16674)
-- Name: supplier_category supplier_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier_category
    ADD CONSTRAINT supplier_category_pkey PRIMARY KEY (supplier_category_id);


--
-- TOC entry 2865 (class 2606 OID 16692)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id);


--
-- TOC entry 2861 (class 2606 OID 16658)
-- Name: coupon unique_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT unique_code UNIQUE (code);


--
-- TOC entry 2867 (class 2606 OID 16699)
-- Name: supplier unique_supplier_code; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT unique_supplier_code UNIQUE (code);


--
-- TOC entry 2894 (class 2620 OID 16711)
-- Name: booking booking_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER booking_update_timestamp BEFORE UPDATE ON public.booking FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2880 (class 2620 OID 16501)
-- Name: branch branch_table_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER branch_table_update_timestamp BEFORE UPDATE ON public.branch FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2891 (class 2620 OID 16656)
-- Name: coupon coupon_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER coupon_update_timestamp BEFORE UPDATE ON public.coupon FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2888 (class 2620 OID 16605)
-- Name: customer customer_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER customer_update_timestamp BEFORE UPDATE ON public.customer FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2889 (class 2620 OID 16614)
-- Name: equipment_category equipment_category_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER equipment_category_update_timestamp BEFORE UPDATE ON public.equipment_category FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2890 (class 2620 OID 16628)
-- Name: equipment equipment_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER equipment_update_timestamp BEFORE UPDATE ON public.equipment FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2881 (class 2620 OID 16502)
-- Name: facility facility_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER facility_update_timestamp BEFORE UPDATE ON public.facility FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2883 (class 2620 OID 16508)
-- Name: product_category product_category_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_category_update_timestamp BEFORE UPDATE ON public.product_category FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2882 (class 2620 OID 16509)
-- Name: product product_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_update_timestamp BEFORE UPDATE ON public.product FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2884 (class 2620 OID 16539)
-- Name: service_group service_group_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER service_group_update_timestamp BEFORE UPDATE ON public.service_group FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2885 (class 2620 OID 16560)
-- Name: service service_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER service_update_timestamp BEFORE UPDATE ON public.service FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2886 (class 2620 OID 16569)
-- Name: staff_category staff_category_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER staff_category_update_timestamp BEFORE UPDATE ON public.staff_category FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2887 (class 2620 OID 16581)
-- Name: staff staff_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER staff_update_timestamp BEFORE UPDATE ON public.staff FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2895 (class 2620 OID 16727)
-- Name: storage storage_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER storage_update_timestamp BEFORE UPDATE ON public.storage FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2892 (class 2620 OID 16672)
-- Name: supplier_category supplier_category_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER supplier_category_update_timestamp BEFORE UPDATE ON public.supplier_category FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2893 (class 2620 OID 16686)
-- Name: supplier supplier_update_timestamp; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER supplier_update_timestamp BEFORE UPDATE ON public.supplier FOR EACH ROW EXECUTE PROCEDURE public.set_updated_timestamp();


--
-- TOC entry 2875 (class 2606 OID 16636)
-- Name: equipment fk_equipment_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT fk_equipment_category_id FOREIGN KEY (equipment_category_id) REFERENCES public.equipment_category(equipment_category_id);


--
-- TOC entry 2879 (class 2606 OID 16730)
-- Name: storage fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 2873 (class 2606 OID 16555)
-- Name: service fk_service_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT fk_service_group_id FOREIGN KEY (service_group_id) REFERENCES public.service_group(service_group_id);


--
-- TOC entry 2876 (class 2606 OID 16659)
-- Name: coupon fk_service_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT fk_service_id FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- TOC entry 2878 (class 2606 OID 16714)
-- Name: booking fk_service_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_service_id FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- TOC entry 2874 (class 2606 OID 16587)
-- Name: staff fk_staff_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT fk_staff_category_id FOREIGN KEY (staff_category_id) REFERENCES public.staff_category(staff_category_id);


--
-- TOC entry 2877 (class 2606 OID 16693)
-- Name: supplier fk_supplier_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT fk_supplier_category_id FOREIGN KEY (supplier_category_id) REFERENCES public.supplier_category(supplier_category_id);


--
-- TOC entry 2872 (class 2606 OID 16503)
-- Name: product pk_product_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product_category_id FOREIGN KEY (product_category_id) REFERENCES public.product_category(product_category_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2019-11-09 22:52:14

--
-- PostgreSQL database dump complete
--

