--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id bigint NOT NULL,
    category_name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city character varying(25) NOT NULL,
    state character varying(25) NOT NULL,
    country character varying(25) DEFAULT 'USA'::character varying NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: contact_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_person (
    contact_person_id bigint NOT NULL,
    phone character varying(25),
    email character varying(50)
);


ALTER TABLE public.contact_person OWNER TO postgres;

--
-- Name: contact_person_contact_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_person_contact_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_person_contact_person_id_seq OWNER TO postgres;

--
-- Name: contact_person_contact_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_person_contact_person_id_seq OWNED BY public.contact_person.contact_person_id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id bigint NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(50),
    phone character varying(25),
    address character varying(100),
    zip_code character varying(20) NOT NULL,
    registration_date date NOT NULL,
    birth_date date NOT NULL,
    city character varying(25)
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_customer_id_seq OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id bigint NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    department character varying(50),
    "position" character varying(50),
    hire_date date,
    salary numeric(12,2),
    manager_id integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_employee_id_seq OWNER TO postgres;

--
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;


--
-- Name: inventory_movements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_movements (
    movement_id bigint NOT NULL,
    product_id integer NOT NULL,
    movement_type character varying(20) NOT NULL,
    quantity integer NOT NULL,
    movement_date date,
    reference_number character varying(50),
    notes text,
    CONSTRAINT inventory_movements_movement_type_check CHECK (((movement_type)::text = ANY ((ARRAY['Stock In'::character varying, 'Stock Out'::character varying, 'Adjustment'::character varying, 'Damaged'::character varying, 'Return'::character varying])::text[])))
);


ALTER TABLE public.inventory_movements OWNER TO postgres;

--
-- Name: inventory_movements_movement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_movements_movement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_movements_movement_id_seq OWNER TO postgres;

--
-- Name: inventory_movements_movement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventory_movements_movement_id_seq OWNED BY public.inventory_movements.movement_id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id bigint NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(12,2),
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_order_item_id_seq OWNER TO postgres;

--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id bigint NOT NULL,
    customer_id integer NOT NULL,
    order_date date,
    status character varying(10) NOT NULL,
    pay_method character varying(20) NOT NULL,
    ship_address character varying(100) NOT NULL,
    ship_date date,
    delivery_date date,
    total_amount numeric(10,2),
    promotion_id integer,
    ship_city character varying(25),
    ship_zip character varying(25),
    CONSTRAINT orders_pay_method_check CHECK (((pay_method)::text = ANY ((ARRAY['Credit Card'::character varying, 'Debit Card'::character varying, 'Paypal'::character varying, 'Google Pay'::character varying, 'Apple Pay'::character varying])::text[]))),
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'Shipped'::character varying, 'Delivered'::character varying, 'Cancelled'::character varying, 'Processing'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id bigint NOT NULL,
    product_name character varying(100) NOT NULL,
    category_id integer NOT NULL,
    brand character varying(50),
    price numeric(10,2) NOT NULL,
    cost numeric(10,2),
    stock_quantity integer DEFAULT 0,
    weight_kg numeric(6,2),
    dimension character varying(50),
    description text,
    created_date date
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_product_id_seq OWNER TO postgres;

--
-- Name: product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;


--
-- Name: product_suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_suppliers (
    product_id integer NOT NULL,
    supplier_id integer NOT NULL,
    supply_price numeric(10,2),
    lead_time_days integer,
    min_order_quantity integer
);


ALTER TABLE public.product_suppliers OWNER TO postgres;

--
-- Name: promotions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotions (
    promotion_id bigint NOT NULL,
    promotion_name character varying(100) NOT NULL,
    description text,
    discount_percentage numeric(5,2),
    start_date date,
    end_date date,
    is_active boolean DEFAULT true,
    CONSTRAINT promotions_discount_percentage_check CHECK (((discount_percentage >= (0)::numeric) AND (discount_percentage <= (100)::numeric)))
);


ALTER TABLE public.promotions OWNER TO postgres;

--
-- Name: promotions_promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promotions_promotion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.promotions_promotion_id_seq OWNER TO postgres;

--
-- Name: promotions_promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promotions_promotion_id_seq OWNED BY public.promotions.promotion_id;


--
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    review_id bigint NOT NULL,
    product_id integer NOT NULL,
    order_id integer NOT NULL,
    rating integer NOT NULL,
    review_text text,
    review_date date DEFAULT CURRENT_DATE,
    helpful_votes integer DEFAULT 0,
    CONSTRAINT review_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.review OWNER TO postgres;

--
-- Name: review_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.review_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_review_id_seq OWNER TO postgres;

--
-- Name: review_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.review_review_id_seq OWNED BY public.review.review_id;


--
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    supplier_id bigint NOT NULL,
    supplier_name character varying(50) NOT NULL,
    contact_person_id integer NOT NULL,
    rating numeric(2,1),
    address character varying(50),
    city character varying(25),
    CONSTRAINT supplier_rating_check CHECK (((rating >= (1)::numeric) AND (rating <= (5)::numeric)))
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_supplier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplier_supplier_id_seq OWNER TO postgres;

--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_supplier_id_seq OWNED BY public.supplier.supplier_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: contact_person contact_person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_person ALTER COLUMN contact_person_id SET DEFAULT nextval('public.contact_person_contact_person_id_seq'::regclass);


--
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- Name: employee employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);


--
-- Name: inventory_movements movement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_movements ALTER COLUMN movement_id SET DEFAULT nextval('public.inventory_movements_movement_id_seq'::regclass);


--
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);


--
-- Name: promotions promotion_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions ALTER COLUMN promotion_id SET DEFAULT nextval('public.promotions_promotion_id_seq'::regclass);


--
-- Name: review review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review ALTER COLUMN review_id SET DEFAULT nextval('public.review_review_id_seq'::regclass);


--
-- Name: supplier supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN supplier_id SET DEFAULT nextval('public.supplier_supplier_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, category_name, description) FROM stdin;
1	Electronics	All electronics products
2	Clothing	All clothing products
3	Home & Garden	All home & garden products
4	Sports & Outdoors	All sports & outdoors products
5	Books	All books products
6	Health & Beauty	All health & beauty products
7	Toys & Games	All toys & games products
8	Automotive	All automotive products
9	Food & Beverages	All food & beverages products
10	Arts & Crafts	All arts & crafts products
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (city, state, country) FROM stdin;
San Francisco	CA	USA
New York	NY	USA
Chicago	IL	USA
Denver	CO	USA
Boston	MA	USA
Austin	TX	USA
Charlotte	NC	USA
Columbus	OH	USA
Dallas	TX	USA
Fort Worth	TX	USA
Houston	TX	USA
Jacksonville	FL	USA
Los Angeles	CA	USA
Philadelphia	PA	USA
Phoenix	AZ	USA
San Antonio	TX	USA
San Diego	CA	USA
San Jose	CA	USA
\.


--
-- Data for Name: contact_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_person (contact_person_id, phone, email) FROM stdin;
1	-655	john@techsource.com
2	-656	sarah@fashionforward.com
3	-657	mike@homeessentials.com
4	-658	lisa@sportsgear.com
5	-659	david@globalbooks.com
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, first_name, last_name, email, phone, address, zip_code, registration_date, birth_date, city) FROM stdin;
1	Sarah	Smith	sarah.smith760@email.com	-5387.0	1779 Second Ave	87397.0	1970-01-01	1970-01-01	Chicago
2	Jane	Smith	jane.smith96@email.com	-9939.0	534 Second Ave	95181.0	1970-01-01	1970-01-01	San Jose
3	Jennifer	Davis	jennifer.davis460@email.com	-2192.0	2715 First St	46421.0	1970-01-01	1970-01-01	Fort Worth
4	Chris	Hernandez	chris.hernandez105@email.com	-3266.0	5735 Second Ave	15695.0	1970-01-01	1970-01-01	Philadelphia
5	Michelle	Brown	michelle.brown997@email.com	-6469.0	6025 Second Ave	19116.0	1970-01-01	1970-01-01	Columbus
6	Jessica	Martinez	jessica.martinez82@email.com	-3966.0	4654 First St	57819.0	1970-01-01	1970-01-01	San Antonio
7	Amanda	Lopez	amanda.lopez215@email.com	-3327.0	2903 Second Ave	31417.0	1970-01-01	1970-01-01	San Jose
8	James	Rodriguez	james.rodriguez948@email.com	-6156.0	5413 Main St	14207.0	1970-01-01	1970-01-01	Austin
9	James	Rodriguez	james.rodriguez68@email.com	-7150.0	8279 First St	70142.0	1970-01-01	1970-01-01	Houston
10	Daniel	Jones	daniel.jones253@email.com	-11365.0	9677 First St	62350.0	1970-01-01	1970-01-01	Phoenix
11	Jessica	Jones	jessica.jones522@email.com	-2568.0	1896 Oak Ave	30969.0	1970-01-01	1970-01-01	Columbus
12	Kimberly	Williams	kimberly.williams395@email.com	-9867.0	4219 Second Ave	99166.0	1970-01-01	1970-01-01	Dallas
13	Michelle	Rodriguez	michelle.rodriguez788@email.com	-4030.0	7223 Oak Ave	10425.0	1970-01-01	1970-01-01	Phoenix
14	William	Garcia	william.garcia520@email.com	-7087.0	8417 Second Ave	30032.0	1970-01-01	1970-01-01	Columbus
15	Emily	Moore	emily.moore977@email.com	-2548.0	5410 First St	24662.0	1970-01-01	1970-01-01	San Jose
16	Ashley	Davis	ashley.davis60@email.com	-3634.0	8062 Main St	26483.0	1970-01-01	1970-01-01	Los Angeles
17	Lisa	Moore	lisa.moore170@email.com	-8942.0	8935 Oak Ave	50857.0	1970-01-01	1970-01-01	Houston
18	Amanda	Anderson	amanda.anderson922@email.com	-4172.0	3781 Main St	12757.0	1970-01-01	1970-01-01	Houston
19	Jessica	Jackson	jessica.jackson226@email.com	-2242.0	1204 Main St	19287.0	1970-01-01	1970-01-01	Houston
20	Jessica	Rodriguez	jessica.rodriguez686@email.com	-10749.0	9455 Second Ave	41850.0	1970-01-01	1970-01-01	Chicago
21	Jennifer	Miller	jennifer.miller97@email.com	-9034.0	7039 First St	17100.0	1970-01-01	1970-01-01	Philadelphia
22	Jane	Gonzalez	jane.gonzalez746@email.com	-4155.0	3239 Oak Ave	68800.0	1970-01-01	1970-01-01	Houston
23	Jennifer	Garcia	jennifer.garcia286@email.com	-3162.0	9116 Main St	95477.0	1970-01-01	1970-01-01	San Diego
24	John	Williams	john.williams949@email.com	-6711.0	6758 First St	38016.0	1970-01-01	1970-01-01	Chicago
25	Jane	Garcia	jane.garcia389@email.com	-5945.0	7554 Park Rd	82845.0	1970-01-01	1970-01-01	Charlotte
26	David	Miller	david.miller304@email.com	-10363.0	5238 Main St	86569.0	1970-01-01	1970-01-01	New York
27	William	Taylor	william.taylor162@email.com	-3089.0	3144 Main St	18907.0	1970-01-01	1970-01-01	Columbus
28	James	Brown	james.brown965@email.com	-2685.0	1443 First St	86503.0	1970-01-01	1970-01-01	San Jose
29	William	Hernandez	william.hernandez958@email.com	-6822.0	4451 First St	98039.0	1970-01-01	1970-01-01	Houston
30	Robert	Hernandez	robert.hernandez952@email.com	-2194.0	9324 Main St	80468.0	1970-01-01	1970-01-01	San Diego
31	William	Rodriguez	william.rodriguez136@email.com	-5628.0	4769 Oak Ave	81200.0	1970-01-01	1970-01-01	Philadelphia
32	Kimberly	Taylor	kimberly.taylor9@email.com	-7623.0	1797 Oak Ave	25129.0	1970-01-01	1970-01-01	Charlotte
33	Michelle	Jones	michelle.jones279@email.com	-5556.0	5717 Oak Ave	93130.0	1970-01-01	1970-01-01	Jacksonville
34	William	Thomas	william.thomas258@email.com	-3629.0	7039 Park Rd	10464.0	1970-01-01	1970-01-01	Austin
35	David	Rodriguez	david.rodriguez166@email.com	-9417.0	258 Main St	29536.0	1970-01-01	1970-01-01	Dallas
36	Jane	Lopez	jane.lopez597@email.com	-8956.0	785 Park Rd	15229.0	1970-01-01	1970-01-01	Chicago
37	Chris	Davis	chris.davis683@email.com	-8324.0	2632 Oak Ave	33206.0	1970-01-01	1970-01-01	San Jose
38	John	Garcia	john.garcia755@email.com	-9085.0	4165 Park Rd	24168.0	1970-01-01	1970-01-01	Fort Worth
39	Jane	Thomas	jane.thomas228@email.com	-9780.0	5100 Oak Ave	13101.0	1970-01-01	1970-01-01	Philadelphia
40	James	Hernandez	james.hernandez286@email.com	-6728.0	8446 First St	80282.0	1970-01-01	1970-01-01	Philadelphia
41	John	Brown	john.brown899@email.com	-5997.0	1876 Second Ave	55309.0	1970-01-01	1970-01-01	New York
42	Jennifer	Martin	jennifer.martin524@email.com	-4825.0	827 First St	78146.0	1970-01-01	1970-01-01	Phoenix
43	Chris	Lopez	chris.lopez442@email.com	-7359.0	5243 Main St	76469.0	1970-01-01	1970-01-01	San Jose
44	Jennifer	Hernandez	jennifer.hernandez413@email.com	-4299.0	6988 First St	32810.0	1970-01-01	1970-01-01	Houston
45	Ashley	Gonzalez	ashley.gonzalez562@email.com	-7030.0	3543 First St	89516.0	1970-01-01	1970-01-01	Phoenix
46	Robert	Anderson	robert.anderson453@email.com	-10483.0	2880 Main St	77561.0	1970-01-01	1970-01-01	San Diego
47	Michael	Davis	michael.davis689@email.com	-5008.0	500 Main St	72277.0	1970-01-01	1970-01-01	Chicago
48	Robert	Wilson	robert.wilson908@email.com	-5617.0	6391 First St	41979.0	1970-01-01	1970-01-01	Jacksonville
49	John	Brown	john.brown798@email.com	-4739.0	8586 First St	83060.0	1970-01-01	1970-01-01	Fort Worth
50	Sarah	Anderson	sarah.anderson137@email.com	-11196.0	9855 Park Rd	90301.0	1970-01-01	1970-01-01	Dallas
51	Jennifer	Moore	jennifer.moore457@email.com	-9899.0	4346 Oak Ave	46347.0	1970-01-01	1970-01-01	San Diego
52	Lisa	Davis	lisa.davis282@email.com	-6409.0	4551 Park Rd	80798.0	1970-01-01	1970-01-01	Houston
53	David	Jones	david.jones237@email.com	-4804.0	3605 Main St	63424.0	1970-01-01	1970-01-01	Jacksonville
54	Michelle	Anderson	michelle.anderson426@email.com	-8356.0	9669 Main St	59857.0	1970-01-01	1970-01-01	San Antonio
55	John	Lopez	john.lopez306@email.com	-9234.0	9047 Second Ave	73993.0	1970-01-01	1970-01-01	Dallas
56	Daniel	Wilson	daniel.wilson498@email.com	-7133.0	6724 Oak Ave	26728.0	1970-01-01	1970-01-01	Austin
57	John	Gonzalez	john.gonzalez607@email.com	-2898.0	7122 Oak Ave	33819.0	1970-01-01	1970-01-01	Los Angeles
58	Daniel	Gonzalez	daniel.gonzalez336@email.com	-7235.0	6311 Park Rd	43065.0	1970-01-01	1970-01-01	Philadelphia
59	Lisa	Smith	lisa.smith768@email.com	-7537.0	1224 Main St	42411.0	1970-01-01	1970-01-01	Houston
60	John	Martin	john.martin157@email.com	-9330.0	1974 Second Ave	70952.0	1970-01-01	1970-01-01	Austin
61	Amanda	Garcia	amanda.garcia621@email.com	-4461.0	2783 Park Rd	85849.0	1970-01-01	1970-01-01	Fort Worth
62	Ashley	Jackson	ashley.jackson694@email.com	-5238.0	9800 Oak Ave	49529.0	1970-01-01	1970-01-01	Los Angeles
63	Charles	Johnson	charles.johnson356@email.com	-8253.0	8389 Park Rd	65057.0	1970-01-01	1970-01-01	Los Angeles
64	Sarah	Wilson	sarah.wilson984@email.com	-9751.0	2606 First St	78386.0	1970-01-01	1970-01-01	Jacksonville
65	Kimberly	Moore	kimberly.moore794@email.com	-9306.0	9807 Park Rd	42177.0	1970-01-01	1970-01-01	Columbus
66	Daniel	Anderson	daniel.anderson250@email.com	-8651.0	570 First St	33834.0	1970-01-01	1970-01-01	Philadelphia
67	Chris	Lopez	chris.lopez817@email.com	-6392.0	9867 Park Rd	11330.0	1970-01-01	1970-01-01	Charlotte
68	Chris	Williams	chris.williams248@email.com	-10356.0	4037 First St	74332.0	1970-01-01	1970-01-01	Dallas
69	John	Williams	john.williams302@email.com	-5825.0	9628 Park Rd	82544.0	1970-01-01	1970-01-01	Phoenix
70	Amanda	Wilson	amanda.wilson764@email.com	-7864.0	7534 Park Rd	42951.0	1970-01-01	1970-01-01	Jacksonville
71	Sarah	Miller	sarah.miller324@email.com	-10860.0	3133 Oak Ave	73464.0	1970-01-01	1970-01-01	Fort Worth
72	Charles	Taylor	charles.taylor612@email.com	-4770.0	3827 Park Rd	49618.0	1970-01-01	1970-01-01	Phoenix
73	Michelle	Jones	michelle.jones281@email.com	-6086.0	2168 First St	11607.0	1970-01-01	1970-01-01	Jacksonville
74	Ashley	Thomas	ashley.thomas491@email.com	-5018.0	4236 First St	18564.0	1970-01-01	1970-01-01	New York
75	Lisa	Williams	lisa.williams591@email.com	-3423.0	2544 Second Ave	21164.0	1970-01-01	1970-01-01	Chicago
76	Sarah	Moore	sarah.moore783@email.com	-5942.0	8661 First St	68028.0	1970-01-01	1970-01-01	Fort Worth
77	Charles	Wilson	charles.wilson313@email.com	-3402.0	1725 Oak Ave	37659.0	1970-01-01	1970-01-01	San Jose
78	Michael	Garcia	michael.garcia246@email.com	-3170.0	143 First St	87832.0	1970-01-01	1970-01-01	Chicago
79	Ashley	Johnson	ashley.johnson238@email.com	-6849.0	7538 Main St	40595.0	1970-01-01	1970-01-01	Jacksonville
80	Charles	Miller	charles.miller436@email.com	-5556.0	2541 Park Rd	19359.0	1970-01-01	1970-01-01	Austin
81	Emily	Martinez	emily.martinez610@email.com	-7537.0	2137 First St	49857.0	1970-01-01	1970-01-01	San Diego
82	Daniel	Taylor	daniel.taylor553@email.com	-3469.0	753 First St	89129.0	1970-01-01	1970-01-01	San Jose
83	John	Williams	john.williams235@email.com	-3084.0	4515 Second Ave	32962.0	1970-01-01	1970-01-01	Fort Worth
84	William	Anderson	william.anderson939@email.com	-8809.0	8156 Main St	55607.0	1970-01-01	1970-01-01	Austin
85	Matthew	Hernandez	matthew.hernandez687@email.com	-4818.0	6844 First St	96846.0	1970-01-01	1970-01-01	Philadelphia
86	Michelle	Johnson	michelle.johnson466@email.com	-5746.0	1999 First St	10150.0	1970-01-01	1970-01-01	Philadelphia
87	Robert	Wilson	robert.wilson56@email.com	-7848.0	8267 First St	36680.0	1970-01-01	1970-01-01	San Jose
88	Michelle	Jones	michelle.jones950@email.com	-9882.0	572 Second Ave	30758.0	1970-01-01	1970-01-01	Los Angeles
89	Michelle	Smith	michelle.smith566@email.com	-5392.0	1958 First St	94896.0	1970-01-01	1970-01-01	Columbus
90	Lisa	Martinez	lisa.martinez522@email.com	-9007.0	8005 First St	69871.0	1970-01-01	1970-01-01	Columbus
91	David	Gonzalez	david.gonzalez196@email.com	-4568.0	1243 Park Rd	54548.0	1970-01-01	1970-01-01	Columbus
92	Daniel	Smith	daniel.smith290@email.com	-10269.0	2534 First St	73483.0	1970-01-01	1970-01-01	Columbus
93	Matthew	Moore	matthew.moore782@email.com	-9601.0	5372 Oak Ave	41300.0	1970-01-01	1970-01-01	Charlotte
94	James	Davis	james.davis877@email.com	-3128.0	7849 First St	96991.0	1970-01-01	1970-01-01	Philadelphia
95	Lisa	Johnson	lisa.johnson130@email.com	-7756.0	1744 First St	78937.0	1970-01-01	1970-01-01	Columbus
96	John	Jones	john.jones420@email.com	-5289.0	7792 Park Rd	91691.0	1970-01-01	1970-01-01	Los Angeles
97	Michael	Hernandez	michael.hernandez873@email.com	-11510.0	5288 First St	14705.0	1970-01-01	1970-01-01	San Antonio
98	Jessica	Martinez	jessica.martinez233@email.com	-9165.0	1746 First St	49251.0	1970-01-01	1970-01-01	Los Angeles
99	Jane	Hernandez	jane.hernandez816@email.com	-7429.0	7156 Oak Ave	79621.0	1970-01-01	1970-01-01	Philadelphia
100	Charles	Garcia	charles.garcia175@email.com	-7725.0	4045 First St	28758.0	1970-01-01	1970-01-01	San Jose
101	Robert	Rodriguez	robert.rodriguez471@email.com	-2295.0	7722 Park Rd	81643.0	1970-01-01	1970-01-01	Charlotte
102	Michael	Anderson	michael.anderson968@email.com	-7054.0	7051 Park Rd	49599.0	1970-01-01	1970-01-01	Austin
103	James	Thomas	james.thomas110@email.com	-7712.0	4947 Park Rd	96275.0	1970-01-01	1970-01-01	San Jose
104	Daniel	Smith	daniel.smith580@email.com	-3589.0	8238 Park Rd	89569.0	1970-01-01	1970-01-01	Charlotte
105	Jessica	Miller	jessica.miller636@email.com	-4389.0	1691 Main St	67779.0	1970-01-01	1970-01-01	Austin
106	Charles	Lopez	charles.lopez750@email.com	-6260.0	6907 Oak Ave	27322.0	1970-01-01	1970-01-01	Philadelphia
107	Amanda	Taylor	amanda.taylor514@email.com	-5023.0	7994 Park Rd	25095.0	1970-01-01	1970-01-01	Phoenix
108	Michael	Jones	michael.jones773@email.com	-8821.0	9231 Park Rd	61717.0	1970-01-01	1970-01-01	Columbus
109	Daniel	Moore	daniel.moore127@email.com	-6336.0	6342 Park Rd	98452.0	1970-01-01	1970-01-01	San Jose
110	Lisa	Smith	lisa.smith635@email.com	-5734.0	1135 First St	49608.0	1970-01-01	1970-01-01	Austin
111	Sarah	Jones	sarah.jones47@email.com	-9619.0	1692 Oak Ave	27781.0	1970-01-01	1970-01-01	Los Angeles
112	Robert	Lopez	robert.lopez687@email.com	-11522.0	9722 Oak Ave	95841.0	1970-01-01	1970-01-01	San Antonio
113	Lisa	Martin	lisa.martin418@email.com	-7588.0	7364 First St	57537.0	1970-01-01	1970-01-01	Houston
114	Amanda	Moore	amanda.moore924@email.com	-3218.0	4620 Oak Ave	69600.0	1970-01-01	1970-01-01	San Antonio
115	Chris	Martin	chris.martin995@email.com	-6735.0	2163 Second Ave	18992.0	1970-01-01	1970-01-01	Houston
116	Chris	Jackson	chris.jackson222@email.com	-6738.0	2517 Second Ave	46342.0	1970-01-01	1970-01-01	Philadelphia
117	David	Moore	david.moore257@email.com	-3995.0	522 Oak Ave	56955.0	1970-01-01	1970-01-01	Austin
118	Charles	Hernandez	charles.hernandez17@email.com	-2506.0	6997 Second Ave	18330.0	1970-01-01	1970-01-01	Chicago
119	Robert	Lopez	robert.lopez526@email.com	-9322.0	3729 Second Ave	96363.0	1970-01-01	1970-01-01	Dallas
120	Ashley	Anderson	ashley.anderson659@email.com	-9139.0	6680 First St	24150.0	1970-01-01	1970-01-01	Columbus
121	Robert	Williams	robert.williams921@email.com	-4040.0	2167 Park Rd	92978.0	1970-01-01	1970-01-01	Los Angeles
122	Matthew	Gonzalez	matthew.gonzalez612@email.com	-9476.0	7148 Main St	24996.0	1970-01-01	1970-01-01	Dallas
123	Chris	Wilson	chris.wilson463@email.com	-7408.0	7530 First St	22463.0	1970-01-01	1970-01-01	Columbus
124	Jennifer	Hernandez	jennifer.hernandez682@email.com	-4343.0	7870 Main St	21188.0	1970-01-01	1970-01-01	Austin
125	Jennifer	Brown	jennifer.brown763@email.com	-4467.0	1082 Second Ave	83620.0	1970-01-01	1970-01-01	Dallas
126	Sarah	Wilson	sarah.wilson363@email.com	-9703.0	942 Park Rd	50953.0	1970-01-01	1970-01-01	Columbus
127	Sarah	Jackson	sarah.jackson520@email.com	-9474.0	1873 Park Rd	58176.0	1970-01-01	1970-01-01	Houston
128	Daniel	Jackson	daniel.jackson232@email.com	-2894.0	4481 Main St	45818.0	1970-01-01	1970-01-01	San Jose
129	Matthew	Lopez	matthew.lopez7@email.com	-4621.0	6666 Main St	92991.0	1970-01-01	1970-01-01	San Jose
130	Michael	Taylor	michael.taylor221@email.com	-9445.0	2678 Park Rd	52517.0	1970-01-01	1970-01-01	Philadelphia
131	Kimberly	Williams	kimberly.williams905@email.com	-3990.0	915 Main St	68079.0	1970-01-01	1970-01-01	Fort Worth
132	Lisa	Martin	lisa.martin453@email.com	-5433.0	8494 Main St	66349.0	1970-01-01	1970-01-01	Fort Worth
133	Ashley	Jackson	ashley.jackson499@email.com	-7474.0	3712 First St	17180.0	1970-01-01	1970-01-01	New York
134	Chris	Martinez	chris.martinez969@email.com	-4448.0	4286 Park Rd	25726.0	1970-01-01	1970-01-01	Fort Worth
135	Lisa	Wilson	lisa.wilson180@email.com	-10445.0	3870 Second Ave	97562.0	1970-01-01	1970-01-01	Jacksonville
136	Michael	Gonzalez	michael.gonzalez883@email.com	-9148.0	7632 Main St	85465.0	1970-01-01	1970-01-01	New York
137	Charles	Gonzalez	charles.gonzalez727@email.com	-7024.0	6736 Main St	32527.0	1970-01-01	1970-01-01	Los Angeles
138	Amanda	Williams	amanda.williams448@email.com	-6157.0	9748 First St	20308.0	1970-01-01	1970-01-01	San Antonio
139	Ashley	Hernandez	ashley.hernandez227@email.com	-5091.0	8463 Main St	76840.0	1970-01-01	1970-01-01	Los Angeles
140	Amanda	Lopez	amanda.lopez745@email.com	-5116.0	1784 Oak Ave	35856.0	1970-01-01	1970-01-01	Houston
141	Kimberly	Jones	kimberly.jones779@email.com	-3881.0	8195 First St	85952.0	1970-01-01	1970-01-01	Chicago
142	Charles	Martin	charles.martin331@email.com	-7904.0	7305 Main St	67961.0	1970-01-01	1970-01-01	Chicago
143	Daniel	Jackson	daniel.jackson58@email.com	-3293.0	7665 First St	17456.0	1970-01-01	1970-01-01	Phoenix
144	Ashley	Williams	ashley.williams661@email.com	-4437.0	9833 Second Ave	70648.0	1970-01-01	1970-01-01	San Jose
145	Jane	Anderson	jane.anderson931@email.com	-5697.0	7892 Second Ave	18109.0	1970-01-01	1970-01-01	Philadelphia
146	Sarah	Hernandez	sarah.hernandez732@email.com	-4628.0	4159 First St	78690.0	1970-01-01	1970-01-01	New York
147	Kimberly	Garcia	kimberly.garcia373@email.com	-8216.0	5643 Second Ave	92691.0	1970-01-01	1970-01-01	San Antonio
148	Michael	Hernandez	michael.hernandez97@email.com	-8797.0	4228 Second Ave	53694.0	1970-01-01	1970-01-01	Phoenix
149	Charles	Jones	charles.jones939@email.com	-8295.0	9849 Main St	83259.0	1970-01-01	1970-01-01	Chicago
150	Matthew	Jones	matthew.jones687@email.com	-11390.0	7037 Second Ave	12389.0	1970-01-01	1970-01-01	Los Angeles
151	Ashley	Garcia	ashley.garcia974@email.com	-9734.0	3811 Oak Ave	20114.0	1970-01-01	1970-01-01	Houston
152	Sarah	Taylor	sarah.taylor790@email.com	-11232.0	5617 Second Ave	88282.0	1970-01-01	1970-01-01	New York
153	David	Garcia	david.garcia186@email.com	-5471.0	7270 Main St	57749.0	1970-01-01	1970-01-01	Jacksonville
154	Robert	Martin	robert.martin292@email.com	-10090.0	8849 Oak Ave	71474.0	1970-01-01	1970-01-01	Houston
155	Amanda	Jackson	amanda.jackson452@email.com	-7074.0	6356 Second Ave	64874.0	1970-01-01	1970-01-01	Fort Worth
156	Chris	Martin	chris.martin142@email.com	-3202.0	7973 Park Rd	23446.0	1970-01-01	1970-01-01	Austin
157	Sarah	Martinez	sarah.martinez86@email.com	-6613.0	8510 Oak Ave	22021.0	1970-01-01	1970-01-01	San Diego
158	Robert	Lopez	robert.lopez953@email.com	-2522.0	8324 Park Rd	60615.0	1970-01-01	1970-01-01	San Antonio
159	Amanda	Davis	amanda.davis29@email.com	-7119.0	2492 Oak Ave	47601.0	1970-01-01	1970-01-01	Fort Worth
160	David	Thomas	david.thomas460@email.com	-3132.0	4293 Oak Ave	81932.0	1970-01-01	1970-01-01	New York
161	Jennifer	Brown	jennifer.brown795@email.com	-6671.0	882 Oak Ave	93748.0	1970-01-01	1970-01-01	Los Angeles
162	Michael	Brown	michael.brown857@email.com	-11103.0	8543 Second Ave	28818.0	1970-01-01	1970-01-01	New York
163	Jennifer	Smith	jennifer.smith630@email.com	-8631.0	1502 Second Ave	18870.0	1970-01-01	1970-01-01	Chicago
164	Michelle	Taylor	michelle.taylor806@email.com	-2618.0	7802 Main St	60709.0	1970-01-01	1970-01-01	San Antonio
165	Daniel	Smith	daniel.smith366@email.com	-7724.0	1798 Second Ave	27486.0	1970-01-01	1970-01-01	Houston
166	Amanda	Moore	amanda.moore347@email.com	-5558.0	7712 First St	33891.0	1970-01-01	1970-01-01	Columbus
167	Michael	Anderson	michael.anderson38@email.com	-2422.0	3368 Main St	50642.0	1970-01-01	1970-01-01	Fort Worth
168	James	Moore	james.moore485@email.com	-4626.0	5948 Main St	53506.0	1970-01-01	1970-01-01	Phoenix
169	Sarah	Lopez	sarah.lopez448@email.com	-9573.0	6434 Park Rd	75038.0	1970-01-01	1970-01-01	Charlotte
170	Amanda	Taylor	amanda.taylor274@email.com	-9058.0	7155 Second Ave	81496.0	1970-01-01	1970-01-01	Los Angeles
171	Matthew	Brown	matthew.brown82@email.com	-7053.0	7405 Second Ave	31842.0	1970-01-01	1970-01-01	Phoenix
172	Amanda	Anderson	amanda.anderson44@email.com	-8609.0	7226 Park Rd	17518.0	1970-01-01	1970-01-01	San Jose
173	James	Lopez	james.lopez526@email.com	-5407.0	2439 Second Ave	67432.0	1970-01-01	1970-01-01	New York
174	David	Williams	david.williams242@email.com	-8657.0	6372 Second Ave	89310.0	1970-01-01	1970-01-01	Philadelphia
175	Robert	Lopez	robert.lopez381@email.com	-3693.0	2355 Second Ave	62171.0	1970-01-01	1970-01-01	San Jose
176	Daniel	Davis	daniel.davis984@email.com	-4389.0	8582 First St	25435.0	1970-01-01	1970-01-01	San Diego
177	Daniel	Anderson	daniel.anderson220@email.com	-10164.0	2109 Oak Ave	69250.0	1970-01-01	1970-01-01	Houston
178	Robert	Williams	robert.williams830@email.com	-7998.0	5792 Main St	81063.0	1970-01-01	1970-01-01	Austin
179	Ashley	Garcia	ashley.garcia729@email.com	-5494.0	6022 Second Ave	25907.0	1970-01-01	1970-01-01	Fort Worth
180	David	Davis	david.davis810@email.com	-7642.0	9476 Park Rd	82305.0	1970-01-01	1970-01-01	Dallas
181	Kimberly	Williams	kimberly.williams68@email.com	-9764.0	6830 First St	19666.0	1970-01-01	1970-01-01	Dallas
182	Matthew	Williams	matthew.williams461@email.com	-10848.0	2202 Second Ave	87042.0	1970-01-01	1970-01-01	Philadelphia
183	David	Wilson	david.wilson515@email.com	-4178.0	2607 Park Rd	31229.0	1970-01-01	1970-01-01	Dallas
184	Jessica	Lopez	jessica.lopez971@email.com	-3312.0	3316 Second Ave	26406.0	1970-01-01	1970-01-01	Phoenix
185	Kimberly	Moore	kimberly.moore96@email.com	-5131.0	9613 Oak Ave	96341.0	1970-01-01	1970-01-01	San Jose
186	Charles	Johnson	charles.johnson846@email.com	-3442.0	9549 Park Rd	37631.0	1970-01-01	1970-01-01	New York
187	Jennifer	Martin	jennifer.martin655@email.com	-10677.0	5049 First St	99783.0	1970-01-01	1970-01-01	Phoenix
188	Ashley	Anderson	ashley.anderson75@email.com	-4554.0	6909 First St	36741.0	1970-01-01	1970-01-01	San Diego
189	Kimberly	Jones	kimberly.jones321@email.com	-8047.0	5758 First St	58567.0	1970-01-01	1970-01-01	Jacksonville
190	Michelle	Brown	michelle.brown327@email.com	-3930.0	7466 Oak Ave	22689.0	1970-01-01	1970-01-01	Phoenix
191	Ashley	Gonzalez	ashley.gonzalez885@email.com	-6324.0	2716 Park Rd	50988.0	1970-01-01	1970-01-01	Columbus
192	Emily	Thomas	emily.thomas528@email.com	-7242.0	479 Main St	76249.0	1970-01-01	1970-01-01	San Diego
193	Jessica	Miller	jessica.miller598@email.com	-2437.0	8208 Second Ave	98148.0	1970-01-01	1970-01-01	Phoenix
194	Ashley	Moore	ashley.moore9@email.com	-9236.0	4433 Park Rd	57964.0	1970-01-01	1970-01-01	Chicago
195	James	Johnson	james.johnson584@email.com	-7912.0	4828 Main St	76093.0	1970-01-01	1970-01-01	Dallas
196	Michelle	Rodriguez	michelle.rodriguez846@email.com	-4479.0	1684 First St	54444.0	1970-01-01	1970-01-01	Chicago
197	Amanda	Jones	amanda.jones204@email.com	-8912.0	759 Main St	27961.0	1970-01-01	1970-01-01	Dallas
198	Lisa	Taylor	lisa.taylor468@email.com	-10417.0	5473 Second Ave	31299.0	1970-01-01	1970-01-01	Chicago
199	Kimberly	Martinez	kimberly.martinez608@email.com	-10413.0	8125 Second Ave	72245.0	1970-01-01	1970-01-01	Dallas
200	Amanda	Hernandez	amanda.hernandez690@email.com	-6777.0	536 Second Ave	44803.0	1970-01-01	1970-01-01	Fort Worth
201	Charles	Davis	charles.davis739@email.com	-9719.0	8689 Second Ave	29369.0	1970-01-01	1970-01-01	Chicago
202	Jane	Jackson	jane.jackson971@email.com	-5153.0	7325 Park Rd	29848.0	1970-01-01	1970-01-01	New York
203	Chris	Wilson	chris.wilson514@email.com	-10344.0	1120 Oak Ave	37176.0	1970-01-01	1970-01-01	Columbus
204	Matthew	Thomas	matthew.thomas539@email.com	-4742.0	8834 Park Rd	56437.0	1970-01-01	1970-01-01	San Diego
205	Kimberly	Thomas	kimberly.thomas197@email.com	-6626.0	4976 Park Rd	37168.0	1970-01-01	1970-01-01	Houston
206	Matthew	Thomas	matthew.thomas358@email.com	-7066.0	2096 Second Ave	81197.0	1970-01-01	1970-01-01	Phoenix
207	James	Lopez	james.lopez978@email.com	-5212.0	789 Park Rd	55398.0	1970-01-01	1970-01-01	Phoenix
208	Daniel	Thomas	daniel.thomas220@email.com	-11076.0	9308 Park Rd	24316.0	1970-01-01	1970-01-01	Phoenix
209	Jessica	Johnson	jessica.johnson686@email.com	-5787.0	1741 First St	71918.0	1970-01-01	1970-01-01	New York
210	David	Smith	david.smith988@email.com	-8589.0	7893 First St	36143.0	1970-01-01	1970-01-01	Austin
211	Matthew	Martinez	matthew.martinez662@email.com	-3511.0	9506 Oak Ave	14888.0	1970-01-01	1970-01-01	Austin
212	Jennifer	Garcia	jennifer.garcia957@email.com	-8596.0	8216 Oak Ave	14910.0	1970-01-01	1970-01-01	Fort Worth
213	Ashley	Jackson	ashley.jackson618@email.com	-6313.0	9001 Second Ave	27589.0	1970-01-01	1970-01-01	San Diego
214	Robert	Rodriguez	robert.rodriguez198@email.com	-7559.0	7618 Park Rd	11846.0	1970-01-01	1970-01-01	Chicago
215	Ashley	Jackson	ashley.jackson691@email.com	-5046.0	6743 First St	52982.0	1970-01-01	1970-01-01	San Jose
216	James	Brown	james.brown190@email.com	-7131.0	4164 Main St	60275.0	1970-01-01	1970-01-01	Charlotte
217	Robert	Rodriguez	robert.rodriguez977@email.com	-2032.0	5990 Oak Ave	97528.0	1970-01-01	1970-01-01	Phoenix
218	Robert	Martinez	robert.martinez164@email.com	-10549.0	5195 Main St	48671.0	1970-01-01	1970-01-01	Charlotte
219	Kimberly	Davis	kimberly.davis225@email.com	-4333.0	6221 First St	81989.0	1970-01-01	1970-01-01	San Diego
220	Michelle	Miller	michelle.miller781@email.com	-3489.0	7419 Second Ave	57419.0	1970-01-01	1970-01-01	Dallas
221	Charles	Brown	charles.brown64@email.com	-10888.0	9483 Second Ave	31566.0	1970-01-01	1970-01-01	Houston
222	William	Anderson	william.anderson120@email.com	-10113.0	8461 First St	69432.0	1970-01-01	1970-01-01	Los Angeles
223	William	Wilson	william.wilson468@email.com	-9410.0	5149 Main St	43352.0	1970-01-01	1970-01-01	Austin
224	Chris	Jackson	chris.jackson75@email.com	-7322.0	1144 Second Ave	19046.0	1970-01-01	1970-01-01	Jacksonville
225	Jane	Martinez	jane.martinez419@email.com	-4388.0	6987 Park Rd	68790.0	1970-01-01	1970-01-01	Fort Worth
226	James	Williams	james.williams700@email.com	-11606.0	5797 Main St	80419.0	1970-01-01	1970-01-01	Chicago
227	William	Jones	william.jones746@email.com	-2337.0	472 Park Rd	98276.0	1970-01-01	1970-01-01	Fort Worth
228	Jennifer	Moore	jennifer.moore389@email.com	-6332.0	5771 Oak Ave	34704.0	1970-01-01	1970-01-01	San Diego
229	Jane	Wilson	jane.wilson630@email.com	-5942.0	1202 Main St	14400.0	1970-01-01	1970-01-01	Houston
230	Kimberly	Johnson	kimberly.johnson251@email.com	-8592.0	3939 Second Ave	17398.0	1970-01-01	1970-01-01	San Diego
231	William	Martinez	william.martinez240@email.com	-8007.0	9896 Park Rd	49552.0	1970-01-01	1970-01-01	San Jose
232	William	Davis	william.davis424@email.com	-2785.0	9793 Oak Ave	98965.0	1970-01-01	1970-01-01	Dallas
233	Michelle	Thomas	michelle.thomas49@email.com	-8453.0	8692 Park Rd	64568.0	1970-01-01	1970-01-01	Fort Worth
234	David	Martinez	david.martinez386@email.com	-10972.0	4048 Oak Ave	28920.0	1970-01-01	1970-01-01	San Diego
235	Jane	Moore	jane.moore423@email.com	-10878.0	6463 Oak Ave	36651.0	1970-01-01	1970-01-01	Chicago
236	Michael	Anderson	michael.anderson868@email.com	-10447.0	3220 Main St	59436.0	1970-01-01	1970-01-01	Jacksonville
237	Michael	Miller	michael.miller824@email.com	-6134.0	3522 Park Rd	12009.0	1970-01-01	1970-01-01	San Diego
238	Chris	Brown	chris.brown765@email.com	-6435.0	3450 First St	82362.0	1970-01-01	1970-01-01	Jacksonville
239	Ashley	Gonzalez	ashley.gonzalez478@email.com	-8295.0	4385 Park Rd	75179.0	1970-01-01	1970-01-01	Phoenix
240	Sarah	Thomas	sarah.thomas780@email.com	-5713.0	5226 First St	83731.0	1970-01-01	1970-01-01	Philadelphia
241	David	Smith	david.smith268@email.com	-9204.0	2597 Oak Ave	40149.0	1970-01-01	1970-01-01	Phoenix
242	Charles	Davis	charles.davis512@email.com	-7962.0	8105 First St	32050.0	1970-01-01	1970-01-01	Phoenix
243	Emily	Jones	emily.jones738@email.com	-5273.0	8982 Main St	14433.0	1970-01-01	1970-01-01	Charlotte
244	Jane	Smith	jane.smith423@email.com	-5992.0	2574 Main St	76287.0	1970-01-01	1970-01-01	Los Angeles
245	Amanda	Johnson	amanda.johnson633@email.com	-10450.0	8093 Main St	79758.0	1970-01-01	1970-01-01	Austin
246	Jennifer	Smith	jennifer.smith18@email.com	-6981.0	4797 Main St	98346.0	1970-01-01	1970-01-01	Dallas
247	Emily	Brown	emily.brown941@email.com	-4272.0	3244 Second Ave	43084.0	1970-01-01	1970-01-01	Houston
248	Daniel	Gonzalez	daniel.gonzalez81@email.com	-9516.0	4084 Oak Ave	99658.0	1970-01-01	1970-01-01	San Jose
249	Jane	Williams	jane.williams416@email.com	-9771.0	254 Oak Ave	75517.0	1970-01-01	1970-01-01	New York
250	Matthew	Jackson	matthew.jackson879@email.com	-2533.0	3563 Second Ave	45532.0	1970-01-01	1970-01-01	Houston
251	Michael	Rodriguez	michael.rodriguez921@email.com	-2871.0	5252 Main St	86943.0	1970-01-01	1970-01-01	Chicago
252	James	Williams	james.williams307@email.com	-5881.0	6475 Second Ave	60311.0	1970-01-01	1970-01-01	San Jose
253	Michael	Taylor	michael.taylor764@email.com	-3207.0	3903 Main St	89320.0	1970-01-01	1970-01-01	San Antonio
254	Matthew	Smith	matthew.smith650@email.com	-9661.0	3837 Park Rd	59207.0	1970-01-01	1970-01-01	San Diego
255	Emily	Jackson	emily.jackson677@email.com	-6514.0	4137 Main St	45123.0	1970-01-01	1970-01-01	Fort Worth
256	James	Jones	james.jones758@email.com	-7830.0	1599 Main St	68292.0	1970-01-01	1970-01-01	Los Angeles
257	Daniel	Brown	daniel.brown136@email.com	-8540.0	9225 Second Ave	63483.0	1970-01-01	1970-01-01	San Diego
258	John	Williams	john.williams363@email.com	-7176.0	6411 Main St	64238.0	1970-01-01	1970-01-01	Columbus
259	Michael	Moore	michael.moore927@email.com	-10569.0	6337 Oak Ave	45247.0	1970-01-01	1970-01-01	Chicago
260	Daniel	Thomas	daniel.thomas150@email.com	-8555.0	6999 Park Rd	20082.0	1970-01-01	1970-01-01	Phoenix
261	Daniel	Davis	daniel.davis739@email.com	-5549.0	1852 Oak Ave	10887.0	1970-01-01	1970-01-01	San Diego
262	Matthew	Martin	matthew.martin390@email.com	-8303.0	5584 First St	87908.0	1970-01-01	1970-01-01	San Diego
263	Ashley	Hernandez	ashley.hernandez618@email.com	-9963.0	3010 First St	48200.0	1970-01-01	1970-01-01	Philadelphia
264	Charles	Davis	charles.davis334@email.com	-8308.0	1965 Second Ave	87624.0	1970-01-01	1970-01-01	Philadelphia
265	Emily	Moore	emily.moore28@email.com	-5849.0	4873 Main St	98208.0	1970-01-01	1970-01-01	San Diego
266	David	Martinez	david.martinez248@email.com	-4656.0	7032 First St	68860.0	1970-01-01	1970-01-01	Jacksonville
267	Charles	Gonzalez	charles.gonzalez548@email.com	-9460.0	702 Park Rd	80373.0	1970-01-01	1970-01-01	Dallas
268	Sarah	Davis	sarah.davis674@email.com	-4967.0	825 Second Ave	98797.0	1970-01-01	1970-01-01	Austin
269	Matthew	Wilson	matthew.wilson109@email.com	-5548.0	8466 Second Ave	86089.0	1970-01-01	1970-01-01	Houston
270	Jessica	Anderson	jessica.anderson384@email.com	-10272.0	5751 Main St	23703.0	1970-01-01	1970-01-01	Chicago
271	Jennifer	Williams	jennifer.williams119@email.com	-5118.0	5210 Park Rd	37114.0	1970-01-01	1970-01-01	Philadelphia
272	Lisa	Lopez	lisa.lopez488@email.com	-9158.0	1200 Park Rd	25084.0	1970-01-01	1970-01-01	Philadelphia
273	Matthew	Brown	matthew.brown694@email.com	-6182.0	2958 Second Ave	53383.0	1970-01-01	1970-01-01	Dallas
274	Jennifer	Anderson	jennifer.anderson238@email.com	-5451.0	7180 First St	90492.0	1970-01-01	1970-01-01	Chicago
275	Robert	Jackson	robert.jackson440@email.com	-5120.0	4660 Main St	23336.0	1970-01-01	1970-01-01	Houston
276	Emily	Lopez	emily.lopez334@email.com	-3735.0	8119 Second Ave	51078.0	1970-01-01	1970-01-01	Phoenix
277	Kimberly	Gonzalez	kimberly.gonzalez602@email.com	-7437.0	7601 Second Ave	98288.0	1970-01-01	1970-01-01	Columbus
278	Kimberly	Jackson	kimberly.jackson87@email.com	-7155.0	4008 Park Rd	33992.0	1970-01-01	1970-01-01	Los Angeles
279	David	Taylor	david.taylor398@email.com	-4495.0	6386 First St	73788.0	1970-01-01	1970-01-01	San Jose
280	Emily	Moore	emily.moore171@email.com	-4293.0	5254 First St	17026.0	1970-01-01	1970-01-01	Chicago
281	John	Thomas	john.thomas140@email.com	-8522.0	8381 First St	99744.0	1970-01-01	1970-01-01	Dallas
282	Jennifer	Anderson	jennifer.anderson501@email.com	-1959.0	3713 Park Rd	46025.0	1970-01-01	1970-01-01	Fort Worth
283	Michelle	Martinez	michelle.martinez173@email.com	-10581.0	8469 Main St	24969.0	1970-01-01	1970-01-01	Dallas
284	Michelle	Lopez	michelle.lopez556@email.com	-3496.0	7331 Second Ave	65725.0	1970-01-01	1970-01-01	Fort Worth
285	Jessica	Martinez	jessica.martinez896@email.com	-5997.0	1525 First St	41056.0	1970-01-01	1970-01-01	Philadelphia
286	Charles	Lopez	charles.lopez882@email.com	-9565.0	2381 Oak Ave	17780.0	1970-01-01	1970-01-01	Chicago
287	Amanda	Moore	amanda.moore288@email.com	-5119.0	4894 Park Rd	45041.0	1970-01-01	1970-01-01	Philadelphia
288	Sarah	Jones	sarah.jones986@email.com	-9514.0	1071 Park Rd	26631.0	1970-01-01	1970-01-01	Charlotte
289	Jessica	Jones	jessica.jones729@email.com	-6431.0	6534 First St	85684.0	1970-01-01	1970-01-01	Fort Worth
290	Jennifer	Gonzalez	jennifer.gonzalez463@email.com	-3449.0	8547 Park Rd	58374.0	1970-01-01	1970-01-01	San Antonio
291	Lisa	Hernandez	lisa.hernandez596@email.com	-3616.0	7611 Park Rd	80048.0	1970-01-01	1970-01-01	Jacksonville
292	Chris	Wilson	chris.wilson845@email.com	-6320.0	4746 Park Rd	85750.0	1970-01-01	1970-01-01	Philadelphia
293	Charles	Thomas	charles.thomas808@email.com	-3041.0	1731 First St	26284.0	1970-01-01	1970-01-01	New York
294	Robert	Anderson	robert.anderson1@email.com	-4005.0	5045 Oak Ave	22234.0	1970-01-01	1970-01-01	Charlotte
295	Daniel	Williams	daniel.williams381@email.com	-5254.0	6593 Park Rd	40689.0	1970-01-01	1970-01-01	New York
296	Michael	Brown	michael.brown2@email.com	-3181.0	9826 Oak Ave	99126.0	1970-01-01	1970-01-01	Chicago
297	John	Smith	john.smith713@email.com	-4361.0	7019 Oak Ave	19283.0	1970-01-01	1970-01-01	Columbus
298	James	Williams	james.williams749@email.com	-3818.0	6122 Park Rd	60164.0	1970-01-01	1970-01-01	Philadelphia
299	David	Williams	david.williams544@email.com	-4471.0	5853 Oak Ave	29840.0	1970-01-01	1970-01-01	San Diego
300	Kimberly	Anderson	kimberly.anderson881@email.com	-3155.0	2117 Second Ave	56076.0	1970-01-01	1970-01-01	Chicago
301	Matthew	Jones	matthew.jones254@email.com	-3522.0	9166 Second Ave	89638.0	1970-01-01	1970-01-01	Houston
302	John	Martinez	john.martinez211@email.com	-10698.0	6518 Park Rd	17152.0	1970-01-01	1970-01-01	Houston
303	Lisa	Gonzalez	lisa.gonzalez116@email.com	-3119.0	297 Park Rd	27299.0	1970-01-01	1970-01-01	Dallas
304	Charles	Wilson	charles.wilson375@email.com	-5287.0	7817 Main St	86986.0	1970-01-01	1970-01-01	Fort Worth
305	John	Rodriguez	john.rodriguez221@email.com	-7820.0	4793 Second Ave	65518.0	1970-01-01	1970-01-01	Dallas
306	Michael	Moore	michael.moore551@email.com	-6531.0	5177 Main St	36633.0	1970-01-01	1970-01-01	Los Angeles
307	Michelle	Hernandez	michelle.hernandez401@email.com	-3531.0	7267 Oak Ave	42044.0	1970-01-01	1970-01-01	Phoenix
308	Jennifer	Brown	jennifer.brown465@email.com	-3349.0	2977 Main St	27984.0	1970-01-01	1970-01-01	Phoenix
309	Emily	Thomas	emily.thomas976@email.com	-10563.0	4347 Oak Ave	26637.0	1970-01-01	1970-01-01	Fort Worth
310	Sarah	Smith	sarah.smith344@email.com	-6920.0	1146 Park Rd	85582.0	1970-01-01	1970-01-01	Dallas
311	Lisa	Anderson	lisa.anderson524@email.com	-9808.0	9387 Oak Ave	30618.0	1970-01-01	1970-01-01	Columbus
312	Sarah	Jackson	sarah.jackson691@email.com	-5799.0	8436 Main St	11610.0	1970-01-01	1970-01-01	Jacksonville
313	Jane	Thomas	jane.thomas373@email.com	-4676.0	679 Second Ave	64967.0	1970-01-01	1970-01-01	Charlotte
314	Matthew	Davis	matthew.davis427@email.com	-6707.0	1376 Second Ave	25650.0	1970-01-01	1970-01-01	Columbus
315	Jane	Garcia	jane.garcia229@email.com	-3302.0	1229 First St	50723.0	1970-01-01	1970-01-01	San Antonio
316	Michael	Moore	michael.moore468@email.com	-4871.0	9337 Park Rd	41795.0	1970-01-01	1970-01-01	Phoenix
317	Amanda	Jackson	amanda.jackson996@email.com	-5696.0	9054 Oak Ave	10835.0	1970-01-01	1970-01-01	Jacksonville
318	John	Davis	john.davis555@email.com	-2361.0	123 First St	23624.0	1970-01-01	1970-01-01	Philadelphia
319	William	Davis	william.davis430@email.com	-4095.0	4684 Main St	40339.0	1970-01-01	1970-01-01	Jacksonville
320	Jennifer	Lopez	jennifer.lopez470@email.com	-3615.0	2287 First St	87580.0	1970-01-01	1970-01-01	Dallas
321	Jane	Wilson	jane.wilson679@email.com	-6352.0	5261 First St	52762.0	1970-01-01	1970-01-01	Phoenix
322	Robert	Rodriguez	robert.rodriguez240@email.com	-3712.0	9679 Main St	23848.0	1970-01-01	1970-01-01	Fort Worth
323	Robert	Anderson	robert.anderson322@email.com	-10518.0	3501 First St	70731.0	1970-01-01	1970-01-01	Philadelphia
324	Sarah	Williams	sarah.williams162@email.com	-7711.0	9984 Main St	52964.0	1970-01-01	1970-01-01	Columbus
325	Michael	Davis	michael.davis992@email.com	-10380.0	4996 Park Rd	14073.0	1970-01-01	1970-01-01	New York
326	Robert	Moore	robert.moore767@email.com	-3568.0	1769 Oak Ave	11567.0	1970-01-01	1970-01-01	San Diego
327	Jessica	Jones	jessica.jones203@email.com	-8550.0	1476 Second Ave	43924.0	1970-01-01	1970-01-01	Austin
328	John	Williams	john.williams203@email.com	-4424.0	5532 Main St	70423.0	1970-01-01	1970-01-01	Los Angeles
329	Emily	Jackson	emily.jackson444@email.com	-9252.0	583 First St	65923.0	1970-01-01	1970-01-01	San Diego
330	Amanda	Miller	amanda.miller931@email.com	-6256.0	2535 Main St	91156.0	1970-01-01	1970-01-01	San Diego
331	Ashley	Thomas	ashley.thomas422@email.com	-3251.0	4683 First St	64949.0	1970-01-01	1970-01-01	Los Angeles
332	William	Davis	william.davis646@email.com	-2895.0	5983 First St	73527.0	1970-01-01	1970-01-01	San Antonio
333	Charles	Taylor	charles.taylor330@email.com	-4818.0	5324 Second Ave	13840.0	1970-01-01	1970-01-01	New York
334	Jane	Thomas	jane.thomas543@email.com	-6163.0	1740 Oak Ave	41608.0	1970-01-01	1970-01-01	Chicago
335	Michelle	Johnson	michelle.johnson783@email.com	-8375.0	2946 Oak Ave	87662.0	1970-01-01	1970-01-01	Philadelphia
336	Amanda	Jackson	amanda.jackson29@email.com	-8397.0	9334 Oak Ave	34672.0	1970-01-01	1970-01-01	San Jose
337	Michelle	Martinez	michelle.martinez180@email.com	-3217.0	3911 Second Ave	12612.0	1970-01-01	1970-01-01	New York
338	Lisa	Smith	lisa.smith340@email.com	-4170.0	3007 Park Rd	12872.0	1970-01-01	1970-01-01	Philadelphia
339	Charles	Jones	charles.jones793@email.com	-10800.0	6078 Main St	96787.0	1970-01-01	1970-01-01	Columbus
340	Charles	Brown	charles.brown345@email.com	-4073.0	7257 First St	51586.0	1970-01-01	1970-01-01	Chicago
341	Michelle	Martin	michelle.martin806@email.com	-4664.0	5126 Park Rd	33292.0	1970-01-01	1970-01-01	San Antonio
342	Charles	Gonzalez	charles.gonzalez872@email.com	-3099.0	9969 Park Rd	38953.0	1970-01-01	1970-01-01	Chicago
343	Sarah	Thomas	sarah.thomas145@email.com	-3575.0	5782 Park Rd	93386.0	1970-01-01	1970-01-01	Houston
344	Matthew	Anderson	matthew.anderson12@email.com	-5772.0	1210 Park Rd	24160.0	1970-01-01	1970-01-01	Jacksonville
345	Jane	Gonzalez	jane.gonzalez449@email.com	-5103.0	6883 First St	56036.0	1970-01-01	1970-01-01	Charlotte
346	James	Brown	james.brown849@email.com	-6191.0	7493 Main St	48654.0	1970-01-01	1970-01-01	Chicago
347	Matthew	Rodriguez	matthew.rodriguez975@email.com	-6981.0	6251 Oak Ave	81702.0	1970-01-01	1970-01-01	Chicago
348	Matthew	Martin	matthew.martin629@email.com	-2921.0	2803 Second Ave	30591.0	1970-01-01	1970-01-01	San Antonio
349	Sarah	Hernandez	sarah.hernandez211@email.com	-10661.0	4712 Park Rd	22571.0	1970-01-01	1970-01-01	Phoenix
350	James	Jackson	james.jackson563@email.com	-5077.0	6011 Main St	21485.0	1970-01-01	1970-01-01	New York
351	Kimberly	Thomas	kimberly.thomas205@email.com	-4714.0	4881 Main St	25139.0	1970-01-01	1970-01-01	Chicago
352	James	Thomas	james.thomas501@email.com	-3639.0	9014 First St	58630.0	1970-01-01	1970-01-01	Austin
353	Amanda	Garcia	amanda.garcia457@email.com	-8717.0	4415 Oak Ave	83956.0	1970-01-01	1970-01-01	San Diego
354	David	Brown	david.brown88@email.com	-11106.0	9762 Oak Ave	17993.0	1970-01-01	1970-01-01	San Antonio
355	William	Wilson	william.wilson989@email.com	-10229.0	3960 First St	20348.0	1970-01-01	1970-01-01	San Jose
356	Jane	Taylor	jane.taylor585@email.com	-4962.0	7457 Oak Ave	37772.0	1970-01-01	1970-01-01	Los Angeles
357	David	Johnson	david.johnson434@email.com	-9111.0	2522 Second Ave	51910.0	1970-01-01	1970-01-01	Houston
358	Michael	Gonzalez	michael.gonzalez570@email.com	-7513.0	4625 Second Ave	11620.0	1970-01-01	1970-01-01	Columbus
359	Jennifer	Brown	jennifer.brown425@email.com	-3144.0	1830 Second Ave	47498.0	1970-01-01	1970-01-01	Charlotte
360	Amanda	Wilson	amanda.wilson271@email.com	-10216.0	7850 Main St	46099.0	1970-01-01	1970-01-01	San Jose
361	David	Martin	david.martin624@email.com	-9187.0	6584 Park Rd	41139.0	1970-01-01	1970-01-01	New York
362	Lisa	Rodriguez	lisa.rodriguez919@email.com	-7135.0	5065 Park Rd	74437.0	1970-01-01	1970-01-01	Columbus
363	Jessica	Jones	jessica.jones308@email.com	-7670.0	6928 Second Ave	21703.0	1970-01-01	1970-01-01	Phoenix
364	Robert	Miller	robert.miller936@email.com	-10395.0	8562 Park Rd	77537.0	1970-01-01	1970-01-01	Fort Worth
365	Michael	Martinez	michael.martinez727@email.com	-4352.0	8689 Second Ave	32772.0	1970-01-01	1970-01-01	Fort Worth
366	Chris	Johnson	chris.johnson256@email.com	-2527.0	6004 Oak Ave	58280.0	1970-01-01	1970-01-01	Charlotte
367	William	Gonzalez	william.gonzalez651@email.com	-2522.0	6202 First St	68471.0	1970-01-01	1970-01-01	Houston
368	Lisa	Jackson	lisa.jackson565@email.com	-4588.0	4337 Main St	13597.0	1970-01-01	1970-01-01	Columbus
369	Jane	Garcia	jane.garcia875@email.com	-6093.0	3726 Oak Ave	37096.0	1970-01-01	1970-01-01	Columbus
370	Jennifer	Taylor	jennifer.taylor21@email.com	-3028.0	2267 Oak Ave	11109.0	1970-01-01	1970-01-01	San Diego
371	Daniel	Martin	daniel.martin825@email.com	-6751.0	6268 Park Rd	43029.0	1970-01-01	1970-01-01	San Antonio
372	Robert	Martinez	robert.martinez694@email.com	-9082.0	1776 Main St	96816.0	1970-01-01	1970-01-01	San Jose
373	Michelle	Martin	michelle.martin624@email.com	-3564.0	1145 Park Rd	93964.0	1970-01-01	1970-01-01	San Diego
374	Daniel	Rodriguez	daniel.rodriguez672@email.com	-7489.0	2556 Second Ave	17441.0	1970-01-01	1970-01-01	Houston
375	Matthew	Jones	matthew.jones739@email.com	-10044.0	4350 First St	60891.0	1970-01-01	1970-01-01	Phoenix
376	Charles	Jackson	charles.jackson836@email.com	-5387.0	8859 First St	56988.0	1970-01-01	1970-01-01	Austin
377	Ashley	Garcia	ashley.garcia861@email.com	-5736.0	1699 First St	43902.0	1970-01-01	1970-01-01	Phoenix
378	Emily	Hernandez	emily.hernandez671@email.com	-7337.0	5131 First St	58717.0	1970-01-01	1970-01-01	Houston
379	Charles	Martinez	charles.martinez475@email.com	-9899.0	9661 Second Ave	19334.0	1970-01-01	1970-01-01	New York
380	Chris	Taylor	chris.taylor123@email.com	-9037.0	4988 First St	29762.0	1970-01-01	1970-01-01	Dallas
381	Chris	Hernandez	chris.hernandez420@email.com	-4596.0	3054 Main St	53598.0	1970-01-01	1970-01-01	Philadelphia
382	Matthew	Johnson	matthew.johnson5@email.com	-5371.0	2862 Second Ave	74169.0	1970-01-01	1970-01-01	Fort Worth
383	David	Martin	david.martin445@email.com	-8895.0	7921 First St	14944.0	1970-01-01	1970-01-01	San Antonio
384	Chris	Lopez	chris.lopez973@email.com	-10242.0	393 Main St	42613.0	1970-01-01	1970-01-01	Houston
385	Amanda	Martinez	amanda.martinez133@email.com	-9942.0	5115 Oak Ave	15992.0	1970-01-01	1970-01-01	San Jose
386	Ashley	Anderson	ashley.anderson746@email.com	-10928.0	7205 Oak Ave	74248.0	1970-01-01	1970-01-01	Philadelphia
387	Chris	Garcia	chris.garcia971@email.com	-2756.0	3775 Oak Ave	12872.0	1970-01-01	1970-01-01	Houston
388	Emily	Brown	emily.brown376@email.com	-3205.0	4290 Second Ave	16368.0	1970-01-01	1970-01-01	San Antonio
389	Sarah	Smith	sarah.smith50@email.com	-8851.0	6330 Main St	43126.0	1970-01-01	1970-01-01	San Diego
390	David	Miller	david.miller712@email.com	-2698.0	6995 Main St	78197.0	1970-01-01	1970-01-01	Phoenix
391	Kimberly	Martin	kimberly.martin718@email.com	-3485.0	2028 Park Rd	23928.0	1970-01-01	1970-01-01	Dallas
392	Chris	Martin	chris.martin205@email.com	-10835.0	5964 First St	31020.0	1970-01-01	1970-01-01	Houston
393	Michelle	Thomas	michelle.thomas933@email.com	-9990.0	3942 Main St	98032.0	1970-01-01	1970-01-01	Philadelphia
394	Sarah	Jackson	sarah.jackson686@email.com	-3331.0	8483 Main St	43540.0	1970-01-01	1970-01-01	Fort Worth
395	Robert	Martinez	robert.martinez271@email.com	-3360.0	2962 Main St	57214.0	1970-01-01	1970-01-01	Columbus
396	Jennifer	Brown	jennifer.brown98@email.com	-3597.0	2367 Oak Ave	56861.0	1970-01-01	1970-01-01	New York
397	Kimberly	Rodriguez	kimberly.rodriguez900@email.com	-8149.0	5715 Oak Ave	62530.0	1970-01-01	1970-01-01	Columbus
398	Robert	Rodriguez	robert.rodriguez856@email.com	-10134.0	7009 Oak Ave	27368.0	1970-01-01	1970-01-01	Fort Worth
399	Emily	Brown	emily.brown427@email.com	-9475.0	6321 Park Rd	13777.0	1970-01-01	1970-01-01	Chicago
400	Lisa	Thomas	lisa.thomas116@email.com	-2824.0	4386 Park Rd	98857.0	1970-01-01	1970-01-01	Los Angeles
401	Charles	Jackson	charles.jackson230@email.com	-8320.0	8670 Second Ave	66734.0	1970-01-01	1970-01-01	Dallas
402	Lisa	Lopez	lisa.lopez680@email.com	-8852.0	9247 Second Ave	11526.0	1970-01-01	1970-01-01	Chicago
403	William	Thomas	william.thomas873@email.com	-5305.0	8155 Park Rd	53371.0	1970-01-01	1970-01-01	Los Angeles
404	Jane	Taylor	jane.taylor229@email.com	-8623.0	3950 Main St	68220.0	1970-01-01	1970-01-01	San Antonio
405	Robert	Williams	robert.williams878@email.com	-7344.0	8248 Main St	62879.0	1970-01-01	1970-01-01	Los Angeles
406	Jane	Moore	jane.moore563@email.com	-3533.0	9999 Second Ave	49924.0	1970-01-01	1970-01-01	Fort Worth
407	Michelle	Miller	michelle.miller671@email.com	-7937.0	989 Oak Ave	53512.0	1970-01-01	1970-01-01	Philadelphia
408	Kimberly	Martin	kimberly.martin485@email.com	-8556.0	7514 Main St	96364.0	1970-01-01	1970-01-01	Jacksonville
409	John	Hernandez	john.hernandez364@email.com	-7479.0	8652 Park Rd	23935.0	1970-01-01	1970-01-01	Dallas
410	Emily	Thomas	emily.thomas144@email.com	-9478.0	4266 Second Ave	34581.0	1970-01-01	1970-01-01	Los Angeles
411	James	Miller	james.miller469@email.com	-5965.0	5636 Main St	16094.0	1970-01-01	1970-01-01	Jacksonville
412	Robert	Anderson	robert.anderson675@email.com	-4523.0	171 Second Ave	82512.0	1970-01-01	1970-01-01	San Diego
413	Charles	Thomas	charles.thomas947@email.com	-5421.0	9579 Oak Ave	23573.0	1970-01-01	1970-01-01	Jacksonville
414	Kimberly	Martin	kimberly.martin904@email.com	-8346.0	4167 Park Rd	54939.0	1970-01-01	1970-01-01	San Antonio
415	Robert	Jones	robert.jones142@email.com	-10630.0	9075 Park Rd	82559.0	1970-01-01	1970-01-01	Phoenix
416	Chris	Miller	chris.miller640@email.com	-7884.0	2273 Oak Ave	81105.0	1970-01-01	1970-01-01	Charlotte
417	Sarah	Lopez	sarah.lopez576@email.com	-9125.0	8847 Park Rd	11673.0	1970-01-01	1970-01-01	Austin
418	Sarah	Smith	sarah.smith391@email.com	-2328.0	4474 Oak Ave	99573.0	1970-01-01	1970-01-01	Houston
419	David	Johnson	david.johnson708@email.com	-5646.0	8966 Main St	69322.0	1970-01-01	1970-01-01	Fort Worth
420	Kimberly	Moore	kimberly.moore886@email.com	-8559.0	8470 Park Rd	97096.0	1970-01-01	1970-01-01	Houston
421	James	Gonzalez	james.gonzalez427@email.com	-7829.0	981 Main St	36619.0	1970-01-01	1970-01-01	Dallas
422	Jessica	Lopez	jessica.lopez774@email.com	-5578.0	3270 Park Rd	33255.0	1970-01-01	1970-01-01	Fort Worth
423	Emily	Garcia	emily.garcia753@email.com	-8027.0	7120 Park Rd	44634.0	1970-01-01	1970-01-01	New York
424	Emily	Jackson	emily.jackson867@email.com	-6880.0	2636 Main St	52287.0	1970-01-01	1970-01-01	San Diego
425	Kimberly	Martinez	kimberly.martinez503@email.com	-8459.0	5307 Second Ave	34100.0	1970-01-01	1970-01-01	Los Angeles
426	Michael	Taylor	michael.taylor164@email.com	-10978.0	1606 Park Rd	37964.0	1970-01-01	1970-01-01	San Antonio
427	Matthew	Lopez	matthew.lopez301@email.com	-10883.0	9296 Main St	97679.0	1970-01-01	1970-01-01	San Diego
428	Robert	Davis	robert.davis927@email.com	-6478.0	5358 First St	60577.0	1970-01-01	1970-01-01	New York
429	Michelle	Martinez	michelle.martinez26@email.com	-8712.0	8435 First St	15747.0	1970-01-01	1970-01-01	Dallas
430	Chris	Hernandez	chris.hernandez527@email.com	-4123.0	8914 Second Ave	92173.0	1970-01-01	1970-01-01	Fort Worth
431	Chris	Miller	chris.miller886@email.com	-4036.0	8910 First St	19452.0	1970-01-01	1970-01-01	Houston
432	John	Anderson	john.anderson735@email.com	-3009.0	989 Oak Ave	83149.0	1970-01-01	1970-01-01	Los Angeles
433	Charles	Davis	charles.davis933@email.com	-8237.0	6726 First St	12213.0	1970-01-01	1970-01-01	San Diego
434	Sarah	Moore	sarah.moore7@email.com	-3628.0	9694 Main St	19514.0	1970-01-01	1970-01-01	Fort Worth
435	William	Brown	william.brown297@email.com	-7643.0	1517 Park Rd	59992.0	1970-01-01	1970-01-01	San Jose
436	John	Thomas	john.thomas161@email.com	-4204.0	6506 Second Ave	93105.0	1970-01-01	1970-01-01	Jacksonville
437	Ashley	Lopez	ashley.lopez981@email.com	-4092.0	784 Main St	88204.0	1970-01-01	1970-01-01	Los Angeles
438	Michelle	Moore	michelle.moore970@email.com	-5039.0	5733 Oak Ave	94663.0	1970-01-01	1970-01-01	Jacksonville
439	David	Garcia	david.garcia189@email.com	-6196.0	1977 Oak Ave	84356.0	1970-01-01	1970-01-01	Houston
440	Michelle	Anderson	michelle.anderson661@email.com	-6597.0	1203 Park Rd	35875.0	1970-01-01	1970-01-01	Austin
441	Matthew	Lopez	matthew.lopez132@email.com	-6399.0	4771 Second Ave	35362.0	1970-01-01	1970-01-01	Los Angeles
442	Lisa	Anderson	lisa.anderson337@email.com	-7513.0	9671 Oak Ave	84299.0	1970-01-01	1970-01-01	Jacksonville
443	Matthew	Wilson	matthew.wilson173@email.com	-5556.0	3729 First St	57118.0	1970-01-01	1970-01-01	Fort Worth
444	Matthew	Thomas	matthew.thomas474@email.com	-7026.0	9138 Main St	94613.0	1970-01-01	1970-01-01	San Diego
445	Daniel	Jones	daniel.jones913@email.com	-6263.0	1352 Main St	76476.0	1970-01-01	1970-01-01	Jacksonville
446	Charles	Jackson	charles.jackson415@email.com	-6075.0	700 Second Ave	81233.0	1970-01-01	1970-01-01	Charlotte
447	Lisa	Jones	lisa.jones375@email.com	-6595.0	7713 Second Ave	21869.0	1970-01-01	1970-01-01	Chicago
448	Amanda	Taylor	amanda.taylor11@email.com	-4838.0	8523 Oak Ave	30869.0	1970-01-01	1970-01-01	Fort Worth
449	Charles	Jackson	charles.jackson676@email.com	-10162.0	762 Oak Ave	40375.0	1970-01-01	1970-01-01	Philadelphia
450	Daniel	Lopez	daniel.lopez240@email.com	-5313.0	6018 First St	69591.0	1970-01-01	1970-01-01	Dallas
451	Jane	Hernandez	jane.hernandez106@email.com	-6932.0	4414 Second Ave	84732.0	1970-01-01	1970-01-01	Columbus
452	James	Gonzalez	james.gonzalez375@email.com	-3744.0	4221 First St	77681.0	1970-01-01	1970-01-01	Dallas
453	Amanda	Lopez	amanda.lopez499@email.com	-2611.0	2376 First St	40145.0	1970-01-01	1970-01-01	Dallas
454	William	Rodriguez	william.rodriguez217@email.com	-4121.0	9963 Main St	40191.0	1970-01-01	1970-01-01	Philadelphia
455	Matthew	Brown	matthew.brown494@email.com	-10228.0	9779 Oak Ave	63857.0	1970-01-01	1970-01-01	Houston
456	Jessica	Johnson	jessica.johnson131@email.com	-5031.0	8499 Main St	29249.0	1970-01-01	1970-01-01	Chicago
457	Emily	Rodriguez	emily.rodriguez945@email.com	-8554.0	9334 Main St	47152.0	1970-01-01	1970-01-01	San Jose
458	Chris	Anderson	chris.anderson622@email.com	-10460.0	3694 First St	28705.0	1970-01-01	1970-01-01	Chicago
459	Kimberly	Taylor	kimberly.taylor271@email.com	-7725.0	7529 Second Ave	19023.0	1970-01-01	1970-01-01	Charlotte
460	James	Gonzalez	james.gonzalez136@email.com	-4641.0	8363 First St	89365.0	1970-01-01	1970-01-01	Dallas
461	Emily	Thomas	emily.thomas924@email.com	-3081.0	8806 Second Ave	22214.0	1970-01-01	1970-01-01	Charlotte
462	David	Martin	david.martin553@email.com	-9116.0	6992 Park Rd	79444.0	1970-01-01	1970-01-01	Dallas
463	Jessica	Thomas	jessica.thomas809@email.com	-8118.0	9539 Main St	27548.0	1970-01-01	1970-01-01	San Jose
464	Lisa	Davis	lisa.davis932@email.com	-6804.0	9008 First St	34775.0	1970-01-01	1970-01-01	San Jose
465	John	Jackson	john.jackson536@email.com	-1968.0	3465 Park Rd	57483.0	1970-01-01	1970-01-01	San Antonio
466	David	Wilson	david.wilson668@email.com	-6338.0	8883 First St	57925.0	1970-01-01	1970-01-01	Columbus
467	James	Miller	james.miller424@email.com	-10470.0	6165 Second Ave	73407.0	1970-01-01	1970-01-01	Chicago
468	Ashley	Jackson	ashley.jackson353@email.com	-9235.0	2362 Main St	68536.0	1970-01-01	1970-01-01	Jacksonville
469	Sarah	Miller	sarah.miller521@email.com	-7957.0	9120 Second Ave	99727.0	1970-01-01	1970-01-01	Fort Worth
470	Emily	Gonzalez	emily.gonzalez988@email.com	-3347.0	2481 First St	67065.0	1970-01-01	1970-01-01	Columbus
471	Michael	Rodriguez	michael.rodriguez228@email.com	-2277.0	6396 First St	96006.0	1970-01-01	1970-01-01	Jacksonville
472	Ashley	Martin	ashley.martin59@email.com	-5701.0	8199 First St	36438.0	1970-01-01	1970-01-01	Austin
473	Ashley	Miller	ashley.miller35@email.com	-10978.0	3895 Second Ave	98345.0	1970-01-01	1970-01-01	Dallas
474	Amanda	Davis	amanda.davis671@email.com	-2782.0	6644 Park Rd	61792.0	1970-01-01	1970-01-01	Phoenix
475	Charles	Miller	charles.miller531@email.com	-3092.0	1577 Second Ave	83284.0	1970-01-01	1970-01-01	Charlotte
476	Amanda	Rodriguez	amanda.rodriguez232@email.com	-9468.0	6718 Second Ave	44223.0	1970-01-01	1970-01-01	Charlotte
477	Jennifer	Taylor	jennifer.taylor110@email.com	-10088.0	5670 Main St	43776.0	1970-01-01	1970-01-01	Phoenix
478	Charles	Rodriguez	charles.rodriguez711@email.com	-9961.0	4085 Park Rd	99337.0	1970-01-01	1970-01-01	Fort Worth
479	Charles	Smith	charles.smith494@email.com	-2688.0	3710 Oak Ave	64057.0	1970-01-01	1970-01-01	San Antonio
480	William	Moore	william.moore10@email.com	-7082.0	4806 Main St	98302.0	1970-01-01	1970-01-01	Houston
481	Michael	Moore	michael.moore954@email.com	-7010.0	3680 Second Ave	33957.0	1970-01-01	1970-01-01	Philadelphia
482	Lisa	Miller	lisa.miller241@email.com	-6547.0	3855 Oak Ave	91080.0	1970-01-01	1970-01-01	Houston
483	David	Brown	david.brown123@email.com	-10042.0	208 Second Ave	73214.0	1970-01-01	1970-01-01	San Jose
484	Kimberly	Hernandez	kimberly.hernandez505@email.com	-7177.0	3096 Second Ave	62150.0	1970-01-01	1970-01-01	San Diego
485	Charles	Jones	charles.jones56@email.com	-9488.0	8959 Main St	55519.0	1970-01-01	1970-01-01	San Diego
486	Emily	Anderson	emily.anderson124@email.com	-9981.0	237 Main St	37623.0	1970-01-01	1970-01-01	Philadelphia
487	Charles	Brown	charles.brown334@email.com	-6450.0	9087 Park Rd	45311.0	1970-01-01	1970-01-01	Chicago
488	Kimberly	Hernandez	kimberly.hernandez375@email.com	-8842.0	6966 Park Rd	62506.0	1970-01-01	1970-01-01	Houston
489	Robert	Garcia	robert.garcia586@email.com	-5666.0	1736 Park Rd	82789.0	1970-01-01	1970-01-01	Columbus
490	James	Miller	james.miller150@email.com	-5224.0	259 Oak Ave	75483.0	1970-01-01	1970-01-01	San Diego
491	William	Moore	william.moore738@email.com	-10298.0	4211 Second Ave	16253.0	1970-01-01	1970-01-01	Phoenix
492	Sarah	Garcia	sarah.garcia62@email.com	-6418.0	1677 First St	44048.0	1970-01-01	1970-01-01	San Diego
493	Amanda	Moore	amanda.moore571@email.com	-7929.0	6846 Main St	99074.0	1970-01-01	1970-01-01	New York
494	Charles	Jackson	charles.jackson666@email.com	-5273.0	4763 Park Rd	98236.0	1970-01-01	1970-01-01	Fort Worth
495	Lisa	Anderson	lisa.anderson911@email.com	-6363.0	2473 Oak Ave	54222.0	1970-01-01	1970-01-01	San Diego
496	Kimberly	Jackson	kimberly.jackson415@email.com	-3437.0	5729 Oak Ave	51533.0	1970-01-01	1970-01-01	Chicago
497	Daniel	Martin	daniel.martin661@email.com	-9169.0	6050 Second Ave	69020.0	1970-01-01	1970-01-01	Fort Worth
498	Emily	Garcia	emily.garcia875@email.com	-5194.0	4222 Main St	31877.0	1970-01-01	1970-01-01	Austin
499	Sarah	Brown	sarah.brown66@email.com	-11567.0	531 First St	20911.0	1970-01-01	1970-01-01	New York
500	Daniel	Martin	daniel.martin160@email.com	-8342.0	3857 Oak Ave	68085.0	1970-01-01	1970-01-01	Phoenix
501	David	Taylor	david.taylor859@email.com	-1977.0	5946 Park Rd	71235.0	1970-01-01	1970-01-01	Austin
502	Daniel	Moore	daniel.moore456@email.com	-10886.0	9780 Second Ave	92712.0	1970-01-01	1970-01-01	Chicago
503	Jennifer	Taylor	jennifer.taylor656@email.com	-7472.0	5788 First St	39770.0	1970-01-01	1970-01-01	Charlotte
504	Robert	Martinez	robert.martinez375@email.com	-4438.0	272 Main St	27865.0	1970-01-01	1970-01-01	Phoenix
505	Ashley	Thomas	ashley.thomas548@email.com	-9970.0	7916 Park Rd	66418.0	1970-01-01	1970-01-01	Fort Worth
506	Kimberly	Davis	kimberly.davis816@email.com	-7888.0	6845 Second Ave	61740.0	1970-01-01	1970-01-01	Houston
507	Emily	Gonzalez	emily.gonzalez849@email.com	-6119.0	7017 Oak Ave	90375.0	1970-01-01	1970-01-01	Los Angeles
508	Ashley	Moore	ashley.moore829@email.com	-4976.0	1221 Oak Ave	47957.0	1970-01-01	1970-01-01	Columbus
509	Robert	Martin	robert.martin464@email.com	-10254.0	5353 Main St	16505.0	1970-01-01	1970-01-01	Houston
510	John	Garcia	john.garcia996@email.com	-6001.0	7283 Main St	21822.0	1970-01-01	1970-01-01	Chicago
511	John	Thomas	john.thomas223@email.com	-7083.0	8265 Park Rd	14159.0	1970-01-01	1970-01-01	Fort Worth
512	Michael	Jones	michael.jones58@email.com	-8694.0	8999 First St	35191.0	1970-01-01	1970-01-01	Los Angeles
513	James	Smith	james.smith125@email.com	-6794.0	7357 Oak Ave	36106.0	1970-01-01	1970-01-01	San Antonio
514	Sarah	Taylor	sarah.taylor682@email.com	-8271.0	5213 Park Rd	92465.0	1970-01-01	1970-01-01	Austin
515	Michelle	Taylor	michelle.taylor126@email.com	-6845.0	6005 Main St	38545.0	1970-01-01	1970-01-01	Houston
516	Jessica	Wilson	jessica.wilson333@email.com	-5908.0	2060 First St	11170.0	1970-01-01	1970-01-01	San Jose
517	Charles	Thomas	charles.thomas705@email.com	-8051.0	1566 Oak Ave	75525.0	1970-01-01	1970-01-01	Fort Worth
518	Kimberly	Hernandez	kimberly.hernandez954@email.com	-3599.0	5924 Oak Ave	80300.0	1970-01-01	1970-01-01	New York
519	David	Thomas	david.thomas239@email.com	-7784.0	7287 Oak Ave	59514.0	1970-01-01	1970-01-01	Fort Worth
520	David	Rodriguez	david.rodriguez921@email.com	-8903.0	4928 Second Ave	74237.0	1970-01-01	1970-01-01	Dallas
521	Charles	Garcia	charles.garcia557@email.com	-9560.0	9908 Second Ave	19027.0	1970-01-01	1970-01-01	Phoenix
522	David	Anderson	david.anderson303@email.com	-11180.0	7539 Main St	76316.0	1970-01-01	1970-01-01	Philadelphia
523	Emily	Smith	emily.smith635@email.com	-6360.0	1137 Second Ave	34886.0	1970-01-01	1970-01-01	Philadelphia
524	Lisa	Moore	lisa.moore158@email.com	-7400.0	5376 Main St	78576.0	1970-01-01	1970-01-01	San Antonio
525	Jane	Jones	jane.jones183@email.com	-5435.0	8052 Oak Ave	14170.0	1970-01-01	1970-01-01	Los Angeles
526	James	Thomas	james.thomas539@email.com	-6748.0	6102 Oak Ave	19289.0	1970-01-01	1970-01-01	New York
527	Chris	Thomas	chris.thomas951@email.com	-9800.0	1094 Park Rd	64519.0	1970-01-01	1970-01-01	Fort Worth
528	Jane	Martin	jane.martin273@email.com	-2934.0	5079 Main St	78089.0	1970-01-01	1970-01-01	Columbus
529	Sarah	Davis	sarah.davis545@email.com	-4951.0	4175 Second Ave	33448.0	1970-01-01	1970-01-01	Dallas
530	Michelle	Wilson	michelle.wilson765@email.com	-7955.0	7615 First St	31864.0	1970-01-01	1970-01-01	Austin
531	Michelle	Gonzalez	michelle.gonzalez517@email.com	-4808.0	9929 First St	51307.0	1970-01-01	1970-01-01	Dallas
532	Matthew	Lopez	matthew.lopez423@email.com	-9683.0	5399 Second Ave	83812.0	1970-01-01	1970-01-01	Columbus
533	Chris	Gonzalez	chris.gonzalez785@email.com	-6686.0	7512 First St	10025.0	1970-01-01	1970-01-01	Philadelphia
534	Ashley	Martin	ashley.martin17@email.com	-6812.0	5020 Oak Ave	51275.0	1970-01-01	1970-01-01	New York
535	Daniel	Moore	daniel.moore524@email.com	-4886.0	718 First St	30461.0	1970-01-01	1970-01-01	Los Angeles
536	Daniel	Lopez	daniel.lopez911@email.com	-5867.0	5020 Main St	62402.0	1970-01-01	1970-01-01	Phoenix
537	Chris	Williams	chris.williams741@email.com	-10247.0	8099 Second Ave	88018.0	1970-01-01	1970-01-01	Chicago
538	Jane	Jackson	jane.jackson391@email.com	-2993.0	5578 Park Rd	64594.0	1970-01-01	1970-01-01	Charlotte
539	Jessica	Martin	jessica.martin951@email.com	-8125.0	5093 Second Ave	51853.0	1970-01-01	1970-01-01	New York
540	Charles	Jones	charles.jones335@email.com	-6044.0	927 First St	88005.0	1970-01-01	1970-01-01	Chicago
541	William	Williams	william.williams228@email.com	-8397.0	2265 Park Rd	72371.0	1970-01-01	1970-01-01	Chicago
542	Jane	Moore	jane.moore409@email.com	-8083.0	7218 Oak Ave	73035.0	1970-01-01	1970-01-01	Dallas
543	Chris	Thomas	chris.thomas405@email.com	-5663.0	8689 Oak Ave	19390.0	1970-01-01	1970-01-01	Dallas
544	Jennifer	Hernandez	jennifer.hernandez702@email.com	-3722.0	6876 First St	55653.0	1970-01-01	1970-01-01	Austin
545	Matthew	Lopez	matthew.lopez609@email.com	-6888.0	5829 Second Ave	91681.0	1970-01-01	1970-01-01	Chicago
546	Robert	Johnson	robert.johnson947@email.com	-5546.0	6224 Oak Ave	24728.0	1970-01-01	1970-01-01	Austin
547	Jessica	Martin	jessica.martin949@email.com	-6952.0	5724 Main St	68990.0	1970-01-01	1970-01-01	New York
548	John	Hernandez	john.hernandez215@email.com	-5977.0	9052 Second Ave	81932.0	1970-01-01	1970-01-01	Houston
549	Kimberly	Jones	kimberly.jones712@email.com	-2899.0	9651 Second Ave	43483.0	1970-01-01	1970-01-01	San Antonio
550	Jane	Martinez	jane.martinez206@email.com	-7164.0	7717 Main St	60940.0	1970-01-01	1970-01-01	New York
551	Amanda	Brown	amanda.brown20@email.com	-8718.0	6337 Second Ave	23055.0	1970-01-01	1970-01-01	Houston
552	Lisa	Martin	lisa.martin545@email.com	-4737.0	7603 Second Ave	12816.0	1970-01-01	1970-01-01	Dallas
553	Jessica	Taylor	jessica.taylor313@email.com	-8486.0	2672 Main St	99694.0	1970-01-01	1970-01-01	Jacksonville
554	Amanda	Martinez	amanda.martinez242@email.com	-3009.0	4321 First St	82737.0	1970-01-01	1970-01-01	Austin
555	Jessica	Jones	jessica.jones350@email.com	-4521.0	6362 Second Ave	90274.0	1970-01-01	1970-01-01	Los Angeles
556	Jennifer	Davis	jennifer.davis587@email.com	-6909.0	5495 First St	27271.0	1970-01-01	1970-01-01	Charlotte
557	David	Jackson	david.jackson555@email.com	-6032.0	2362 Park Rd	78656.0	1970-01-01	1970-01-01	Columbus
558	Jennifer	Jones	jennifer.jones672@email.com	-7139.0	9231 Second Ave	34134.0	1970-01-01	1970-01-01	Los Angeles
559	David	Smith	david.smith784@email.com	-8685.0	7358 Park Rd	34632.0	1970-01-01	1970-01-01	Phoenix
560	David	Garcia	david.garcia27@email.com	-6977.0	9390 Second Ave	88166.0	1970-01-01	1970-01-01	San Jose
561	Jessica	Smith	jessica.smith368@email.com	-9792.0	8330 Second Ave	95140.0	1970-01-01	1970-01-01	Chicago
562	Emily	Gonzalez	emily.gonzalez504@email.com	-4507.0	3807 Main St	11967.0	1970-01-01	1970-01-01	Houston
563	Jennifer	Davis	jennifer.davis761@email.com	-5444.0	3001 First St	74217.0	1970-01-01	1970-01-01	Los Angeles
564	Robert	Davis	robert.davis438@email.com	-3092.0	6332 Park Rd	90151.0	1970-01-01	1970-01-01	San Jose
565	Kimberly	Moore	kimberly.moore538@email.com	-3381.0	1891 First St	15559.0	1970-01-01	1970-01-01	Dallas
566	William	Moore	william.moore406@email.com	-8338.0	907 Oak Ave	67613.0	1970-01-01	1970-01-01	Dallas
567	Ashley	Martinez	ashley.martinez473@email.com	-6624.0	993 Second Ave	70762.0	1970-01-01	1970-01-01	San Jose
568	Michael	Taylor	michael.taylor116@email.com	-11132.0	6540 First St	69098.0	1970-01-01	1970-01-01	Chicago
569	Emily	Anderson	emily.anderson605@email.com	-9583.0	4197 Park Rd	95010.0	1970-01-01	1970-01-01	Los Angeles
570	Sarah	Williams	sarah.williams117@email.com	-8328.0	8682 First St	90225.0	1970-01-01	1970-01-01	Los Angeles
571	James	Moore	james.moore390@email.com	-4828.0	5591 Second Ave	29672.0	1970-01-01	1970-01-01	Charlotte
572	David	Garcia	david.garcia788@email.com	-8854.0	5171 First St	92110.0	1970-01-01	1970-01-01	Phoenix
573	Sarah	Jones	sarah.jones984@email.com	-5555.0	7614 First St	81237.0	1970-01-01	1970-01-01	New York
574	Kimberly	Thomas	kimberly.thomas244@email.com	-9817.0	6819 First St	88802.0	1970-01-01	1970-01-01	San Diego
575	Jessica	Moore	jessica.moore285@email.com	-5877.0	3128 Oak Ave	95626.0	1970-01-01	1970-01-01	New York
576	Jane	Jones	jane.jones875@email.com	-6804.0	1536 Main St	64651.0	1970-01-01	1970-01-01	Philadelphia
577	Emily	Martinez	emily.martinez626@email.com	-5489.0	9585 Park Rd	22206.0	1970-01-01	1970-01-01	San Diego
578	Matthew	Lopez	matthew.lopez920@email.com	-3534.0	7101 Second Ave	48382.0	1970-01-01	1970-01-01	Fort Worth
579	David	Brown	david.brown712@email.com	-7753.0	6879 Second Ave	37400.0	1970-01-01	1970-01-01	Dallas
580	Sarah	Jackson	sarah.jackson748@email.com	-3820.0	4805 First St	51482.0	1970-01-01	1970-01-01	San Diego
581	William	Jackson	william.jackson639@email.com	-9825.0	8254 First St	89876.0	1970-01-01	1970-01-01	Dallas
582	Ashley	Miller	ashley.miller2@email.com	-8960.0	2032 Oak Ave	64346.0	1970-01-01	1970-01-01	Austin
583	Jane	Hernandez	jane.hernandez359@email.com	-6075.0	3396 Park Rd	18891.0	1970-01-01	1970-01-01	New York
584	Ashley	Taylor	ashley.taylor564@email.com	-2415.0	5560 Park Rd	84569.0	1970-01-01	1970-01-01	Los Angeles
585	Emily	Miller	emily.miller339@email.com	-10247.0	7874 Main St	27793.0	1970-01-01	1970-01-01	Charlotte
586	David	Anderson	david.anderson914@email.com	-8123.0	6882 Main St	49235.0	1970-01-01	1970-01-01	San Diego
587	Matthew	Moore	matthew.moore549@email.com	-6865.0	5893 Main St	46760.0	1970-01-01	1970-01-01	Fort Worth
588	Matthew	Gonzalez	matthew.gonzalez642@email.com	-5327.0	6482 Oak Ave	25315.0	1970-01-01	1970-01-01	San Jose
589	Matthew	Johnson	matthew.johnson279@email.com	-9853.0	3993 Park Rd	49666.0	1970-01-01	1970-01-01	Charlotte
590	William	Martinez	william.martinez180@email.com	-2308.0	3411 Main St	76321.0	1970-01-01	1970-01-01	Fort Worth
591	Lisa	Taylor	lisa.taylor158@email.com	-9662.0	8679 Park Rd	28781.0	1970-01-01	1970-01-01	Jacksonville
592	William	Jones	william.jones211@email.com	-9503.0	8658 Main St	50760.0	1970-01-01	1970-01-01	San Antonio
593	Kimberly	Williams	kimberly.williams342@email.com	-3413.0	5219 Main St	50913.0	1970-01-01	1970-01-01	Dallas
594	Matthew	Miller	matthew.miller198@email.com	-10495.0	7327 Main St	29571.0	1970-01-01	1970-01-01	Philadelphia
595	Daniel	Brown	daniel.brown16@email.com	-10831.0	3484 Second Ave	82006.0	1970-01-01	1970-01-01	Los Angeles
596	Daniel	Jones	daniel.jones966@email.com	-7384.0	4111 Oak Ave	50812.0	1970-01-01	1970-01-01	San Jose
597	Michelle	Anderson	michelle.anderson52@email.com	-9073.0	926 Main St	17051.0	1970-01-01	1970-01-01	Charlotte
598	Jennifer	Gonzalez	jennifer.gonzalez184@email.com	-9834.0	5926 Park Rd	35971.0	1970-01-01	1970-01-01	San Jose
599	Michael	Anderson	michael.anderson582@email.com	-9100.0	7564 Park Rd	94465.0	1970-01-01	1970-01-01	Los Angeles
600	Lisa	Davis	lisa.davis971@email.com	-5802.0	6054 First St	97186.0	1970-01-01	1970-01-01	Charlotte
601	Matthew	Anderson	matthew.anderson500@email.com	-9082.0	5858 First St	32387.0	1970-01-01	1970-01-01	Los Angeles
602	Amanda	Martin	amanda.martin589@email.com	-3535.0	1852 Park Rd	95124.0	1970-01-01	1970-01-01	San Antonio
603	Ashley	Moore	ashley.moore473@email.com	-8986.0	4092 Second Ave	73225.0	1970-01-01	1970-01-01	Houston
604	Michael	Hernandez	michael.hernandez214@email.com	-9805.0	7232 Second Ave	81372.0	1970-01-01	1970-01-01	Fort Worth
605	Emily	Williams	emily.williams758@email.com	-10486.0	9802 Second Ave	52647.0	1970-01-01	1970-01-01	Los Angeles
606	Sarah	Anderson	sarah.anderson181@email.com	-3069.0	1881 Second Ave	52914.0	1970-01-01	1970-01-01	San Jose
607	Jane	Williams	jane.williams223@email.com	-2180.0	2503 Oak Ave	79632.0	1970-01-01	1970-01-01	Fort Worth
608	James	Martin	james.martin592@email.com	-5225.0	5287 Park Rd	99071.0	1970-01-01	1970-01-01	Austin
609	Jennifer	Lopez	jennifer.lopez92@email.com	-10165.0	2189 Park Rd	58394.0	1970-01-01	1970-01-01	San Antonio
610	Jane	Smith	jane.smith721@email.com	-8497.0	4723 Main St	66585.0	1970-01-01	1970-01-01	Los Angeles
611	Matthew	Gonzalez	matthew.gonzalez416@email.com	-10965.0	2941 First St	34671.0	1970-01-01	1970-01-01	Houston
612	James	Lopez	james.lopez861@email.com	-6509.0	2156 Oak Ave	19403.0	1970-01-01	1970-01-01	Columbus
613	David	Thomas	david.thomas674@email.com	-3172.0	6913 First St	89223.0	1970-01-01	1970-01-01	Chicago
614	Kimberly	Garcia	kimberly.garcia466@email.com	-9527.0	5921 Oak Ave	65675.0	1970-01-01	1970-01-01	San Antonio
615	Charles	Thomas	charles.thomas868@email.com	-10409.0	6831 Second Ave	58099.0	1970-01-01	1970-01-01	Phoenix
616	Jane	Jackson	jane.jackson495@email.com	-4151.0	7989 Main St	78997.0	1970-01-01	1970-01-01	San Jose
617	Robert	Taylor	robert.taylor81@email.com	-3807.0	7840 Main St	93058.0	1970-01-01	1970-01-01	Houston
618	Charles	Martinez	charles.martinez628@email.com	-10369.0	276 First St	77195.0	1970-01-01	1970-01-01	Fort Worth
619	Charles	Hernandez	charles.hernandez432@email.com	-7204.0	2844 Main St	88333.0	1970-01-01	1970-01-01	Phoenix
620	Charles	Rodriguez	charles.rodriguez63@email.com	-5097.0	945 Park Rd	13578.0	1970-01-01	1970-01-01	San Jose
621	Lisa	Williams	lisa.williams130@email.com	-6346.0	2271 Second Ave	46073.0	1970-01-01	1970-01-01	Phoenix
622	John	Brown	john.brown619@email.com	-4458.0	7417 Park Rd	44242.0	1970-01-01	1970-01-01	Austin
623	Lisa	Garcia	lisa.garcia819@email.com	-3163.0	1482 Oak Ave	30204.0	1970-01-01	1970-01-01	Philadelphia
624	Jennifer	Gonzalez	jennifer.gonzalez244@email.com	-5065.0	9565 Park Rd	94182.0	1970-01-01	1970-01-01	Houston
625	Sarah	Johnson	sarah.johnson172@email.com	-9884.0	7903 Second Ave	59781.0	1970-01-01	1970-01-01	Phoenix
626	Lisa	Rodriguez	lisa.rodriguez149@email.com	-9755.0	4831 First St	98931.0	1970-01-01	1970-01-01	New York
627	William	Johnson	william.johnson100@email.com	-8192.0	7174 Second Ave	45728.0	1970-01-01	1970-01-01	Columbus
628	Daniel	Rodriguez	daniel.rodriguez822@email.com	-7968.0	4061 Second Ave	78151.0	1970-01-01	1970-01-01	San Diego
629	Emily	Hernandez	emily.hernandez561@email.com	-2035.0	1213 Main St	22805.0	1970-01-01	1970-01-01	Columbus
630	Sarah	Anderson	sarah.anderson360@email.com	-6806.0	3263 Main St	91185.0	1970-01-01	1970-01-01	Phoenix
631	Jane	Martin	jane.martin673@email.com	-4271.0	2065 Main St	27027.0	1970-01-01	1970-01-01	Jacksonville
632	Charles	Garcia	charles.garcia918@email.com	-5042.0	4926 First St	19924.0	1970-01-01	1970-01-01	Phoenix
633	Daniel	Wilson	daniel.wilson709@email.com	-7968.0	2753 Main St	18177.0	1970-01-01	1970-01-01	Phoenix
634	James	Hernandez	james.hernandez62@email.com	-6631.0	7318 Main St	36302.0	1970-01-01	1970-01-01	Chicago
635	Emily	Thomas	emily.thomas112@email.com	-8964.0	1840 First St	23538.0	1970-01-01	1970-01-01	Houston
636	Michael	Williams	michael.williams586@email.com	-9505.0	8254 Oak Ave	93930.0	1970-01-01	1970-01-01	New York
637	Jane	Gonzalez	jane.gonzalez273@email.com	-7473.0	6511 Second Ave	77552.0	1970-01-01	1970-01-01	Charlotte
638	Lisa	Wilson	lisa.wilson414@email.com	-3956.0	3800 Main St	73185.0	1970-01-01	1970-01-01	Dallas
639	Charles	Moore	charles.moore958@email.com	-6868.0	1004 Main St	80074.0	1970-01-01	1970-01-01	San Antonio
640	Michael	Anderson	michael.anderson779@email.com	-5606.0	9184 Main St	96603.0	1970-01-01	1970-01-01	Chicago
641	Ashley	Gonzalez	ashley.gonzalez918@email.com	-7839.0	1490 First St	28342.0	1970-01-01	1970-01-01	San Diego
642	Chris	Smith	chris.smith738@email.com	-10065.0	1132 Second Ave	50334.0	1970-01-01	1970-01-01	San Antonio
643	Michelle	Anderson	michelle.anderson990@email.com	-6810.0	5633 Main St	25491.0	1970-01-01	1970-01-01	New York
644	William	Anderson	william.anderson963@email.com	-11575.0	9592 Oak Ave	14833.0	1970-01-01	1970-01-01	Chicago
645	Lisa	Smith	lisa.smith483@email.com	-5854.0	2238 Main St	92924.0	1970-01-01	1970-01-01	Jacksonville
646	Ashley	Brown	ashley.brown468@email.com	-3045.0	1842 Main St	87984.0	1970-01-01	1970-01-01	Columbus
647	Michael	Miller	michael.miller437@email.com	-8960.0	2079 Second Ave	28000.0	1970-01-01	1970-01-01	Philadelphia
648	Chris	Johnson	chris.johnson608@email.com	-2754.0	4587 Oak Ave	32026.0	1970-01-01	1970-01-01	Los Angeles
649	Michelle	Garcia	michelle.garcia450@email.com	-2709.0	1737 Second Ave	30677.0	1970-01-01	1970-01-01	Chicago
650	Lisa	Williams	lisa.williams7@email.com	-2849.0	9827 Park Rd	72391.0	1970-01-01	1970-01-01	Jacksonville
651	Chris	Jones	chris.jones656@email.com	-9390.0	4019 Oak Ave	14931.0	1970-01-01	1970-01-01	San Antonio
652	Lisa	Martin	lisa.martin974@email.com	-6865.0	6961 Main St	40885.0	1970-01-01	1970-01-01	Philadelphia
653	Sarah	Taylor	sarah.taylor98@email.com	-11044.0	3692 First St	96419.0	1970-01-01	1970-01-01	Dallas
654	Daniel	Johnson	daniel.johnson199@email.com	-4573.0	7872 First St	30940.0	1970-01-01	1970-01-01	Austin
655	Jane	Lopez	jane.lopez292@email.com	-5976.0	7524 Main St	16875.0	1970-01-01	1970-01-01	Philadelphia
656	Emily	Garcia	emily.garcia805@email.com	-10160.0	1260 Oak Ave	87687.0	1970-01-01	1970-01-01	Los Angeles
657	Matthew	Wilson	matthew.wilson204@email.com	-7993.0	1904 Park Rd	22853.0	1970-01-01	1970-01-01	Houston
658	Jennifer	Miller	jennifer.miller385@email.com	-9215.0	8036 Main St	28997.0	1970-01-01	1970-01-01	San Jose
659	Kimberly	Anderson	kimberly.anderson183@email.com	-4211.0	3281 Park Rd	36504.0	1970-01-01	1970-01-01	San Diego
660	David	Johnson	david.johnson709@email.com	-6439.0	1920 First St	64817.0	1970-01-01	1970-01-01	Chicago
661	Matthew	Davis	matthew.davis908@email.com	-4687.0	2884 Second Ave	40107.0	1970-01-01	1970-01-01	Fort Worth
662	Jennifer	Taylor	jennifer.taylor501@email.com	-10059.0	7681 Park Rd	66113.0	1970-01-01	1970-01-01	Columbus
663	Jessica	Hernandez	jessica.hernandez445@email.com	-4459.0	9499 Main St	15796.0	1970-01-01	1970-01-01	Charlotte
664	Lisa	Taylor	lisa.taylor35@email.com	-8637.0	1705 First St	41524.0	1970-01-01	1970-01-01	San Diego
665	Michelle	Smith	michelle.smith710@email.com	-5935.0	5972 Park Rd	94887.0	1970-01-01	1970-01-01	Chicago
666	John	Thomas	john.thomas686@email.com	-9200.0	9445 Second Ave	69616.0	1970-01-01	1970-01-01	Columbus
667	David	Gonzalez	david.gonzalez190@email.com	-8967.0	7707 Main St	19266.0	1970-01-01	1970-01-01	Austin
668	Matthew	Taylor	matthew.taylor34@email.com	-6358.0	8987 Second Ave	99740.0	1970-01-01	1970-01-01	Jacksonville
669	Kimberly	Hernandez	kimberly.hernandez754@email.com	-7745.0	944 Main St	57918.0	1970-01-01	1970-01-01	Charlotte
670	Kimberly	Johnson	kimberly.johnson375@email.com	-2850.0	3454 Oak Ave	41278.0	1970-01-01	1970-01-01	Dallas
671	Sarah	Thomas	sarah.thomas756@email.com	-6000.0	3793 Park Rd	45043.0	1970-01-01	1970-01-01	Fort Worth
672	Jennifer	Rodriguez	jennifer.rodriguez56@email.com	-7300.0	8066 Second Ave	26083.0	1970-01-01	1970-01-01	San Diego
673	Michelle	Moore	michelle.moore922@email.com	-7991.0	1175 Oak Ave	21443.0	1970-01-01	1970-01-01	Fort Worth
674	James	Garcia	james.garcia296@email.com	-4087.0	1935 Oak Ave	29726.0	1970-01-01	1970-01-01	Phoenix
675	William	Smith	william.smith301@email.com	-11193.0	2263 First St	65067.0	1970-01-01	1970-01-01	Charlotte
676	John	Martinez	john.martinez194@email.com	-5091.0	8613 Park Rd	85851.0	1970-01-01	1970-01-01	Columbus
677	Matthew	Thomas	matthew.thomas608@email.com	-11279.0	9086 First St	49856.0	1970-01-01	1970-01-01	Columbus
678	David	Martinez	david.martinez176@email.com	-5988.0	6193 Park Rd	29443.0	1970-01-01	1970-01-01	San Diego
679	Ashley	Anderson	ashley.anderson980@email.com	-4636.0	8870 Park Rd	32984.0	1970-01-01	1970-01-01	Jacksonville
680	Emily	Davis	emily.davis120@email.com	-3637.0	4366 Park Rd	36890.0	1970-01-01	1970-01-01	San Diego
681	Jane	Hernandez	jane.hernandez353@email.com	-9078.0	2763 Second Ave	25923.0	1970-01-01	1970-01-01	Dallas
682	James	Thomas	james.thomas787@email.com	-7062.0	170 Second Ave	53421.0	1970-01-01	1970-01-01	Chicago
683	Lisa	Martinez	lisa.martinez993@email.com	-4967.0	9360 First St	24721.0	1970-01-01	1970-01-01	Fort Worth
684	Jane	Jones	jane.jones695@email.com	-6929.0	6680 Second Ave	68454.0	1970-01-01	1970-01-01	New York
685	Michael	Hernandez	michael.hernandez57@email.com	-5674.0	8725 Oak Ave	35652.0	1970-01-01	1970-01-01	San Jose
686	Michael	Moore	michael.moore870@email.com	-3779.0	6562 Oak Ave	51649.0	1970-01-01	1970-01-01	Dallas
687	Jane	Lopez	jane.lopez408@email.com	-9089.0	6426 Park Rd	47309.0	1970-01-01	1970-01-01	Philadelphia
688	Amanda	Martinez	amanda.martinez457@email.com	-4103.0	7378 First St	47831.0	1970-01-01	1970-01-01	Houston
689	Jennifer	Wilson	jennifer.wilson143@email.com	-4065.0	3504 Park Rd	78852.0	1970-01-01	1970-01-01	Chicago
690	Michael	Jackson	michael.jackson775@email.com	-1781.0	4578 First St	82851.0	1970-01-01	1970-01-01	San Antonio
691	Charles	Jones	charles.jones205@email.com	-8495.0	9174 First St	49582.0	1970-01-01	1970-01-01	Phoenix
692	Lisa	Moore	lisa.moore758@email.com	-2341.0	140 Oak Ave	49343.0	1970-01-01	1970-01-01	Fort Worth
693	Sarah	Martinez	sarah.martinez428@email.com	-5894.0	2055 Park Rd	18745.0	1970-01-01	1970-01-01	New York
694	Charles	Thomas	charles.thomas580@email.com	-6759.0	7899 Main St	77177.0	1970-01-01	1970-01-01	Austin
695	John	Rodriguez	john.rodriguez167@email.com	-4247.0	7653 Oak Ave	31405.0	1970-01-01	1970-01-01	Philadelphia
696	Daniel	Lopez	daniel.lopez430@email.com	-3012.0	4878 Second Ave	20069.0	1970-01-01	1970-01-01	Phoenix
697	Chris	Garcia	chris.garcia784@email.com	-4646.0	5385 Park Rd	49462.0	1970-01-01	1970-01-01	Dallas
698	Amanda	Brown	amanda.brown548@email.com	-4506.0	2343 Second Ave	58891.0	1970-01-01	1970-01-01	New York
699	Jennifer	Hernandez	jennifer.hernandez944@email.com	-5038.0	8347 Oak Ave	83224.0	1970-01-01	1970-01-01	Chicago
700	Michelle	Moore	michelle.moore720@email.com	-4661.0	7644 Main St	27200.0	1970-01-01	1970-01-01	San Antonio
701	Lisa	Lopez	lisa.lopez320@email.com	-4554.0	7340 Second Ave	54832.0	1970-01-01	1970-01-01	Columbus
702	Ashley	Smith	ashley.smith763@email.com	-5797.0	2432 Oak Ave	26429.0	1970-01-01	1970-01-01	Chicago
703	David	Williams	david.williams436@email.com	-4517.0	408 First St	15572.0	1970-01-01	1970-01-01	Los Angeles
704	Sarah	Johnson	sarah.johnson813@email.com	-3370.0	2048 Park Rd	18683.0	1970-01-01	1970-01-01	San Diego
705	John	Brown	john.brown802@email.com	-5306.0	3377 Oak Ave	56076.0	1970-01-01	1970-01-01	San Jose
706	Michael	Jones	michael.jones867@email.com	-7945.0	2730 Second Ave	41696.0	1970-01-01	1970-01-01	Philadelphia
707	Charles	Williams	charles.williams102@email.com	-2859.0	3655 Oak Ave	32514.0	1970-01-01	1970-01-01	Dallas
708	John	Brown	john.brown947@email.com	-9711.0	9756 Oak Ave	98280.0	1970-01-01	1970-01-01	Philadelphia
709	Emily	Lopez	emily.lopez389@email.com	-10277.0	6777 Main St	26202.0	1970-01-01	1970-01-01	Houston
710	Sarah	Taylor	sarah.taylor140@email.com	-8404.0	4823 Second Ave	20780.0	1970-01-01	1970-01-01	Jacksonville
711	Lisa	Brown	lisa.brown395@email.com	-7067.0	7373 Oak Ave	63383.0	1970-01-01	1970-01-01	Austin
712	Jennifer	Miller	jennifer.miller878@email.com	-9924.0	6120 Oak Ave	98363.0	1970-01-01	1970-01-01	Austin
713	Sarah	Gonzalez	sarah.gonzalez449@email.com	-3800.0	2448 First St	87405.0	1970-01-01	1970-01-01	Los Angeles
714	Emily	Williams	emily.williams373@email.com	-5029.0	6723 Main St	65666.0	1970-01-01	1970-01-01	San Jose
715	Daniel	Jackson	daniel.jackson608@email.com	-8809.0	7895 Second Ave	73508.0	1970-01-01	1970-01-01	Philadelphia
716	Daniel	Jones	daniel.jones787@email.com	-3775.0	8117 First St	92361.0	1970-01-01	1970-01-01	Phoenix
717	John	Brown	john.brown756@email.com	-3220.0	538 Oak Ave	89244.0	1970-01-01	1970-01-01	San Diego
718	David	Martinez	david.martinez637@email.com	-3188.0	8618 First St	36467.0	1970-01-01	1970-01-01	Austin
719	Lisa	Thomas	lisa.thomas517@email.com	-7650.0	8956 Second Ave	14141.0	1970-01-01	1970-01-01	Fort Worth
720	Sarah	Gonzalez	sarah.gonzalez461@email.com	-8559.0	7631 Main St	33182.0	1970-01-01	1970-01-01	San Diego
721	Ashley	Garcia	ashley.garcia504@email.com	-6896.0	6474 First St	84560.0	1970-01-01	1970-01-01	Jacksonville
722	Michelle	Moore	michelle.moore586@email.com	-4727.0	1013 First St	74840.0	1970-01-01	1970-01-01	Dallas
723	Kimberly	Lopez	kimberly.lopez785@email.com	-2824.0	9774 Main St	58026.0	1970-01-01	1970-01-01	New York
724	Charles	Smith	charles.smith784@email.com	-8423.0	7114 Park Rd	63992.0	1970-01-01	1970-01-01	Los Angeles
725	Jane	Davis	jane.davis254@email.com	-7215.0	1491 Main St	25003.0	1970-01-01	1970-01-01	San Jose
726	Emily	Smith	emily.smith552@email.com	-9121.0	7021 Second Ave	65203.0	1970-01-01	1970-01-01	Austin
727	John	Thomas	john.thomas603@email.com	-7733.0	6494 Park Rd	22809.0	1970-01-01	1970-01-01	San Jose
728	Sarah	Miller	sarah.miller345@email.com	-7784.0	5007 Park Rd	36444.0	1970-01-01	1970-01-01	Chicago
729	Michael	Moore	michael.moore220@email.com	-2542.0	9496 First St	91863.0	1970-01-01	1970-01-01	Phoenix
730	Charles	Brown	charles.brown607@email.com	-2924.0	8800 First St	37490.0	1970-01-01	1970-01-01	San Jose
731	Michael	Martinez	michael.martinez517@email.com	-9421.0	8946 Park Rd	64304.0	1970-01-01	1970-01-01	Austin
732	Daniel	Martin	daniel.martin528@email.com	-11321.0	404 Second Ave	85608.0	1970-01-01	1970-01-01	Chicago
733	Chris	Anderson	chris.anderson275@email.com	-9503.0	9375 Main St	36299.0	1970-01-01	1970-01-01	Charlotte
734	Robert	Jones	robert.jones247@email.com	-7036.0	7233 First St	18444.0	1970-01-01	1970-01-01	Columbus
735	Jennifer	Rodriguez	jennifer.rodriguez844@email.com	-4784.0	9950 Oak Ave	41258.0	1970-01-01	1970-01-01	Phoenix
736	David	Miller	david.miller29@email.com	-7353.0	8052 Second Ave	65314.0	1970-01-01	1970-01-01	San Diego
737	Chris	Garcia	chris.garcia280@email.com	-5600.0	4651 Second Ave	94448.0	1970-01-01	1970-01-01	Fort Worth
738	Lisa	Smith	lisa.smith57@email.com	-7307.0	4982 Main St	57636.0	1970-01-01	1970-01-01	San Jose
739	James	Jones	james.jones242@email.com	-10093.0	2076 Second Ave	86076.0	1970-01-01	1970-01-01	Charlotte
740	Daniel	Thomas	daniel.thomas906@email.com	-3537.0	5234 Park Rd	61111.0	1970-01-01	1970-01-01	Fort Worth
741	Jennifer	Miller	jennifer.miller148@email.com	-4994.0	7300 First St	87264.0	1970-01-01	1970-01-01	Phoenix
742	Lisa	Moore	lisa.moore384@email.com	-7215.0	7043 First St	42289.0	1970-01-01	1970-01-01	Dallas
743	David	Lopez	david.lopez487@email.com	-7356.0	670 Main St	98027.0	1970-01-01	1970-01-01	New York
744	Daniel	Moore	daniel.moore394@email.com	-8114.0	2099 Second Ave	67986.0	1970-01-01	1970-01-01	Charlotte
745	John	Gonzalez	john.gonzalez950@email.com	-3246.0	3957 Park Rd	31001.0	1970-01-01	1970-01-01	Charlotte
746	Matthew	Wilson	matthew.wilson809@email.com	-2825.0	8155 First St	53610.0	1970-01-01	1970-01-01	Columbus
747	Sarah	Garcia	sarah.garcia716@email.com	-3071.0	6995 Second Ave	52830.0	1970-01-01	1970-01-01	Philadelphia
748	John	Johnson	john.johnson657@email.com	-9307.0	2329 Main St	36224.0	1970-01-01	1970-01-01	Fort Worth
749	Matthew	Jackson	matthew.jackson85@email.com	-5562.0	2231 Second Ave	63780.0	1970-01-01	1970-01-01	Dallas
750	Robert	Thomas	robert.thomas895@email.com	-6357.0	9816 Park Rd	36039.0	1970-01-01	1970-01-01	Chicago
751	Jennifer	Lopez	jennifer.lopez187@email.com	-8680.0	9445 Oak Ave	13010.0	1970-01-01	1970-01-01	Columbus
752	Kimberly	Davis	kimberly.davis929@email.com	-5011.0	2864 Main St	91003.0	1970-01-01	1970-01-01	Phoenix
753	Kimberly	Rodriguez	kimberly.rodriguez153@email.com	-4453.0	2022 Main St	67037.0	1970-01-01	1970-01-01	San Jose
754	Lisa	Brown	lisa.brown230@email.com	-5258.0	4461 Park Rd	60079.0	1970-01-01	1970-01-01	Columbus
755	Jennifer	Miller	jennifer.miller615@email.com	-6898.0	3202 First St	63546.0	1970-01-01	1970-01-01	Jacksonville
756	John	Martinez	john.martinez269@email.com	-9460.0	4168 Park Rd	99688.0	1970-01-01	1970-01-01	Charlotte
757	Michael	Smith	michael.smith481@email.com	-7523.0	6613 Oak Ave	60265.0	1970-01-01	1970-01-01	Jacksonville
758	Kimberly	Rodriguez	kimberly.rodriguez75@email.com	-2828.0	5553 Oak Ave	56439.0	1970-01-01	1970-01-01	New York
759	John	Rodriguez	john.rodriguez517@email.com	-7179.0	6176 Oak Ave	15390.0	1970-01-01	1970-01-01	San Antonio
760	Daniel	Garcia	daniel.garcia516@email.com	-9719.0	1568 Park Rd	79523.0	1970-01-01	1970-01-01	Chicago
761	David	Rodriguez	david.rodriguez120@email.com	-3659.0	4703 Park Rd	47083.0	1970-01-01	1970-01-01	San Diego
762	Kimberly	Rodriguez	kimberly.rodriguez530@email.com	-4668.0	8149 Oak Ave	96169.0	1970-01-01	1970-01-01	Philadelphia
763	Jane	Miller	jane.miller153@email.com	-4489.0	7804 Park Rd	71228.0	1970-01-01	1970-01-01	New York
764	Sarah	Thomas	sarah.thomas42@email.com	-9965.0	8177 Main St	26207.0	1970-01-01	1970-01-01	San Diego
765	Michael	Miller	michael.miller890@email.com	-4430.0	8435 Park Rd	96918.0	1970-01-01	1970-01-01	Jacksonville
766	Charles	Smith	charles.smith539@email.com	-5526.0	1358 Oak Ave	98723.0	1970-01-01	1970-01-01	San Antonio
767	Matthew	Smith	matthew.smith292@email.com	-4590.0	6220 Second Ave	52406.0	1970-01-01	1970-01-01	San Antonio
768	John	Williams	john.williams472@email.com	-10634.0	4512 Second Ave	10760.0	1970-01-01	1970-01-01	San Diego
769	Jane	Martin	jane.martin974@email.com	-4112.0	897 Park Rd	17279.0	1970-01-01	1970-01-01	Houston
770	Michelle	Martin	michelle.martin391@email.com	-5881.0	4033 First St	12688.0	1970-01-01	1970-01-01	Chicago
771	Emily	Gonzalez	emily.gonzalez799@email.com	-4427.0	4991 First St	50645.0	1970-01-01	1970-01-01	Los Angeles
772	Amanda	Brown	amanda.brown853@email.com	-5373.0	7398 First St	45190.0	1970-01-01	1970-01-01	San Diego
773	Kimberly	Wilson	kimberly.wilson93@email.com	-8438.0	3153 First St	65838.0	1970-01-01	1970-01-01	San Jose
774	Jane	Taylor	jane.taylor350@email.com	-6038.0	2640 First St	92517.0	1970-01-01	1970-01-01	Austin
775	Michael	Martinez	michael.martinez480@email.com	-9552.0	2534 Oak Ave	49375.0	1970-01-01	1970-01-01	Phoenix
776	William	Wilson	william.wilson303@email.com	-3082.0	838 Second Ave	76932.0	1970-01-01	1970-01-01	Charlotte
777	Jennifer	Brown	jennifer.brown476@email.com	-6763.0	4275 Second Ave	75987.0	1970-01-01	1970-01-01	Philadelphia
778	Sarah	Anderson	sarah.anderson184@email.com	-8628.0	1464 First St	49013.0	1970-01-01	1970-01-01	New York
779	Charles	Anderson	charles.anderson776@email.com	-6687.0	3166 Oak Ave	20252.0	1970-01-01	1970-01-01	Philadelphia
780	Sarah	Wilson	sarah.wilson548@email.com	-7692.0	317 Oak Ave	72537.0	1970-01-01	1970-01-01	Los Angeles
781	James	Martin	james.martin744@email.com	-7917.0	6571 Park Rd	26395.0	1970-01-01	1970-01-01	Jacksonville
782	John	Miller	john.miller115@email.com	-5133.0	539 Oak Ave	95016.0	1970-01-01	1970-01-01	Columbus
783	Jessica	Wilson	jessica.wilson863@email.com	-11542.0	1510 Park Rd	29420.0	1970-01-01	1970-01-01	Houston
784	Jennifer	Smith	jennifer.smith120@email.com	-8820.0	7824 Main St	86706.0	1970-01-01	1970-01-01	San Diego
785	Chris	Martinez	chris.martinez584@email.com	-9319.0	5569 Main St	92629.0	1970-01-01	1970-01-01	New York
786	Jennifer	Thomas	jennifer.thomas755@email.com	-7165.0	8087 First St	77286.0	1970-01-01	1970-01-01	New York
787	Jessica	Johnson	jessica.johnson541@email.com	-6824.0	1140 Park Rd	64675.0	1970-01-01	1970-01-01	Dallas
788	Sarah	Thomas	sarah.thomas638@email.com	-9560.0	7247 Main St	47750.0	1970-01-01	1970-01-01	Jacksonville
789	Lisa	Lopez	lisa.lopez449@email.com	-5554.0	5656 Second Ave	71402.0	1970-01-01	1970-01-01	San Jose
790	Ashley	Gonzalez	ashley.gonzalez983@email.com	-8380.0	7838 Oak Ave	37159.0	1970-01-01	1970-01-01	Fort Worth
791	Michael	Thomas	michael.thomas133@email.com	-4141.0	8163 Main St	74713.0	1970-01-01	1970-01-01	San Jose
792	Jessica	Miller	jessica.miller571@email.com	-7143.0	4373 Park Rd	30788.0	1970-01-01	1970-01-01	Charlotte
793	William	Johnson	william.johnson827@email.com	-8664.0	3814 Main St	39372.0	1970-01-01	1970-01-01	Los Angeles
794	Daniel	Hernandez	daniel.hernandez804@email.com	-3113.0	9226 Park Rd	77552.0	1970-01-01	1970-01-01	Fort Worth
795	Jane	Anderson	jane.anderson819@email.com	-4345.0	1769 Second Ave	76493.0	1970-01-01	1970-01-01	Los Angeles
796	Emily	Brown	emily.brown892@email.com	-4351.0	4886 First St	75325.0	1970-01-01	1970-01-01	Jacksonville
797	David	Lopez	david.lopez343@email.com	-4192.0	3407 First St	10863.0	1970-01-01	1970-01-01	Columbus
798	Lisa	Hernandez	lisa.hernandez294@email.com	-3287.0	6201 First St	92502.0	1970-01-01	1970-01-01	Phoenix
799	David	Taylor	david.taylor432@email.com	-4498.0	7125 First St	70129.0	1970-01-01	1970-01-01	Fort Worth
800	Amanda	Smith	amanda.smith454@email.com	-2298.0	8576 Main St	54342.0	1970-01-01	1970-01-01	Jacksonville
801	James	Garcia	james.garcia445@email.com	-2270.0	2573 Second Ave	92786.0	1970-01-01	1970-01-01	Austin
802	Ashley	Wilson	ashley.wilson412@email.com	-7599.0	5239 Park Rd	46671.0	1970-01-01	1970-01-01	Jacksonville
803	Kimberly	Jones	kimberly.jones718@email.com	-5428.0	9019 Second Ave	95463.0	1970-01-01	1970-01-01	Charlotte
804	Amanda	Gonzalez	amanda.gonzalez795@email.com	-3089.0	8905 Park Rd	26515.0	1970-01-01	1970-01-01	New York
805	Michelle	Martinez	michelle.martinez219@email.com	-6932.0	5682 Oak Ave	13655.0	1970-01-01	1970-01-01	Dallas
806	Charles	Rodriguez	charles.rodriguez248@email.com	-7822.0	7026 Second Ave	17857.0	1970-01-01	1970-01-01	Jacksonville
807	Daniel	Taylor	daniel.taylor363@email.com	-3416.0	4981 Second Ave	69394.0	1970-01-01	1970-01-01	San Diego
808	Jessica	Jackson	jessica.jackson580@email.com	-11309.0	9857 Oak Ave	49216.0	1970-01-01	1970-01-01	Columbus
809	Charles	Jones	charles.jones732@email.com	-6174.0	5471 Second Ave	35238.0	1970-01-01	1970-01-01	Los Angeles
810	Robert	Brown	robert.brown151@email.com	-9113.0	1611 Main St	27047.0	1970-01-01	1970-01-01	Los Angeles
811	Chris	Anderson	chris.anderson80@email.com	-10892.0	9737 Second Ave	61744.0	1970-01-01	1970-01-01	San Antonio
812	Charles	Thomas	charles.thomas652@email.com	-10102.0	6930 Oak Ave	76294.0	1970-01-01	1970-01-01	Jacksonville
813	Lisa	Anderson	lisa.anderson133@email.com	-11114.0	3583 First St	14273.0	1970-01-01	1970-01-01	Los Angeles
814	Michelle	Lopez	michelle.lopez944@email.com	-8630.0	2080 Park Rd	47957.0	1970-01-01	1970-01-01	Los Angeles
815	William	Jones	william.jones121@email.com	-8026.0	4916 First St	28726.0	1970-01-01	1970-01-01	Phoenix
816	Charles	Wilson	charles.wilson50@email.com	-5333.0	8108 Main St	81766.0	1970-01-01	1970-01-01	Chicago
817	Michael	Johnson	michael.johnson428@email.com	-7351.0	7511 Park Rd	72289.0	1970-01-01	1970-01-01	San Jose
818	David	Taylor	david.taylor652@email.com	-9820.0	7457 Oak Ave	21706.0	1970-01-01	1970-01-01	Austin
819	James	Davis	james.davis922@email.com	-10813.0	7359 Park Rd	21603.0	1970-01-01	1970-01-01	New York
820	John	Jackson	john.jackson646@email.com	-7864.0	2128 Second Ave	35221.0	1970-01-01	1970-01-01	Dallas
821	Charles	Johnson	charles.johnson981@email.com	-5419.0	7896 Second Ave	25765.0	1970-01-01	1970-01-01	Fort Worth
822	Emily	Smith	emily.smith282@email.com	-6232.0	9595 First St	79932.0	1970-01-01	1970-01-01	Columbus
823	James	Jackson	james.jackson47@email.com	-2965.0	7260 Oak Ave	13153.0	1970-01-01	1970-01-01	Philadelphia
824	Matthew	Gonzalez	matthew.gonzalez264@email.com	-3036.0	2855 Park Rd	33942.0	1970-01-01	1970-01-01	Dallas
825	Michael	Jones	michael.jones315@email.com	-5082.0	5429 Oak Ave	17667.0	1970-01-01	1970-01-01	New York
826	James	Brown	james.brown328@email.com	-7077.0	6252 Main St	36549.0	1970-01-01	1970-01-01	Phoenix
827	Kimberly	Jackson	kimberly.jackson243@email.com	-10487.0	1985 Park Rd	51724.0	1970-01-01	1970-01-01	San Antonio
828	Michelle	Wilson	michelle.wilson68@email.com	-8399.0	3929 Main St	82623.0	1970-01-01	1970-01-01	Austin
829	Jessica	Moore	jessica.moore668@email.com	-7121.0	6764 First St	93335.0	1970-01-01	1970-01-01	San Jose
830	Chris	Jones	chris.jones383@email.com	-5940.0	7042 Second Ave	15477.0	1970-01-01	1970-01-01	Dallas
831	Robert	Martin	robert.martin297@email.com	-2046.0	8000 Park Rd	42884.0	1970-01-01	1970-01-01	New York
832	Amanda	Miller	amanda.miller600@email.com	-7190.0	2744 Second Ave	19166.0	1970-01-01	1970-01-01	New York
833	Michael	Gonzalez	michael.gonzalez716@email.com	-4462.0	9217 Park Rd	37636.0	1970-01-01	1970-01-01	Jacksonville
834	Matthew	Hernandez	matthew.hernandez651@email.com	-9653.0	4129 Park Rd	37606.0	1970-01-01	1970-01-01	Phoenix
835	Kimberly	Hernandez	kimberly.hernandez17@email.com	-2076.0	7907 Main St	98172.0	1970-01-01	1970-01-01	San Jose
836	Jennifer	Moore	jennifer.moore917@email.com	-10643.0	6535 Second Ave	95078.0	1970-01-01	1970-01-01	Fort Worth
837	Michelle	Smith	michelle.smith914@email.com	-10179.0	2122 Park Rd	88815.0	1970-01-01	1970-01-01	Austin
838	James	Garcia	james.garcia860@email.com	-2954.0	7680 Park Rd	68271.0	1970-01-01	1970-01-01	Los Angeles
839	Jessica	Smith	jessica.smith777@email.com	-8044.0	1574 Second Ave	49738.0	1970-01-01	1970-01-01	Houston
840	Jessica	Thomas	jessica.thomas991@email.com	-6206.0	3525 Main St	93681.0	1970-01-01	1970-01-01	San Diego
841	Sarah	Rodriguez	sarah.rodriguez583@email.com	-5009.0	3274 Second Ave	99441.0	1970-01-01	1970-01-01	Dallas
842	Emily	Williams	emily.williams603@email.com	-3158.0	4353 Second Ave	78561.0	1970-01-01	1970-01-01	Chicago
843	Chris	Smith	chris.smith994@email.com	-11333.0	4243 Second Ave	10256.0	1970-01-01	1970-01-01	San Jose
844	Jane	Hernandez	jane.hernandez443@email.com	-6968.0	8591 First St	57378.0	1970-01-01	1970-01-01	Los Angeles
845	Jane	Davis	jane.davis49@email.com	-10636.0	5281 Main St	35507.0	1970-01-01	1970-01-01	San Diego
846	Michael	Jackson	michael.jackson828@email.com	-5675.0	7043 Main St	35805.0	1970-01-01	1970-01-01	Jacksonville
847	Matthew	Martinez	matthew.martinez65@email.com	-4064.0	7963 First St	87664.0	1970-01-01	1970-01-01	New York
848	Daniel	Davis	daniel.davis111@email.com	-7510.0	991 Park Rd	41030.0	1970-01-01	1970-01-01	Columbus
849	Kimberly	Martin	kimberly.martin450@email.com	-9392.0	2145 Main St	14370.0	1970-01-01	1970-01-01	San Jose
850	Matthew	Williams	matthew.williams802@email.com	-8632.0	5039 Second Ave	66602.0	1970-01-01	1970-01-01	New York
851	Sarah	Johnson	sarah.johnson573@email.com	-7802.0	1670 Second Ave	40554.0	1970-01-01	1970-01-01	San Antonio
852	Robert	Gonzalez	robert.gonzalez476@email.com	-4110.0	525 First St	53017.0	1970-01-01	1970-01-01	Philadelphia
853	Sarah	Brown	sarah.brown13@email.com	-3644.0	3272 Second Ave	93540.0	1970-01-01	1970-01-01	San Jose
854	Daniel	Lopez	daniel.lopez432@email.com	-9717.0	4083 Oak Ave	17928.0	1970-01-01	1970-01-01	Chicago
855	Ashley	Jackson	ashley.jackson447@email.com	-8252.0	9662 Second Ave	29321.0	1970-01-01	1970-01-01	Phoenix
856	Ashley	Martin	ashley.martin352@email.com	-2006.0	9708 Oak Ave	41114.0	1970-01-01	1970-01-01	Dallas
857	Michelle	Johnson	michelle.johnson433@email.com	-5033.0	3397 Main St	34819.0	1970-01-01	1970-01-01	Austin
858	Robert	Martin	robert.martin710@email.com	-7909.0	5009 First St	31270.0	1970-01-01	1970-01-01	San Jose
859	Robert	Johnson	robert.johnson508@email.com	-5080.0	3872 First St	37936.0	1970-01-01	1970-01-01	Jacksonville
860	Lisa	Hernandez	lisa.hernandez827@email.com	-5703.0	3118 Main St	11296.0	1970-01-01	1970-01-01	San Antonio
861	Amanda	Smith	amanda.smith569@email.com	-6221.0	3285 Second Ave	15754.0	1970-01-01	1970-01-01	San Diego
862	Chris	Miller	chris.miller291@email.com	-5893.0	2955 Park Rd	42239.0	1970-01-01	1970-01-01	Jacksonville
863	Chris	Smith	chris.smith181@email.com	-3987.0	2348 First St	24544.0	1970-01-01	1970-01-01	New York
864	Chris	Martinez	chris.martinez468@email.com	-7922.0	2907 Second Ave	66848.0	1970-01-01	1970-01-01	Austin
865	Sarah	Jones	sarah.jones904@email.com	-5252.0	8825 First St	59054.0	1970-01-01	1970-01-01	Houston
866	Kimberly	Wilson	kimberly.wilson652@email.com	-4594.0	8873 Park Rd	52949.0	1970-01-01	1970-01-01	Columbus
867	Jane	Rodriguez	jane.rodriguez894@email.com	-10526.0	8111 Oak Ave	71691.0	1970-01-01	1970-01-01	San Jose
868	Emily	Taylor	emily.taylor398@email.com	-10970.0	8268 Second Ave	33461.0	1970-01-01	1970-01-01	Philadelphia
869	Amanda	Taylor	amanda.taylor712@email.com	-10531.0	4496 Second Ave	93637.0	1970-01-01	1970-01-01	San Diego
870	Chris	Davis	chris.davis917@email.com	-5708.0	3681 Park Rd	59425.0	1970-01-01	1970-01-01	San Antonio
871	Emily	Lopez	emily.lopez261@email.com	-4048.0	1476 Park Rd	78002.0	1970-01-01	1970-01-01	Fort Worth
872	Jessica	Jackson	jessica.jackson43@email.com	-7710.0	7491 First St	63602.0	1970-01-01	1970-01-01	San Antonio
873	Lisa	Hernandez	lisa.hernandez280@email.com	-4557.0	3930 Park Rd	19946.0	1970-01-01	1970-01-01	San Diego
874	Michael	Martinez	michael.martinez863@email.com	-11193.0	1380 Park Rd	22898.0	1970-01-01	1970-01-01	Austin
875	Michael	Lopez	michael.lopez40@email.com	-7431.0	5494 Park Rd	99592.0	1970-01-01	1970-01-01	Houston
876	Chris	Martin	chris.martin142@email.com	-11742.0	4378 Main St	46942.0	1970-01-01	1970-01-01	Charlotte
877	James	Gonzalez	james.gonzalez842@email.com	-2761.0	8499 Oak Ave	39829.0	1970-01-01	1970-01-01	San Diego
878	Chris	Thomas	chris.thomas240@email.com	-10007.0	7659 Park Rd	51035.0	1970-01-01	1970-01-01	Jacksonville
879	Jennifer	Wilson	jennifer.wilson215@email.com	-2601.0	2376 Second Ave	50051.0	1970-01-01	1970-01-01	Philadelphia
880	Lisa	Lopez	lisa.lopez348@email.com	-8832.0	6708 Second Ave	52739.0	1970-01-01	1970-01-01	Austin
881	Charles	Johnson	charles.johnson945@email.com	-6908.0	9979 Second Ave	61234.0	1970-01-01	1970-01-01	San Jose
882	Chris	Gonzalez	chris.gonzalez66@email.com	-5226.0	1879 Park Rd	69183.0	1970-01-01	1970-01-01	San Diego
883	Michael	Garcia	michael.garcia107@email.com	-5366.0	9985 First St	34470.0	1970-01-01	1970-01-01	New York
884	Michael	Gonzalez	michael.gonzalez291@email.com	-6416.0	8691 Main St	17530.0	1970-01-01	1970-01-01	Austin
885	William	Smith	william.smith176@email.com	-9144.0	2672 Main St	80313.0	1970-01-01	1970-01-01	San Antonio
886	Lisa	Williams	lisa.williams399@email.com	-4424.0	3469 Park Rd	97135.0	1970-01-01	1970-01-01	Columbus
887	Emily	Martin	emily.martin589@email.com	-5442.0	7619 Park Rd	10975.0	1970-01-01	1970-01-01	Dallas
888	Robert	Williams	robert.williams845@email.com	-6270.0	5488 Second Ave	70319.0	1970-01-01	1970-01-01	Dallas
889	Charles	Johnson	charles.johnson755@email.com	-9062.0	4973 First St	32954.0	1970-01-01	1970-01-01	Philadelphia
890	Jessica	Garcia	jessica.garcia922@email.com	-9660.0	6402 Oak Ave	84529.0	1970-01-01	1970-01-01	San Diego
891	James	Johnson	james.johnson246@email.com	-6736.0	8910 Park Rd	18748.0	1970-01-01	1970-01-01	Charlotte
892	Lisa	Wilson	lisa.wilson781@email.com	-7930.0	1823 Second Ave	63752.0	1970-01-01	1970-01-01	Los Angeles
893	Emily	Rodriguez	emily.rodriguez213@email.com	-9334.0	1299 First St	55043.0	1970-01-01	1970-01-01	New York
894	Chris	Gonzalez	chris.gonzalez39@email.com	-3343.0	2336 Park Rd	70849.0	1970-01-01	1970-01-01	Jacksonville
895	Robert	Williams	robert.williams85@email.com	-6401.0	7271 Oak Ave	46587.0	1970-01-01	1970-01-01	Jacksonville
896	Emily	Smith	emily.smith622@email.com	-6301.0	8859 First St	20169.0	1970-01-01	1970-01-01	Los Angeles
897	Daniel	Jones	daniel.jones452@email.com	-5296.0	664 Second Ave	67941.0	1970-01-01	1970-01-01	Jacksonville
898	William	Brown	william.brown400@email.com	-9494.0	9900 Main St	59465.0	1970-01-01	1970-01-01	New York
899	Jessica	Lopez	jessica.lopez931@email.com	-3144.0	7008 Main St	54186.0	1970-01-01	1970-01-01	New York
900	Michael	Davis	michael.davis982@email.com	-4863.0	2836 Main St	77174.0	1970-01-01	1970-01-01	Jacksonville
901	Matthew	Hernandez	matthew.hernandez576@email.com	-5427.0	8975 First St	25834.0	1970-01-01	1970-01-01	Charlotte
902	Chris	Brown	chris.brown366@email.com	-1952.0	5281 Main St	37887.0	1970-01-01	1970-01-01	San Antonio
903	Jessica	Williams	jessica.williams674@email.com	-8363.0	1203 Oak Ave	49522.0	1970-01-01	1970-01-01	New York
904	Sarah	Moore	sarah.moore811@email.com	-5460.0	1652 Second Ave	92689.0	1970-01-01	1970-01-01	Phoenix
905	David	Hernandez	david.hernandez180@email.com	-7837.0	7999 Main St	12313.0	1970-01-01	1970-01-01	Columbus
906	James	Taylor	james.taylor656@email.com	-10444.0	317 Oak Ave	90786.0	1970-01-01	1970-01-01	San Jose
907	Ashley	Davis	ashley.davis756@email.com	-6402.0	1400 Main St	59089.0	1970-01-01	1970-01-01	San Jose
908	Ashley	Miller	ashley.miller156@email.com	-2413.0	9898 First St	27598.0	1970-01-01	1970-01-01	Houston
909	Matthew	Johnson	matthew.johnson534@email.com	-7159.0	488 Oak Ave	54922.0	1970-01-01	1970-01-01	Fort Worth
910	Chris	Moore	chris.moore56@email.com	-5777.0	6350 Second Ave	34057.0	1970-01-01	1970-01-01	San Jose
911	John	Williams	john.williams891@email.com	-4926.0	2418 Oak Ave	22027.0	1970-01-01	1970-01-01	New York
912	Charles	Moore	charles.moore852@email.com	-6093.0	1380 First St	50824.0	1970-01-01	1970-01-01	Dallas
913	Chris	Davis	chris.davis435@email.com	-6078.0	4775 Second Ave	93309.0	1970-01-01	1970-01-01	Phoenix
914	Daniel	Thomas	daniel.thomas82@email.com	-8162.0	7812 First St	76229.0	1970-01-01	1970-01-01	Chicago
915	David	Thomas	david.thomas21@email.com	-9371.0	1463 Park Rd	80411.0	1970-01-01	1970-01-01	Columbus
916	Michelle	Garcia	michelle.garcia264@email.com	-7073.0	4740 First St	89432.0	1970-01-01	1970-01-01	San Diego
917	Michael	Hernandez	michael.hernandez140@email.com	-5617.0	3206 Main St	75627.0	1970-01-01	1970-01-01	Chicago
918	Lisa	Gonzalez	lisa.gonzalez948@email.com	-8141.0	8120 Park Rd	87110.0	1970-01-01	1970-01-01	San Antonio
919	Jennifer	Johnson	jennifer.johnson944@email.com	-4380.0	7248 Park Rd	76795.0	1970-01-01	1970-01-01	Houston
920	Amanda	Johnson	amanda.johnson667@email.com	-6070.0	7927 Main St	92700.0	1970-01-01	1970-01-01	Houston
921	David	Rodriguez	david.rodriguez620@email.com	-4776.0	4153 Second Ave	96848.0	1970-01-01	1970-01-01	Phoenix
922	John	Brown	john.brown790@email.com	-8249.0	9703 Main St	34749.0	1970-01-01	1970-01-01	San Antonio
923	Emily	Wilson	emily.wilson259@email.com	-10418.0	6371 Second Ave	63950.0	1970-01-01	1970-01-01	Dallas
924	Sarah	Jackson	sarah.jackson796@email.com	-4705.0	3532 First St	50383.0	1970-01-01	1970-01-01	Phoenix
925	Emily	Thomas	emily.thomas2@email.com	-8214.0	6929 Park Rd	32365.0	1970-01-01	1970-01-01	Dallas
926	Amanda	Garcia	amanda.garcia721@email.com	-9508.0	8334 Main St	84329.0	1970-01-01	1970-01-01	Chicago
927	Emily	Miller	emily.miller61@email.com	-5296.0	6797 First St	91844.0	1970-01-01	1970-01-01	Phoenix
928	Emily	Williams	emily.williams301@email.com	-3714.0	1152 Park Rd	86761.0	1970-01-01	1970-01-01	Phoenix
929	Lisa	Thomas	lisa.thomas689@email.com	-2235.0	4459 Main St	86342.0	1970-01-01	1970-01-01	New York
930	Sarah	Miller	sarah.miller535@email.com	-8170.0	8620 Park Rd	72027.0	1970-01-01	1970-01-01	San Jose
931	Kimberly	Wilson	kimberly.wilson345@email.com	-7896.0	4025 Park Rd	62228.0	1970-01-01	1970-01-01	Philadelphia
932	Kimberly	Johnson	kimberly.johnson999@email.com	-7867.0	1741 Main St	62665.0	1970-01-01	1970-01-01	Fort Worth
933	John	Martin	john.martin126@email.com	-7209.0	4172 Park Rd	91048.0	1970-01-01	1970-01-01	Jacksonville
934	William	Wilson	william.wilson677@email.com	-6672.0	6001 Main St	98857.0	1970-01-01	1970-01-01	New York
935	Jessica	Martin	jessica.martin497@email.com	-3697.0	7110 First St	23166.0	1970-01-01	1970-01-01	Philadelphia
936	Ashley	Martin	ashley.martin200@email.com	-10594.0	9469 Second Ave	26759.0	1970-01-01	1970-01-01	Charlotte
937	Michael	Martinez	michael.martinez853@email.com	-10097.0	7411 Main St	96853.0	1970-01-01	1970-01-01	Chicago
938	Jessica	Davis	jessica.davis217@email.com	-3609.0	7225 Main St	52795.0	1970-01-01	1970-01-01	Los Angeles
939	Daniel	Davis	daniel.davis737@email.com	-9946.0	2116 Oak Ave	93040.0	1970-01-01	1970-01-01	Charlotte
940	Michael	Hernandez	michael.hernandez893@email.com	-3076.0	5723 First St	95710.0	1970-01-01	1970-01-01	Austin
941	Jennifer	Davis	jennifer.davis229@email.com	-6349.0	1924 Main St	87620.0	1970-01-01	1970-01-01	Los Angeles
942	Sarah	Jackson	sarah.jackson377@email.com	-7336.0	9552 Main St	18111.0	1970-01-01	1970-01-01	San Antonio
943	Chris	Gonzalez	chris.gonzalez434@email.com	-8295.0	2169 Second Ave	88855.0	1970-01-01	1970-01-01	Fort Worth
944	Sarah	Gonzalez	sarah.gonzalez10@email.com	-10168.0	2470 Park Rd	75514.0	1970-01-01	1970-01-01	Philadelphia
945	David	Martin	david.martin291@email.com	-2674.0	5345 Park Rd	26182.0	1970-01-01	1970-01-01	San Jose
946	Charles	Thomas	charles.thomas647@email.com	-10377.0	6271 Main St	30014.0	1970-01-01	1970-01-01	Phoenix
947	Jessica	Johnson	jessica.johnson946@email.com	-5812.0	8087 First St	96409.0	1970-01-01	1970-01-01	Columbus
948	John	Moore	john.moore402@email.com	-9732.0	6512 First St	79185.0	1970-01-01	1970-01-01	Philadelphia
949	Ashley	Miller	ashley.miller718@email.com	-9087.0	2244 Park Rd	17094.0	1970-01-01	1970-01-01	Los Angeles
950	Robert	Garcia	robert.garcia592@email.com	-9695.0	2472 Oak Ave	35644.0	1970-01-01	1970-01-01	Phoenix
951	Amanda	Jackson	amanda.jackson105@email.com	-5115.0	7097 Oak Ave	22589.0	1970-01-01	1970-01-01	San Antonio
952	Lisa	Garcia	lisa.garcia968@email.com	-9816.0	5645 Second Ave	29473.0	1970-01-01	1970-01-01	Austin
953	Jessica	Johnson	jessica.johnson122@email.com	-9856.0	9867 Oak Ave	59200.0	1970-01-01	1970-01-01	Phoenix
954	Robert	Gonzalez	robert.gonzalez282@email.com	-9806.0	290 Main St	20831.0	1970-01-01	1970-01-01	Philadelphia
955	Lisa	Taylor	lisa.taylor231@email.com	-9678.0	1649 Second Ave	60326.0	1970-01-01	1970-01-01	Phoenix
956	Jennifer	Martinez	jennifer.martinez586@email.com	-6756.0	8906 Oak Ave	12588.0	1970-01-01	1970-01-01	Los Angeles
957	Michelle	Moore	michelle.moore803@email.com	-10576.0	8601 Second Ave	95419.0	1970-01-01	1970-01-01	Los Angeles
958	Chris	Brown	chris.brown186@email.com	-5642.0	9188 First St	26127.0	1970-01-01	1970-01-01	New York
959	David	Jackson	david.jackson212@email.com	-3470.0	4306 Main St	26346.0	1970-01-01	1970-01-01	Dallas
960	Ashley	Lopez	ashley.lopez990@email.com	-8862.0	101 Oak Ave	16051.0	1970-01-01	1970-01-01	Austin
961	Ashley	Moore	ashley.moore456@email.com	-9967.0	5227 Second Ave	89452.0	1970-01-01	1970-01-01	Jacksonville
962	William	Miller	william.miller705@email.com	-2710.0	701 Oak Ave	49283.0	1970-01-01	1970-01-01	Houston
963	David	Martin	david.martin566@email.com	-7907.0	2205 Second Ave	19746.0	1970-01-01	1970-01-01	Phoenix
964	Daniel	Rodriguez	daniel.rodriguez391@email.com	-8585.0	1464 Park Rd	65750.0	1970-01-01	1970-01-01	San Diego
965	Michelle	Miller	michelle.miller73@email.com	-7006.0	3256 Park Rd	96155.0	1970-01-01	1970-01-01	Austin
966	Kimberly	Garcia	kimberly.garcia430@email.com	-7380.0	7204 First St	89116.0	1970-01-01	1970-01-01	Fort Worth
967	Michael	Rodriguez	michael.rodriguez128@email.com	-10839.0	1180 Park Rd	21662.0	1970-01-01	1970-01-01	San Antonio
968	Matthew	Rodriguez	matthew.rodriguez150@email.com	-6603.0	261 Main St	39127.0	1970-01-01	1970-01-01	Phoenix
969	Sarah	Brown	sarah.brown180@email.com	-7505.0	8121 Main St	55731.0	1970-01-01	1970-01-01	San Jose
970	Ashley	Moore	ashley.moore278@email.com	-2707.0	5310 First St	55242.0	1970-01-01	1970-01-01	Chicago
971	Michelle	Martin	michelle.martin904@email.com	-10293.0	2190 Park Rd	77314.0	1970-01-01	1970-01-01	San Jose
972	David	Jones	david.jones388@email.com	-6913.0	6164 Oak Ave	89783.0	1970-01-01	1970-01-01	New York
973	Robert	Garcia	robert.garcia450@email.com	-10056.0	4799 Park Rd	78235.0	1970-01-01	1970-01-01	Dallas
974	Ashley	Williams	ashley.williams971@email.com	-7050.0	1576 Main St	41462.0	1970-01-01	1970-01-01	Columbus
975	Emily	Jackson	emily.jackson59@email.com	-6729.0	8174 Main St	98740.0	1970-01-01	1970-01-01	Dallas
976	David	Thomas	david.thomas510@email.com	-11149.0	2142 First St	90777.0	1970-01-01	1970-01-01	Jacksonville
977	John	Wilson	john.wilson720@email.com	-8166.0	8752 Second Ave	89609.0	1970-01-01	1970-01-01	Houston
978	Emily	Taylor	emily.taylor926@email.com	-2838.0	2284 Second Ave	16672.0	1970-01-01	1970-01-01	Philadelphia
979	Lisa	Gonzalez	lisa.gonzalez175@email.com	-7233.0	4192 Second Ave	48019.0	1970-01-01	1970-01-01	Charlotte
980	Lisa	Martinez	lisa.martinez272@email.com	-7868.0	5094 Second Ave	70693.0	1970-01-01	1970-01-01	Houston
981	Jane	Lopez	jane.lopez7@email.com	-7682.0	5898 Main St	55838.0	1970-01-01	1970-01-01	Phoenix
982	James	Lopez	james.lopez10@email.com	-9804.0	1488 Second Ave	30147.0	1970-01-01	1970-01-01	Houston
983	Sarah	Thomas	sarah.thomas8@email.com	-6243.0	7811 First St	49227.0	1970-01-01	1970-01-01	Houston
984	Jennifer	Garcia	jennifer.garcia550@email.com	-4085.0	7298 Oak Ave	56365.0	1970-01-01	1970-01-01	San Diego
985	John	Lopez	john.lopez905@email.com	-6067.0	3205 Park Rd	27521.0	1970-01-01	1970-01-01	Los Angeles
986	Jennifer	Hernandez	jennifer.hernandez923@email.com	-4655.0	4454 Main St	74103.0	1970-01-01	1970-01-01	San Diego
987	Lisa	Jones	lisa.jones333@email.com	-9301.0	6470 Oak Ave	24139.0	1970-01-01	1970-01-01	Dallas
988	David	Jones	david.jones353@email.com	-5598.0	5705 First St	11052.0	1970-01-01	1970-01-01	New York
989	Lisa	Martinez	lisa.martinez289@email.com	-8807.0	2598 Second Ave	42698.0	1970-01-01	1970-01-01	Houston
990	Sarah	Rodriguez	sarah.rodriguez718@email.com	-9165.0	7864 Main St	75841.0	1970-01-01	1970-01-01	Houston
991	Chris	Jackson	chris.jackson645@email.com	-5758.0	2267 First St	45895.0	1970-01-01	1970-01-01	Los Angeles
992	David	Wilson	david.wilson19@email.com	-3523.0	934 First St	78809.0	1970-01-01	1970-01-01	Columbus
993	Jessica	Davis	jessica.davis345@email.com	-3130.0	7097 Main St	24425.0	1970-01-01	1970-01-01	Dallas
994	Amanda	Rodriguez	amanda.rodriguez966@email.com	-9135.0	5340 Main St	15359.0	1970-01-01	1970-01-01	Houston
995	Jane	Hernandez	jane.hernandez218@email.com	-6564.0	1750 First St	43064.0	1970-01-01	1970-01-01	Charlotte
996	Amanda	Hernandez	amanda.hernandez312@email.com	-1635.0	9140 Oak Ave	57260.0	1970-01-01	1970-01-01	Austin
997	Charles	Taylor	charles.taylor620@email.com	-6343.0	9673 First St	23941.0	1970-01-01	1970-01-01	Houston
998	Kimberly	Brown	kimberly.brown43@email.com	-5589.0	7403 Main St	81641.0	1970-01-01	1970-01-01	Houston
999	Ashley	Thomas	ashley.thomas780@email.com	-4468.0	2194 Oak Ave	82154.0	1970-01-01	1970-01-01	New York
1000	Michelle	Lopez	michelle.lopez917@email.com	-3955.0	7245 Main St	64919.0	1970-01-01	1970-01-01	Charlotte
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (employee_id, first_name, last_name, email, department, "position", hire_date, salary, manager_id) FROM stdin;
1	Dan	Ford	dan.ford@company.com	Customer Service	Chat Agent	2020-09-24	42335.00	\N
2	Frank	Clark	frank.clark@company.com	Finance	Accountant	2020-09-11	102878.00	\N
3	Alice	Hall	alice.hall@company.com	Sales	Sales Manager	2018-07-18	40973.00	\N
4	Ivy	Brown	ivy.brown@company.com	HR	Recruiter	2021-07-27	117634.00	\N
5	Dan	Ford	dan.ford@company.com	HR	Recruiter	2017-11-27	73625.00	\N
6	Carol	Evans	carol.evans@company.com	Marketing	Marketing Manager	2022-11-22	97044.00	\N
7	Henry	Evans	henry.evans@company.com	Warehouse	Inventory Manager	2018-03-14	70844.00	\N
8	Eva	Jones	eva.jones@company.com	IT	IT Support	2017-10-01	39446.00	\N
9	Eva	Adams	eva.adams@company.com	Customer Service	Support Manager	2015-07-19	91984.00	\N
10	Jack	Irwin	jack.irwin@company.com	Sales	Sales Manager	2020-09-24	52788.00	\N
11	Ivy	Green	ivy.green@company.com	Warehouse	Inventory Manager	2016-05-30	94962.00	6
12	Dan	Hall	dan.hall@company.com	HR	Recruiter	2020-03-09	112816.00	4
13	Frank	Evans	frank.evans@company.com	HR	HR Manager	2022-04-29	84786.00	1
14	Carol	Brown	carol.brown@company.com	IT	Software Developer	2015-04-01	68313.00	1
15	Frank	Evans	frank.evans@company.com	Warehouse	Warehouse Worker	2018-12-21	60967.00	10
16	Bob	Green	bob.green@company.com	Warehouse	Warehouse Worker	2015-09-05	110170.00	10
17	Carol	Evans	carol.evans@company.com	HR	HR Specialist	2020-04-03	39073.00	8
18	Grace	Clark	grace.clark@company.com	IT	Software Developer	2019-01-16	48651.00	8
19	Bob	Green	bob.green@company.com	Customer Service	Customer Service Rep	2015-08-21	63522.00	3
20	Dan	Jones	dan.jones@company.com	Customer Service	Customer Service Rep	2018-05-02	67312.00	10
21	Eva	Evans	eva.evans@company.com	IT	System Administrator	2016-09-25	95283.00	9
22	Carol	Davis	carol.davis@company.com	IT	IT Support	2019-10-17	46902.00	8
23	Jack	Green	jack.green@company.com	IT	IT Support	2023-02-21	69414.00	6
24	Jack	Ford	jack.ford@company.com	HR	Recruiter	2022-12-23	116681.00	6
25	Ivy	Brown	ivy.brown@company.com	HR	Recruiter	2016-12-10	93802.00	4
26	Henry	Evans	henry.evans@company.com	Finance	Accountant	2022-08-21	53838.00	8
27	Ivy	Davis	ivy.davis@company.com	Finance	Accountant	2016-06-27	54014.00	5
28	Dan	Jones	dan.jones@company.com	Sales	Sales Representative	2017-05-04	86660.00	3
29	Bob	Hall	bob.hall@company.com	Warehouse	Inventory Manager	2019-08-01	70471.00	1
30	Eva	Adams	eva.adams@company.com	HR	HR Manager	2018-02-13	86044.00	6
31	Bob	Brown	bob.brown@company.com	Finance	Financial Analyst	2016-10-31	107408.00	7
32	Bob	Brown	bob.brown@company.com	Marketing	Content Creator	2015-03-07	80903.00	1
33	Carol	Irwin	carol.irwin@company.com	Marketing	Content Creator	2023-01-21	114049.00	3
34	Eva	Ford	eva.ford@company.com	Sales	Sales Manager	2021-08-04	81728.00	3
35	Carol	Hall	carol.hall@company.com	HR	HR Manager	2019-09-17	99273.00	8
36	Carol	Davis	carol.davis@company.com	HR	Recruiter	2022-01-03	62550.00	6
37	Dan	Davis	dan.davis@company.com	Finance	Financial Analyst	2022-03-01	94874.00	4
38	Henry	Irwin	henry.irwin@company.com	Finance	Accountant	2017-06-03	114680.00	7
39	Jack	Clark	jack.clark@company.com	HR	HR Manager	2015-11-23	80182.00	2
40	Carol	Green	carol.green@company.com	Sales	Sales Representative	2015-01-06	99188.00	8
41	Bob	Evans	bob.evans@company.com	HR	HR Specialist	2017-03-04	117317.00	5
42	Grace	Jones	grace.jones@company.com	Finance	Finance Manager	2022-06-22	85155.00	6
43	Bob	Ford	bob.ford@company.com	Marketing	Marketing Manager	2018-12-31	97443.00	4
44	Frank	Clark	frank.clark@company.com	Sales	Sales Representative	2015-01-18	108441.00	10
45	Bob	Irwin	bob.irwin@company.com	IT	Software Developer	2020-01-31	64095.00	1
46	Frank	Adams	frank.adams@company.com	Finance	Finance Manager	2020-05-04	116618.00	4
47	Henry	Hall	henry.hall@company.com	HR	HR Specialist	2017-07-21	48821.00	3
48	Dan	Evans	dan.evans@company.com	IT	IT Support	2015-12-17	75808.00	9
49	Carol	Hall	carol.hall@company.com	Customer Service	Customer Service Rep	2022-07-06	83905.00	10
50	Alice	Irwin	alice.irwin@company.com	Finance	Finance Manager	2016-09-03	88998.00	9
\.


--
-- Data for Name: inventory_movements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory_movements (movement_id, product_id, movement_type, quantity, movement_date, reference_number, notes) FROM stdin;
1	432	Stock In	10	2023-05-29	INV-000001	Stock In for BrandB Protein Bar
2	258	Stock In	130	2020-11-04	INV-000002	Stock In for BrandE Doll
3	53	Stock Out	-2	2023-02-22	INV-000003	Stock Out for Premium Coffee Beans
4	19	Return	2	2020-11-16	INV-000004	Return for Premium Tea Set
5	217	Stock In	143	2023-04-11	INV-000005	Stock In for Elite Yoga Mat
6	29	Adjustment	2	2021-01-03	INV-000006	Adjustment for BrandD Cookbook
7	186	Stock Out	-39	2023-08-10	INV-000007	Stock Out for BrandD Cookbook
8	101	Adjustment	16	2022-04-26	INV-000008	Adjustment for BrandA Jacket
9	164	Stock In	43	2021-04-25	INV-000009	Stock In for BrandB Phone Mount
10	64	Stock Out	-5	2021-11-02	INV-000010	Stock Out for BrandA Doll
11	247	Damaged	-5	2022-11-22	INV-000011	Damaged for BrandD Self-Help Book
12	316	Return	6	2020-08-23	INV-000012	Return for Deluxe Self-Help Book
13	73	Return	6	2022-07-01	INV-000013	Return for Deluxe Vacuum Cleaner
14	416	Damaged	-1	2021-02-08	INV-000014	Damaged for Basic Shampoo
15	404	Stock Out	-13	2020-01-29	INV-000015	Stock Out for Elite Self-Help Book
16	23	Damaged	-5	2023-01-07	INV-000016	Damaged for BrandC Shampoo
17	413	Stock In	121	2020-01-07	INV-000017	Stock In for Elite Craft Paper
18	179	Damaged	-3	2020-05-17	INV-000018	Damaged for Premium Running Shoes
19	68	Return	6	2020-01-25	INV-000019	Return for BrandB Boots
20	484	Stock Out	-47	2021-07-26	INV-000020	Stock Out for Standard Chocolate
21	363	Stock In	66	2020-02-19	INV-000021	Stock In for Basic Water Bottle
22	299	Stock In	123	2022-11-17	INV-000022	Stock In for Premium Craft Paper
23	289	Damaged	-4	2022-10-07	INV-000023	Damaged for Elite Laptop
24	69	Adjustment	13	2023-12-05	INV-000024	Adjustment for BrandE Tent
25	339	Return	6	2021-11-28	INV-000025	Return for Standard Running Shoes
26	424	Damaged	-3	2020-01-11	INV-000026	Damaged for Standard Smartphone
27	195	Damaged	-3	2023-03-23	INV-000027	Damaged for Elite Bedding Set
28	323	Stock In	87	2021-11-17	INV-000028	Stock In for Basic Speaker
29	177	Stock In	85	2023-06-20	INV-000029	Stock In for Basic Tire Gauge
30	272	Return	3	2021-05-23	INV-000030	Return for Basic Tent
31	336	Return	7	2023-06-27	INV-000031	Return for Elite Tea Set
32	119	Adjustment	5	2020-09-19	INV-000032	Adjustment for BrandA Bedding Set
33	364	Return	3	2022-10-24	INV-000033	Return for BrandD Hat
34	364	Return	6	2020-08-01	INV-000034	Return for BrandD Hat
35	486	Damaged	-1	2021-08-12	INV-000035	Damaged for Basic Glue Set
36	12	Stock Out	-3	2021-09-23	INV-000036	Stock Out for BrandE T-Shirt
37	427	Stock Out	-42	2023-02-07	INV-000037	Stock Out for BrandC Boots
38	366	Adjustment	0	2020-04-04	INV-000038	Adjustment for Premium Coffee Maker
39	30	Adjustment	5	2020-10-26	INV-000039	Adjustment for BrandA Vitamins
40	453	Stock In	134	2022-03-01	INV-000040	Stock In for Standard Craft Paper
41	358	Adjustment	-8	2021-08-28	INV-000041	Adjustment for BrandA Toy Car
42	464	Damaged	-2	2023-03-21	INV-000042	Damaged for BrandC Tire Gauge
43	468	Adjustment	-14	2022-05-21	INV-000043	Adjustment for Deluxe Tablet
44	416	Return	8	2021-06-09	INV-000044	Return for Basic Shampoo
45	12	Stock In	123	2023-02-12	INV-000045	Stock In for BrandE T-Shirt
46	138	Damaged	-4	2023-02-28	INV-000046	Damaged for BrandE Board Game
47	139	Damaged	-3	2022-12-27	INV-000047	Damaged for BrandB Coffee Beans
48	415	Adjustment	8	2021-07-08	INV-000048	Adjustment for Deluxe Fiction Novel
49	258	Damaged	-1	2020-06-25	INV-000049	Damaged for BrandE Doll
50	191	Stock In	111	2023-08-15	INV-000050	Stock In for BrandE Glue Set
51	44	Return	8	2023-08-05	INV-000051	Return for BrandD Tablet
52	436	Stock Out	-28	2021-08-16	INV-000052	Stock Out for BrandE Paint Set
53	500	Stock In	139	2022-07-05	INV-000053	Stock In for Elite Plant Pot
54	470	Damaged	-2	2023-08-30	INV-000054	Damaged for BrandD Fiction Novel
55	139	Damaged	-4	2023-01-06	INV-000055	Damaged for BrandB Coffee Beans
56	225	Damaged	-3	2021-03-19	INV-000056	Damaged for Deluxe Car Mat
57	162	Return	8	2020-04-17	INV-000057	Return for BrandE Glue Set
58	478	Stock In	50	2021-07-24	INV-000058	Stock In for BrandA Air Freshener
59	25	Damaged	-2	2020-08-12	INV-000059	Damaged for Basic Glue Set
60	5	Return	5	2021-12-30	INV-000060	Return for BrandD Dress
61	200	Damaged	-5	2020-10-28	INV-000061	Damaged for Basic Car Mat
62	190	Adjustment	-5	2022-06-17	INV-000062	Adjustment for Basic Fiction Novel
63	157	Damaged	-1	2021-07-07	INV-000063	Damaged for BrandC Bicycle
64	499	Return	1	2021-08-22	INV-000064	Return for Premium Biography
65	375	Stock In	133	2023-07-10	INV-000065	Stock In for BrandC Doll
66	171	Damaged	-2	2022-03-07	INV-000066	Damaged for BrandC Jacket
67	205	Adjustment	-16	2022-11-08	INV-000067	Adjustment for Basic Protein Bar
68	388	Return	6	2022-03-17	INV-000068	Return for Standard Fiction Novel
69	203	Damaged	-2	2022-06-03	INV-000069	Damaged for Premium Laptop
70	321	Damaged	-2	2020-04-12	INV-000070	Damaged for BrandA Coffee Beans
71	111	Stock Out	-43	2020-11-21	INV-000071	Stock Out for Standard Perfume
72	256	Return	4	2021-12-02	INV-000072	Return for BrandA Dress
73	455	Return	2	2020-10-15	INV-000073	Return for BrandB Cookbook
74	194	Adjustment	4	2022-09-17	INV-000074	Adjustment for Standard Protein Bar
75	44	Stock Out	-5	2020-11-12	INV-000075	Stock Out for BrandD Tablet
76	371	Stock Out	-1	2020-02-25	INV-000076	Stock Out for BrandA Running Shoes
77	393	Damaged	-3	2022-07-26	INV-000077	Damaged for BrandE Action Figure
78	267	Damaged	-5	2021-12-15	INV-000078	Damaged for BrandB Vacuum Cleaner
79	185	Damaged	-1	2022-01-22	INV-000079	Damaged for BrandE Paint Set
80	492	Stock Out	-10	2023-12-16	INV-000080	Stock Out for Elite Tablet
81	279	Adjustment	-9	2021-11-28	INV-000081	Adjustment for BrandA Self-Help Book
82	84	Return	7	2020-02-10	INV-000082	Return for Standard Coffee Beans
83	293	Stock In	158	2023-01-10	INV-000083	Stock In for BrandA Dress
84	314	Stock In	95	2022-10-02	INV-000084	Stock In for Basic Vacuum Cleaner
85	176	Damaged	-2	2022-04-14	INV-000085	Damaged for BrandE Phone Mount
86	473	Damaged	-1	2023-11-30	INV-000086	Damaged for BrandB T-Shirt
87	138	Stock Out	-2	2021-02-18	INV-000087	Stock Out for BrandE Board Game
88	256	Adjustment	-16	2021-05-18	INV-000088	Adjustment for BrandA Dress
89	452	Return	6	2023-09-01	INV-000089	Return for Elite Shampoo
90	487	Stock Out	-9	2023-04-19	INV-000090	Stock Out for BrandB Phone Mount
91	95	Damaged	-3	2022-06-07	INV-000091	Damaged for BrandB Car Mat
92	66	Damaged	-3	2023-06-16	INV-000092	Damaged for Premium Plant Pot
93	179	Damaged	-4	2022-06-22	INV-000093	Damaged for Premium Running Shoes
94	186	Stock In	198	2022-10-17	INV-000094	Stock In for BrandD Cookbook
95	279	Stock In	119	2020-03-31	INV-000095	Stock In for BrandA Self-Help Book
96	151	Stock In	137	2021-07-11	INV-000096	Stock In for Deluxe Doll
97	456	Return	2	2021-07-23	INV-000097	Return for Deluxe Protein Bar
98	480	Stock Out	-16	2022-06-30	INV-000098	Stock Out for Basic Phone Mount
99	492	Stock In	23	2021-07-22	INV-000099	Stock In for Elite Tablet
100	30	Damaged	-1	2023-09-14	INV-000100	Damaged for BrandA Vitamins
101	19	Return	5	2021-08-04	INV-000101	Return for Premium Tea Set
102	10	Stock Out	-25	2023-02-20	INV-000102	Stock Out for Deluxe Cookbook
103	3	Return	2	2023-09-14	INV-000103	Return for Deluxe Glue Set
104	130	Return	4	2022-10-28	INV-000104	Return for BrandE Jeans
105	238	Return	7	2021-01-16	INV-000105	Return for BrandE Paint Set
106	496	Stock In	101	2022-09-05	INV-000106	Stock In for BrandC Chocolate
107	143	Return	5	2020-01-13	INV-000107	Return for Elite Bedding Set
108	212	Adjustment	-4	2022-02-06	INV-000108	Adjustment for BrandC Self-Help Book
109	224	Damaged	-4	2022-05-28	INV-000109	Damaged for Premium Sketchbook
110	104	Stock In	144	2020-11-01	INV-000110	Stock In for BrandB Air Freshener
111	437	Adjustment	14	2022-10-19	INV-000111	Adjustment for Deluxe Tea Set
112	336	Adjustment	-16	2021-07-15	INV-000112	Adjustment for Elite Tea Set
113	350	Stock Out	-32	2022-11-02	INV-000113	Stock Out for Basic Glue Set
114	427	Adjustment	-6	2023-07-09	INV-000114	Adjustment for BrandC Boots
115	408	Stock In	74	2020-08-10	INV-000115	Stock In for Deluxe Action Figure
116	484	Damaged	-5	2022-10-22	INV-000116	Damaged for Standard Chocolate
117	318	Return	3	2022-05-06	INV-000117	Return for BrandC Shampoo
118	205	Stock Out	-46	2021-06-12	INV-000118	Stock Out for Basic Protein Bar
119	259	Damaged	-2	2020-06-17	INV-000119	Damaged for Elite Vitamins
120	322	Stock Out	-9	2021-02-23	INV-000120	Stock Out for Deluxe Jeans
121	99	Stock Out	-37	2023-04-13	INV-000121	Stock Out for BrandB Protein Bar
122	204	Damaged	-2	2020-09-08	INV-000122	Damaged for Deluxe Cookbook
123	165	Adjustment	16	2020-02-18	INV-000123	Adjustment for BrandB Paint Set
124	58	Stock In	128	2023-12-01	INV-000124	Stock In for BrandE Air Freshener
125	200	Stock In	64	2020-10-10	INV-000125	Stock In for Basic Car Mat
126	422	Stock In	84	2021-07-13	INV-000126	Stock In for Elite Makeup Kit
127	227	Damaged	-3	2021-12-20	INV-000127	Damaged for BrandE Tablet
128	181	Return	8	2022-09-16	INV-000128	Return for Elite Glue Set
129	217	Stock In	103	2023-09-27	INV-000129	Stock In for Elite Yoga Mat
130	413	Adjustment	-13	2022-08-09	INV-000130	Adjustment for Elite Craft Paper
131	196	Return	7	2020-01-15	INV-000131	Return for Elite Shampoo
132	108	Adjustment	0	2022-05-05	INV-000132	Adjustment for BrandD Backpack
133	472	Damaged	-5	2021-04-17	INV-000133	Damaged for BrandC Sweater
134	284	Damaged	-1	2020-07-21	INV-000134	Damaged for BrandB Tea Set
135	314	Return	5	2022-01-28	INV-000135	Return for Basic Vacuum Cleaner
136	345	Return	7	2022-10-03	INV-000136	Return for Deluxe Tea Set
137	99	Return	7	2022-02-01	INV-000137	Return for BrandB Protein Bar
138	111	Return	7	2022-02-27	INV-000138	Return for Standard Perfume
139	380	Return	5	2022-09-11	INV-000139	Return for Standard Vitamins
140	184	Return	1	2023-02-25	INV-000140	Return for BrandA Perfume
141	184	Adjustment	-12	2020-01-18	INV-000141	Adjustment for BrandA Perfume
142	318	Damaged	-3	2023-08-05	INV-000142	Damaged for BrandC Shampoo
143	308	Stock Out	-38	2022-06-11	INV-000143	Stock Out for Standard Hat
144	209	Adjustment	1	2021-10-18	INV-000144	Adjustment for BrandE Sketchbook
145	173	Stock Out	-5	2022-10-02	INV-000145	Stock Out for BrandE Water Bottle
146	155	Adjustment	-17	2021-08-11	INV-000146	Adjustment for Elite Chocolate
147	399	Damaged	-5	2023-01-05	INV-000147	Damaged for BrandB Action Figure
148	441	Damaged	-4	2022-12-19	INV-000148	Damaged for BrandC Sneakers
149	317	Stock Out	-38	2023-02-17	INV-000149	Stock Out for Deluxe Cookbook
150	329	Damaged	-4	2020-10-21	INV-000150	Damaged for BrandA Tea Set
151	305	Return	6	2021-09-04	INV-000151	Return for BrandB Shampoo
152	381	Adjustment	-11	2020-12-07	INV-000152	Adjustment for Standard Shampoo
153	231	Stock In	120	2020-06-06	INV-000153	Stock In for Deluxe Laptop
154	433	Damaged	-3	2023-11-18	INV-000154	Damaged for BrandC Fiction Novel
155	362	Stock In	116	2023-05-28	INV-000155	Stock In for Standard Glue Set
156	82	Stock Out	-39	2023-01-03	INV-000156	Stock Out for BrandC Hat
157	185	Return	4	2023-08-14	INV-000157	Return for BrandE Paint Set
158	447	Damaged	-4	2023-11-05	INV-000158	Damaged for Basic Fiction Novel
159	434	Adjustment	-18	2020-05-06	INV-000159	Adjustment for BrandC Jeans
160	223	Return	8	2020-10-13	INV-000160	Return for BrandE Chocolate
161	395	Adjustment	6	2022-06-03	INV-000161	Adjustment for Deluxe Self-Help Book
162	432	Stock Out	-38	2020-03-17	INV-000162	Stock Out for BrandB Protein Bar
163	495	Stock Out	-11	2020-06-28	INV-000163	Stock Out for BrandE Makeup Kit
164	310	Adjustment	-5	2020-04-23	INV-000164	Adjustment for Standard Chocolate
165	237	Stock Out	-6	2023-01-19	INV-000165	Stock Out for Elite Paint Set
166	358	Stock Out	-37	2021-05-04	INV-000166	Stock Out for BrandA Toy Car
167	4	Stock Out	-2	2020-06-10	INV-000167	Stock Out for Standard Hat
168	278	Stock In	38	2022-11-07	INV-000168	Stock In for BrandD Coffee Beans
169	340	Adjustment	-19	2022-03-31	INV-000169	Adjustment for Deluxe Tea Set
170	138	Adjustment	-4	2022-10-24	INV-000170	Adjustment for BrandE Board Game
171	239	Damaged	-3	2021-12-03	INV-000171	Damaged for Elite Protein Bar
172	484	Damaged	-4	2021-10-16	INV-000172	Damaged for Standard Chocolate
173	422	Adjustment	-12	2023-11-27	INV-000173	Adjustment for Elite Makeup Kit
174	275	Adjustment	2	2020-11-10	INV-000174	Adjustment for BrandA Sneakers
175	473	Damaged	-4	2020-08-01	INV-000175	Damaged for BrandB T-Shirt
176	182	Adjustment	-16	2021-07-20	INV-000176	Adjustment for Standard Tea Set
177	457	Stock Out	-27	2023-05-31	INV-000177	Stock Out for Deluxe Fiction Novel
178	386	Return	5	2021-12-10	INV-000178	Return for BrandB Hat
179	219	Return	9	2021-03-08	INV-000179	Return for Elite Science Textbook
180	402	Adjustment	-16	2022-07-16	INV-000180	Adjustment for BrandA Toy Car
181	19	Damaged	-5	2021-02-13	INV-000181	Damaged for Premium Tea Set
182	49	Damaged	-4	2023-12-30	INV-000182	Damaged for Elite Science Textbook
183	2	Stock In	178	2021-05-09	INV-000183	Stock In for Elite Camera
184	291	Adjustment	2	2022-03-24	INV-000184	Adjustment for Basic Jacket
185	313	Return	10	2022-06-03	INV-000185	Return for Standard Water Bottle
186	234	Stock Out	-43	2021-02-20	INV-000186	Stock Out for Premium Glue Set
187	353	Damaged	-5	2021-12-28	INV-000187	Damaged for Elite Phone Mount
188	56	Damaged	-4	2023-09-22	INV-000188	Damaged for Premium Paint Set
189	61	Adjustment	-16	2022-08-08	INV-000189	Adjustment for BrandA Vitamins
190	17	Damaged	-2	2021-10-31	INV-000190	Damaged for BrandA Cookbook
191	454	Return	1	2023-11-19	INV-000191	Return for BrandD Protein Bar
192	132	Stock In	163	2023-06-12	INV-000192	Stock In for Deluxe Action Figure
193	193	Damaged	-1	2022-06-04	INV-000193	Damaged for BrandA Doll
194	222	Stock Out	-17	2022-05-19	INV-000194	Stock Out for Elite Monitor
195	348	Damaged	-3	2023-07-22	INV-000195	Damaged for Basic Protein Bar
196	166	Return	7	2023-12-12	INV-000196	Return for BrandA Coffee Beans
197	240	Stock Out	-38	2021-02-05	INV-000197	Stock Out for BrandC Perfume
198	193	Return	9	2021-08-04	INV-000198	Return for BrandA Doll
199	461	Stock Out	-28	2022-12-11	INV-000199	Stock Out for BrandB Cookbook
200	412	Adjustment	-13	2022-09-20	INV-000200	Adjustment for Premium Protein Bar
201	172	Damaged	-4	2021-01-26	INV-000201	Damaged for Premium Plant Pot
202	359	Return	8	2023-03-02	INV-000202	Return for Standard Vitamins
203	165	Damaged	-1	2020-07-04	INV-000203	Damaged for BrandB Paint Set
204	397	Stock In	43	2023-09-03	INV-000204	Stock In for BrandD Dress
205	102	Return	2	2023-05-27	INV-000205	Return for BrandC Air Freshener
206	51	Stock In	183	2023-06-24	INV-000206	Stock In for Basic Face Cream
207	223	Adjustment	-12	2020-01-19	INV-000207	Adjustment for BrandE Chocolate
208	67	Stock Out	-35	2023-09-14	INV-000208	Stock Out for Deluxe Science Textbook
209	341	Return	3	2020-07-25	INV-000209	Return for BrandC Tire Gauge
210	445	Stock Out	-8	2022-01-18	INV-000210	Stock Out for Standard Tent
211	235	Stock In	156	2020-03-25	INV-000211	Stock In for Elite Science Textbook
212	408	Adjustment	2	2022-02-22	INV-000212	Adjustment for Deluxe Action Figure
213	484	Stock Out	-20	2021-07-08	INV-000213	Stock Out for Standard Chocolate
214	355	Return	3	2020-11-04	INV-000214	Return for Standard Self-Help Book
215	339	Stock In	34	2022-03-11	INV-000215	Stock In for Standard Running Shoes
216	102	Adjustment	7	2022-04-15	INV-000216	Adjustment for BrandC Air Freshener
217	249	Stock Out	-41	2021-04-27	INV-000217	Stock Out for BrandD Coffee Beans
218	119	Damaged	-2	2023-10-20	INV-000218	Damaged for BrandA Bedding Set
219	459	Adjustment	-18	2022-12-04	INV-000219	Adjustment for Elite Coffee Maker
220	426	Stock Out	-19	2021-01-21	INV-000220	Stock Out for BrandD Protein Bar
221	22	Stock Out	-25	2020-09-19	INV-000221	Stock Out for Premium Phone Mount
222	408	Adjustment	-5	2023-10-11	INV-000222	Adjustment for Deluxe Action Figure
223	370	Damaged	-1	2021-07-20	INV-000223	Damaged for BrandD Camera
224	338	Stock In	70	2020-04-19	INV-000224	Stock In for BrandA Bedding Set
225	191	Return	6	2021-10-03	INV-000225	Return for BrandE Glue Set
226	140	Damaged	-5	2021-08-04	INV-000226	Damaged for BrandC Glue Set
227	31	Stock In	182	2021-07-14	INV-000227	Stock In for BrandC Puzzle
228	267	Stock Out	-4	2020-10-16	INV-000228	Stock Out for BrandB Vacuum Cleaner
229	19	Adjustment	13	2021-09-01	INV-000229	Adjustment for Premium Tea Set
230	252	Stock Out	-49	2021-12-10	INV-000230	Stock Out for BrandA Plant Pot
231	425	Stock In	134	2021-07-27	INV-000231	Stock In for BrandE Board Game
232	295	Adjustment	-20	2023-05-14	INV-000232	Adjustment for Basic Vitamins
233	283	Stock Out	-48	2021-05-20	INV-000233	Stock Out for BrandB Chocolate
234	90	Stock Out	-33	2020-04-20	INV-000234	Stock Out for Deluxe Phone Mount
235	375	Damaged	-5	2023-05-30	INV-000235	Damaged for BrandC Doll
236	430	Return	1	2020-10-13	INV-000236	Return for Basic Boots
237	266	Adjustment	-3	2020-01-09	INV-000237	Adjustment for Premium Coffee Maker
238	354	Adjustment	-8	2020-06-25	INV-000238	Adjustment for BrandC Headphones
239	143	Stock In	168	2020-01-25	INV-000239	Stock In for Elite Bedding Set
240	358	Return	8	2020-07-16	INV-000240	Return for BrandA Toy Car
241	67	Damaged	-2	2021-04-27	INV-000241	Damaged for Deluxe Science Textbook
242	78	Adjustment	-5	2020-09-21	INV-000242	Adjustment for BrandD Smart Watch
243	58	Return	8	2023-07-13	INV-000243	Return for BrandE Air Freshener
244	175	Stock Out	-32	2022-06-12	INV-000244	Stock Out for BrandA Headphones
245	230	Adjustment	1	2021-06-10	INV-000245	Adjustment for BrandB Paint Set
246	288	Return	7	2020-05-12	INV-000246	Return for BrandE Headphones
247	358	Return	3	2022-06-27	INV-000247	Return for BrandA Toy Car
248	302	Adjustment	10	2021-04-06	INV-000248	Adjustment for Elite Water Bottle
249	72	Adjustment	0	2021-09-26	INV-000249	Adjustment for Basic Coffee Beans
250	53	Damaged	-1	2021-08-13	INV-000250	Damaged for Premium Coffee Beans
251	277	Return	2	2021-01-03	INV-000251	Return for Elite Camera
252	320	Return	7	2022-05-26	INV-000252	Return for Elite Air Freshener
253	38	Stock In	96	2023-10-31	INV-000253	Stock In for Premium Coffee Beans
254	463	Stock Out	-38	2021-03-20	INV-000254	Stock Out for Deluxe Science Textbook
255	362	Damaged	-2	2023-05-28	INV-000255	Damaged for Standard Glue Set
256	464	Adjustment	-9	2022-08-05	INV-000256	Adjustment for BrandC Tire Gauge
257	195	Stock In	45	2020-05-21	INV-000257	Stock In for Elite Bedding Set
258	397	Adjustment	-17	2023-08-07	INV-000258	Adjustment for BrandD Dress
259	88	Stock In	63	2021-06-05	INV-000259	Stock In for Elite Protein Bar
260	74	Stock Out	-41	2021-05-26	INV-000260	Stock Out for Basic Yoga Mat
261	264	Damaged	-1	2022-06-13	INV-000261	Damaged for BrandA Plant Pot
262	263	Stock Out	-31	2023-06-21	INV-000262	Stock Out for Premium Speaker
263	324	Damaged	-5	2023-08-11	INV-000263	Damaged for BrandB Makeup Kit
264	442	Adjustment	12	2021-01-05	INV-000264	Adjustment for Elite Board Game
265	469	Adjustment	8	2022-08-27	INV-000265	Adjustment for BrandE Vitamins
266	139	Stock Out	-14	2023-12-14	INV-000266	Stock Out for BrandB Coffee Beans
267	407	Damaged	-1	2020-09-26	INV-000267	Damaged for Deluxe Backpack
268	122	Damaged	-5	2020-03-29	INV-000268	Damaged for Deluxe Water Bottle
269	10	Stock Out	-29	2020-08-17	INV-000269	Stock Out for Deluxe Cookbook
270	208	Damaged	-1	2020-10-30	INV-000270	Damaged for Deluxe Water Bottle
271	341	Return	6	2023-05-12	INV-000271	Return for BrandC Tire Gauge
272	304	Stock Out	-37	2023-11-28	INV-000272	Stock Out for BrandE Smart Watch
273	75	Adjustment	0	2022-08-04	INV-000273	Adjustment for BrandB Bedding Set
274	412	Stock In	83	2021-01-05	INV-000274	Stock In for Premium Protein Bar
275	270	Stock In	199	2020-07-02	INV-000275	Stock In for BrandD Science Textbook
276	471	Return	3	2020-12-29	INV-000276	Return for BrandD Car Mat
277	171	Stock In	190	2022-03-12	INV-000277	Stock In for BrandC Jacket
278	10	Adjustment	18	2020-06-30	INV-000278	Adjustment for Deluxe Cookbook
279	492	Stock In	10	2021-07-19	INV-000279	Stock In for Elite Tablet
280	375	Adjustment	-8	2022-03-17	INV-000280	Adjustment for BrandC Doll
281	428	Adjustment	-7	2022-03-14	INV-000281	Adjustment for BrandB Water Bottle
282	367	Adjustment	-2	2021-05-29	INV-000282	Adjustment for BrandD Air Freshener
283	145	Stock Out	-11	2023-02-27	INV-000283	Stock Out for BrandE Sneakers
284	425	Return	10	2020-07-09	INV-000284	Return for BrandE Board Game
285	6	Adjustment	-11	2020-11-16	INV-000285	Adjustment for BrandD Tea Set
286	39	Stock In	171	2020-04-25	INV-000286	Stock In for Deluxe Yoga Mat
287	280	Return	3	2020-12-04	INV-000287	Return for Premium Yoga Mat
288	120	Return	7	2022-10-21	INV-000288	Return for Standard Sketchbook
289	214	Stock Out	-21	2020-11-17	INV-000289	Stock Out for Premium Paint Set
290	69	Return	9	2020-04-06	INV-000290	Return for BrandE Tent
291	250	Damaged	-4	2023-01-21	INV-000291	Damaged for Deluxe Science Textbook
292	302	Adjustment	10	2020-08-05	INV-000292	Adjustment for Elite Water Bottle
293	139	Stock In	164	2021-03-23	INV-000293	Stock In for BrandB Coffee Beans
294	323	Stock Out	-35	2022-02-01	INV-000294	Stock Out for Basic Speaker
295	328	Stock Out	-3	2020-01-30	INV-000295	Stock Out for Elite Glue Set
296	309	Stock In	160	2020-03-29	INV-000296	Stock In for Elite Hat
297	107	Stock In	180	2022-05-16	INV-000297	Stock In for Standard Sketchbook
298	261	Stock Out	-41	2020-10-14	INV-000298	Stock Out for BrandA Vitamins
299	63	Adjustment	12	2022-05-18	INV-000299	Adjustment for BrandD Shampoo
300	221	Return	8	2021-11-08	INV-000300	Return for Basic Yoga Mat
301	229	Adjustment	5	2022-01-27	INV-000301	Adjustment for BrandA Air Freshener
302	392	Damaged	-4	2020-09-03	INV-000302	Damaged for BrandB Tea Set
303	288	Return	3	2023-02-06	INV-000303	Return for BrandE Headphones
304	18	Adjustment	9	2023-09-01	INV-000304	Adjustment for Standard Jeans
305	243	Stock In	71	2021-08-15	INV-000305	Stock In for BrandE Shampoo
306	212	Adjustment	6	2023-07-30	INV-000306	Adjustment for BrandC Self-Help Book
307	417	Stock Out	-15	2021-01-11	INV-000307	Stock Out for BrandD Paint Set
308	87	Adjustment	4	2021-12-25	INV-000308	Adjustment for BrandE Sweater
309	318	Return	9	2021-08-06	INV-000309	Return for BrandC Shampoo
310	255	Stock In	95	2021-08-30	INV-000310	Stock In for Standard Boots
311	266	Return	4	2021-11-12	INV-000311	Return for Premium Coffee Maker
312	301	Stock In	129	2021-10-02	INV-000312	Stock In for Deluxe Tablet
313	322	Return	4	2021-10-04	INV-000313	Return for Deluxe Jeans
314	314	Stock In	141	2022-01-20	INV-000314	Stock In for Basic Vacuum Cleaner
315	8	Stock In	196	2022-10-20	INV-000315	Stock In for BrandE Cookbook
316	261	Return	10	2023-10-13	INV-000316	Return for BrandA Vitamins
317	59	Return	6	2023-12-12	INV-000317	Return for Elite Plant Pot
318	113	Damaged	-3	2023-04-02	INV-000318	Damaged for BrandD Coffee Beans
319	112	Return	6	2022-04-23	INV-000319	Return for BrandE Cookbook
320	339	Stock In	20	2023-08-04	INV-000320	Stock In for Standard Running Shoes
321	215	Stock Out	-46	2021-03-24	INV-000321	Stock Out for Basic Fiction Novel
322	406	Return	6	2020-11-10	INV-000322	Return for Deluxe Craft Paper
323	202	Stock Out	-37	2022-03-20	INV-000323	Stock Out for BrandB Chocolate
324	289	Adjustment	13	2021-06-08	INV-000324	Adjustment for Elite Laptop
325	18	Stock Out	-6	2020-01-18	INV-000325	Stock Out for Standard Jeans
326	24	Damaged	-2	2021-01-11	INV-000326	Damaged for BrandC Puzzle
327	271	Stock Out	-21	2020-07-08	INV-000327	Stock Out for Standard Bicycle
328	175	Adjustment	1	2021-12-24	INV-000328	Adjustment for BrandA Headphones
329	328	Return	10	2023-07-22	INV-000329	Return for Elite Glue Set
330	107	Adjustment	-8	2022-07-17	INV-000330	Adjustment for Standard Sketchbook
331	178	Stock Out	-15	2022-09-19	INV-000331	Stock Out for Standard Coffee Maker
332	263	Return	7	2020-04-02	INV-000332	Return for Premium Speaker
333	171	Adjustment	-16	2021-08-06	INV-000333	Adjustment for BrandC Jacket
334	41	Stock Out	-28	2021-09-20	INV-000334	Stock Out for BrandE Garden Hose
335	406	Stock Out	-4	2021-01-13	INV-000335	Stock Out for Deluxe Craft Paper
336	245	Damaged	-4	2020-04-04	INV-000336	Damaged for Premium Car Mat
337	120	Damaged	-1	2021-03-27	INV-000337	Damaged for Standard Sketchbook
338	192	Return	3	2021-01-01	INV-000338	Return for Premium Sketchbook
339	482	Damaged	-5	2020-10-19	INV-000339	Damaged for Standard Sketchbook
340	488	Stock In	14	2023-06-23	INV-000340	Stock In for BrandB Air Freshener
341	402	Stock Out	-24	2023-07-31	INV-000341	Stock Out for BrandA Toy Car
342	111	Stock Out	-20	2023-10-06	INV-000342	Stock Out for Standard Perfume
343	10	Stock Out	-39	2020-11-08	INV-000343	Stock Out for Deluxe Cookbook
344	232	Stock Out	-39	2023-07-30	INV-000344	Stock Out for BrandE Puzzle
345	180	Adjustment	-18	2020-06-27	INV-000345	Adjustment for BrandE Lamp
346	107	Adjustment	16	2022-03-18	INV-000346	Adjustment for Standard Sketchbook
347	314	Stock Out	-36	2021-06-17	INV-000347	Stock Out for Basic Vacuum Cleaner
348	63	Stock In	127	2022-06-04	INV-000348	Stock In for BrandD Shampoo
349	245	Damaged	-3	2021-02-09	INV-000349	Damaged for Premium Car Mat
350	204	Damaged	-1	2023-01-22	INV-000350	Damaged for Deluxe Cookbook
351	124	Return	9	2021-03-11	INV-000351	Return for Basic Sweater
352	330	Adjustment	11	2022-04-05	INV-000352	Adjustment for Basic Doll
353	133	Return	10	2020-02-19	INV-000353	Return for BrandD Self-Help Book
354	460	Stock In	122	2022-11-01	INV-000354	Stock In for BrandB Paint Set
355	60	Stock Out	-20	2021-09-13	INV-000355	Stock Out for Standard Smartphone
356	73	Return	7	2022-03-14	INV-000356	Return for Deluxe Vacuum Cleaner
357	479	Return	10	2021-09-24	INV-000357	Return for Elite Car Mat
358	392	Damaged	-2	2022-06-02	INV-000358	Damaged for BrandB Tea Set
359	179	Stock In	184	2023-03-03	INV-000359	Stock In for Premium Running Shoes
360	451	Adjustment	-7	2022-11-26	INV-000360	Adjustment for BrandA Biography
361	191	Return	9	2020-11-21	INV-000361	Return for BrandE Glue Set
362	114	Adjustment	-19	2022-12-20	INV-000362	Adjustment for BrandB Bedding Set
363	251	Adjustment	1	2023-04-01	INV-000363	Adjustment for BrandA Dress
364	464	Stock Out	-22	2023-07-20	INV-000364	Stock Out for BrandC Tire Gauge
365	294	Return	3	2023-03-15	INV-000365	Return for BrandA Camera
366	234	Return	3	2022-02-11	INV-000366	Return for Premium Glue Set
367	11	Return	10	2020-10-26	INV-000367	Return for BrandB Perfume
368	458	Stock Out	-50	2020-10-19	INV-000368	Stock Out for Basic Boots
369	88	Adjustment	8	2020-11-21	INV-000369	Adjustment for Elite Protein Bar
370	248	Return	4	2023-07-18	INV-000370	Return for Deluxe Bicycle
371	153	Adjustment	6	2023-01-11	INV-000371	Adjustment for BrandB Tire Gauge
372	416	Damaged	-2	2022-08-27	INV-000372	Damaged for Basic Shampoo
373	114	Stock In	196	2023-10-28	INV-000373	Stock In for BrandB Bedding Set
374	474	Adjustment	9	2020-12-28	INV-000374	Adjustment for BrandD Puzzle
375	407	Stock Out	-50	2023-10-08	INV-000375	Stock Out for Deluxe Backpack
376	322	Stock Out	-17	2023-07-30	INV-000376	Stock Out for Deluxe Jeans
377	129	Adjustment	7	2022-05-02	INV-000377	Adjustment for BrandA Chocolate
378	194	Return	2	2020-04-04	INV-000378	Return for Standard Protein Bar
379	304	Adjustment	-14	2021-09-02	INV-000379	Adjustment for BrandE Smart Watch
380	239	Damaged	-4	2020-06-27	INV-000380	Damaged for Elite Protein Bar
381	254	Damaged	-1	2022-02-14	INV-000381	Damaged for Standard Chocolate
382	200	Damaged	-4	2020-12-11	INV-000382	Damaged for Basic Car Mat
383	140	Damaged	-5	2022-03-01	INV-000383	Damaged for BrandC Glue Set
384	245	Damaged	-5	2022-08-22	INV-000384	Damaged for Premium Car Mat
385	269	Damaged	-2	2021-07-10	INV-000385	Damaged for BrandA Craft Paper
386	103	Adjustment	18	2021-06-05	INV-000386	Adjustment for BrandB Tent
387	291	Stock In	72	2023-10-25	INV-000387	Stock In for Basic Jacket
388	399	Damaged	-3	2020-06-19	INV-000388	Damaged for BrandB Action Figure
389	298	Damaged	-4	2023-06-27	INV-000389	Damaged for Deluxe Plant Pot
390	377	Adjustment	6	2020-06-26	INV-000390	Adjustment for BrandA Glue Set
391	469	Stock Out	-43	2021-09-05	INV-000391	Stock Out for BrandE Vitamins
392	152	Adjustment	-17	2023-02-23	INV-000392	Adjustment for Elite Paint Set
393	386	Damaged	-2	2023-11-25	INV-000393	Damaged for BrandB Hat
394	295	Stock Out	-7	2023-01-20	INV-000394	Stock Out for Basic Vitamins
395	492	Stock Out	-35	2020-02-26	INV-000395	Stock Out for Elite Tablet
396	314	Stock In	111	2023-04-01	INV-000396	Stock In for Basic Vacuum Cleaner
397	3	Stock Out	-18	2022-08-18	INV-000397	Stock Out for Deluxe Glue Set
398	494	Return	10	2020-05-19	INV-000398	Return for BrandD Face Cream
399	78	Stock Out	-42	2021-02-20	INV-000399	Stock Out for BrandD Smart Watch
400	365	Return	8	2023-05-18	INV-000400	Return for BrandD Cookbook
401	314	Stock Out	-41	2023-06-03	INV-000401	Stock Out for Basic Vacuum Cleaner
402	330	Damaged	-1	2020-07-05	INV-000402	Damaged for Basic Doll
403	427	Stock Out	-11	2020-02-26	INV-000403	Stock Out for BrandC Boots
404	278	Stock In	108	2021-03-16	INV-000404	Stock In for BrandD Coffee Beans
405	473	Stock In	138	2022-01-21	INV-000405	Stock In for BrandB T-Shirt
406	173	Stock Out	-2	2020-01-13	INV-000406	Stock Out for BrandE Water Bottle
407	201	Stock Out	-16	2023-04-02	INV-000407	Stock Out for BrandB Shampoo
408	86	Stock In	103	2020-11-07	INV-000408	Stock In for BrandE Makeup Kit
409	341	Stock Out	-5	2021-02-03	INV-000409	Stock Out for BrandC Tire Gauge
410	263	Stock Out	-26	2023-07-28	INV-000410	Stock Out for Premium Speaker
411	480	Stock Out	-44	2020-05-16	INV-000411	Stock Out for Basic Phone Mount
412	493	Adjustment	-20	2023-04-30	INV-000412	Adjustment for BrandC Perfume
413	231	Damaged	-2	2020-06-11	INV-000413	Damaged for Deluxe Laptop
414	420	Stock Out	-32	2020-04-03	INV-000414	Stock Out for Premium Jacket
415	13	Stock Out	-16	2020-09-07	INV-000415	Stock Out for BrandD Backpack
416	413	Damaged	-5	2022-05-23	INV-000416	Damaged for Elite Craft Paper
417	114	Return	3	2020-03-12	INV-000417	Return for BrandB Bedding Set
418	76	Stock In	56	2023-06-28	INV-000418	Stock In for BrandB Tea Set
419	357	Adjustment	18	2020-02-07	INV-000419	Adjustment for BrandE Lamp
420	435	Stock Out	-7	2023-09-20	INV-000420	Stock Out for Deluxe Chocolate
421	115	Return	8	2023-07-25	INV-000421	Return for Elite Craft Paper
422	10	Adjustment	5	2023-03-24	INV-000422	Adjustment for Deluxe Cookbook
423	327	Stock In	11	2023-12-02	INV-000423	Stock In for BrandA Garden Hose
424	308	Stock In	186	2020-08-03	INV-000424	Stock In for Standard Hat
425	334	Damaged	-1	2022-08-06	INV-000425	Damaged for BrandA Chocolate
426	422	Return	6	2021-03-11	INV-000426	Return for Elite Makeup Kit
427	491	Stock Out	-19	2021-09-24	INV-000427	Stock Out for Basic Board Game
428	170	Damaged	-2	2021-06-10	INV-000428	Damaged for BrandA Tea Set
429	28	Stock Out	-33	2022-09-12	INV-000429	Stock Out for Premium Puzzle
430	447	Stock In	105	2020-05-28	INV-000430	Stock In for Basic Fiction Novel
431	468	Adjustment	-2	2022-10-06	INV-000431	Adjustment for Deluxe Tablet
432	93	Adjustment	7	2023-06-21	INV-000432	Adjustment for Deluxe Jacket
433	261	Stock In	39	2022-08-10	INV-000433	Stock In for BrandA Vitamins
434	75	Stock In	193	2023-11-14	INV-000434	Stock In for BrandB Bedding Set
435	217	Damaged	-4	2020-01-23	INV-000435	Damaged for Elite Yoga Mat
436	105	Stock Out	-31	2020-10-15	INV-000436	Stock Out for BrandB Tent
437	295	Damaged	-2	2020-03-08	INV-000437	Damaged for Basic Vitamins
438	181	Adjustment	-17	2020-04-05	INV-000438	Adjustment for Elite Glue Set
439	270	Damaged	-2	2023-09-07	INV-000439	Damaged for BrandD Science Textbook
440	215	Damaged	-1	2023-01-21	INV-000440	Damaged for Basic Fiction Novel
441	326	Stock Out	-19	2023-07-08	INV-000441	Stock Out for Premium Perfume
442	63	Damaged	-1	2021-01-01	INV-000442	Damaged for BrandD Shampoo
443	293	Stock Out	-11	2020-08-19	INV-000443	Stock Out for BrandA Dress
444	146	Return	1	2020-02-21	INV-000444	Return for BrandB Toy Car
445	205	Adjustment	18	2023-12-25	INV-000445	Adjustment for Basic Protein Bar
446	13	Stock Out	-12	2021-06-27	INV-000446	Stock Out for BrandD Backpack
447	357	Stock In	149	2021-04-23	INV-000447	Stock In for BrandE Lamp
448	345	Stock Out	-44	2021-12-18	INV-000448	Stock Out for Deluxe Tea Set
449	389	Stock Out	-46	2022-07-12	INV-000449	Stock Out for Premium Dress
450	304	Return	3	2022-01-09	INV-000450	Return for BrandE Smart Watch
451	437	Stock Out	-42	2020-03-28	INV-000451	Stock Out for Deluxe Tea Set
452	111	Stock Out	-6	2021-03-27	INV-000452	Stock Out for Standard Perfume
453	189	Stock In	35	2022-06-13	INV-000453	Stock In for BrandB Fiction Novel
454	9	Return	10	2021-12-10	INV-000454	Return for BrandE Lamp
455	209	Adjustment	-10	2022-12-19	INV-000455	Adjustment for BrandE Sketchbook
456	151	Stock Out	-11	2022-03-02	INV-000456	Stock Out for Deluxe Doll
457	186	Return	1	2020-07-26	INV-000457	Return for BrandD Cookbook
458	227	Stock In	112	2022-07-02	INV-000458	Stock In for BrandE Tablet
459	219	Damaged	-1	2020-08-19	INV-000459	Damaged for Elite Science Textbook
460	323	Return	8	2023-01-04	INV-000460	Return for Basic Speaker
461	78	Return	3	2023-05-09	INV-000461	Return for BrandD Smart Watch
462	158	Stock In	55	2021-10-17	INV-000462	Stock In for Premium Bedding Set
463	347	Stock In	95	2021-01-21	INV-000463	Stock In for Premium Phone Mount
464	113	Damaged	-4	2021-06-09	INV-000464	Damaged for BrandD Coffee Beans
465	177	Stock Out	-28	2022-06-25	INV-000465	Stock Out for Basic Tire Gauge
466	77	Stock Out	-50	2020-02-02	INV-000466	Stock Out for BrandA Glue Set
467	384	Stock Out	-11	2020-03-24	INV-000467	Stock Out for BrandC Tea Set
468	318	Damaged	-5	2021-09-04	INV-000468	Damaged for BrandC Shampoo
469	32	Stock In	133	2023-11-05	INV-000469	Stock In for Standard Tea Set
470	217	Adjustment	-7	2023-08-05	INV-000470	Adjustment for Elite Yoga Mat
471	229	Stock In	82	2023-10-11	INV-000471	Stock In for BrandA Air Freshener
472	371	Stock In	102	2021-02-08	INV-000472	Stock In for BrandA Running Shoes
473	463	Stock In	165	2022-12-04	INV-000473	Stock In for Deluxe Science Textbook
474	325	Adjustment	-16	2020-05-04	INV-000474	Adjustment for Premium Coffee Beans
475	186	Adjustment	-19	2022-07-05	INV-000475	Adjustment for BrandD Cookbook
476	298	Adjustment	0	2020-01-06	INV-000476	Adjustment for Deluxe Plant Pot
477	386	Damaged	-3	2022-10-24	INV-000477	Damaged for BrandB Hat
478	478	Adjustment	-10	2023-01-26	INV-000478	Adjustment for BrandA Air Freshener
479	291	Adjustment	6	2022-09-29	INV-000479	Adjustment for Basic Jacket
480	343	Return	1	2021-04-21	INV-000480	Return for Elite Hat
481	448	Return	9	2021-05-28	INV-000481	Return for BrandD Protein Bar
482	325	Return	8	2023-06-03	INV-000482	Return for Premium Coffee Beans
483	54	Return	1	2020-01-15	INV-000483	Return for Basic Vacuum Cleaner
484	346	Damaged	-2	2020-02-18	INV-000484	Damaged for Standard Puzzle
485	361	Return	7	2021-07-12	INV-000485	Return for Basic Board Game
486	496	Adjustment	-18	2021-11-26	INV-000486	Adjustment for BrandC Chocolate
487	169	Damaged	-2	2021-10-21	INV-000487	Damaged for BrandB Yoga Mat
488	9	Adjustment	-20	2020-06-21	INV-000488	Adjustment for BrandE Lamp
489	94	Return	3	2022-06-23	INV-000489	Return for Premium Tire Gauge
490	483	Stock Out	-30	2023-08-06	INV-000490	Stock Out for BrandE Phone Mount
491	322	Damaged	-4	2021-05-11	INV-000491	Damaged for Deluxe Jeans
492	326	Stock Out	-36	2021-01-18	INV-000492	Stock Out for Premium Perfume
493	363	Damaged	-1	2020-08-29	INV-000493	Damaged for Basic Water Bottle
494	450	Damaged	-2	2020-09-24	INV-000494	Damaged for Basic Glue Set
495	419	Stock In	102	2020-08-09	INV-000495	Stock In for Standard Camera
496	431	Stock In	50	2020-05-09	INV-000496	Stock In for Elite Smart Watch
497	207	Stock Out	-17	2020-02-26	INV-000497	Stock Out for BrandC Puzzle
498	495	Return	4	2022-02-24	INV-000498	Return for BrandE Makeup Kit
499	64	Damaged	-1	2020-05-29	INV-000499	Damaged for BrandA Doll
500	314	Damaged	-5	2020-03-21	INV-000500	Damaged for Basic Vacuum Cleaner
501	4	Adjustment	-19	2021-01-01	INV-000501	Adjustment for Standard Hat
502	19	Adjustment	-18	2022-04-01	INV-000502	Adjustment for Premium Tea Set
503	111	Adjustment	-16	2020-05-15	INV-000503	Adjustment for Standard Perfume
504	4	Return	5	2022-08-30	INV-000504	Return for Standard Hat
505	282	Stock In	194	2020-06-30	INV-000505	Stock In for BrandB Plant Pot
506	179	Return	1	2023-09-30	INV-000506	Return for Premium Running Shoes
507	445	Return	5	2023-01-12	INV-000507	Return for Standard Tent
508	170	Adjustment	8	2023-03-06	INV-000508	Adjustment for BrandA Tea Set
509	315	Return	9	2023-02-12	INV-000509	Return for Deluxe Camera
510	109	Return	4	2023-07-15	INV-000510	Return for BrandB Toy Car
511	191	Stock In	51	2021-06-05	INV-000511	Stock In for BrandE Glue Set
512	57	Stock In	124	2023-09-14	INV-000512	Stock In for BrandC Bicycle
513	113	Damaged	-1	2021-09-22	INV-000513	Damaged for BrandD Coffee Beans
514	56	Adjustment	14	2023-11-03	INV-000514	Adjustment for Premium Paint Set
515	352	Stock In	73	2023-01-15	INV-000515	Stock In for BrandD Biography
516	380	Damaged	-1	2023-03-28	INV-000516	Damaged for Standard Vitamins
517	209	Stock In	41	2020-07-23	INV-000517	Stock In for BrandE Sketchbook
518	369	Adjustment	1	2023-12-01	INV-000518	Adjustment for Deluxe Doll
519	427	Return	8	2023-11-24	INV-000519	Return for BrandC Boots
520	126	Return	8	2022-06-18	INV-000520	Return for BrandB Makeup Kit
521	251	Return	2	2023-04-11	INV-000521	Return for BrandA Dress
522	316	Adjustment	-12	2021-07-02	INV-000522	Adjustment for Deluxe Self-Help Book
523	252	Damaged	-4	2020-02-29	INV-000523	Damaged for BrandA Plant Pot
524	323	Stock In	133	2020-03-20	INV-000524	Stock In for Basic Speaker
525	85	Damaged	-2	2020-07-12	INV-000525	Damaged for BrandC Speaker
526	284	Return	7	2021-09-19	INV-000526	Return for BrandB Tea Set
527	269	Adjustment	-16	2022-09-16	INV-000527	Adjustment for BrandA Craft Paper
528	90	Return	1	2020-09-21	INV-000528	Return for Deluxe Phone Mount
529	177	Stock Out	-43	2021-02-25	INV-000529	Stock Out for Basic Tire Gauge
530	387	Damaged	-1	2021-05-30	INV-000530	Damaged for Standard Toy Car
531	268	Adjustment	-6	2021-09-17	INV-000531	Adjustment for BrandB Plant Pot
532	132	Return	9	2020-11-28	INV-000532	Return for Deluxe Action Figure
533	390	Return	8	2023-09-07	INV-000533	Return for BrandC Cookbook
534	56	Stock Out	-21	2021-01-23	INV-000534	Stock Out for Premium Paint Set
535	111	Stock Out	-4	2023-06-18	INV-000535	Stock Out for Standard Perfume
536	181	Adjustment	20	2023-04-19	INV-000536	Adjustment for Elite Glue Set
537	160	Stock Out	-35	2021-07-02	INV-000537	Stock Out for BrandD Paint Set
538	213	Damaged	-5	2023-02-11	INV-000538	Damaged for BrandB Craft Paper
539	429	Return	4	2022-01-08	INV-000539	Return for BrandA Dress
540	230	Damaged	-4	2020-12-23	INV-000540	Damaged for BrandB Paint Set
541	301	Return	3	2023-06-22	INV-000541	Return for Deluxe Tablet
542	28	Damaged	-2	2021-03-16	INV-000542	Damaged for Premium Puzzle
543	444	Adjustment	10	2023-11-02	INV-000543	Adjustment for BrandA Lamp
544	275	Stock In	51	2023-12-04	INV-000544	Stock In for BrandA Sneakers
545	296	Adjustment	-19	2023-06-08	INV-000545	Adjustment for Elite Coffee Beans
546	45	Stock Out	-37	2022-10-27	INV-000546	Stock Out for Elite Chocolate
547	87	Return	7	2021-02-04	INV-000547	Return for BrandE Sweater
548	369	Damaged	-5	2021-09-23	INV-000548	Damaged for Deluxe Doll
549	195	Return	5	2022-12-29	INV-000549	Return for Elite Bedding Set
550	104	Adjustment	-3	2020-10-04	INV-000550	Adjustment for BrandB Air Freshener
551	309	Return	4	2023-04-14	INV-000551	Return for Elite Hat
552	210	Damaged	-2	2021-10-15	INV-000552	Damaged for BrandD Jeans
553	317	Return	6	2020-09-25	INV-000553	Return for Deluxe Cookbook
554	133	Stock Out	-39	2020-06-07	INV-000554	Stock Out for BrandD Self-Help Book
555	193	Damaged	-5	2022-05-02	INV-000555	Damaged for BrandA Doll
556	324	Return	7	2020-12-06	INV-000556	Return for BrandB Makeup Kit
557	199	Stock Out	-31	2021-05-24	INV-000557	Stock Out for BrandC Self-Help Book
558	75	Adjustment	-6	2021-04-25	INV-000558	Adjustment for BrandB Bedding Set
559	401	Adjustment	-20	2022-03-10	INV-000559	Adjustment for BrandB Coffee Maker
560	445	Stock Out	-4	2020-08-01	INV-000560	Stock Out for Standard Tent
561	371	Return	7	2021-02-02	INV-000561	Return for BrandA Running Shoes
562	46	Stock Out	-18	2020-05-01	INV-000562	Stock Out for BrandD Sketchbook
563	112	Stock In	77	2023-11-16	INV-000563	Stock In for BrandE Cookbook
564	111	Stock Out	-6	2022-02-05	INV-000564	Stock Out for Standard Perfume
565	248	Return	4	2021-06-07	INV-000565	Return for Deluxe Bicycle
566	237	Adjustment	-9	2022-05-01	INV-000566	Adjustment for Elite Paint Set
567	328	Stock Out	-26	2020-12-16	INV-000567	Stock Out for Elite Glue Set
568	342	Damaged	-5	2022-05-09	INV-000568	Damaged for BrandE Vitamins
569	192	Stock Out	-14	2021-02-03	INV-000569	Stock Out for Premium Sketchbook
570	40	Adjustment	9	2020-03-06	INV-000570	Adjustment for Deluxe Coffee Beans
571	195	Adjustment	-3	2021-06-29	INV-000571	Adjustment for Elite Bedding Set
572	70	Adjustment	3	2020-08-28	INV-000572	Adjustment for Premium Jeans
573	247	Adjustment	-7	2021-07-08	INV-000573	Adjustment for BrandD Self-Help Book
574	458	Adjustment	-11	2020-06-21	INV-000574	Adjustment for Basic Boots
575	459	Stock In	36	2022-08-14	INV-000575	Stock In for Elite Coffee Maker
576	139	Adjustment	-4	2023-03-25	INV-000576	Adjustment for BrandB Coffee Beans
577	330	Adjustment	-2	2023-03-08	INV-000577	Adjustment for Basic Doll
578	307	Adjustment	10	2023-08-06	INV-000578	Adjustment for BrandD Glue Set
579	190	Adjustment	-10	2020-06-14	INV-000579	Adjustment for Basic Fiction Novel
580	187	Damaged	-5	2021-09-04	INV-000580	Damaged for Standard Air Freshener
581	260	Stock Out	-41	2021-09-06	INV-000581	Stock Out for Deluxe Glue Set
582	477	Return	4	2022-11-01	INV-000582	Return for BrandC Jeans
583	62	Stock In	103	2020-06-01	INV-000583	Stock In for Standard Chocolate
584	120	Stock Out	-40	2020-08-15	INV-000584	Stock Out for Standard Sketchbook
585	364	Stock In	114	2021-07-13	INV-000585	Stock In for BrandD Hat
586	189	Return	10	2020-12-21	INV-000586	Return for BrandB Fiction Novel
587	258	Adjustment	4	2021-08-13	INV-000587	Adjustment for BrandE Doll
588	227	Stock Out	-38	2023-05-06	INV-000588	Stock Out for BrandE Tablet
589	155	Damaged	-4	2020-12-21	INV-000589	Damaged for Elite Chocolate
590	431	Adjustment	8	2021-02-22	INV-000590	Adjustment for Elite Smart Watch
591	279	Adjustment	-7	2023-08-27	INV-000591	Adjustment for BrandA Self-Help Book
592	152	Damaged	-5	2022-12-17	INV-000592	Damaged for Elite Paint Set
593	221	Return	6	2023-08-14	INV-000593	Return for Basic Yoga Mat
594	6	Damaged	-1	2022-01-07	INV-000594	Damaged for BrandD Tea Set
595	182	Stock Out	-1	2020-05-05	INV-000595	Stock Out for Standard Tea Set
596	256	Return	6	2020-09-01	INV-000596	Return for BrandA Dress
597	291	Adjustment	3	2023-08-26	INV-000597	Adjustment for Basic Jacket
598	394	Stock In	145	2021-03-27	INV-000598	Stock In for BrandC Sneakers
599	190	Adjustment	10	2023-03-10	INV-000599	Adjustment for Basic Fiction Novel
600	299	Stock Out	-44	2021-04-25	INV-000600	Stock Out for Premium Craft Paper
601	105	Stock In	96	2022-08-11	INV-000601	Stock In for BrandB Tent
602	110	Damaged	-2	2021-06-16	INV-000602	Damaged for Premium Tire Gauge
603	321	Adjustment	-8	2020-06-05	INV-000603	Adjustment for BrandA Coffee Beans
604	106	Stock In	195	2022-10-27	INV-000604	Stock In for BrandB Hat
605	41	Stock In	45	2021-05-29	INV-000605	Stock In for BrandE Garden Hose
606	449	Return	5	2021-05-03	INV-000606	Return for Deluxe Protein Bar
607	127	Return	9	2023-08-03	INV-000607	Return for BrandC Hat
608	419	Return	3	2021-09-23	INV-000608	Return for Standard Camera
609	141	Stock Out	-48	2020-04-07	INV-000609	Stock Out for BrandB Running Shoes
610	169	Stock In	78	2023-07-18	INV-000610	Stock In for BrandB Yoga Mat
611	289	Return	1	2022-05-21	INV-000611	Return for Elite Laptop
612	313	Return	10	2022-03-08	INV-000612	Return for Standard Water Bottle
613	26	Stock In	195	2020-02-24	INV-000613	Stock In for Elite Water Bottle
614	385	Return	10	2023-07-07	INV-000614	Return for Premium Protein Bar
615	76	Return	4	2022-07-02	INV-000615	Return for BrandB Tea Set
616	99	Adjustment	18	2020-07-28	INV-000616	Adjustment for BrandB Protein Bar
617	310	Stock Out	-5	2022-11-28	INV-000617	Stock Out for Standard Chocolate
618	460	Return	10	2023-12-04	INV-000618	Return for BrandB Paint Set
619	118	Stock In	108	2021-11-23	INV-000619	Stock In for BrandA Speaker
620	82	Stock In	118	2020-06-07	INV-000620	Stock In for BrandC Hat
621	495	Adjustment	8	2020-06-20	INV-000621	Adjustment for BrandE Makeup Kit
622	319	Adjustment	17	2020-01-19	INV-000622	Adjustment for BrandB Smart Watch
623	487	Stock In	37	2020-12-03	INV-000623	Stock In for BrandB Phone Mount
624	26	Adjustment	-20	2020-10-11	INV-000624	Adjustment for Elite Water Bottle
625	298	Stock Out	-6	2022-04-30	INV-000625	Stock Out for Deluxe Plant Pot
626	331	Stock In	10	2021-06-04	INV-000626	Stock In for Basic Craft Paper
627	327	Stock In	57	2022-09-11	INV-000627	Stock In for BrandA Garden Hose
628	398	Stock Out	-36	2023-06-25	INV-000628	Stock Out for BrandB Water Bottle
629	221	Damaged	-4	2022-11-13	INV-000629	Damaged for Basic Yoga Mat
630	338	Stock Out	-41	2020-09-30	INV-000630	Stock Out for BrandA Bedding Set
631	403	Stock In	54	2020-05-03	INV-000631	Stock In for Basic Bicycle
632	402	Damaged	-4	2020-06-12	INV-000632	Damaged for BrandA Toy Car
633	110	Adjustment	19	2023-01-27	INV-000633	Adjustment for Premium Tire Gauge
634	309	Adjustment	-11	2022-01-31	INV-000634	Adjustment for Elite Hat
635	496	Stock In	128	2023-06-20	INV-000635	Stock In for BrandC Chocolate
636	493	Return	7	2023-06-19	INV-000636	Return for BrandC Perfume
637	136	Damaged	-4	2022-10-31	INV-000637	Damaged for Deluxe Sketchbook
638	181	Adjustment	-10	2020-03-07	INV-000638	Adjustment for Elite Glue Set
639	464	Stock In	175	2020-05-18	INV-000639	Stock In for BrandC Tire Gauge
640	445	Adjustment	-15	2021-07-23	INV-000640	Adjustment for Standard Tent
641	318	Adjustment	-12	2021-06-11	INV-000641	Adjustment for BrandC Shampoo
642	380	Return	1	2023-08-07	INV-000642	Return for Standard Vitamins
643	254	Return	4	2022-09-27	INV-000643	Return for Standard Chocolate
644	68	Stock Out	-16	2023-12-15	INV-000644	Stock Out for BrandB Boots
645	202	Damaged	-4	2020-05-18	INV-000645	Damaged for BrandB Chocolate
646	459	Adjustment	17	2022-01-24	INV-000646	Adjustment for Elite Coffee Maker
647	227	Stock Out	-34	2023-12-14	INV-000647	Stock Out for BrandE Tablet
648	121	Adjustment	18	2023-12-22	INV-000648	Adjustment for Standard Chocolate
649	52	Damaged	-3	2022-07-24	INV-000649	Damaged for BrandC Smartphone
650	457	Adjustment	10	2023-11-29	INV-000650	Adjustment for Deluxe Fiction Novel
651	471	Return	4	2022-09-30	INV-000651	Return for BrandD Car Mat
652	393	Damaged	-5	2020-12-15	INV-000652	Damaged for BrandE Action Figure
653	72	Damaged	-2	2020-02-28	INV-000653	Damaged for Basic Coffee Beans
654	484	Adjustment	0	2022-10-18	INV-000654	Adjustment for Standard Chocolate
655	173	Return	10	2022-08-18	INV-000655	Return for BrandE Water Bottle
656	294	Damaged	-5	2021-03-03	INV-000656	Damaged for BrandA Camera
657	66	Return	8	2022-06-08	INV-000657	Return for Premium Plant Pot
658	169	Stock In	130	2021-09-30	INV-000658	Stock In for BrandB Yoga Mat
659	422	Stock In	20	2022-01-25	INV-000659	Stock In for Elite Makeup Kit
660	372	Damaged	-2	2023-05-24	INV-000660	Damaged for BrandB Yoga Mat
661	250	Adjustment	14	2020-07-30	INV-000661	Adjustment for Deluxe Science Textbook
662	219	Adjustment	-20	2021-07-28	INV-000662	Adjustment for Elite Science Textbook
663	250	Stock Out	-37	2020-04-24	INV-000663	Stock Out for Deluxe Science Textbook
664	85	Stock Out	-22	2022-06-07	INV-000664	Stock Out for BrandC Speaker
665	247	Stock In	44	2022-12-22	INV-000665	Stock In for BrandD Self-Help Book
666	148	Adjustment	15	2023-07-19	INV-000666	Adjustment for Premium Tablet
667	400	Return	10	2023-07-19	INV-000667	Return for Elite Car Mat
668	398	Return	7	2020-01-31	INV-000668	Return for BrandB Water Bottle
669	99	Damaged	-4	2021-03-09	INV-000669	Damaged for BrandB Protein Bar
670	113	Adjustment	-1	2023-10-17	INV-000670	Adjustment for BrandD Coffee Beans
671	124	Return	7	2020-02-05	INV-000671	Return for Basic Sweater
672	430	Return	6	2020-06-16	INV-000672	Return for Basic Boots
673	416	Stock Out	-6	2020-04-26	INV-000673	Stock Out for Basic Shampoo
674	197	Stock In	138	2021-08-18	INV-000674	Stock In for Premium Jeans
675	220	Stock Out	-25	2020-12-04	INV-000675	Stock Out for Deluxe Protein Bar
676	149	Stock Out	-25	2021-09-28	INV-000676	Stock Out for BrandC Perfume
677	197	Adjustment	-14	2022-12-14	INV-000677	Adjustment for Premium Jeans
678	326	Stock In	43	2021-07-22	INV-000678	Stock In for Premium Perfume
679	233	Adjustment	17	2021-08-23	INV-000679	Adjustment for Basic Tablet
680	452	Stock In	138	2021-12-15	INV-000680	Stock In for Elite Shampoo
681	329	Damaged	-2	2021-10-20	INV-000681	Damaged for BrandA Tea Set
682	117	Return	6	2021-05-07	INV-000682	Return for BrandB Tent
683	91	Adjustment	-10	2021-07-20	INV-000683	Adjustment for BrandC Boots
684	75	Stock Out	-31	2022-07-17	INV-000684	Stock Out for BrandB Bedding Set
685	18	Damaged	-3	2020-03-18	INV-000685	Damaged for Standard Jeans
686	402	Return	7	2023-10-28	INV-000686	Return for BrandA Toy Car
687	49	Adjustment	0	2022-07-28	INV-000687	Adjustment for Elite Science Textbook
688	333	Stock Out	-32	2021-05-31	INV-000688	Stock Out for Elite Garden Hose
689	387	Damaged	-3	2020-11-12	INV-000689	Damaged for Standard Toy Car
690	203	Adjustment	-16	2020-12-15	INV-000690	Adjustment for Premium Laptop
691	318	Stock Out	-22	2023-02-02	INV-000691	Stock Out for BrandC Shampoo
692	16	Adjustment	6	2022-07-26	INV-000692	Adjustment for BrandD Board Game
693	113	Damaged	-1	2020-06-17	INV-000693	Damaged for BrandD Coffee Beans
694	17	Return	6	2020-12-13	INV-000694	Return for BrandA Cookbook
695	204	Stock Out	-31	2023-04-21	INV-000695	Stock Out for Deluxe Cookbook
696	311	Stock Out	-40	2021-07-14	INV-000696	Stock Out for Basic Laptop
697	324	Damaged	-4	2021-11-02	INV-000697	Damaged for BrandB Makeup Kit
698	472	Stock Out	-14	2023-07-02	INV-000698	Stock Out for BrandC Sweater
699	11	Return	8	2021-06-05	INV-000699	Return for BrandB Perfume
700	485	Damaged	-5	2023-06-16	INV-000700	Damaged for Elite Tea Set
701	295	Stock In	46	2020-05-03	INV-000701	Stock In for Basic Vitamins
702	367	Stock Out	-43	2022-11-24	INV-000702	Stock Out for BrandD Air Freshener
703	290	Adjustment	-3	2020-03-18	INV-000703	Adjustment for Deluxe Vacuum Cleaner
704	111	Return	1	2020-04-30	INV-000704	Return for Standard Perfume
705	187	Damaged	-3	2020-07-02	INV-000705	Damaged for Standard Air Freshener
706	189	Adjustment	16	2020-06-17	INV-000706	Adjustment for BrandB Fiction Novel
707	128	Stock Out	-19	2020-10-20	INV-000707	Stock Out for BrandA Craft Paper
708	296	Return	10	2021-10-17	INV-000708	Return for Elite Coffee Beans
709	301	Return	6	2021-03-29	INV-000709	Return for Deluxe Tablet
710	442	Damaged	-3	2020-05-21	INV-000710	Damaged for Elite Board Game
711	307	Stock Out	-44	2023-05-30	INV-000711	Stock Out for BrandD Glue Set
712	197	Return	7	2023-12-15	INV-000712	Return for Premium Jeans
713	8	Stock Out	-22	2020-11-25	INV-000713	Stock Out for BrandE Cookbook
714	471	Damaged	-3	2022-05-04	INV-000714	Damaged for BrandD Car Mat
715	489	Stock In	89	2020-09-24	INV-000715	Stock In for Premium Face Cream
716	80	Return	3	2020-02-14	INV-000716	Return for BrandC Face Cream
717	271	Adjustment	-17	2022-11-12	INV-000717	Adjustment for Standard Bicycle
718	148	Adjustment	-11	2020-02-15	INV-000718	Adjustment for Premium Tablet
719	286	Return	4	2021-02-22	INV-000719	Return for Premium Tea Set
720	125	Adjustment	6	2020-06-05	INV-000720	Adjustment for Premium Speaker
721	154	Stock In	144	2023-05-11	INV-000721	Stock In for Premium Shampoo
722	384	Return	9	2022-10-12	INV-000722	Return for BrandC Tea Set
723	343	Stock Out	-29	2020-10-21	INV-000723	Stock Out for Elite Hat
724	441	Damaged	-2	2023-08-25	INV-000724	Damaged for BrandC Sneakers
725	393	Return	6	2023-05-20	INV-000725	Return for BrandE Action Figure
726	28	Stock Out	-43	2021-03-23	INV-000726	Stock Out for Premium Puzzle
727	339	Damaged	-1	2021-08-10	INV-000727	Damaged for Standard Running Shoes
728	404	Stock In	192	2023-06-09	INV-000728	Stock In for Elite Self-Help Book
729	475	Stock In	133	2020-06-23	INV-000729	Stock In for Premium Backpack
730	93	Return	1	2021-05-17	INV-000730	Return for Deluxe Jacket
731	416	Stock Out	-48	2023-10-19	INV-000731	Stock Out for Basic Shampoo
732	225	Stock Out	-4	2022-10-30	INV-000732	Stock Out for Deluxe Car Mat
733	176	Adjustment	-2	2021-07-30	INV-000733	Adjustment for BrandE Phone Mount
734	130	Stock In	145	2023-08-24	INV-000734	Stock In for BrandE Jeans
735	58	Adjustment	-5	2022-05-09	INV-000735	Adjustment for BrandE Air Freshener
736	22	Return	1	2023-09-23	INV-000736	Return for Premium Phone Mount
737	171	Stock Out	-44	2020-02-02	INV-000737	Stock Out for BrandC Jacket
738	428	Damaged	-2	2020-06-27	INV-000738	Damaged for BrandB Water Bottle
739	106	Stock Out	-31	2023-02-07	INV-000739	Stock Out for BrandB Hat
740	185	Damaged	-1	2020-11-20	INV-000740	Damaged for BrandE Paint Set
741	22	Stock In	18	2023-04-03	INV-000741	Stock In for Premium Phone Mount
742	376	Stock Out	-27	2022-09-21	INV-000742	Stock Out for BrandE Shampoo
743	12	Return	8	2022-07-26	INV-000743	Return for BrandE T-Shirt
744	155	Return	8	2021-05-06	INV-000744	Return for Elite Chocolate
745	425	Return	6	2022-07-23	INV-000745	Return for BrandE Board Game
746	179	Return	5	2022-01-01	INV-000746	Return for Premium Running Shoes
747	451	Adjustment	-1	2021-11-08	INV-000747	Adjustment for BrandA Biography
748	137	Damaged	-1	2021-03-02	INV-000748	Damaged for Basic Running Shoes
749	440	Adjustment	12	2020-08-14	INV-000749	Adjustment for Standard Sneakers
750	280	Damaged	-3	2023-11-26	INV-000750	Damaged for Premium Yoga Mat
751	261	Adjustment	-8	2022-01-03	INV-000751	Adjustment for BrandA Vitamins
752	418	Stock In	37	2020-04-13	INV-000752	Stock In for Elite Sweater
753	175	Stock Out	-25	2023-07-02	INV-000753	Stock Out for BrandA Headphones
754	325	Stock Out	-37	2021-10-07	INV-000754	Stock Out for Premium Coffee Beans
755	376	Adjustment	-7	2021-04-26	INV-000755	Adjustment for BrandE Shampoo
756	202	Stock In	147	2023-06-20	INV-000756	Stock In for BrandB Chocolate
757	4	Stock Out	-13	2023-11-16	INV-000757	Stock Out for Standard Hat
758	93	Stock Out	-13	2023-08-29	INV-000758	Stock Out for Deluxe Jacket
759	277	Stock In	62	2022-01-17	INV-000759	Stock In for Elite Camera
760	189	Stock In	89	2023-09-03	INV-000760	Stock In for BrandB Fiction Novel
761	234	Damaged	-3	2021-11-19	INV-000761	Damaged for Premium Glue Set
762	401	Stock In	128	2020-02-16	INV-000762	Stock In for BrandB Coffee Maker
763	124	Stock Out	-25	2021-05-27	INV-000763	Stock Out for Basic Sweater
764	306	Stock In	120	2020-10-10	INV-000764	Stock In for Basic Water Bottle
765	307	Return	1	2022-02-28	INV-000765	Return for BrandD Glue Set
766	43	Return	5	2020-08-05	INV-000766	Return for Deluxe Perfume
767	19	Adjustment	20	2020-09-09	INV-000767	Adjustment for Premium Tea Set
768	306	Adjustment	-1	2022-11-04	INV-000768	Adjustment for Basic Water Bottle
769	455	Return	7	2020-11-17	INV-000769	Return for BrandB Cookbook
770	275	Stock In	117	2021-08-08	INV-000770	Stock In for BrandA Sneakers
771	189	Damaged	-2	2021-06-06	INV-000771	Damaged for BrandB Fiction Novel
772	238	Stock Out	-30	2023-11-28	INV-000772	Stock Out for BrandE Paint Set
773	295	Damaged	-4	2021-05-25	INV-000773	Damaged for Basic Vitamins
774	408	Stock In	54	2023-04-09	INV-000774	Stock In for Deluxe Action Figure
775	498	Adjustment	-17	2022-06-13	INV-000775	Adjustment for BrandE Water Bottle
776	14	Damaged	-3	2022-09-05	INV-000776	Damaged for BrandB Bedding Set
777	164	Stock Out	-23	2020-12-09	INV-000777	Stock Out for BrandB Phone Mount
778	101	Stock In	50	2021-04-13	INV-000778	Stock In for BrandA Jacket
779	335	Adjustment	12	2023-06-23	INV-000779	Adjustment for Elite Paint Set
780	125	Stock Out	-30	2022-08-04	INV-000780	Stock Out for Premium Speaker
781	324	Stock In	51	2022-02-05	INV-000781	Stock In for BrandB Makeup Kit
782	299	Damaged	-2	2023-01-04	INV-000782	Damaged for Premium Craft Paper
783	84	Adjustment	13	2023-02-19	INV-000783	Adjustment for Standard Coffee Beans
784	120	Damaged	-1	2023-04-26	INV-000784	Damaged for Standard Sketchbook
785	8	Damaged	-3	2023-05-20	INV-000785	Damaged for BrandE Cookbook
786	168	Adjustment	-15	2022-02-25	INV-000786	Adjustment for BrandB Glue Set
787	149	Adjustment	19	2023-04-07	INV-000787	Adjustment for BrandC Perfume
788	35	Stock In	190	2023-12-05	INV-000788	Stock In for Basic Cookbook
789	169	Damaged	-3	2021-10-04	INV-000789	Damaged for BrandB Yoga Mat
790	463	Return	5	2021-09-03	INV-000790	Return for Deluxe Science Textbook
791	156	Return	5	2021-10-20	INV-000791	Return for BrandB Smartphone
792	256	Stock Out	-16	2023-04-11	INV-000792	Stock Out for BrandA Dress
793	235	Stock In	17	2021-06-12	INV-000793	Stock In for Elite Science Textbook
794	105	Stock In	104	2020-12-13	INV-000794	Stock In for BrandB Tent
795	246	Adjustment	-11	2022-12-13	INV-000795	Adjustment for BrandB Tablet
796	168	Return	8	2023-01-07	INV-000796	Return for BrandB Glue Set
797	101	Adjustment	1	2021-06-07	INV-000797	Adjustment for BrandA Jacket
798	72	Return	1	2020-05-21	INV-000798	Return for Basic Coffee Beans
799	457	Damaged	-5	2022-08-20	INV-000799	Damaged for Deluxe Fiction Novel
800	212	Return	10	2023-11-08	INV-000800	Return for BrandC Self-Help Book
801	163	Adjustment	-18	2020-09-12	INV-000801	Adjustment for Premium Bedding Set
802	11	Adjustment	4	2022-07-13	INV-000802	Adjustment for BrandB Perfume
803	44	Stock In	167	2023-10-22	INV-000803	Stock In for BrandD Tablet
804	397	Stock Out	-28	2022-09-30	INV-000804	Stock Out for BrandD Dress
805	434	Stock Out	-49	2023-08-07	INV-000805	Stock Out for BrandC Jeans
806	433	Adjustment	-18	2020-09-19	INV-000806	Adjustment for BrandC Fiction Novel
807	286	Damaged	-1	2020-04-27	INV-000807	Damaged for Premium Tea Set
808	194	Adjustment	-16	2022-08-03	INV-000808	Adjustment for Standard Protein Bar
809	324	Return	1	2023-07-24	INV-000809	Return for BrandB Makeup Kit
810	153	Return	4	2021-07-06	INV-000810	Return for BrandB Tire Gauge
811	493	Return	1	2023-10-10	INV-000811	Return for BrandC Perfume
812	346	Stock Out	-7	2022-04-27	INV-000812	Stock Out for Standard Puzzle
813	95	Stock In	66	2023-09-21	INV-000813	Stock In for BrandB Car Mat
814	294	Adjustment	-20	2022-09-25	INV-000814	Adjustment for BrandA Camera
815	281	Damaged	-5	2020-09-18	INV-000815	Damaged for Elite Action Figure
816	170	Stock In	108	2021-07-03	INV-000816	Stock In for BrandA Tea Set
817	199	Adjustment	10	2021-10-24	INV-000817	Adjustment for BrandC Self-Help Book
818	134	Stock Out	-32	2021-12-08	INV-000818	Stock Out for BrandB Biography
819	367	Adjustment	-9	2022-10-26	INV-000819	Adjustment for BrandD Air Freshener
820	277	Stock Out	-9	2023-02-24	INV-000820	Stock Out for Elite Camera
821	153	Return	8	2023-11-08	INV-000821	Return for BrandB Tire Gauge
822	383	Damaged	-3	2020-07-03	INV-000822	Damaged for BrandC Craft Paper
823	42	Adjustment	-17	2022-05-16	INV-000823	Adjustment for Basic Vitamins
824	173	Return	9	2022-11-06	INV-000824	Return for BrandE Water Bottle
825	477	Stock In	98	2022-01-04	INV-000825	Stock In for BrandC Jeans
826	248	Return	2	2023-11-19	INV-000826	Return for Deluxe Bicycle
827	185	Adjustment	3	2022-05-01	INV-000827	Adjustment for BrandE Paint Set
828	366	Return	2	2022-05-12	INV-000828	Return for Premium Coffee Maker
829	487	Return	9	2023-04-07	INV-000829	Return for BrandB Phone Mount
830	249	Adjustment	-18	2023-03-04	INV-000830	Adjustment for BrandD Coffee Beans
831	53	Stock Out	-27	2021-05-04	INV-000831	Stock Out for Premium Coffee Beans
832	444	Return	5	2022-04-14	INV-000832	Return for BrandA Lamp
833	45	Stock In	97	2023-03-10	INV-000833	Stock In for Elite Chocolate
834	58	Adjustment	0	2020-09-01	INV-000834	Adjustment for BrandE Air Freshener
835	123	Return	2	2020-05-26	INV-000835	Return for Premium Tea Set
836	145	Stock Out	-14	2023-04-17	INV-000836	Stock Out for BrandE Sneakers
837	54	Adjustment	6	2021-01-19	INV-000837	Adjustment for Basic Vacuum Cleaner
838	75	Stock Out	-9	2021-06-18	INV-000838	Stock Out for BrandB Bedding Set
839	153	Adjustment	-16	2022-11-12	INV-000839	Adjustment for BrandB Tire Gauge
840	80	Stock Out	-24	2022-03-19	INV-000840	Stock Out for BrandC Face Cream
841	59	Damaged	-4	2020-05-17	INV-000841	Damaged for Elite Plant Pot
842	347	Damaged	-2	2020-06-15	INV-000842	Damaged for Premium Phone Mount
843	109	Stock Out	-42	2023-12-23	INV-000843	Stock Out for BrandB Toy Car
844	370	Return	10	2022-07-12	INV-000844	Return for BrandD Camera
845	380	Adjustment	15	2023-12-04	INV-000845	Adjustment for Standard Vitamins
846	88	Return	10	2022-09-22	INV-000846	Return for Elite Protein Bar
847	184	Damaged	-3	2022-12-12	INV-000847	Damaged for BrandA Perfume
848	392	Return	10	2022-11-05	INV-000848	Return for BrandB Tea Set
849	332	Damaged	-4	2021-02-09	INV-000849	Damaged for BrandB Coffee Beans
850	90	Stock In	156	2022-05-20	INV-000850	Stock In for Deluxe Phone Mount
851	106	Stock Out	-4	2021-12-12	INV-000851	Stock Out for BrandB Hat
852	69	Stock Out	-32	2023-07-08	INV-000852	Stock Out for BrandE Tent
853	387	Stock In	76	2023-12-22	INV-000853	Stock In for Standard Toy Car
854	237	Stock Out	-25	2023-03-14	INV-000854	Stock Out for Elite Paint Set
855	54	Stock Out	-12	2021-12-12	INV-000855	Stock Out for Basic Vacuum Cleaner
856	271	Damaged	-1	2022-05-14	INV-000856	Damaged for Standard Bicycle
857	448	Adjustment	-12	2021-04-26	INV-000857	Adjustment for BrandD Protein Bar
858	112	Stock In	40	2020-10-01	INV-000858	Stock In for BrandE Cookbook
859	331	Return	5	2022-04-10	INV-000859	Return for Basic Craft Paper
860	98	Damaged	-1	2020-08-14	INV-000860	Damaged for Basic Science Textbook
861	247	Return	7	2021-02-21	INV-000861	Return for BrandD Self-Help Book
862	251	Stock In	165	2020-07-04	INV-000862	Stock In for BrandA Dress
863	132	Damaged	-5	2022-05-20	INV-000863	Damaged for Deluxe Action Figure
864	277	Stock Out	-30	2023-10-29	INV-000864	Stock Out for Elite Camera
865	254	Stock In	144	2022-01-13	INV-000865	Stock In for Standard Chocolate
866	311	Adjustment	-6	2022-03-06	INV-000866	Adjustment for Basic Laptop
867	497	Stock In	117	2020-11-03	INV-000867	Stock In for Elite Lamp
868	78	Stock Out	-13	2020-01-25	INV-000868	Stock Out for BrandD Smart Watch
869	210	Return	4	2021-12-14	INV-000869	Return for BrandD Jeans
870	444	Return	8	2021-02-26	INV-000870	Return for BrandA Lamp
871	196	Adjustment	11	2022-07-20	INV-000871	Adjustment for Elite Shampoo
872	441	Adjustment	5	2023-06-24	INV-000872	Adjustment for BrandC Sneakers
873	110	Adjustment	-10	2023-05-30	INV-000873	Adjustment for Premium Tire Gauge
874	321	Damaged	-3	2020-05-12	INV-000874	Damaged for BrandA Coffee Beans
875	151	Stock In	86	2020-01-18	INV-000875	Stock In for Deluxe Doll
876	191	Stock In	65	2020-11-22	INV-000876	Stock In for BrandE Glue Set
877	234	Return	4	2020-02-07	INV-000877	Return for Premium Glue Set
878	283	Stock Out	-49	2020-09-18	INV-000878	Stock Out for BrandB Chocolate
879	401	Adjustment	13	2020-12-22	INV-000879	Adjustment for BrandB Coffee Maker
880	423	Return	5	2023-11-23	INV-000880	Return for BrandE Hat
881	444	Return	4	2021-10-27	INV-000881	Return for BrandA Lamp
882	404	Stock Out	-44	2021-04-14	INV-000882	Stock Out for Elite Self-Help Book
883	421	Adjustment	6	2020-06-14	INV-000883	Adjustment for BrandC Board Game
884	328	Stock In	152	2022-11-20	INV-000884	Stock In for Elite Glue Set
885	167	Stock Out	-1	2021-05-12	INV-000885	Stock Out for BrandA Tire Gauge
886	9	Damaged	-1	2023-11-07	INV-000886	Damaged for BrandE Lamp
887	92	Return	10	2021-11-05	INV-000887	Return for BrandA Bicycle
888	163	Damaged	-4	2020-10-11	INV-000888	Damaged for Premium Bedding Set
889	351	Stock In	153	2021-11-16	INV-000889	Stock In for BrandB Car Mat
890	453	Stock Out	-42	2023-09-23	INV-000890	Stock Out for Standard Craft Paper
891	37	Stock In	191	2020-07-29	INV-000891	Stock In for Basic Sneakers
892	227	Stock In	177	2020-12-01	INV-000892	Stock In for BrandE Tablet
893	109	Damaged	-1	2022-08-13	INV-000893	Damaged for BrandB Toy Car
894	368	Return	10	2020-03-02	INV-000894	Return for BrandA Plant Pot
895	319	Stock Out	-41	2022-03-12	INV-000895	Stock Out for BrandB Smart Watch
896	463	Return	7	2022-03-16	INV-000896	Return for Deluxe Science Textbook
897	89	Stock Out	-26	2023-08-26	INV-000897	Stock Out for Premium Water Bottle
898	249	Damaged	-3	2022-09-10	INV-000898	Damaged for BrandD Coffee Beans
899	277	Stock Out	-33	2020-05-30	INV-000899	Stock Out for Elite Camera
900	296	Stock Out	-11	2022-04-28	INV-000900	Stock Out for Elite Coffee Beans
901	491	Adjustment	17	2022-11-21	INV-000901	Adjustment for Basic Board Game
902	449	Adjustment	1	2020-01-21	INV-000902	Adjustment for Deluxe Protein Bar
903	268	Stock Out	-13	2023-11-01	INV-000903	Stock Out for BrandB Plant Pot
904	325	Return	10	2020-04-10	INV-000904	Return for Premium Coffee Beans
905	59	Stock Out	-43	2023-09-21	INV-000905	Stock Out for Elite Plant Pot
906	431	Damaged	-3	2020-03-04	INV-000906	Damaged for Elite Smart Watch
907	223	Stock Out	-32	2022-01-09	INV-000907	Stock Out for BrandE Chocolate
908	288	Stock Out	-23	2023-07-20	INV-000908	Stock Out for BrandE Headphones
909	296	Stock Out	-43	2020-08-08	INV-000909	Stock Out for Elite Coffee Beans
910	493	Stock Out	-10	2023-12-26	INV-000910	Stock Out for BrandC Perfume
911	216	Adjustment	1	2020-09-15	INV-000911	Adjustment for BrandD Smartphone
912	460	Return	6	2022-04-29	INV-000912	Return for BrandB Paint Set
913	115	Return	2	2023-04-07	INV-000913	Return for Elite Craft Paper
914	194	Adjustment	-17	2021-05-26	INV-000914	Adjustment for Standard Protein Bar
915	413	Stock In	104	2022-04-04	INV-000915	Stock In for Elite Craft Paper
916	345	Damaged	-4	2023-02-11	INV-000916	Damaged for Deluxe Tea Set
917	490	Stock In	126	2020-05-17	INV-000917	Stock In for BrandB Bedding Set
918	275	Stock Out	-45	2022-03-26	INV-000918	Stock Out for BrandA Sneakers
919	54	Adjustment	-11	2021-08-04	INV-000919	Adjustment for Basic Vacuum Cleaner
920	61	Damaged	-3	2023-01-14	INV-000920	Damaged for BrandA Vitamins
921	14	Damaged	-1	2022-10-22	INV-000921	Damaged for BrandB Bedding Set
922	176	Adjustment	-10	2023-05-12	INV-000922	Adjustment for BrandE Phone Mount
923	13	Damaged	-2	2022-11-05	INV-000923	Damaged for BrandD Backpack
924	242	Damaged	-2	2020-01-09	INV-000924	Damaged for BrandB Smart Watch
925	478	Stock In	93	2020-09-04	INV-000925	Stock In for BrandA Air Freshener
926	82	Adjustment	17	2022-08-14	INV-000926	Adjustment for BrandC Hat
927	345	Return	8	2022-04-27	INV-000927	Return for Deluxe Tea Set
928	346	Adjustment	16	2020-07-01	INV-000928	Adjustment for Standard Puzzle
929	54	Stock Out	-26	2020-06-22	INV-000929	Stock Out for Basic Vacuum Cleaner
930	46	Return	6	2022-06-21	INV-000930	Return for BrandD Sketchbook
931	239	Return	6	2020-10-08	INV-000931	Return for Elite Protein Bar
932	263	Damaged	-2	2020-10-01	INV-000932	Damaged for Premium Speaker
933	291	Return	2	2023-03-08	INV-000933	Return for Basic Jacket
934	226	Adjustment	-3	2023-12-21	INV-000934	Adjustment for Standard Speaker
935	286	Damaged	-1	2020-09-25	INV-000935	Damaged for Premium Tea Set
936	51	Damaged	-3	2023-02-24	INV-000936	Damaged for Basic Face Cream
937	201	Adjustment	17	2021-08-30	INV-000937	Adjustment for BrandB Shampoo
938	138	Stock Out	-43	2021-06-08	INV-000938	Stock Out for BrandE Board Game
939	454	Adjustment	9	2022-09-10	INV-000939	Adjustment for BrandD Protein Bar
940	133	Return	7	2020-06-06	INV-000940	Return for BrandD Self-Help Book
941	208	Stock Out	-35	2023-01-02	INV-000941	Stock Out for Deluxe Water Bottle
942	220	Return	6	2023-07-04	INV-000942	Return for Deluxe Protein Bar
943	440	Adjustment	-19	2020-03-10	INV-000943	Adjustment for Standard Sneakers
944	299	Damaged	-1	2023-11-29	INV-000944	Damaged for Premium Craft Paper
945	262	Adjustment	18	2021-12-10	INV-000945	Adjustment for Elite Board Game
946	292	Return	8	2022-11-21	INV-000946	Return for Premium Lamp
947	405	Stock Out	-10	2021-03-02	INV-000947	Stock Out for BrandA Camera
948	285	Damaged	-3	2023-04-25	INV-000948	Damaged for Basic Self-Help Book
949	39	Stock Out	-25	2020-02-01	INV-000949	Stock Out for Deluxe Yoga Mat
950	1	Stock In	158	2021-08-06	INV-000950	Stock In for BrandC Coffee Beans
951	29	Stock In	49	2023-07-28	INV-000951	Stock In for BrandD Cookbook
952	49	Return	1	2022-04-30	INV-000952	Return for Elite Science Textbook
953	54	Return	2	2023-02-24	INV-000953	Return for Basic Vacuum Cleaner
954	395	Adjustment	-6	2022-04-19	INV-000954	Adjustment for Deluxe Self-Help Book
955	405	Stock In	190	2022-12-23	INV-000955	Stock In for BrandA Camera
956	149	Return	9	2020-03-26	INV-000956	Return for BrandC Perfume
957	289	Return	3	2020-01-02	INV-000957	Return for Elite Laptop
958	499	Stock Out	-2	2021-04-02	INV-000958	Stock Out for Premium Biography
959	148	Stock Out	-36	2023-01-29	INV-000959	Stock Out for Premium Tablet
960	450	Stock In	27	2020-11-19	INV-000960	Stock In for Basic Glue Set
961	322	Stock In	157	2023-06-19	INV-000961	Stock In for Deluxe Jeans
962	79	Return	7	2022-09-03	INV-000962	Return for BrandB Puzzle
963	229	Return	4	2022-06-26	INV-000963	Return for BrandA Air Freshener
964	447	Stock Out	-2	2021-02-12	INV-000964	Stock Out for Basic Fiction Novel
965	221	Return	4	2021-08-27	INV-000965	Return for Basic Yoga Mat
966	379	Adjustment	12	2021-04-03	INV-000966	Adjustment for Standard Glue Set
967	247	Return	6	2022-05-11	INV-000967	Return for BrandD Self-Help Book
968	364	Return	1	2022-07-31	INV-000968	Return for BrandD Hat
969	58	Stock In	158	2023-07-12	INV-000969	Stock In for BrandE Air Freshener
970	451	Stock In	98	2022-04-10	INV-000970	Stock In for BrandA Biography
971	200	Adjustment	11	2021-08-10	INV-000971	Adjustment for Basic Car Mat
972	323	Stock Out	-38	2022-04-15	INV-000972	Stock Out for Basic Speaker
973	144	Return	8	2020-03-10	INV-000973	Return for Standard Air Freshener
974	222	Adjustment	-4	2022-03-11	INV-000974	Adjustment for Elite Monitor
975	15	Return	4	2023-05-15	INV-000975	Return for BrandE Car Mat
976	75	Stock Out	-5	2022-03-14	INV-000976	Stock Out for BrandB Bedding Set
977	490	Adjustment	18	2020-01-12	INV-000977	Adjustment for BrandB Bedding Set
978	487	Damaged	-3	2021-07-08	INV-000978	Damaged for BrandB Phone Mount
979	48	Return	9	2023-08-31	INV-000979	Return for BrandB Dress
980	51	Damaged	-4	2021-05-08	INV-000980	Damaged for Basic Face Cream
981	89	Stock In	100	2022-11-25	INV-000981	Stock In for Premium Water Bottle
982	33	Damaged	-4	2022-12-29	INV-000982	Damaged for BrandB Phone Mount
983	100	Stock In	24	2020-11-25	INV-000983	Stock In for Basic Garden Hose
984	227	Adjustment	-7	2020-07-12	INV-000984	Adjustment for BrandE Tablet
985	294	Stock Out	-38	2020-12-26	INV-000985	Stock Out for BrandA Camera
986	254	Return	7	2020-09-18	INV-000986	Return for Standard Chocolate
987	201	Adjustment	-3	2022-10-11	INV-000987	Adjustment for BrandB Shampoo
988	299	Damaged	-1	2023-11-06	INV-000988	Damaged for Premium Craft Paper
989	38	Stock In	154	2021-11-02	INV-000989	Stock In for Premium Coffee Beans
990	205	Damaged	-1	2021-09-18	INV-000990	Damaged for Basic Protein Bar
991	19	Stock In	33	2021-08-24	INV-000991	Stock In for Premium Tea Set
992	206	Return	2	2021-10-08	INV-000992	Return for BrandA Craft Paper
993	93	Damaged	-4	2020-01-27	INV-000993	Damaged for Deluxe Jacket
994	53	Stock In	16	2020-05-24	INV-000994	Stock In for Premium Coffee Beans
995	330	Damaged	-1	2020-03-12	INV-000995	Damaged for Basic Doll
996	322	Return	4	2022-11-29	INV-000996	Return for Deluxe Jeans
997	368	Damaged	-3	2021-06-11	INV-000997	Damaged for BrandA Plant Pot
998	374	Return	8	2023-12-23	INV-000998	Return for BrandD Self-Help Book
999	256	Stock Out	-41	2021-09-24	INV-000999	Stock Out for BrandA Dress
1000	392	Return	5	2021-05-14	INV-001000	Return for BrandB Tea Set
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (order_item_id, order_id, product_id, quantity, unit_price, total_price) FROM stdin;
1	2089	299	3	10.57	31.71
2	2244	52	1	1713.47	1713.47
3	2422	460	3	53.88	161.64
4	590	242	5	899.18	4495.90
5	2226	222	3	1222.06	3666.18
6	2205	217	1	102.71	102.71
7	1528	126	1	47.88	47.88
8	982	16	3	21.47	64.41
9	1792	54	2	177.79	355.58
10	1663	103	1	168.49	168.49
11	1320	352	1	21.21	21.21
12	265	33	4	36.04	144.16
13	235	94	2	124.81	249.62
14	937	140	1	22.98	22.98
15	99	465	4	151.90	607.60
16	1874	291	4	62.85	251.40
17	834	370	1	460.14	460.14
18	1810	414	3	32.14	96.42
19	1346	248	4	235.92	943.68
20	1790	308	1	197.22	197.22
21	2153	100	3	128.64	385.92
22	241	165	5	10.39	51.95
23	1203	227	4	1612.51	6450.04
24	2110	397	5	97.03	485.15
25	629	466	1	43.61	43.61
26	26	305	3	64.25	192.75
27	510	193	2	56.68	113.36
28	225	250	2	40.88	81.76
29	1165	480	3	138.76	416.28
30	1929	19	3	34.49	103.47
31	1161	261	1	64.39	64.39
32	1195	346	2	78.72	157.44
33	838	172	2	450.87	901.74
34	1107	409	5	62.83	314.15
35	1598	363	3	30.19	90.57
36	508	252	3	175.20	525.60
37	955	99	4	42.94	171.76
38	1077	201	5	20.18	100.90
39	1474	55	3	88.59	265.77
40	1939	425	1	50.74	50.74
41	2481	49	4	36.01	144.04
42	807	108	3	43.88	131.64
43	1839	322	3	134.71	404.13
44	671	157	2	212.65	425.30
45	2343	196	1	36.96	36.96
46	1067	370	3	460.14	1380.42
47	1622	134	4	15.54	62.16
48	540	460	5	53.88	269.40
49	1287	444	1	276.46	276.46
50	1498	431	3	226.93	680.79
51	56	298	4	137.17	548.68
52	1978	332	1	20.41	20.41
53	2	462	5	290.55	1452.75
54	1404	109	1	62.66	62.66
55	1326	473	5	160.59	802.95
56	2477	50	5	43.57	217.85
57	1373	67	5	47.52	237.60
58	441	377	4	57.24	228.96
59	854	324	4	74.42	297.68
60	565	443	3	17.52	52.56
61	2460	482	4	26.78	107.12
62	599	381	5	19.94	99.70
63	919	469	2	27.64	55.28
64	1472	169	4	186.87	747.48
65	576	433	3	10.07	30.21
66	2210	488	4	47.80	191.20
67	1146	55	1	88.59	88.59
68	342	42	5	90.48	452.40
69	2448	328	2	53.11	106.22
70	810	333	2	240.47	480.94
71	1506	327	3	126.09	378.27
72	1782	304	5	951.76	4758.80
73	568	112	4	17.58	70.32
74	89	405	3	1223.24	3669.72
75	1099	434	5	49.87	249.35
76	352	341	4	59.37	237.48
77	489	359	4	53.26	213.04
78	576	71	5	41.29	206.45
79	313	161	1	183.22	183.22
80	546	461	3	37.37	112.11
81	1281	309	4	20.47	81.88
82	840	411	1	40.37	40.37
83	507	331	2	65.98	131.96
84	815	189	2	30.28	60.56
85	1217	418	4	134.86	539.44
86	1074	195	4	172.13	688.52
87	2330	37	1	168.04	168.04
88	2108	87	5	192.95	964.75
89	1571	145	3	87.37	262.11
90	1980	231	2	1595.61	3191.22
91	1971	193	1	56.68	56.68
92	1360	397	1	97.03	97.03
93	1928	345	5	35.23	176.15
94	449	329	2	43.29	86.58
95	2076	365	2	22.34	44.68
96	2291	379	1	37.51	37.51
97	1614	21	5	42.95	214.75
98	1422	466	3	43.61	130.83
99	845	87	4	192.95	771.80
100	916	336	4	12.98	51.92
101	1020	455	2	40.50	81.00
102	332	487	2	138.30	276.60
103	759	205	2	19.42	38.84
104	418	59	2	248.24	496.48
105	494	431	5	226.93	1134.65
106	1865	142	4	97.11	388.44
107	707	481	2	49.26	98.52
108	1454	457	2	10.57	21.14
109	337	253	2	82.55	165.10
110	570	105	5	45.66	228.30
111	26	70	4	194.01	776.04
112	2121	11	3	53.63	160.89
113	2039	237	3	24.89	74.67
114	1568	128	1	38.41	38.41
115	2032	93	2	54.25	108.50
116	1783	130	5	41.39	206.95
117	506	301	2	558.90	1117.80
118	1811	418	3	134.86	404.58
119	1528	392	2	35.62	71.24
120	530	442	2	19.09	38.18
121	1704	75	4	323.09	1292.36
122	1151	446	4	361.96	1447.84
123	1479	76	4	9.20	36.80
124	527	147	5	289.77	1448.85
125	2257	36	5	20.31	101.55
126	1190	212	2	43.24	86.48
127	1294	500	3	175.70	527.10
128	14	65	2	70.40	140.80
129	1288	197	4	135.87	543.48
130	25	414	4	32.14	128.56
131	2476	401	2	498.85	997.70
132	654	114	5	152.22	761.10
133	373	100	2	128.64	257.28
134	1166	74	2	293.77	587.54
135	958	441	5	97.86	489.30
136	2221	380	3	41.63	124.89
137	1564	284	2	22.44	44.88
138	1598	411	1	40.37	40.37
139	945	338	2	173.05	346.10
140	1749	3	2	26.19	52.38
141	350	365	2	22.34	44.68
142	2398	295	1	39.05	39.05
143	1191	189	5	30.28	151.40
144	1267	469	1	27.64	27.64
145	517	61	3	21.85	65.55
146	1275	221	1	56.85	56.85
147	957	31	1	17.37	17.37
148	416	308	4	197.22	788.88
149	2014	420	5	163.63	818.15
150	674	355	2	42.69	85.38
151	1486	248	2	235.92	471.84
152	466	260	2	50.36	100.72
153	896	119	5	254.39	1271.95
154	1057	224	3	50.63	151.89
155	2240	279	3	16.56	49.68
156	1359	199	2	33.04	66.08
157	127	157	2	212.65	425.30
158	1666	375	3	62.45	187.35
159	1698	40	4	30.42	121.68
160	213	493	1	54.70	54.70
161	1672	206	5	45.80	229.00
162	1487	388	5	15.05	75.25
163	2046	307	5	43.66	218.30
164	1563	305	2	64.25	128.50
165	1930	132	5	41.64	208.20
166	951	238	1	54.26	54.26
167	249	182	4	18.31	73.24
168	546	69	3	259.22	777.66
169	2161	219	3	31.22	93.66
170	394	213	1	65.92	65.92
171	1728	10	3	35.19	105.57
172	412	243	3	56.14	168.42
173	1748	450	3	33.27	99.81
174	1327	345	2	35.23	70.46
175	354	40	4	30.42	121.68
176	1372	364	1	157.44	157.44
177	1381	439	4	1837.39	7349.56
178	92	301	3	558.90	1676.70
179	247	424	4	924.51	3698.04
180	742	355	5	42.69	213.45
181	390	37	5	168.04	840.20
182	2048	295	5	39.05	195.25
183	1050	32	1	36.44	36.44
184	2086	475	2	218.49	436.98
185	1668	204	5	46.65	233.25
186	1659	18	2	178.99	357.98
187	193	91	1	81.18	81.18
188	217	166	1	39.81	39.81
189	658	334	1	22.93	22.93
190	32	41	4	480.19	1920.76
191	1621	17	3	31.74	95.22
192	1526	257	2	13.06	26.12
193	1595	136	2	68.76	137.52
194	1685	185	2	68.10	136.20
195	1122	9	2	437.61	875.22
196	2080	52	4	1713.47	6853.88
197	1340	459	2	53.30	106.60
198	2200	485	2	22.10	44.20
199	2086	137	4	59.63	238.52
200	1216	256	4	175.24	700.96
201	537	43	4	87.93	351.72
202	3	94	4	124.81	499.24
203	921	78	2	1094.06	2188.12
204	585	21	2	42.95	85.90
205	2294	150	1	68.63	68.63
206	848	330	4	44.43	177.72
207	1866	69	5	259.22	1296.10
208	1817	311	1	475.70	475.70
209	127	192	4	42.22	168.88
210	1787	26	4	173.16	692.64
211	1073	88	3	24.07	72.21
212	1901	307	4	43.66	174.64
213	24	470	1	18.69	18.69
214	23	59	4	248.24	992.96
215	1905	344	1	39.33	39.33
216	976	119	2	254.39	508.78
217	813	399	5	71.86	359.30
218	1705	258	3	34.33	102.99
219	1532	230	1	12.95	12.95
220	2340	398	2	237.21	474.42
221	1114	55	4	88.59	354.36
222	386	348	1	5.26	5.26
223	1372	372	3	203.87	611.61
224	1826	237	5	24.89	124.45
225	2121	60	3	1576.99	4730.97
226	2278	56	2	60.90	121.80
227	2384	91	5	81.18	405.90
228	1466	180	5	432.09	2160.45
229	2074	488	3	47.80	143.40
230	1381	152	2	70.59	141.18
231	2357	372	3	203.87	611.61
232	1497	38	1	32.14	32.14
233	1514	162	1	51.77	51.77
234	769	59	4	248.24	992.96
235	1954	99	3	42.94	128.82
236	233	465	1	151.90	151.90
237	333	82	2	48.26	96.52
238	1151	489	4	88.05	352.20
239	894	403	3	208.42	625.26
240	2337	197	1	135.87	135.87
241	950	216	4	316.91	1267.64
242	98	241	4	101.95	407.80
243	1250	435	3	12.96	38.88
244	1533	162	5	51.77	258.85
245	2285	237	2	24.89	49.78
246	533	233	4	1143.94	4575.76
247	1978	156	4	446.90	1787.60
248	1155	174	4	80.98	323.92
249	1860	231	2	1595.61	3191.22
250	2430	331	3	65.98	197.94
251	2030	95	5	76.13	380.65
252	493	411	1	40.37	40.37
253	1577	371	4	129.51	518.04
254	922	80	2	33.99	67.98
255	821	488	1	47.80	47.80
256	2389	461	1	37.37	37.37
257	593	164	2	143.24	286.48
258	589	130	4	41.39	165.56
259	84	479	2	142.79	285.58
260	157	409	5	62.83	314.15
261	2003	31	3	17.37	52.11
262	1341	47	4	87.81	351.24
263	1895	456	3	39.61	118.83
264	1125	84	4	6.04	24.16
265	404	41	1	480.19	480.19
266	433	206	3	45.80	137.40
267	398	205	5	19.42	97.10
268	1191	30	4	72.53	290.12
269	712	348	3	5.26	15.78
270	460	139	3	38.32	114.96
271	618	397	5	97.03	485.15
272	699	158	4	191.11	764.44
273	794	264	5	51.18	255.90
274	120	5	2	23.44	46.88
275	1688	120	1	41.71	41.71
276	2034	177	5	74.94	374.70
277	2407	437	2	11.99	23.98
278	2214	294	5	956.29	4781.45
279	971	41	5	480.19	2400.95
280	1355	85	4	478.53	1914.12
281	2324	105	5	45.66	228.30
282	2431	121	5	16.58	82.90
283	1966	326	3	80.44	241.32
284	2169	426	5	34.78	173.90
285	213	362	1	60.33	60.33
286	416	156	3	446.90	1340.70
287	31	323	5	1447.42	7237.10
288	2486	288	5	656.63	3283.15
289	692	299	4	10.57	42.28
290	2253	397	1	97.03	97.03
291	1753	394	5	148.49	742.45
292	529	173	5	112.69	563.45
293	733	353	3	139.69	419.07
294	50	95	3	76.13	228.39
295	796	42	1	90.48	90.48
296	2256	414	3	32.14	96.42
297	1128	181	5	57.96	289.80
298	1228	164	2	143.24	286.48
299	1471	293	2	77.37	154.74
300	1801	124	4	133.17	532.68
301	934	328	4	53.11	212.44
302	635	81	3	40.13	120.39
303	1727	483	2	75.61	151.22
304	534	3	2	26.19	52.38
305	840	456	2	39.61	79.22
306	2015	352	2	21.21	42.42
307	1836	339	5	187.08	935.40
308	1895	184	3	50.91	152.73
309	1602	77	4	57.74	230.96
310	1107	441	1	97.86	97.86
311	88	167	2	67.26	134.52
312	2158	225	1	97.45	97.45
313	1190	79	2	75.58	151.16
314	1946	19	5	34.49	172.45
315	2197	89	5	127.84	639.20
316	2132	73	5	496.56	2482.80
317	432	11	1	53.63	53.63
318	1672	162	1	51.77	51.77
319	1551	343	3	45.18	135.54
320	906	84	5	6.04	30.20
321	2223	372	3	203.87	611.61
322	1139	283	5	26.19	130.95
323	1609	102	3	93.77	281.31
324	373	57	2	47.99	95.98
325	2061	358	3	68.55	205.65
326	139	478	1	94.13	94.13
327	2297	274	1	78.08	78.08
328	351	116	1	1031.32	1031.32
329	434	97	2	1307.31	2614.62
330	1000	206	4	45.80	183.20
331	165	370	4	460.14	1840.56
332	2330	109	2	62.66	125.32
333	1547	232	2	43.21	86.42
334	2316	52	2	1713.47	3426.94
335	667	36	5	20.31	101.55
336	960	374	5	44.65	223.25
337	1946	437	3	11.99	35.97
338	2406	497	4	25.76	103.04
339	1382	196	3	36.96	110.88
340	78	132	2	41.64	83.28
341	2375	12	2	45.14	90.28
342	2170	189	3	30.28	90.84
343	1179	41	4	480.19	1920.76
344	2381	452	4	14.12	56.48
345	369	310	5	38.48	192.40
346	1128	363	4	30.19	120.76
347	430	385	1	13.45	13.45
348	952	111	5	38.70	193.50
349	1961	493	5	54.70	273.50
350	270	141	5	25.01	125.05
351	1181	322	2	134.71	269.42
352	1711	441	2	97.86	195.72
353	1446	356	2	378.69	757.38
354	224	232	4	43.21	172.84
355	1095	391	5	169.39	846.95
356	662	16	5	21.47	107.35
357	71	430	4	143.84	575.36
358	1092	36	1	20.31	20.31
359	2451	229	3	51.78	155.34
360	569	91	5	81.18	405.90
361	900	133	3	22.04	66.12
362	2249	154	1	17.90	17.90
363	177	138	4	68.43	273.72
364	1791	1	5	31.96	159.80
365	634	92	1	222.12	222.12
366	2450	263	4	1800.59	7202.36
367	2202	207	1	76.84	76.84
368	1462	462	2	290.55	581.10
369	260	382	3	139.89	419.67
370	2302	361	5	67.61	338.05
371	143	40	3	30.42	91.26
372	1700	19	4	34.49	137.96
373	36	463	3	25.47	76.41
374	1232	394	4	148.49	593.96
375	1967	181	5	57.96	289.80
376	320	274	5	78.08	390.40
377	931	43	5	87.93	439.65
378	1554	129	3	7.25	21.75
379	723	470	4	18.69	74.76
380	928	439	1	1837.39	1837.39
381	899	175	3	1956.92	5870.76
382	59	292	5	425.20	2126.00
383	2253	382	4	139.89	559.56
384	1841	201	4	20.18	80.72
385	1127	27	5	46.75	233.75
386	1779	92	3	222.12	666.36
387	1510	364	5	157.44	787.20
388	1508	76	4	9.20	36.80
389	1625	15	2	34.26	68.52
390	1941	197	5	135.87	679.35
391	2273	81	2	40.13	80.26
392	1365	286	1	21.30	21.30
393	173	346	5	78.72	393.60
394	2216	441	4	97.86	391.44
395	1231	173	2	112.69	225.38
396	36	424	2	924.51	1849.02
397	284	70	4	194.01	776.04
398	2311	332	1	20.41	20.41
399	1332	185	1	68.10	68.10
400	1559	286	5	21.30	106.50
401	764	275	1	44.37	44.37
402	2438	103	5	168.49	842.45
403	557	413	2	68.02	136.04
404	2334	147	4	289.77	1159.08
405	836	171	1	127.13	127.13
406	2082	411	4	40.37	161.48
407	1178	389	4	71.80	287.20
408	1175	160	2	63.03	126.06
409	1761	36	1	20.31	20.31
410	133	183	1	20.45	20.45
411	939	181	4	57.96	231.84
412	2277	470	3	18.69	56.07
413	1160	57	3	47.99	143.97
414	256	229	3	51.78	155.34
415	1032	42	4	90.48	361.92
416	103	320	5	82.53	412.65
417	1290	481	4	49.26	197.04
418	2029	491	3	65.83	197.49
419	1730	139	3	38.32	114.96
420	272	168	4	68.11	272.44
421	1313	222	5	1222.06	6110.30
422	1782	277	4	1676.49	6705.96
423	496	369	3	61.27	183.81
424	81	159	3	15.19	45.57
425	1011	33	3	36.04	108.12
426	1356	179	4	224.59	898.36
427	54	99	3	42.94	128.82
428	2327	102	1	93.77	93.77
429	575	272	2	120.40	240.80
430	2071	498	3	224.97	674.91
431	1670	82	4	48.26	193.04
432	600	142	4	97.11	388.44
433	2014	30	3	72.53	217.59
434	2053	326	1	80.44	80.44
435	1768	240	1	77.63	77.63
436	2191	227	1	1612.51	1612.51
437	2373	21	4	42.95	171.80
438	1674	256	5	175.24	876.20
439	2491	111	4	38.70	154.80
440	739	255	3	96.70	290.10
441	299	407	5	262.44	1312.20
442	967	200	4	50.56	202.24
443	698	240	5	77.63	388.15
444	1117	171	2	127.13	254.26
445	863	455	3	40.50	121.50
446	148	205	1	19.42	19.42
447	2073	439	3	1837.39	5512.17
448	1281	82	1	48.26	48.26
449	134	34	4	37.20	148.80
450	723	368	4	234.47	937.88
451	1451	185	3	68.10	204.30
452	1972	55	3	88.59	265.77
453	330	457	3	10.57	31.71
454	2056	188	1	58.13	58.13
455	246	435	2	12.96	25.92
456	1665	366	2	437.87	875.74
457	2442	443	3	17.52	52.56
458	1873	450	3	33.27	99.81
459	595	389	3	71.80	215.40
460	1348	65	1	70.40	70.40
461	913	230	5	12.95	64.75
462	1542	232	5	43.21	216.05
463	2448	236	5	1207.15	6035.75
464	818	161	4	183.22	732.88
465	1038	135	3	28.66	85.98
466	1381	65	1	70.40	70.40
467	120	235	2	32.53	65.06
468	237	397	2	97.03	194.06
469	136	193	2	56.68	113.36
470	1746	37	5	168.04	840.20
471	168	267	4	109.12	436.48
472	2208	340	5	41.26	206.30
473	1118	95	4	76.13	304.52
474	598	386	1	152.82	152.82
475	844	282	5	367.58	1837.90
476	578	73	2	496.56	993.12
477	1016	181	3	57.96	173.88
478	1591	135	4	28.66	114.64
479	883	321	1	35.69	35.69
480	2165	441	1	97.86	97.86
481	1704	486	4	55.39	221.56
482	2438	209	1	70.93	70.93
483	1427	467	2	100.75	201.50
484	1323	1	4	31.96	127.84
485	1431	97	2	1307.31	2614.62
486	1642	78	1	1094.06	1094.06
487	628	194	5	37.99	189.95
488	2387	441	3	97.86	293.58
489	9	10	3	35.19	105.57
490	52	470	2	18.69	37.38
491	340	89	2	127.84	255.68
492	1718	336	5	12.98	64.90
493	337	42	4	90.48	361.92
494	601	459	1	53.30	53.30
495	503	470	2	18.69	37.38
496	331	146	1	50.37	50.37
497	1186	235	3	32.53	97.59
498	2214	11	1	53.63	53.63
499	926	138	5	68.43	342.15
500	1154	447	5	18.24	91.20
501	1397	313	5	171.44	857.20
502	1517	257	2	13.06	26.12
503	144	1	1	31.96	31.96
504	2036	61	5	21.85	109.25
505	2240	196	3	36.96	110.88
506	951	486	1	55.39	55.39
507	2083	426	2	34.78	69.56
508	1266	459	3	53.30	159.90
509	607	487	5	138.30	691.50
510	256	134	1	15.54	15.54
511	1407	475	5	218.49	1092.45
512	2466	244	4	26.32	105.28
513	1552	79	1	75.58	75.58
514	502	361	5	67.61	338.05
515	1515	433	4	10.07	40.28
516	2000	18	5	178.99	894.95
517	1199	405	4	1223.24	4892.96
518	2379	351	5	47.82	239.10
519	565	295	4	39.05	156.20
520	1195	360	2	41.94	83.88
521	155	118	3	396.15	1188.45
522	1927	444	3	276.46	829.38
523	1197	428	2	238.02	476.04
524	869	230	5	12.95	64.75
525	662	3	3	26.19	78.57
526	1185	214	1	18.50	18.50
527	573	40	2	30.42	60.84
528	1524	412	3	32.98	98.94
529	1544	19	4	34.49	137.96
530	1506	424	5	924.51	4622.55
531	1185	497	3	25.76	77.28
532	303	99	5	42.94	214.70
533	743	83	1	40.42	40.42
534	2432	394	3	148.49	445.47
535	1533	435	3	12.96	38.88
536	859	57	1	47.99	47.99
537	501	104	4	50.61	202.44
538	26	135	2	28.66	57.32
539	836	128	3	38.41	115.23
540	2033	19	4	34.49	137.96
541	1004	64	4	37.18	148.72
542	2130	54	3	177.79	533.37
543	1351	229	5	51.78	258.90
544	1059	422	1	57.25	57.25
545	865	497	5	25.76	128.80
546	493	273	3	1558.15	4674.45
547	199	101	4	35.50	142.00
548	1307	279	2	16.56	33.12
549	1257	233	5	1143.94	5719.70
550	1074	387	3	43.03	129.09
551	497	187	1	131.18	131.18
552	706	125	3	812.50	2437.50
553	2034	438	5	7.95	39.75
554	22	178	5	386.24	1931.20
555	958	144	1	115.12	115.12
556	2286	257	2	13.06	26.12
557	1259	198	4	104.90	419.60
558	1340	4	1	145.93	145.93
559	1931	64	2	37.18	74.36
560	2144	469	5	27.64	138.20
561	2293	183	3	20.45	61.35
562	1129	424	3	924.51	2773.53
563	1728	66	2	104.91	209.82
564	604	300	1	873.93	873.93
565	1374	493	2	54.70	109.40
566	1044	127	1	111.79	111.79
567	1154	104	3	50.61	151.83
568	340	358	5	68.55	342.75
569	516	486	5	55.39	276.95
570	2424	224	2	50.63	101.26
571	979	80	3	33.99	101.97
572	2077	38	5	32.14	160.70
573	1000	461	3	37.37	112.11
574	2313	302	5	84.18	420.90
575	2472	297	1	15.73	15.73
576	2453	139	4	38.32	153.28
577	947	497	2	25.76	51.52
578	2036	97	3	1307.31	3921.93
579	1213	304	2	951.76	1903.52
580	424	2	1	1385.15	1385.15
581	876	6	2	29.06	58.12
582	868	449	1	36.96	36.96
583	2313	271	5	148.66	743.30
584	1011	275	4	44.37	177.48
585	2100	362	4	60.33	241.32
586	1754	380	4	41.63	166.52
587	1832	295	3	39.05	117.15
588	672	174	5	80.98	404.90
589	1045	329	4	43.29	173.16
590	375	222	4	1222.06	4888.24
591	1353	360	3	41.94	125.82
592	2155	465	5	151.90	759.50
593	1869	133	3	22.04	66.12
594	826	168	1	68.11	68.11
595	1041	448	3	21.73	65.19
596	1947	299	1	10.57	10.57
597	2356	90	5	126.60	633.00
598	752	65	4	70.40	281.60
599	1046	209	3	70.93	212.79
600	1417	288	5	656.63	3283.15
601	1719	335	2	45.97	91.94
602	790	113	2	48.15	96.30
603	506	118	1	396.15	396.15
604	890	338	5	173.05	865.25
605	2106	340	5	41.26	206.30
606	2075	288	2	656.63	1313.26
607	458	335	5	45.97	229.85
608	1071	484	3	6.41	19.23
609	1470	356	5	378.69	1893.45
610	1279	131	4	16.19	64.76
611	1186	479	5	142.79	713.95
612	65	90	3	126.60	379.80
613	101	263	1	1800.59	1800.59
614	2193	409	5	62.83	314.15
615	1418	428	4	238.02	952.08
616	2289	366	2	437.87	875.74
617	716	200	2	50.56	101.12
618	485	74	2	293.77	587.54
619	1777	445	2	169.10	338.20
620	1266	80	4	33.99	135.96
621	2097	291	1	62.85	62.85
622	137	195	3	172.13	516.39
623	1717	9	5	437.61	2188.05
624	1515	338	4	173.05	692.20
625	2468	346	5	78.72	393.60
626	788	235	3	32.53	97.59
627	1887	485	2	22.10	44.20
628	821	260	4	50.36	201.44
629	243	189	4	30.28	121.12
630	2088	215	4	14.02	56.08
631	1255	158	3	191.11	573.33
632	1144	439	5	1837.39	9186.95
633	667	66	2	104.91	209.82
634	1291	157	1	212.65	212.65
635	1879	36	4	20.31	81.24
636	1619	437	2	11.99	23.98
637	2056	451	1	37.84	37.84
638	401	313	4	171.44	685.76
639	2465	462	4	290.55	1162.20
640	244	129	2	7.25	14.50
641	1077	387	5	43.03	215.15
642	289	377	2	57.24	114.48
643	853	467	1	100.75	100.75
644	1682	129	3	7.25	21.75
645	804	195	1	172.13	172.13
646	2353	444	5	276.46	1382.30
647	1206	451	1	37.84	37.84
648	1164	220	4	21.07	84.28
649	349	113	5	48.15	240.75
650	1724	262	5	55.35	276.75
651	1435	468	2	429.47	858.94
652	1020	299	3	10.57	31.71
653	232	422	2	57.25	114.50
654	524	41	4	480.19	1920.76
655	1002	226	3	173.76	521.28
656	2115	148	3	1809.97	5429.91
657	2243	171	5	127.13	635.65
658	639	361	3	67.61	202.83
659	1484	8	4	48.86	195.44
660	1811	10	5	35.19	175.95
661	1737	299	5	10.57	52.85
662	1746	443	5	17.52	87.60
663	1709	47	1	87.81	87.81
664	78	13	4	150.13	600.52
665	2059	216	2	316.91	633.82
666	2213	279	2	16.56	33.12
667	1053	154	2	17.90	35.80
668	703	324	4	74.42	297.68
669	1882	6	2	29.06	58.12
670	1717	486	2	55.39	110.78
671	1246	335	4	45.97	183.88
672	1708	212	1	43.24	43.24
673	783	268	4	441.06	1764.24
674	288	471	5	67.11	335.55
675	953	449	5	36.96	184.80
676	2400	196	5	36.96	184.80
677	1384	149	1	33.61	33.61
678	408	123	2	27.40	54.80
679	798	61	2	21.85	43.70
680	1154	78	2	1094.06	2188.12
681	1472	354	4	1200.13	4800.52
682	1147	92	5	222.12	1110.60
683	1396	243	1	56.14	56.14
684	67	73	1	496.56	496.56
685	1854	241	4	101.95	407.80
686	74	355	3	42.69	128.07
687	1769	392	3	35.62	106.86
688	1256	160	5	63.03	315.15
689	739	345	4	35.23	140.92
690	370	405	1	1223.24	1223.24
691	1267	461	5	37.37	186.85
692	1661	101	3	35.50	106.50
693	405	214	4	18.50	74.00
694	1744	321	4	35.69	142.76
695	455	412	5	32.98	164.90
696	914	163	3	463.60	1390.80
697	2087	302	3	84.18	252.54
698	1179	203	1	1902.34	1902.34
699	915	362	4	60.33	241.32
700	853	333	4	240.47	961.88
701	1020	470	4	18.69	74.76
702	1234	251	3	159.92	479.76
703	1689	396	3	34.20	102.60
704	716	442	2	19.09	38.18
705	1363	272	5	120.40	602.00
706	1815	415	5	46.59	232.95
707	2036	273	1	1558.15	1558.15
708	2393	369	5	61.27	306.35
709	957	392	5	35.62	178.10
710	1908	193	5	56.68	283.40
711	1554	486	1	55.39	55.39
712	616	236	4	1207.15	4828.60
713	349	168	2	68.11	136.22
714	1451	84	4	6.04	24.16
715	1157	475	5	218.49	1092.45
716	2418	152	1	70.59	70.59
717	1066	381	3	19.94	59.82
718	339	142	5	97.11	485.55
719	875	216	1	316.91	316.91
720	1706	136	3	68.76	206.28
721	1831	157	4	212.65	850.60
722	233	491	5	65.83	329.15
723	138	361	1	67.61	67.61
724	1859	141	5	25.01	125.05
725	1071	110	5	50.85	254.25
726	221	221	3	56.85	170.55
727	1519	489	3	88.05	264.15
728	219	388	5	15.05	75.25
729	1143	44	5	1624.58	8122.90
730	1087	242	4	899.18	3596.72
731	2301	103	2	168.49	336.98
732	2208	233	4	1143.94	4575.76
733	862	195	5	172.13	860.65
734	1363	373	2	24.06	48.12
735	113	249	5	17.60	88.00
736	197	102	3	93.77	281.31
737	1837	270	5	17.08	85.40
738	2390	300	5	873.93	4369.65
739	1560	54	4	177.79	711.16
740	376	256	4	175.24	700.96
741	275	262	2	55.35	110.70
742	930	488	5	47.80	239.00
743	1314	467	1	100.75	100.75
744	1215	32	2	36.44	72.88
745	1982	456	1	39.61	39.61
746	435	265	4	192.35	769.40
747	2283	490	4	46.96	187.84
748	625	296	1	19.61	19.61
749	439	167	2	67.26	134.52
750	875	369	2	61.27	122.54
751	1377	168	5	68.11	340.55
752	462	330	4	44.43	177.72
753	1206	336	1	12.98	12.98
754	1102	140	2	22.98	45.96
755	2227	217	1	102.71	102.71
756	422	124	5	133.17	665.85
757	755	476	1	1824.95	1824.95
758	1672	268	3	441.06	1323.18
759	248	223	1	35.37	35.37
760	1266	281	5	12.06	60.30
761	73	446	5	361.96	1809.80
762	450	21	1	42.95	42.95
763	1001	123	2	27.40	54.80
764	1784	385	5	13.45	67.25
765	131	361	5	67.61	338.05
766	879	98	5	13.19	65.95
767	1260	39	4	28.02	112.08
768	1231	498	1	224.97	224.97
769	1693	221	5	56.85	284.25
770	1595	212	2	43.24	86.48
771	137	179	1	224.59	224.59
772	890	128	4	38.41	153.64
773	2233	72	1	6.47	6.47
774	359	425	4	50.74	202.96
775	794	113	4	48.15	192.60
776	593	88	5	24.07	120.35
777	2281	176	1	94.41	94.41
778	1166	395	1	48.37	48.37
779	403	446	1	361.96	361.96
780	1043	239	4	28.15	112.60
781	1801	401	5	498.85	2494.25
782	1168	147	2	289.77	579.54
783	622	444	2	276.46	552.92
784	2435	450	4	33.27	133.08
785	1851	40	2	30.42	60.84
786	613	102	5	93.77	468.85
787	2161	15	5	34.26	171.30
788	591	197	2	135.87	271.74
789	1046	20	4	248.39	993.56
790	25	130	5	41.39	206.95
791	528	326	5	80.44	402.20
792	2352	465	2	151.90	303.80
793	1596	142	2	97.11	194.22
794	1764	155	3	24.69	74.07
795	1156	352	5	21.21	106.05
796	315	44	4	1624.58	6498.32
797	61	452	3	14.12	42.36
798	46	491	5	65.83	329.15
799	2483	121	4	16.58	66.32
800	1645	222	1	1222.06	1222.06
801	1732	56	2	60.90	121.80
802	593	117	3	70.83	212.49
803	228	67	1	47.52	47.52
804	1435	286	4	21.30	85.20
805	1041	98	4	13.19	52.76
806	444	496	3	7.91	23.73
807	2491	432	4	28.57	114.28
808	1934	81	5	40.13	200.65
809	1653	31	5	17.37	86.85
810	2152	27	4	46.75	187.00
811	2282	89	5	127.84	639.20
812	988	271	2	148.66	297.32
813	1766	352	2	21.21	42.42
814	451	241	3	101.95	305.85
815	2100	64	3	37.18	111.54
816	899	16	4	21.47	85.88
817	2300	85	1	478.53	478.53
818	2111	152	4	70.59	282.36
819	178	444	4	276.46	1105.84
820	1484	95	2	76.13	152.26
821	2255	104	1	50.61	50.61
822	1619	355	2	42.69	85.38
823	2424	413	2	68.02	136.04
824	863	327	1	126.09	126.09
825	1348	394	3	148.49	445.47
826	2211	377	3	57.24	171.72
827	1813	29	3	12.23	36.69
828	352	424	1	924.51	924.51
829	499	248	3	235.92	707.76
830	1916	100	4	128.64	514.56
831	2344	371	1	129.51	129.51
832	488	270	3	17.08	51.24
833	245	481	2	49.26	98.52
834	489	227	1	1612.51	1612.51
835	2340	455	5	40.50	202.50
836	392	80	4	33.99	135.96
837	2095	48	5	66.82	334.10
838	1496	320	5	82.53	412.65
839	1565	23	2	37.46	74.92
840	806	309	5	20.47	102.35
841	1209	173	3	112.69	338.07
842	163	248	3	235.92	707.76
843	1447	358	3	68.55	205.65
844	451	72	1	6.47	6.47
845	1844	230	3	12.95	38.85
846	1354	281	3	12.06	36.18
847	196	442	5	19.09	95.45
848	551	87	5	192.95	964.75
849	896	228	2	249.92	499.84
850	1049	362	1	60.33	60.33
851	2080	406	1	53.06	53.06
852	1401	101	3	35.50	106.50
853	1316	442	1	19.09	19.09
854	1261	437	3	11.99	35.97
855	516	105	4	45.66	182.64
856	199	190	1	45.03	45.03
857	59	94	1	124.81	124.81
858	1763	392	2	35.62	71.24
859	570	67	2	47.52	95.04
860	1865	178	3	386.24	1158.72
861	2205	349	1	67.66	67.66
862	456	118	2	396.15	792.30
863	973	382	4	139.89	559.56
864	1185	323	5	1447.42	7237.10
865	1670	234	4	59.10	236.40
866	1373	53	1	25.96	25.96
867	1820	407	3	262.44	787.32
868	1916	101	4	35.50	142.00
869	2095	33	5	36.04	180.20
870	655	488	5	47.80	239.00
871	1869	53	1	25.96	25.96
872	2204	378	1	245.22	245.22
873	2307	441	5	97.86	489.30
874	2192	29	4	12.23	48.92
875	431	103	4	168.49	673.96
876	244	51	5	54.55	272.75
877	1253	204	4	46.65	186.60
878	2038	334	5	22.93	114.65
879	1649	279	1	16.56	16.56
880	280	294	2	956.29	1912.58
881	2013	386	2	152.82	305.64
882	412	159	3	15.19	45.57
883	1992	473	3	160.59	481.77
884	281	9	3	437.61	1312.83
885	918	430	4	143.84	575.36
886	1747	470	5	18.69	93.45
887	795	242	3	899.18	2697.54
888	585	350	3	29.82	89.46
889	8	480	4	138.76	555.04
890	1644	217	4	102.71	410.84
891	1975	488	5	47.80	239.00
892	873	196	3	36.96	110.88
893	899	467	1	100.75	100.75
894	882	10	2	35.19	70.38
895	490	447	4	18.24	72.96
896	339	460	4	53.88	215.52
897	860	463	3	25.47	76.41
898	971	409	1	62.83	62.83
899	889	169	1	186.87	186.87
900	1719	133	4	22.04	88.16
901	981	439	2	1837.39	3674.78
902	252	381	2	19.94	39.88
903	125	220	5	21.07	105.35
904	590	395	3	48.37	145.11
905	375	436	4	70.65	282.60
906	343	213	2	65.92	131.84
907	1497	386	4	152.82	611.28
908	2315	247	5	23.80	119.00
909	1640	342	2	70.36	140.72
910	1787	146	1	50.37	50.37
911	169	27	3	46.75	140.25
912	576	96	5	494.22	2471.10
913	680	204	4	46.65	186.60
914	2404	411	3	40.37	121.11
915	768	414	4	32.14	128.56
916	239	11	2	53.63	107.26
917	1217	287	5	13.46	67.30
918	443	92	2	222.12	444.24
919	1506	272	4	120.40	481.60
920	800	162	2	51.77	103.54
921	1490	191	1	49.67	49.67
922	1714	474	5	62.56	312.80
923	924	459	4	53.30	213.20
924	1516	442	5	19.09	95.45
925	1585	367	2	119.27	238.54
926	1685	189	1	30.28	30.28
927	1984	111	2	38.70	77.40
928	606	197	5	135.87	679.35
929	935	268	1	441.06	441.06
930	1384	334	3	22.93	68.79
931	1834	231	5	1595.61	7978.05
932	1657	371	3	129.51	388.53
933	2034	441	3	97.86	293.58
934	1897	268	2	441.06	882.12
935	2175	337	2	71.01	142.02
936	1286	473	2	160.59	321.18
937	1265	240	2	77.63	155.26
938	2104	187	3	131.18	393.54
939	1159	358	1	68.55	68.55
940	1065	54	4	177.79	711.16
941	1224	90	3	126.60	379.80
942	1341	190	1	45.03	45.03
943	1558	270	5	17.08	85.40
944	2051	20	3	248.39	745.17
945	2468	115	3	21.78	65.34
946	601	369	5	61.27	306.35
947	1281	296	2	19.61	39.22
948	170	67	5	47.52	237.60
949	188	241	4	101.95	407.80
950	1262	173	4	112.69	450.76
951	1679	143	1	432.47	432.47
952	1171	39	4	28.02	112.08
953	521	278	2	39.34	78.68
954	1844	133	3	22.04	66.12
955	278	476	3	1824.95	5474.85
956	32	278	4	39.34	157.36
957	32	390	4	43.60	174.40
958	1273	309	3	20.47	61.41
959	598	133	4	22.04	88.16
960	487	483	2	75.61	151.22
961	2135	445	1	169.10	169.10
962	1099	298	3	137.17	411.51
963	551	104	5	50.61	253.05
964	1923	411	3	40.37	121.11
965	2205	185	5	68.10	340.50
966	434	71	3	41.29	123.87
967	667	117	1	70.83	70.83
968	1796	495	4	28.08	112.32
969	1569	269	3	33.41	100.23
970	364	183	5	20.45	102.25
971	888	112	1	17.58	17.58
972	529	238	4	54.26	217.04
973	1138	175	1	1956.92	1956.92
974	1037	269	4	33.41	133.64
975	1227	257	1	13.06	13.06
976	1109	304	3	951.76	2855.28
977	111	191	1	49.67	49.67
978	2247	351	2	47.82	95.64
979	729	80	2	33.99	67.98
980	889	240	1	77.63	77.63
981	2315	119	5	254.39	1271.95
982	1924	70	1	194.01	194.01
983	55	356	4	378.69	1514.76
984	1526	27	5	46.75	233.75
985	1648	366	5	437.87	2189.35
986	2036	58	1	39.85	39.85
987	1894	23	3	37.46	112.38
988	1560	266	1	243.80	243.80
989	589	62	2	37.50	75.00
990	1664	283	3	26.19	78.57
991	1265	149	3	33.61	100.83
992	2058	472	4	91.09	364.36
993	826	454	4	10.72	42.88
994	1440	481	1	49.26	49.26
995	246	200	5	50.56	252.80
996	1344	184	3	50.91	152.73
997	1018	459	5	53.30	266.50
998	2221	216	2	316.91	633.82
999	1600	461	4	37.37	149.48
1000	1976	24	4	18.15	72.60
1001	1334	455	3	40.50	121.50
1002	2447	211	1	127.39	127.39
1003	1250	491	2	65.83	131.66
1004	1547	498	5	224.97	1124.85
1005	1100	304	2	951.76	1903.52
1006	235	211	5	127.39	636.95
1007	592	95	4	76.13	304.52
1008	1198	364	3	157.44	472.32
1009	765	345	2	35.23	70.46
1010	327	7	2	1801.75	3603.50
1011	2221	214	1	18.50	18.50
1012	1063	212	2	43.24	86.48
1013	1526	214	4	18.50	74.00
1014	1877	272	3	120.40	361.20
1015	1011	22	1	133.18	133.18
1016	738	182	5	18.31	91.55
1017	2002	323	5	1447.42	7237.10
1018	42	1	4	31.96	127.84
1019	35	276	2	44.63	89.26
1020	1893	453	1	27.19	27.19
1021	409	38	5	32.14	160.70
1022	1417	273	2	1558.15	3116.30
1023	310	341	4	59.37	237.48
1024	980	430	4	143.84	575.36
1025	1502	475	4	218.49	873.96
1026	2381	53	4	25.96	103.84
1027	2340	435	1	12.96	12.96
1028	2484	45	5	40.34	201.70
1029	170	187	4	131.18	524.72
1030	1516	147	4	289.77	1159.08
1031	1518	56	4	60.90	243.60
1032	2360	4	4	145.93	583.72
1033	1108	139	1	38.32	38.32
1034	2381	468	1	429.47	429.47
1035	41	211	2	127.39	254.78
1036	1386	362	3	60.33	180.99
1037	92	82	4	48.26	193.04
1038	2486	428	2	238.02	476.04
1039	903	47	3	87.81	263.43
1040	1560	118	2	396.15	792.30
1041	1159	441	1	97.86	97.86
1042	1531	358	2	68.55	137.10
1043	1518	351	2	47.82	95.64
1044	2433	293	2	77.37	154.74
1045	303	403	2	208.42	416.84
1046	701	57	3	47.99	143.97
1047	379	403	5	208.42	1042.10
1048	1781	192	5	42.22	211.10
1049	1099	382	5	139.89	699.45
1050	510	278	1	39.34	39.34
1051	2113	185	1	68.10	68.10
1052	896	83	2	40.42	80.84
1053	2034	170	4	8.45	33.80
1054	1965	431	4	226.93	907.72
1055	892	419	5	1124.89	5624.45
1056	2060	168	2	68.11	136.22
1057	476	462	4	290.55	1162.20
1058	1259	211	4	127.39	509.56
1059	2431	475	3	218.49	655.47
1060	2098	456	5	39.61	198.05
1061	301	296	1	19.61	19.61
1062	94	408	1	24.29	24.29
1063	1854	113	4	48.15	192.60
1064	411	300	4	873.93	3495.72
1065	349	103	5	168.49	842.45
1066	599	157	1	212.65	212.65
1067	2469	417	3	44.72	134.16
1068	2351	494	2	25.21	50.42
1069	1227	83	3	40.42	121.26
1070	231	103	3	168.49	505.47
1071	2112	368	4	234.47	937.88
1072	1741	240	1	77.63	77.63
1073	1357	249	3	17.60	52.80
1074	1621	345	3	35.23	105.69
1075	1810	200	1	50.56	50.56
1076	290	328	5	53.11	265.55
1077	132	149	2	33.61	67.22
1078	1543	251	2	159.92	319.84
1079	657	463	2	25.47	50.94
1080	885	209	3	70.93	212.79
1081	2424	386	1	152.82	152.82
1082	462	38	4	32.14	128.56
1083	2219	155	3	24.69	74.07
1084	390	202	4	20.16	80.64
1085	2451	272	3	120.40	361.20
1086	1152	361	4	67.61	270.44
1087	377	156	3	446.90	1340.70
1088	2050	185	2	68.10	136.20
1089	1147	387	4	43.03	172.12
1090	1657	165	1	10.39	10.39
1091	567	305	1	64.25	64.25
1092	1646	452	5	14.12	70.60
1093	1350	274	4	78.08	312.32
1094	1069	14	2	201.38	402.76
1095	767	20	4	248.39	993.56
1096	187	342	2	70.36	140.72
1097	2102	468	4	429.47	1717.88
1098	1820	34	2	37.20	74.40
1099	2290	403	1	208.42	208.42
1100	2482	493	5	54.70	273.50
1101	115	111	5	38.70	193.50
1102	1756	33	3	36.04	108.12
1103	1676	115	4	21.78	87.12
1104	29	243	5	56.14	280.70
1105	941	459	3	53.30	159.90
1106	2066	378	3	245.22	735.66
1107	2253	480	5	138.76	693.80
1108	802	337	2	71.01	142.02
1109	1298	148	2	1809.97	3619.94
1110	1569	369	4	61.27	245.08
1111	1667	393	4	15.33	61.32
1112	462	344	4	39.33	157.32
1113	2168	325	3	33.89	101.67
1114	43	437	1	11.99	11.99
1115	1714	422	3	57.25	171.75
1116	300	417	5	44.72	223.60
1117	1953	332	1	20.41	20.41
1118	330	415	1	46.59	46.59
1119	785	320	2	82.53	165.06
1120	2022	456	5	39.61	198.05
1121	478	405	3	1223.24	3669.72
1122	1782	440	1	119.15	119.15
1123	948	307	2	43.66	87.32
1124	1775	25	3	48.32	144.96
1125	2284	20	3	248.39	745.17
1126	1885	190	1	45.03	45.03
1127	930	100	2	128.64	257.28
1128	608	386	3	152.82	458.46
1129	431	81	3	40.13	120.39
1130	1029	433	3	10.07	30.21
1131	2042	82	5	48.26	241.30
1132	697	482	4	26.78	107.12
1133	1449	454	4	10.72	42.88
1134	733	123	2	27.40	54.80
1135	463	168	2	68.11	136.22
1136	2346	265	5	192.35	961.75
1137	839	104	5	50.61	253.05
1138	187	444	2	276.46	552.92
1139	790	478	5	94.13	470.65
1140	1283	289	1	1622.15	1622.15
1141	654	268	3	441.06	1323.18
1142	1275	57	4	47.99	191.96
1143	72	227	2	1612.51	3225.02
1144	535	17	2	31.74	63.48
1145	1903	78	1	1094.06	1094.06
1146	1865	306	3	155.79	467.37
1147	286	39	3	28.02	84.06
1148	625	378	3	245.22	735.66
1149	1422	285	4	31.36	125.44
1150	1275	478	1	94.13	94.13
1151	2126	248	3	235.92	707.76
1152	601	374	4	44.65	178.60
1153	655	91	3	81.18	243.54
1154	690	423	5	121.24	606.20
1155	264	380	2	41.63	83.26
1156	1206	47	2	87.81	175.62
1157	258	263	3	1800.59	5401.77
1158	1465	36	1	20.31	20.31
1159	1970	318	1	50.11	50.11
1160	1003	281	3	12.06	36.18
1161	711	94	5	124.81	624.05
1162	924	450	4	33.27	133.08
1163	2355	52	5	1713.47	8567.35
1164	2457	237	5	24.89	124.45
1165	2137	405	4	1223.24	4892.96
1166	621	431	5	226.93	1134.65
1167	444	247	3	23.80	71.40
1168	892	401	2	498.85	997.70
1169	1086	155	1	24.69	24.69
1170	2490	364	2	157.44	314.88
1171	220	222	1	1222.06	1222.06
1172	635	38	3	32.14	96.42
1173	90	74	1	293.77	293.77
1174	1513	49	5	36.01	180.05
1175	25	289	3	1622.15	4866.45
1176	1742	182	3	18.31	54.93
1177	2224	471	2	67.11	134.22
1178	222	265	4	192.35	769.40
1179	1042	43	4	87.93	351.72
1180	380	122	4	158.20	632.80
1181	788	30	4	72.53	290.12
1182	692	297	1	15.73	15.73
1183	1517	37	5	168.04	840.20
1184	516	406	2	53.06	106.12
1185	1362	82	1	48.26	48.26
1186	1840	201	5	20.18	100.90
1187	1476	7	3	1801.75	5405.25
1188	959	449	5	36.96	184.80
1189	1532	191	1	49.67	49.67
1190	956	173	1	112.69	112.69
1191	797	56	1	60.90	60.90
1192	234	498	5	224.97	1124.85
1193	2383	290	4	263.35	1053.40
1194	1685	113	2	48.15	96.30
1195	1466	188	1	58.13	58.13
1196	2025	90	3	126.60	379.80
1197	1840	131	2	16.19	32.38
1198	2274	353	5	139.69	698.45
1199	505	328	1	53.11	53.11
1200	984	110	3	50.85	152.55
1201	1883	324	1	74.42	74.42
1202	616	175	1	1956.92	1956.92
1203	2286	446	3	361.96	1085.88
1204	1417	477	2	183.20	366.40
1205	823	248	4	235.92	943.68
1206	744	160	4	63.03	252.12
1207	2471	243	5	56.14	280.70
1208	2210	428	4	238.02	952.08
1209	730	241	2	101.95	203.90
1210	1197	494	1	25.21	25.21
1211	875	330	1	44.43	44.43
1212	844	148	4	1809.97	7239.88
1213	2107	92	5	222.12	1110.60
1214	1456	89	1	127.84	127.84
1215	1577	428	5	238.02	1190.10
1216	1999	212	4	43.24	172.96
1217	2096	399	1	71.86	71.86
1218	510	495	1	28.08	28.08
1219	519	101	5	35.50	177.50
1220	641	365	4	22.34	89.36
1221	1705	421	5	33.87	169.35
1222	3	39	3	28.02	84.06
1223	1595	32	4	36.44	145.76
1224	1815	114	3	152.22	456.66
1225	2426	204	2	46.65	93.30
1226	1655	114	3	152.22	456.66
1227	1481	391	4	169.39	677.56
1228	1604	56	1	60.90	60.90
1229	1625	211	4	127.39	509.56
1230	1054	76	5	9.20	46.00
1231	8	196	1	36.96	36.96
1232	18	157	2	212.65	425.30
1233	1021	66	4	104.91	419.64
1234	1319	437	5	11.99	59.95
1235	595	39	2	28.02	56.04
1236	2175	49	2	36.01	72.02
1237	999	290	1	263.35	263.35
1238	2055	462	3	290.55	871.65
1239	68	118	3	396.15	1188.45
1240	1979	255	2	96.70	193.40
1241	1420	440	2	119.15	238.30
1242	2410	289	1	1622.15	1622.15
1243	517	439	4	1837.39	7349.56
1244	1006	210	1	117.15	117.15
1245	794	267	1	109.12	109.12
1246	1192	490	2	46.96	93.92
1247	1640	417	2	44.72	89.44
1248	1810	198	1	104.90	104.90
1249	923	168	2	68.11	136.22
1250	1701	99	5	42.94	214.70
1251	2105	355	4	42.69	170.76
1252	1371	414	3	32.14	96.42
1253	813	447	3	18.24	54.72
1254	1552	331	1	65.98	65.98
1255	733	473	3	160.59	481.77
1256	1926	127	2	111.79	223.58
1257	1815	406	2	53.06	106.12
1258	1682	50	3	43.57	130.71
1259	272	251	1	159.92	159.92
1260	1260	52	1	1713.47	1713.47
1261	1108	469	3	27.64	82.92
1262	94	244	2	26.32	52.64
1263	1235	31	1	17.37	17.37
1264	2438	482	4	26.78	107.12
1265	2333	268	4	441.06	1764.24
1266	421	199	4	33.04	132.16
1267	1108	309	1	20.47	20.47
1268	1332	289	1	1622.15	1622.15
1269	1726	252	3	175.20	525.60
1270	1663	445	1	169.10	169.10
1271	2135	296	3	19.61	58.83
1272	2200	26	3	173.16	519.48
1273	620	231	5	1595.61	7978.05
1274	1758	466	5	43.61	218.05
1275	1068	34	2	37.20	74.40
1276	1172	288	1	656.63	656.63
1277	302	157	1	212.65	212.65
1278	337	451	4	37.84	151.36
1279	506	164	4	143.24	572.96
1280	1367	440	2	119.15	238.30
1281	1853	364	2	157.44	314.88
1282	2482	179	5	224.59	1122.95
1283	273	185	2	68.10	136.20
1284	886	51	2	54.55	109.10
1285	1358	387	2	43.03	86.06
1286	1254	393	2	15.33	30.66
1287	2254	340	3	41.26	123.78
1288	2281	320	1	82.53	82.53
1289	1070	36	1	20.31	20.31
1290	2496	120	3	41.71	125.13
1291	93	373	2	24.06	48.12
1292	702	198	5	104.90	524.50
1293	1665	309	2	20.47	40.94
1294	947	500	2	175.70	351.40
1295	1877	120	2	41.71	83.42
1296	1822	343	1	45.18	45.18
1297	2430	373	3	24.06	72.18
1298	506	421	4	33.87	135.48
1299	1476	466	2	43.61	87.22
1300	430	461	1	37.37	37.37
1301	1558	71	1	41.29	41.29
1302	1164	340	5	41.26	206.30
1303	1087	8	1	48.86	48.86
1304	1510	342	1	70.36	70.36
1305	171	429	1	135.14	135.14
1306	2157	204	2	46.65	93.30
1307	2021	77	3	57.74	173.22
1308	1529	70	5	194.01	970.05
1309	2227	295	3	39.05	117.15
1310	802	366	2	437.87	875.74
1311	1524	373	2	24.06	48.12
1312	1537	421	5	33.87	169.35
1313	2218	194	1	37.99	37.99
1314	406	126	2	47.88	95.76
1315	1000	9	2	437.61	875.22
1316	2162	300	2	873.93	1747.86
1317	955	308	3	197.22	591.66
1318	132	116	2	1031.32	2062.64
1319	1963	261	5	64.39	321.95
1320	1512	324	4	74.42	297.68
1321	1923	415	1	46.59	46.59
1322	2105	386	2	152.82	305.64
1323	2248	216	2	316.91	633.82
1324	1303	124	2	133.17	266.34
1325	936	499	5	31.84	159.20
1326	688	499	3	31.84	95.52
1327	1688	457	3	10.57	31.71
1328	1012	217	4	102.71	410.84
1329	914	354	3	1200.13	3600.39
1330	1030	489	3	88.05	264.15
1331	1700	309	2	20.47	40.94
1332	917	462	2	290.55	581.10
1333	2423	438	3	7.95	23.85
1334	54	356	2	378.69	757.38
1335	2296	489	5	88.05	440.25
1336	2290	250	4	40.88	163.52
1337	1380	364	3	157.44	472.32
1338	676	315	3	1323.55	3970.65
1339	120	497	5	25.76	128.80
1340	1058	205	4	19.42	77.68
1341	941	351	4	47.82	191.28
1342	2411	155	1	24.69	24.69
1343	1717	126	2	47.88	95.76
1344	890	206	3	45.80	137.40
1345	2005	277	5	1676.49	8382.45
1346	1983	228	5	249.92	1249.60
1347	1883	12	4	45.14	180.56
1348	741	130	4	41.39	165.56
1349	1744	389	2	71.80	143.60
1350	2447	117	3	70.83	212.49
1351	665	425	2	50.74	101.48
1352	455	471	1	67.11	67.11
1353	64	268	5	441.06	2205.30
1354	1337	490	3	46.96	140.88
1355	1467	280	2	241.86	483.72
1356	1103	25	4	48.32	193.28
1357	1164	381	4	19.94	79.76
1358	159	422	4	57.25	229.00
1359	1511	37	2	168.04	336.08
1360	937	197	3	135.87	407.61
1361	841	246	5	1098.58	5492.90
1362	1046	491	5	65.83	329.15
1363	557	456	3	39.61	118.83
1364	2493	120	2	41.71	83.42
1365	986	471	5	67.11	335.55
1366	498	413	4	68.02	272.08
1367	792	473	2	160.59	321.18
1368	1138	11	3	53.63	160.89
1369	371	426	4	34.78	139.12
1370	531	146	1	50.37	50.37
1371	605	229	3	51.78	155.34
1372	278	311	2	475.70	951.40
1373	2342	190	4	45.03	180.12
1374	1020	18	4	178.99	715.96
1375	950	352	3	21.21	63.63
1376	691	133	3	22.04	66.12
1377	1879	78	5	1094.06	5470.30
1378	1834	227	1	1612.51	1612.51
1379	763	195	3	172.13	516.39
1380	872	180	4	432.09	1728.36
1381	489	12	4	45.14	180.56
1382	292	123	2	27.40	54.80
1383	1140	120	3	41.71	125.13
1384	1380	469	2	27.64	55.28
1385	2397	136	5	68.76	343.80
1386	2054	73	1	496.56	496.56
1387	1306	479	5	142.79	713.95
1388	176	283	4	26.19	104.76
1389	1463	84	4	6.04	24.16
1390	2304	310	3	38.48	115.44
1391	1528	86	1	50.97	50.97
1392	216	345	3	35.23	105.69
1393	207	232	4	43.21	172.84
1394	898	139	3	38.32	114.96
1395	998	407	2	262.44	524.88
1396	557	424	2	924.51	1849.02
1397	234	394	4	148.49	593.96
1398	219	268	5	441.06	2205.30
1399	1154	440	3	119.15	357.45
1400	2048	201	2	20.18	40.36
1401	149	24	3	18.15	54.45
1402	17	287	4	13.46	53.84
1403	1130	404	3	18.86	56.58
1404	1793	7	4	1801.75	7207.00
1405	1769	339	4	187.08	748.32
1406	2195	485	3	22.10	66.30
1407	1416	291	2	62.85	125.70
1408	437	444	3	276.46	829.38
1409	694	97	2	1307.31	2614.62
1410	1453	489	5	88.05	440.25
1411	93	74	5	293.77	1468.85
1412	2333	47	4	87.81	351.24
1413	285	227	2	1612.51	3225.02
1414	1432	339	5	187.08	935.40
1415	1245	35	5	47.26	236.30
1416	1820	414	3	32.14	96.42
1417	1324	68	2	106.83	213.66
1418	336	105	2	45.66	91.32
1419	1639	360	3	41.94	125.82
1420	2272	67	2	47.52	95.04
1421	1742	241	4	101.95	407.80
1422	2286	20	4	248.39	993.56
1423	2198	184	5	50.91	254.55
1424	208	317	2	35.02	70.04
1425	1989	473	3	160.59	481.77
1426	572	24	1	18.15	18.15
1427	959	346	3	78.72	236.16
1428	1566	166	4	39.81	159.24
1429	1500	409	1	62.83	62.83
1430	564	274	2	78.08	156.16
1431	1823	234	4	59.10	236.40
1432	778	494	4	25.21	100.84
1433	1945	174	2	80.98	161.96
1434	336	425	5	50.74	253.70
1435	117	209	2	70.93	141.86
1436	912	262	3	55.35	166.05
1437	1979	98	3	13.19	39.57
1438	2062	298	2	137.17	274.34
1439	1366	356	3	378.69	1136.07
1440	787	127	4	111.79	447.16
1441	1347	162	5	51.77	258.85
1442	1093	382	3	139.89	419.67
1443	391	447	5	18.24	91.20
1444	192	123	4	27.40	109.60
1445	1313	25	2	48.32	96.64
1446	394	58	5	39.85	199.25
1447	1467	413	1	68.02	68.02
1448	2154	185	4	68.10	272.40
1449	2035	370	1	460.14	460.14
1450	2036	109	4	62.66	250.64
1451	1018	423	5	121.24	606.20
1452	2357	450	2	33.27	66.54
1453	1268	150	3	68.63	205.89
1454	2306	313	5	171.44	857.20
1455	536	40	4	30.42	121.68
1456	1474	247	5	23.80	119.00
1457	752	10	2	35.19	70.38
1458	746	221	5	56.85	284.25
1459	1085	135	5	28.66	143.30
1460	731	474	5	62.56	312.80
1461	673	363	1	30.19	30.19
1462	319	489	4	88.05	352.20
1463	2237	353	1	139.69	139.69
1464	1052	232	3	43.21	129.63
1465	1323	152	2	70.59	141.18
1466	318	38	5	32.14	160.70
1467	2145	127	1	111.79	111.79
1468	155	440	1	119.15	119.15
1469	2397	234	4	59.10	236.40
1470	1187	71	5	41.29	206.45
1471	2093	257	2	13.06	26.12
1472	2358	204	4	46.65	186.60
1473	2250	263	1	1800.59	1800.59
1474	157	109	1	62.66	62.66
1475	698	222	2	1222.06	2444.12
1476	607	499	1	31.84	31.84
1477	816	109	4	62.66	250.64
1478	246	112	2	17.58	35.16
1479	82	137	4	59.63	238.52
1480	2406	142	2	97.11	194.22
1481	1376	421	4	33.87	135.48
1482	1071	499	1	31.84	31.84
1483	1748	179	4	224.59	898.36
1484	1482	217	2	102.71	205.42
1485	922	157	1	212.65	212.65
1486	1903	361	1	67.61	67.61
1487	377	261	3	64.39	193.17
1488	1770	53	5	25.96	129.80
1489	2071	242	5	899.18	4495.90
1490	83	229	4	51.78	207.12
1491	1598	369	4	61.27	245.08
1492	735	103	5	168.49	842.45
1493	2015	139	1	38.32	38.32
1494	1408	48	5	66.82	334.10
1495	753	51	2	54.55	109.10
1496	624	29	4	12.23	48.92
1497	189	457	3	10.57	31.71
1498	1104	99	5	42.94	214.70
1499	1061	199	2	33.04	66.08
1500	1567	109	1	62.66	62.66
1501	1857	35	2	47.26	94.52
1502	41	131	1	16.19	16.19
1503	302	452	3	14.12	42.36
1504	2433	357	4	142.57	570.28
1505	941	468	2	429.47	858.94
1506	1967	352	5	21.21	106.05
1507	2020	154	3	17.90	53.70
1508	1774	87	4	192.95	771.80
1509	2076	467	4	100.75	403.00
1510	475	45	2	40.34	80.68
1511	2400	398	3	237.21	711.63
1512	2193	493	3	54.70	164.10
1513	1060	306	2	155.79	311.58
1514	38	412	5	32.98	164.90
1515	1962	352	2	21.21	42.42
1516	579	37	4	168.04	672.16
1517	1749	122	3	158.20	474.60
1518	1065	447	3	18.24	54.72
1519	1222	6	4	29.06	116.24
1520	1261	285	2	31.36	62.72
1521	1583	187	2	131.18	262.36
1522	2191	1	5	31.96	159.80
1523	1915	297	1	15.73	15.73
1524	130	142	4	97.11	388.44
1525	2211	126	2	47.88	95.76
1526	905	422	5	57.25	286.25
1527	1660	29	5	12.23	61.15
1528	1024	58	3	39.85	119.55
1529	2207	172	1	450.87	450.87
1530	1229	485	2	22.10	44.20
1531	167	113	4	48.15	192.60
1532	2062	80	5	33.99	169.95
1533	1414	96	3	494.22	1482.66
1534	1914	389	5	71.80	359.00
1535	1395	420	1	163.63	163.63
1536	1478	363	1	30.19	30.19
1537	2479	464	2	76.32	152.64
1538	770	281	4	12.06	48.24
1539	1630	226	4	173.76	695.04
1540	2461	393	3	15.33	45.99
1541	443	319	5	1794.17	8970.85
1542	945	138	4	68.43	273.72
1543	1345	81	1	40.13	40.13
1544	291	233	5	1143.94	5719.70
1545	1512	252	4	175.20	700.80
1546	1734	316	4	30.13	120.52
1547	478	220	1	21.07	21.07
1548	1791	356	4	378.69	1514.76
1549	600	314	5	158.44	792.20
1550	973	43	2	87.93	175.86
1551	439	430	2	143.84	287.68
1552	1888	204	3	46.65	139.95
1553	2205	94	2	124.81	249.62
1554	2174	53	5	25.96	129.80
1555	1133	470	1	18.69	18.69
1556	2450	129	1	7.25	7.25
1557	2289	489	1	88.05	88.05
1558	1062	500	4	175.70	702.80
1559	1469	147	1	289.77	289.77
1560	1850	199	2	33.04	66.08
1561	1546	245	3	71.20	213.60
1562	1824	25	5	48.32	241.60
1563	2470	74	1	293.77	293.77
1564	657	65	1	70.40	70.40
1565	2108	244	4	26.32	105.28
1566	2131	52	2	1713.47	3426.94
1567	1482	427	5	156.77	783.85
1568	1367	70	5	194.01	970.05
1569	359	109	3	62.66	187.98
1570	1063	235	5	32.53	162.65
1571	445	399	1	71.86	71.86
1572	771	18	1	178.99	178.99
1573	1309	130	2	41.39	82.78
1574	2081	424	2	924.51	1849.02
1575	289	187	2	131.18	262.36
1576	2172	256	3	175.24	525.72
1577	1213	70	3	194.01	582.03
1578	1366	232	2	43.21	86.42
1579	1988	35	4	47.26	189.04
1580	2177	35	4	47.26	189.04
1581	1611	189	4	30.28	121.12
1582	1515	132	2	41.64	83.28
1583	690	304	3	951.76	2855.28
1584	2017	458	5	43.32	216.60
1585	495	417	1	44.72	44.72
1586	1036	457	3	10.57	31.71
1587	1700	7	1	1801.75	1801.75
1588	836	401	5	498.85	2494.25
1589	1972	69	5	259.22	1296.10
1590	1145	343	3	45.18	135.54
1591	49	496	1	7.91	7.91
1592	1148	362	1	60.33	60.33
1593	2205	439	1	1837.39	1837.39
1594	1383	190	4	45.03	180.12
1595	107	322	4	134.71	538.84
1596	1012	382	5	139.89	699.45
1597	1981	150	2	68.63	137.26
1598	1222	28	1	69.72	69.72
1599	1492	203	1	1902.34	1902.34
1600	425	169	3	186.87	560.61
1601	2158	183	5	20.45	102.25
1602	2499	2	1	1385.15	1385.15
1603	429	60	1	1576.99	1576.99
1604	2354	211	4	127.39	509.56
1605	1908	228	1	249.92	249.92
1606	2307	352	3	21.21	63.63
1607	1023	72	5	6.47	32.35
1608	714	278	5	39.34	196.70
1609	772	251	1	159.92	159.92
1610	2169	467	1	100.75	100.75
1611	1003	194	1	37.99	37.99
1612	281	236	3	1207.15	3621.45
1613	2302	370	2	460.14	920.28
1614	1754	140	1	22.98	22.98
1615	373	115	2	21.78	43.56
1616	1623	360	5	41.94	209.70
1617	1119	389	5	71.80	359.00
1618	1190	154	4	17.90	71.60
1619	1652	219	4	31.22	124.88
1620	1565	256	1	175.24	175.24
1621	695	334	4	22.93	91.72
1622	1499	294	5	956.29	4781.45
1623	925	233	1	1143.94	1143.94
1624	21	233	1	1143.94	1143.94
1625	494	327	5	126.09	630.45
1626	112	129	5	7.25	36.25
1627	829	242	1	899.18	899.18
1628	2417	207	2	76.84	153.68
1629	1376	218	3	34.45	103.35
1630	79	47	2	87.81	175.62
1631	306	256	1	175.24	175.24
1632	1465	478	2	94.13	188.26
1633	2213	62	3	37.50	112.50
1634	516	434	5	49.87	249.35
1635	2393	73	3	496.56	1489.68
1636	1320	429	3	135.14	405.42
1637	2487	476	5	1824.95	9124.75
1638	1228	8	3	48.86	146.58
1639	1063	310	2	38.48	76.96
1640	1164	37	1	168.04	168.04
1641	2050	427	2	156.77	313.54
1642	972	39	3	28.02	84.06
1643	785	339	2	187.08	374.16
1644	1320	193	1	56.68	56.68
1645	2380	236	4	1207.15	4828.60
1646	2393	162	1	51.77	51.77
1647	1646	191	4	49.67	198.68
1648	1726	489	5	88.05	440.25
1649	222	42	1	90.48	90.48
1650	1119	302	4	84.18	336.72
1651	852	198	5	104.90	524.50
1652	1890	71	1	41.29	41.29
1653	86	323	2	1447.42	2894.84
1654	2443	357	5	142.57	712.85
1655	360	3	4	26.19	104.76
1656	718	86	1	50.97	50.97
1657	1011	460	1	53.88	53.88
1658	92	167	3	67.26	201.78
1659	1016	174	4	80.98	323.92
1660	1006	88	1	24.07	24.07
1661	1509	339	1	187.08	187.08
1662	69	335	4	45.97	183.88
1663	649	22	1	133.18	133.18
1664	114	330	2	44.43	88.86
1665	2115	140	2	22.98	45.96
1666	142	399	1	71.86	71.86
1667	232	500	5	175.70	878.50
1668	1804	269	3	33.41	100.23
1669	2444	99	1	42.94	42.94
1670	467	410	2	178.58	357.16
1671	869	16	3	21.47	64.41
1672	2487	221	4	56.85	227.40
1673	2136	169	1	186.87	186.87
1674	1321	284	2	22.44	44.88
1675	1468	60	5	1576.99	7884.95
1676	1424	266	5	243.80	1219.00
1677	149	233	1	1143.94	1143.94
1678	160	256	3	175.24	525.72
1679	2002	385	1	13.45	13.45
1680	506	297	1	15.73	15.73
1681	1567	124	2	133.17	266.34
1682	2350	316	5	30.13	150.65
1683	1023	198	4	104.90	419.60
1684	716	405	3	1223.24	3669.72
1685	1342	438	3	7.95	23.85
1686	2265	329	2	43.29	86.58
1687	1296	286	4	21.30	85.20
1688	1593	74	1	293.77	293.77
1689	2036	106	5	77.98	389.90
1690	1790	231	2	1595.61	3191.22
1691	1813	363	4	30.19	120.76
1692	1593	467	4	100.75	403.00
1693	219	203	5	1902.34	9511.70
1694	1906	160	3	63.03	189.09
1695	654	121	4	16.58	66.32
1696	1475	129	4	7.25	29.00
1697	1006	186	3	35.21	105.63
1698	1626	466	4	43.61	174.44
1699	840	25	2	48.32	96.64
1700	362	277	5	1676.49	8382.45
1701	404	178	1	386.24	386.24
1702	913	489	2	88.05	176.10
1703	2215	162	5	51.77	258.85
1704	2202	339	1	187.08	187.08
1705	506	363	1	30.19	30.19
1706	1133	433	4	10.07	40.28
1707	1554	141	3	25.01	75.03
1708	2491	457	5	10.57	52.85
1709	1702	226	1	173.76	173.76
1710	1317	387	4	43.03	172.12
1711	1782	105	1	45.66	45.66
1712	844	189	5	30.28	151.40
1713	1543	383	3	29.97	89.91
1714	264	274	2	78.08	156.16
1715	885	201	2	20.18	40.36
1716	404	73	2	496.56	993.12
1717	1594	386	1	152.82	152.82
1718	1360	371	3	129.51	388.53
1719	425	232	3	43.21	129.63
1720	1582	275	1	44.37	44.37
1721	1679	305	1	64.25	64.25
1722	1196	65	2	70.40	140.80
1723	1874	461	1	37.37	37.37
1724	1254	129	3	7.25	21.75
1725	205	472	2	91.09	182.18
1726	2013	158	3	191.11	573.33
1727	931	289	1	1622.15	1622.15
1728	1236	161	4	183.22	732.88
1729	12	97	5	1307.31	6536.55
1730	1752	309	4	20.47	81.88
1731	230	141	2	25.01	50.02
1732	1119	163	4	463.60	1854.40
1733	2156	323	1	1447.42	1447.42
1734	247	124	4	133.17	532.68
1735	2300	440	5	119.15	595.75
1736	2094	385	3	13.45	40.35
1737	55	364	3	157.44	472.32
1738	1669	206	3	45.80	137.40
1739	1846	373	2	24.06	48.12
1740	175	381	3	19.94	59.82
1741	2134	494	2	25.21	50.42
1742	558	319	4	1794.17	7176.68
1743	14	304	3	951.76	2855.28
1744	201	55	1	88.59	88.59
1745	1060	40	1	30.42	30.42
1746	894	237	2	24.89	49.78
1747	8	70	3	194.01	582.03
1748	1527	177	3	74.94	224.82
1749	967	207	4	76.84	307.36
1750	919	343	1	45.18	45.18
1751	1494	27	4	46.75	187.00
1752	16	371	5	129.51	647.55
1753	1263	443	5	17.52	87.60
1754	948	73	5	496.56	2482.80
1755	986	300	5	873.93	4369.65
1756	608	480	3	138.76	416.28
1757	822	373	5	24.06	120.30
1758	245	301	5	558.90	2794.50
1759	536	187	3	131.18	393.54
1760	544	1	4	31.96	127.84
1761	532	491	4	65.83	263.32
1762	1899	315	5	1323.55	6617.75
1763	985	103	3	168.49	505.47
1764	1233	428	5	238.02	1190.10
1765	1213	359	5	53.26	266.30
1766	1860	73	5	496.56	2482.80
1767	627	396	2	34.20	68.40
1768	1358	155	1	24.69	24.69
1769	2059	167	1	67.26	67.26
1770	253	316	3	30.13	90.39
1771	952	478	1	94.13	94.13
1772	318	120	5	41.71	208.55
1773	197	322	3	134.71	404.13
1774	1202	73	4	496.56	1986.24
1775	324	198	4	104.90	419.60
1776	802	325	3	33.89	101.67
1777	1063	210	4	117.15	468.60
1778	1791	127	2	111.79	223.58
1779	592	224	3	50.63	151.89
1780	2376	266	3	243.80	731.40
1781	1669	456	5	39.61	198.05
1782	1608	188	3	58.13	174.39
1783	1494	253	2	82.55	165.10
1784	781	429	2	135.14	270.28
1785	34	262	4	55.35	221.40
1786	2332	32	1	36.44	36.44
1787	2064	295	4	39.05	156.20
1788	2141	107	2	15.08	30.16
1789	1714	318	4	50.11	200.44
1790	948	113	4	48.15	192.60
1791	547	57	2	47.99	95.98
1792	1229	268	3	441.06	1323.18
1793	526	155	4	24.69	98.76
1794	237	455	3	40.50	121.50
1795	2476	356	1	378.69	378.69
1796	2264	498	3	224.97	674.91
1797	1160	237	4	24.89	99.56
1798	1734	210	1	117.15	117.15
1799	2028	219	4	31.22	124.88
1800	880	237	1	24.89	24.89
1801	216	172	1	450.87	450.87
1802	1096	239	1	28.15	28.15
1803	1598	367	3	119.27	357.81
1804	1275	141	3	25.01	75.03
1805	2346	323	1	1447.42	1447.42
1806	844	493	2	54.70	109.40
1807	1824	117	1	70.83	70.83
1808	1229	423	4	121.24	484.96
1809	609	217	5	102.71	513.55
1810	485	220	4	21.07	84.28
1811	333	398	2	237.21	474.42
1812	1242	203	3	1902.34	5707.02
1813	2069	229	1	51.78	51.78
1814	1164	14	5	201.38	1006.90
1815	1337	108	4	43.88	175.52
1816	57	361	1	67.61	67.61
1817	2357	195	1	172.13	172.13
1818	257	491	1	65.83	65.83
1819	221	325	4	33.89	135.56
1820	694	205	4	19.42	77.68
1821	46	485	5	22.10	110.50
1822	2264	486	5	55.39	276.95
1823	1781	312	1	23.82	23.82
1824	1530	313	3	171.44	514.32
1825	665	360	1	41.94	41.94
1826	1694	179	4	224.59	898.36
1827	1750	252	2	175.20	350.40
1828	1916	37	5	168.04	840.20
1829	2002	31	2	17.37	34.74
1830	1941	495	1	28.08	28.08
1831	855	360	4	41.94	167.76
1832	831	355	4	42.69	170.76
1833	1565	75	2	323.09	646.18
1834	2002	131	2	16.19	32.38
1835	175	161	5	183.22	916.10
1836	863	392	1	35.62	35.62
1837	1241	447	1	18.24	18.24
1838	2327	341	3	59.37	178.11
1839	985	238	2	54.26	108.52
1840	1878	488	2	47.80	95.60
1841	470	97	2	1307.31	2614.62
1842	206	129	2	7.25	14.50
1843	1270	429	5	135.14	675.70
1844	327	476	2	1824.95	3649.90
1845	1013	111	2	38.70	77.40
1846	459	70	2	194.01	388.02
1847	548	435	5	12.96	64.80
1848	1728	370	2	460.14	920.28
1849	772	328	3	53.11	159.33
1850	2039	113	1	48.15	48.15
1851	302	411	5	40.37	201.85
1852	381	69	3	259.22	777.66
1853	830	365	4	22.34	89.36
1854	622	209	3	70.93	212.79
1855	571	452	2	14.12	28.24
1856	1256	347	5	34.57	172.85
1857	1125	91	2	81.18	162.36
1858	1726	302	3	84.18	252.54
1859	2324	122	5	158.20	791.00
1860	317	471	5	67.11	335.55
1861	1148	335	5	45.97	229.85
1862	1964	430	3	143.84	431.52
1863	198	240	1	77.63	77.63
1864	195	120	1	41.71	41.71
1865	845	199	3	33.04	99.12
1866	1914	405	1	1223.24	1223.24
1867	1015	31	1	17.37	17.37
1868	282	164	5	143.24	716.20
1869	1915	437	3	11.99	35.97
1870	2247	256	4	175.24	700.96
1871	2307	186	5	35.21	176.05
1872	2357	313	1	171.44	171.44
1873	95	136	2	68.76	137.52
1874	1783	281	3	12.06	36.18
1875	2321	62	1	37.50	37.50
1876	1329	80	1	33.99	33.99
1877	1923	385	2	13.45	26.90
1878	446	408	3	24.29	72.87
1879	800	375	1	62.45	62.45
1880	1522	77	3	57.74	173.22
1881	1640	401	2	498.85	997.70
1882	55	304	3	951.76	2855.28
1883	1841	480	4	138.76	555.04
1884	25	121	2	16.58	33.16
1885	240	153	2	23.36	46.72
1886	1429	371	5	129.51	647.55
1887	217	21	5	42.95	214.75
1888	2027	101	2	35.50	71.00
1889	847	46	1	74.80	74.80
1890	2000	423	4	121.24	484.96
1891	641	357	3	142.57	427.71
1892	1771	286	1	21.30	21.30
1893	1447	275	3	44.37	133.11
1894	1716	69	4	259.22	1036.88
1895	1987	150	5	68.63	343.15
1896	1751	8	1	48.86	48.86
1897	1681	169	5	186.87	934.35
1898	1069	357	4	142.57	570.28
1899	1481	248	5	235.92	1179.60
1900	829	161	2	183.22	366.44
1901	1350	64	1	37.18	37.18
1902	846	361	2	67.61	135.22
1903	2241	126	5	47.88	239.40
1904	382	97	1	1307.31	1307.31
1905	57	126	1	47.88	47.88
1906	761	180	1	432.09	432.09
1907	252	77	3	57.74	173.22
1908	384	292	1	425.20	425.20
1909	582	323	5	1447.42	7237.10
1910	2341	16	3	21.47	64.41
1911	404	486	3	55.39	166.17
1912	414	78	2	1094.06	2188.12
1913	920	139	3	38.32	114.96
1914	2370	401	1	498.85	498.85
1915	2203	68	5	106.83	534.15
1916	58	133	3	22.04	66.12
1917	1388	421	2	33.87	67.74
1918	435	440	5	119.15	595.75
1919	1584	267	1	109.12	109.12
1920	828	264	3	51.18	153.54
1921	1046	116	3	1031.32	3093.96
1922	37	213	4	65.92	263.68
1923	1485	1	5	31.96	159.80
1924	549	459	4	53.30	213.20
1925	2062	134	4	15.54	62.16
1926	127	159	3	15.19	45.57
1927	190	158	2	191.11	382.22
1928	1990	112	5	17.58	87.90
1929	1125	412	1	32.98	32.98
1930	2191	383	2	29.97	59.94
1931	313	482	1	26.78	26.78
1932	2461	290	5	263.35	1316.75
1933	336	478	5	94.13	470.65
1934	428	347	5	34.57	172.85
1935	975	452	2	14.12	28.24
1936	1398	348	1	5.26	5.26
1937	1972	350	4	29.82	119.28
1938	116	40	2	30.42	60.84
1939	118	95	3	76.13	228.39
1940	1908	321	4	35.69	142.76
1941	430	408	5	24.29	121.45
1942	1337	46	1	74.80	74.80
1943	2413	374	2	44.65	89.30
1944	1277	342	4	70.36	281.44
1945	760	134	5	15.54	77.70
1946	147	44	5	1624.58	8122.90
1947	903	265	1	192.35	192.35
1948	209	164	2	143.24	286.48
1949	2090	3	1	26.19	26.19
1950	1115	388	2	15.05	30.10
1951	1123	16	5	21.47	107.35
1952	2361	188	4	58.13	232.52
1953	302	357	3	142.57	427.71
1954	971	226	2	173.76	347.52
1955	972	300	4	873.93	3495.72
1956	2245	49	5	36.01	180.05
1957	2394	232	5	43.21	216.05
1958	2279	110	1	50.85	50.85
1959	528	76	3	9.20	27.60
1960	1532	72	3	6.47	19.41
1961	544	118	5	396.15	1980.75
1962	2117	269	3	33.41	100.23
1963	1015	150	3	68.63	205.89
1964	620	35	4	47.26	189.04
1965	1279	84	3	6.04	18.12
1966	1703	365	5	22.34	111.70
1967	517	83	5	40.42	202.10
1968	884	79	3	75.58	226.74
1969	275	48	1	66.82	66.82
1970	1754	218	5	34.45	172.25
1971	2253	12	3	45.14	135.42
1972	1410	174	2	80.98	161.96
1973	910	107	5	15.08	75.40
1974	1422	484	1	6.41	6.41
1975	721	263	4	1800.59	7202.36
1976	2048	268	5	441.06	2205.30
1977	1735	196	4	36.96	147.84
1978	2312	207	5	76.84	384.20
1979	2372	82	1	48.26	48.26
1980	211	365	3	22.34	67.02
1981	1715	144	3	115.12	345.36
1982	2312	132	2	41.64	83.28
1983	702	10	5	35.19	175.95
1984	1178	307	5	43.66	218.30
1985	1551	169	5	186.87	934.35
1986	431	392	4	35.62	142.48
1987	466	157	1	212.65	212.65
1988	1982	346	4	78.72	314.88
1989	448	317	1	35.02	35.02
1990	1575	282	1	367.58	367.58
1991	2223	4	4	145.93	583.72
1992	387	80	3	33.99	101.97
1993	1895	265	4	192.35	769.40
1994	1169	330	4	44.43	177.72
1995	1955	206	2	45.80	91.60
1996	28	414	2	32.14	64.28
1997	642	4	4	145.93	583.72
1998	1373	174	3	80.98	242.94
1999	363	183	3	20.45	61.35
2000	2453	37	4	168.04	672.16
2001	70	279	1	16.56	16.56
2002	2499	467	1	100.75	100.75
2003	1320	187	4	131.18	524.72
2004	863	207	3	76.84	230.52
2005	2005	387	2	43.03	86.06
2006	2391	187	4	131.18	524.72
2007	2464	476	4	1824.95	7299.80
2008	289	421	1	33.87	33.87
2009	1865	123	2	27.40	54.80
2010	1000	492	4	1644.22	6576.88
2011	824	366	5	437.87	2189.35
2012	60	445	1	169.10	169.10
2013	1377	225	3	97.45	292.35
2014	646	258	5	34.33	171.65
2015	2093	193	5	56.68	283.40
2016	245	374	1	44.65	44.65
2017	1023	269	2	33.41	66.82
2018	448	193	3	56.68	170.04
2019	2455	351	2	47.82	95.64
2020	1102	255	1	96.70	96.70
2021	1338	106	5	77.98	389.90
2022	294	57	3	47.99	143.97
2023	2002	26	2	173.16	346.32
2024	2017	207	4	76.84	307.36
2025	1657	8	4	48.86	195.44
2026	1847	416	5	17.53	87.65
2027	2016	333	5	240.47	1202.35
2028	1293	263	2	1800.59	3601.18
2029	1298	469	5	27.64	138.20
2030	1092	209	4	70.93	283.72
2031	498	363	3	30.19	90.57
2032	1102	225	3	97.45	292.35
2033	1063	422	3	57.25	171.75
2034	1557	121	4	16.58	66.32
2035	2121	347	4	34.57	138.28
2036	1700	47	2	87.81	175.62
2037	1363	60	3	1576.99	4730.97
2038	1679	406	1	53.06	53.06
2039	922	156	5	446.90	2234.50
2040	375	45	3	40.34	121.02
2041	1258	406	2	53.06	106.12
2042	1410	185	2	68.10	136.20
2043	2073	374	2	44.65	89.30
2044	2477	356	3	378.69	1136.07
2045	86	483	2	75.61	151.22
2046	1585	214	2	18.50	37.00
2047	68	18	3	178.99	536.97
2048	1375	461	5	37.37	186.85
2049	1171	225	1	97.45	97.45
2050	868	257	1	13.06	13.06
2051	1791	234	3	59.10	177.30
2052	1018	399	1	71.86	71.86
2053	2202	137	4	59.63	238.52
2054	362	434	2	49.87	99.74
2055	1568	475	3	218.49	655.47
2056	2286	189	1	30.28	30.28
2057	1371	181	3	57.96	173.88
2058	1950	63	3	46.66	139.98
2059	990	263	2	1800.59	3601.18
2060	1560	326	4	80.44	321.76
2061	461	79	5	75.58	377.90
2062	1670	440	1	119.15	119.15
2063	5	438	3	7.95	23.85
2064	868	417	5	44.72	223.60
2065	734	34	3	37.20	111.60
2066	1271	417	3	44.72	134.16
2067	1799	333	4	240.47	961.88
2068	2138	325	3	33.89	101.67
2069	2284	365	5	22.34	111.70
2070	567	332	1	20.41	20.41
2071	41	138	4	68.43	273.72
2072	1972	455	2	40.50	81.00
2073	1175	393	4	15.33	61.32
2074	2091	493	5	54.70	273.50
2075	2345	421	4	33.87	135.48
2076	616	386	1	152.82	152.82
2077	1409	432	2	28.57	57.14
2078	657	44	3	1624.58	4873.74
2079	1595	80	2	33.99	67.98
2080	1414	66	3	104.91	314.73
2081	1078	30	4	72.53	290.12
2082	1138	341	1	59.37	59.37
2083	1842	478	2	94.13	188.26
2084	1086	402	2	55.39	110.78
2085	925	488	2	47.80	95.60
2086	816	76	2	9.20	18.40
2087	520	213	5	65.92	329.60
2088	164	37	3	168.04	504.12
2089	759	271	5	148.66	743.30
2090	1344	426	3	34.78	104.34
2091	1511	92	3	222.12	666.36
2092	861	363	2	30.19	60.38
2093	1782	393	2	15.33	30.66
2094	42	103	1	168.49	168.49
2095	2280	351	3	47.82	143.46
2096	1747	39	5	28.02	140.10
2097	1726	491	2	65.83	131.66
2098	608	77	5	57.74	288.70
2099	151	165	4	10.39	41.56
2100	1399	382	2	139.89	279.78
2101	1114	237	1	24.89	24.89
2102	931	234	3	59.10	177.30
2103	1221	438	1	7.95	7.95
2104	2391	255	2	96.70	193.40
2105	1973	210	5	117.15	585.75
2106	554	147	4	289.77	1159.08
2107	2346	450	4	33.27	133.08
2108	8	234	2	59.10	118.20
2109	600	489	5	88.05	440.25
2110	787	125	5	812.50	4062.50
2111	355	11	1	53.63	53.63
2112	46	331	4	65.98	263.92
2113	129	201	2	20.18	40.36
2114	1213	294	1	956.29	956.29
2115	2477	230	4	12.95	51.80
2116	816	416	3	17.53	52.59
2117	1324	158	2	191.11	382.22
2118	346	229	5	51.78	258.90
2119	982	270	2	17.08	34.16
2120	1450	223	2	35.37	70.74
2121	2363	82	1	48.26	48.26
2122	1423	345	3	35.23	105.69
2123	2043	189	1	30.28	30.28
2124	246	151	4	35.67	142.68
2125	1746	165	4	10.39	41.56
2126	1446	366	5	437.87	2189.35
2127	550	366	2	437.87	875.74
2128	829	39	1	28.02	28.02
2129	1971	153	3	23.36	70.08
2130	2012	307	2	43.66	87.32
2131	621	162	5	51.77	258.85
2132	2328	481	2	49.26	98.52
2133	367	295	4	39.05	156.20
2134	767	175	4	1956.92	7827.68
2135	1861	357	5	142.57	712.85
2136	403	473	2	160.59	321.18
2137	2397	306	4	155.79	623.16
2138	366	273	1	1558.15	1558.15
2139	1529	175	4	1956.92	7827.68
2140	259	271	2	148.66	297.32
2141	756	429	2	135.14	270.28
2142	1313	445	3	169.10	507.30
2143	839	201	1	20.18	20.18
2144	420	481	2	49.26	98.52
2145	2070	7	1	1801.75	1801.75
2146	8	470	2	18.69	37.38
2147	2241	448	5	21.73	108.65
2148	253	274	2	78.08	156.16
2149	1623	295	5	39.05	195.25
2150	1466	498	1	224.97	224.97
2151	1332	273	3	1558.15	4674.45
2152	1397	478	5	94.13	470.65
2153	1142	292	3	425.20	1275.60
2154	1625	152	1	70.59	70.59
2155	654	133	2	22.04	44.08
2156	172	6	2	29.06	58.12
2157	897	110	1	50.85	50.85
2158	1680	118	4	396.15	1584.60
2159	679	273	1	1558.15	1558.15
2160	1982	346	5	78.72	393.60
2161	579	52	1	1713.47	1713.47
2162	237	369	1	61.27	61.27
2163	342	174	5	80.98	404.90
2164	1044	133	2	22.04	44.08
2165	1316	146	2	50.37	100.74
2166	638	463	2	25.47	50.94
2167	551	239	3	28.15	84.45
2168	906	71	5	41.29	206.45
2169	1065	50	2	43.57	87.14
2170	1156	238	4	54.26	217.04
2171	1995	104	5	50.61	253.05
2172	1451	221	4	56.85	227.40
2173	2281	91	1	81.18	81.18
2174	1565	368	5	234.47	1172.35
2175	2280	224	1	50.63	50.63
2176	2435	430	1	143.84	143.84
2177	2381	436	1	70.65	70.65
2178	1824	195	1	172.13	172.13
2179	348	281	2	12.06	24.12
2180	1138	277	5	1676.49	8382.45
2181	1765	412	3	32.98	98.94
2182	2341	398	4	237.21	948.84
2183	2007	165	1	10.39	10.39
2184	894	250	4	40.88	163.52
2185	496	145	2	87.37	174.74
2186	2388	171	2	127.13	254.26
2187	2459	345	3	35.23	105.69
2188	1604	450	4	33.27	133.08
2189	543	204	3	46.65	139.95
2190	1104	176	4	94.41	377.64
2191	525	443	1	17.52	17.52
2192	905	116	5	1031.32	5156.60
2193	371	333	3	240.47	721.41
2194	175	430	3	143.84	431.52
2195	1832	391	5	169.39	846.95
2196	605	45	3	40.34	121.02
2197	566	280	1	241.86	241.86
2198	1139	469	4	27.64	110.56
2199	639	35	5	47.26	236.30
2200	546	288	5	656.63	3283.15
2201	1163	18	2	178.99	357.98
2202	1850	481	2	49.26	98.52
2203	699	422	1	57.25	57.25
2204	1102	247	3	23.80	71.40
2205	1653	89	3	127.84	383.52
2206	2413	459	2	53.30	106.60
2207	108	51	2	54.55	109.10
2208	542	97	2	1307.31	2614.62
2209	1415	346	1	78.72	78.72
2210	2144	335	4	45.97	183.88
2211	1839	218	4	34.45	137.80
2212	1721	414	4	32.14	128.56
2213	2364	120	5	41.71	208.55
2214	2324	370	1	460.14	460.14
2215	1032	387	3	43.03	129.09
2216	1743	405	3	1223.24	3669.72
2217	1114	119	4	254.39	1017.56
2218	1713	69	3	259.22	777.66
2219	2137	396	4	34.20	136.80
2220	819	377	3	57.24	171.72
2221	646	69	2	259.22	518.44
2222	1129	94	4	124.81	499.24
2223	970	328	1	53.11	53.11
2224	1062	150	1	68.63	68.63
2225	2373	426	5	34.78	173.90
2226	1955	77	3	57.74	173.22
2227	2332	265	3	192.35	577.05
2228	200	436	2	70.65	141.30
2229	320	376	5	45.14	225.70
2230	1285	318	1	50.11	50.11
2231	282	167	1	67.26	67.26
2232	1380	79	4	75.58	302.32
2233	1427	191	4	49.67	198.68
2234	18	188	4	58.13	232.52
2235	511	4	4	145.93	583.72
2236	1737	399	4	71.86	287.44
2237	1764	332	3	20.41	61.23
2238	2471	336	1	12.98	12.98
2239	2145	374	3	44.65	133.95
2240	608	41	2	480.19	960.38
2241	315	270	4	17.08	68.32
2242	2301	347	4	34.57	138.28
2243	1006	433	1	10.07	10.07
2244	1497	87	2	192.95	385.90
2245	508	116	1	1031.32	1031.32
2246	1394	131	5	16.19	80.95
2247	1124	437	2	11.99	23.98
2248	53	435	5	12.96	64.80
2249	1509	96	1	494.22	494.22
2250	1742	385	3	13.45	40.35
2251	2219	173	4	112.69	450.76
2252	1071	433	5	10.07	50.35
2253	689	454	1	10.72	10.72
2254	1180	12	4	45.14	180.56
2255	19	315	1	1323.55	1323.55
2256	608	138	5	68.43	342.15
2257	641	56	1	60.90	60.90
2258	1404	239	2	28.15	56.30
2259	925	249	2	17.60	35.20
2260	1705	220	2	21.07	42.14
2261	224	493	1	54.70	54.70
2262	2305	309	1	20.47	20.47
2263	1029	149	4	33.61	134.44
2264	2119	350	4	29.82	119.28
2265	712	285	5	31.36	156.80
2266	2088	28	4	69.72	278.88
2267	1842	126	1	47.88	47.88
2268	1916	99	4	42.94	171.76
2269	1319	56	4	60.90	243.60
2270	445	452	4	14.12	56.48
2271	1305	447	2	18.24	36.48
2272	534	282	3	367.58	1102.74
2273	71	352	2	21.21	42.42
2274	13	363	2	30.19	60.38
2275	1295	84	2	6.04	12.08
2276	2387	314	2	158.44	316.88
2277	815	153	4	23.36	93.44
2278	1398	10	1	35.19	35.19
2279	2186	191	5	49.67	248.35
2280	1110	174	3	80.98	242.94
2281	257	484	5	6.41	32.05
2282	2270	2	2	1385.15	2770.30
2283	226	387	1	43.03	43.03
2284	295	35	2	47.26	94.52
2285	1544	50	4	43.57	174.28
2286	2048	237	5	24.89	124.45
2287	271	135	3	28.66	85.98
2288	196	128	5	38.41	192.05
2289	1735	154	3	17.90	53.70
2290	658	58	4	39.85	159.40
2291	2342	354	2	1200.13	2400.26
2292	431	497	4	25.76	103.04
2293	11	87	1	192.95	192.95
2294	2124	484	1	6.41	6.41
2295	1089	223	3	35.37	106.11
2296	949	487	2	138.30	276.60
2297	2162	233	5	1143.94	5719.70
2298	587	63	3	46.66	139.98
2299	1628	244	2	26.32	52.64
2300	132	7	1	1801.75	1801.75
2301	601	496	1	7.91	7.91
2302	792	86	1	50.97	50.97
2303	1432	92	2	222.12	444.24
2304	1529	344	4	39.33	157.32
2305	1009	157	3	212.65	637.95
2306	469	411	2	40.37	80.74
2307	311	5	5	23.44	117.20
2308	336	102	5	93.77	468.85
2309	247	211	5	127.39	636.95
2310	425	481	2	49.26	98.52
2311	733	346	2	78.72	157.44
2312	709	228	1	249.92	249.92
2313	1118	145	2	87.37	174.74
2314	1272	303	2	91.70	183.40
2315	2100	168	3	68.11	204.33
2316	637	130	4	41.39	165.56
2317	845	325	3	33.89	101.67
2318	1460	356	5	378.69	1893.45
2319	851	391	5	169.39	846.95
2320	428	21	4	42.95	171.80
2321	2278	242	4	899.18	3596.72
2322	2076	47	5	87.81	439.05
2323	463	20	2	248.39	496.78
2324	878	488	2	47.80	95.60
2325	1548	379	4	37.51	150.04
2326	123	76	5	9.20	46.00
2327	1178	231	3	1595.61	4786.83
2328	440	414	1	32.14	32.14
2329	2351	364	4	157.44	629.76
2330	932	365	5	22.34	111.70
2331	2391	290	2	263.35	526.70
2332	698	412	4	32.98	131.92
2333	2474	176	4	94.41	377.64
2334	68	112	3	17.58	52.74
2335	32	62	5	37.50	187.50
2336	576	166	1	39.81	39.81
2337	502	235	3	32.53	97.59
2338	2313	490	2	46.96	93.92
2339	289	273	5	1558.15	7790.75
2340	543	203	2	1902.34	3804.68
2341	2196	36	1	20.31	20.31
2342	1780	121	1	16.58	16.58
2343	2114	482	1	26.78	26.78
2344	984	114	3	152.22	456.66
2345	1807	323	1	1447.42	1447.42
2346	1571	73	4	496.56	1986.24
2347	1630	342	3	70.36	211.08
2348	623	366	2	437.87	875.74
2349	1889	298	4	137.17	548.68
2350	1745	491	4	65.83	263.32
2351	332	299	3	10.57	31.71
2352	1502	73	2	496.56	993.12
2353	1920	216	4	316.91	1267.64
2354	393	183	4	20.45	81.80
2355	944	22	2	133.18	266.36
2356	749	327	3	126.09	378.27
2357	1486	349	1	67.66	67.66
2358	1842	16	2	21.47	42.94
2359	1061	433	4	10.07	40.28
2360	374	2	2	1385.15	2770.30
2361	2245	462	3	290.55	871.65
2362	980	118	3	396.15	1188.45
2363	1938	469	3	27.64	82.92
2364	2439	53	2	25.96	51.92
2365	736	98	2	13.19	26.38
2366	2370	484	4	6.41	25.64
2367	372	480	3	138.76	416.28
2368	1061	270	4	17.08	68.32
2369	1148	103	3	168.49	505.47
2370	1749	82	4	48.26	193.04
2371	1724	167	5	67.26	336.30
2372	1451	3	4	26.19	104.76
2373	1205	427	4	156.77	627.08
2374	1559	82	3	48.26	144.78
2375	2107	269	5	33.41	167.05
2376	1104	372	4	203.87	815.48
2377	1773	339	5	187.08	935.40
2378	2492	500	3	175.70	527.10
2379	1691	487	5	138.30	691.50
2380	886	481	4	49.26	197.04
2381	1126	105	2	45.66	91.32
2382	1703	327	2	126.09	252.18
2383	190	363	3	30.19	90.57
2384	694	361	5	67.61	338.05
2385	1221	392	3	35.62	106.86
2386	1492	57	3	47.99	143.97
2387	524	207	1	76.84	76.84
2388	267	331	1	65.98	65.98
2389	525	405	3	1223.24	3669.72
2390	1077	313	4	171.44	685.76
2391	2173	192	2	42.22	84.44
2392	1046	374	3	44.65	133.95
2393	1766	95	1	76.13	76.13
2394	2219	12	4	45.14	180.56
2395	2179	162	5	51.77	258.85
2396	162	356	2	378.69	757.38
2397	727	231	5	1595.61	7978.05
2398	267	1	4	31.96	127.84
2399	2075	259	3	44.64	133.92
2400	1941	124	4	133.17	532.68
2401	1476	477	5	183.20	916.00
2402	1482	266	3	243.80	731.40
2403	136	93	1	54.25	54.25
2404	675	419	2	1124.89	2249.78
2405	528	11	1	53.63	53.63
2406	2327	55	4	88.59	354.36
2407	912	474	2	62.56	125.12
2408	1438	459	4	53.30	213.20
2409	2114	401	4	498.85	1995.40
2410	1312	489	4	88.05	352.20
2411	1038	481	2	49.26	98.52
2412	316	60	5	1576.99	7884.95
2413	764	193	2	56.68	113.36
2414	1256	418	3	134.86	404.58
2415	2208	182	1	18.31	18.31
2416	310	156	5	446.90	2234.50
2417	1634	467	4	100.75	403.00
2418	1346	256	5	175.24	876.20
2419	1091	33	2	36.04	72.08
2420	2162	42	3	90.48	271.44
2421	814	241	3	101.95	305.85
2422	1377	141	2	25.01	50.02
2423	596	463	1	25.47	25.47
2424	881	439	2	1837.39	3674.78
2425	960	358	5	68.55	342.75
2426	2263	8	1	48.86	48.86
2427	718	240	3	77.63	232.89
2428	175	407	4	262.44	1049.76
2429	662	422	3	57.25	171.75
2430	951	54	1	177.79	177.79
2431	493	187	2	131.18	262.36
2432	72	182	2	18.31	36.62
2433	2329	379	2	37.51	75.02
2434	1764	55	3	88.59	265.77
2435	732	158	4	191.11	764.44
2436	1848	492	4	1644.22	6576.88
2437	1399	188	5	58.13	290.65
2438	272	18	1	178.99	178.99
2439	1601	186	3	35.21	105.63
2440	471	183	3	20.45	61.35
2441	338	54	4	177.79	711.16
2442	1242	315	5	1323.55	6617.75
2443	2004	148	4	1809.97	7239.88
2444	455	376	2	45.14	90.28
2445	1365	272	3	120.40	361.20
2446	1689	21	1	42.95	42.95
2447	2159	159	5	15.19	75.95
2448	295	415	3	46.59	139.77
2449	906	208	1	111.45	111.45
2450	1947	197	4	135.87	543.48
2451	2120	191	1	49.67	49.67
2452	291	57	2	47.99	95.98
2453	379	7	2	1801.75	3603.50
2454	1784	61	5	21.85	109.25
2455	2085	371	5	129.51	647.55
2456	1012	356	2	378.69	757.38
2457	1467	229	1	51.78	51.78
2458	73	366	3	437.87	1313.61
2459	2286	272	4	120.40	481.60
2460	82	213	5	65.92	329.60
2461	64	120	2	41.71	83.42
2462	165	402	2	55.39	110.78
2463	1004	469	2	27.64	55.28
2464	1555	238	4	54.26	217.04
2465	2029	491	2	65.83	131.66
2466	646	64	1	37.18	37.18
2467	2319	241	5	101.95	509.75
2468	55	439	3	1837.39	5512.17
2469	1188	171	3	127.13	381.39
2470	1521	205	1	19.42	19.42
2471	164	438	4	7.95	31.80
2472	1998	228	4	249.92	999.68
2473	1163	183	4	20.45	81.80
2474	522	128	4	38.41	153.64
2475	1688	436	1	70.65	70.65
2476	1329	304	4	951.76	3807.04
2477	272	410	2	178.58	357.16
2478	1826	202	4	20.16	80.64
2479	309	123	2	27.40	54.80
2480	1162	404	2	18.86	37.72
2481	703	450	5	33.27	166.35
2482	233	245	4	71.20	284.80
2483	1784	23	2	37.46	74.92
2484	890	86	1	50.97	50.97
2485	1696	275	1	44.37	44.37
2486	570	230	1	12.95	12.95
2487	1736	465	2	151.90	303.80
2488	1397	431	2	226.93	453.86
2489	2345	387	1	43.03	43.03
2490	1941	340	1	41.26	41.26
2491	782	334	5	22.93	114.65
2492	1704	227	3	1612.51	4837.53
2493	1650	343	5	45.18	225.90
2494	30	316	3	30.13	90.39
2495	2198	274	2	78.08	156.16
2496	659	345	4	35.23	140.92
2497	2168	10	3	35.19	105.57
2498	1660	358	5	68.55	342.75
2499	714	158	2	191.11	382.22
2500	1390	173	2	112.69	225.38
2501	1898	68	2	106.83	213.66
2502	1366	270	4	17.08	68.32
2503	863	56	4	60.90	243.60
2504	315	166	5	39.81	199.05
2505	127	194	4	37.99	151.96
2506	2339	140	1	22.98	22.98
2507	567	468	5	429.47	2147.35
2508	344	195	2	172.13	344.26
2509	823	211	5	127.39	636.95
2510	1027	80	5	33.99	169.95
2511	789	278	4	39.34	157.36
2512	818	304	4	951.76	3807.04
2513	1681	278	1	39.34	39.34
2514	607	16	2	21.47	42.94
2515	1091	310	4	38.48	153.92
2516	797	291	1	62.85	62.85
2517	1172	500	3	175.70	527.10
2518	2486	133	3	22.04	66.12
2519	1825	466	5	43.61	218.05
2520	588	427	3	156.77	470.31
2521	111	448	4	21.73	86.92
2522	206	299	5	10.57	52.85
2523	2271	425	2	50.74	101.48
2524	2471	373	1	24.06	24.06
2525	1170	355	5	42.69	213.45
2526	2452	121	3	16.58	49.74
2527	1454	341	4	59.37	237.48
2528	1082	409	3	62.83	188.49
2529	696	245	5	71.20	356.00
2530	1137	332	1	20.41	20.41
2531	727	254	1	19.26	19.26
2532	689	458	2	43.32	86.64
2533	2175	220	2	21.07	42.14
2534	1785	314	3	158.44	475.32
2535	1316	9	5	437.61	2188.05
2536	714	28	3	69.72	209.16
2537	2262	141	1	25.01	25.01
2538	590	380	5	41.63	208.15
2539	1897	279	2	16.56	33.12
2540	150	209	3	70.93	212.79
2541	451	372	1	203.87	203.87
2542	1380	370	1	460.14	460.14
2543	781	80	1	33.99	33.99
2544	346	353	1	139.69	139.69
2545	96	353	3	139.69	419.07
2546	1009	26	3	173.16	519.48
2547	2152	257	4	13.06	52.24
2548	1159	468	1	429.47	429.47
2549	1	386	4	152.82	611.28
2550	255	255	3	96.70	290.10
2551	1400	414	5	32.14	160.70
2552	2430	364	1	157.44	157.44
2553	1600	203	5	1902.34	9511.70
2554	1587	62	1	37.50	37.50
2555	1525	207	2	76.84	153.68
2556	1362	25	5	48.32	241.60
2557	2155	68	5	106.83	534.15
2558	620	498	5	224.97	1124.85
2559	58	263	1	1800.59	1800.59
2560	150	439	3	1837.39	5512.17
2561	2397	117	3	70.83	212.49
2562	2370	134	1	15.54	15.54
2563	269	217	1	102.71	102.71
2564	1985	316	3	30.13	90.39
2565	289	441	1	97.86	97.86
2566	1732	104	3	50.61	151.83
2567	468	356	2	378.69	757.38
2568	1229	322	1	134.71	134.71
2569	992	70	3	194.01	582.03
2570	285	49	4	36.01	144.04
2571	1677	437	4	11.99	47.96
2572	1270	462	5	290.55	1452.75
2573	2009	14	3	201.38	604.14
2574	399	264	1	51.18	51.18
2575	225	347	2	34.57	69.14
2576	566	202	3	20.16	60.48
2577	1935	68	2	106.83	213.66
2578	2130	103	5	168.49	842.45
2579	1661	66	1	104.91	104.91
2580	371	470	3	18.69	56.07
2581	2455	238	5	54.26	271.30
2582	1882	19	2	34.49	68.98
2583	1780	327	4	126.09	504.36
2584	723	185	3	68.10	204.30
2585	2339	328	4	53.11	212.44
2586	1730	148	3	1809.97	5429.91
2587	2473	406	3	53.06	159.18
2588	49	272	5	120.40	602.00
2589	989	260	1	50.36	50.36
2590	804	423	2	121.24	242.48
2591	490	120	1	41.71	41.71
2592	224	258	5	34.33	171.65
2593	2024	201	1	20.18	20.18
2594	2373	122	1	158.20	158.20
2595	1737	382	4	139.89	559.56
2596	162	270	5	17.08	85.40
2597	569	19	3	34.49	103.47
2598	1475	323	4	1447.42	5789.68
2599	1051	218	3	34.45	103.35
2600	731	118	4	396.15	1584.60
2601	691	424	1	924.51	924.51
2602	1128	115	4	21.78	87.12
2603	479	93	4	54.25	217.00
2604	859	394	5	148.49	742.45
2605	1134	246	3	1098.58	3295.74
2606	187	249	1	17.60	17.60
2607	2288	356	1	378.69	378.69
2608	511	213	5	65.92	329.60
2609	1570	437	1	11.99	11.99
2610	190	22	2	133.18	266.36
2611	27	279	4	16.56	66.24
2612	814	304	1	951.76	951.76
2613	1220	328	4	53.11	212.44
2614	742	480	5	138.76	693.80
2615	655	465	5	151.90	759.50
2616	305	180	5	432.09	2160.45
2617	390	326	2	80.44	160.88
2618	96	347	4	34.57	138.28
2619	791	75	1	323.09	323.09
2620	1731	88	4	24.07	96.28
2621	860	387	1	43.03	43.03
2622	764	181	1	57.96	57.96
2623	2021	293	3	77.37	232.11
2624	999	467	5	100.75	503.75
2625	1536	165	4	10.39	41.56
2626	2097	407	4	262.44	1049.76
2627	1511	391	5	169.39	846.95
2628	127	208	4	111.45	445.80
2629	2068	264	1	51.18	51.18
2630	815	235	1	32.53	32.53
2631	1233	371	5	129.51	647.55
2632	2194	43	5	87.93	439.65
2633	861	313	4	171.44	685.76
2634	1393	199	4	33.04	132.16
2635	2268	319	4	1794.17	7176.68
2636	571	207	3	76.84	230.52
2637	1251	44	5	1624.58	8122.90
2638	1244	263	5	1800.59	9002.95
2639	1910	52	2	1713.47	3426.94
2640	1003	204	2	46.65	93.30
2641	1831	374	2	44.65	89.30
2642	2006	490	4	46.96	187.84
2643	865	354	1	1200.13	1200.13
2644	1154	140	4	22.98	91.92
2645	2277	154	1	17.90	17.90
2646	2000	141	3	25.01	75.03
2647	1747	222	1	1222.06	1222.06
2648	917	149	3	33.61	100.83
2649	822	330	5	44.43	222.15
2650	1082	310	2	38.48	76.96
2651	310	463	3	25.47	76.41
2652	725	318	2	50.11	100.22
2653	466	159	3	15.19	45.57
2654	766	95	3	76.13	228.39
2655	19	284	5	22.44	112.20
2656	2417	433	1	10.07	10.07
2657	1936	330	5	44.43	222.15
2658	2283	313	3	171.44	514.32
2659	1612	334	4	22.93	91.72
2660	1816	94	3	124.81	374.43
2661	1249	180	4	432.09	1728.36
2662	874	278	2	39.34	78.68
2663	848	467	5	100.75	503.75
2664	1298	347	3	34.57	103.71
2665	779	262	2	55.35	110.70
2666	2029	152	3	70.59	211.77
2667	694	221	2	56.85	113.70
2668	1035	358	2	68.55	137.10
2669	1573	240	5	77.63	388.15
2670	1533	407	5	262.44	1312.20
2671	1687	296	5	19.61	98.05
2672	2243	39	2	28.02	56.04
2673	1719	181	3	57.96	173.88
2674	402	343	2	45.18	90.36
2675	88	391	4	169.39	677.56
2676	982	493	4	54.70	218.80
2677	112	412	2	32.98	65.96
2678	1704	358	1	68.55	68.55
2679	470	469	4	27.64	110.56
2680	102	203	4	1902.34	7609.36
2681	568	319	3	1794.17	5382.51
2682	2432	331	5	65.98	329.90
2683	298	338	1	173.05	173.05
2684	1901	265	1	192.35	192.35
2685	2290	3	3	26.19	78.57
2686	110	349	5	67.66	338.30
2687	2399	189	3	30.28	90.84
2688	1444	287	4	13.46	53.84
2689	2433	494	4	25.21	100.84
2690	1039	220	5	21.07	105.35
2691	442	278	4	39.34	157.36
2692	1180	453	5	27.19	135.95
2693	1582	42	2	90.48	180.96
2694	976	314	1	158.44	158.44
2695	1065	382	2	139.89	279.78
2696	1345	442	1	19.09	19.09
2697	345	1	2	31.96	63.92
2698	1719	268	5	441.06	2205.30
2699	487	84	3	6.04	18.12
2700	1072	424	2	924.51	1849.02
2701	2077	494	2	25.21	50.42
2702	620	273	4	1558.15	6232.60
2703	456	211	2	127.39	254.78
2704	575	435	4	12.96	51.84
2705	1437	299	4	10.57	42.28
2706	1295	127	4	111.79	447.16
2707	932	356	5	378.69	1893.45
2708	2267	296	5	19.61	98.05
2709	12	98	2	13.19	26.38
2710	1082	78	3	1094.06	3282.18
2711	2196	76	3	9.20	27.60
2712	2079	63	1	46.66	46.66
2713	1773	238	3	54.26	162.78
2714	2464	10	1	35.19	35.19
2715	1737	223	2	35.37	70.74
2716	295	106	3	77.98	233.94
2717	454	258	2	34.33	68.66
2718	2157	168	5	68.11	340.55
2719	2417	60	3	1576.99	4730.97
2720	459	88	3	24.07	72.21
2721	1332	479	4	142.79	571.16
2722	971	368	1	234.47	234.47
2723	1118	357	2	142.57	285.14
2724	2319	484	1	6.41	6.41
2725	1189	260	5	50.36	251.80
2726	1004	100	4	128.64	514.56
2727	265	465	2	151.90	303.80
2728	321	235	1	32.53	32.53
2729	1787	400	5	72.50	362.50
2730	800	448	5	21.73	108.65
2731	24	442	4	19.09	76.36
2732	1730	135	2	28.66	57.32
2733	1369	484	1	6.41	6.41
2734	412	347	4	34.57	138.28
2735	1636	30	2	72.53	145.06
2736	1069	2	5	1385.15	6925.75
2737	538	165	2	10.39	20.78
2738	1495	340	4	41.26	165.04
2739	1038	267	4	109.12	436.48
2740	1148	293	4	77.37	309.48
2741	161	78	4	1094.06	4376.24
2742	2168	400	1	72.50	72.50
2743	255	97	1	1307.31	1307.31
2744	1942	288	5	656.63	3283.15
2745	552	405	3	1223.24	3669.72
2746	1077	217	2	102.71	205.42
2747	1508	126	3	47.88	143.64
2748	1766	278	2	39.34	78.68
2749	1073	170	4	8.45	33.80
2750	228	429	5	135.14	675.70
2751	442	151	4	35.67	142.68
2752	1433	287	2	13.46	26.92
2753	1341	313	1	171.44	171.44
2754	1642	338	5	173.05	865.25
2755	272	83	1	40.42	40.42
2756	1227	116	1	1031.32	1031.32
2757	1731	295	4	39.05	156.20
2758	1984	105	1	45.66	45.66
2759	127	131	2	16.19	32.38
2760	1808	75	1	323.09	323.09
2761	1247	247	1	23.80	23.80
2762	435	231	2	1595.61	3191.22
2763	1981	491	3	65.83	197.49
2764	924	86	2	50.97	101.94
2765	1377	438	2	7.95	15.90
2766	1225	86	3	50.97	152.91
2767	141	98	3	13.19	39.57
2768	297	339	4	187.08	748.32
2769	138	457	2	10.57	21.14
2770	119	405	1	1223.24	1223.24
2771	1987	214	3	18.50	55.50
2772	1925	86	4	50.97	203.88
2773	1299	304	4	951.76	3807.04
2774	2277	500	4	175.70	702.80
2775	1457	181	1	57.96	57.96
2776	547	196	5	36.96	184.80
2777	1408	1	4	31.96	127.84
2778	412	179	1	224.59	224.59
2779	880	247	5	23.80	119.00
2780	1023	177	5	74.94	374.70
2781	1302	187	4	131.18	524.72
2782	1483	452	1	14.12	14.12
2783	747	395	4	48.37	193.48
2784	1739	251	3	159.92	479.76
2785	2055	335	5	45.97	229.85
2786	2414	95	4	76.13	304.52
2787	82	452	3	14.12	42.36
2788	2390	157	4	212.65	850.60
2789	1052	321	4	35.69	142.76
2790	876	390	4	43.60	174.40
2791	1039	67	4	47.52	190.08
2792	2088	87	3	192.95	578.85
2793	26	204	1	46.65	46.65
2794	1374	63	5	46.66	233.30
2795	1448	369	5	61.27	306.35
2796	568	174	4	80.98	323.92
2797	690	301	5	558.90	2794.50
2798	2191	21	2	42.95	85.90
2799	763	175	2	1956.92	3913.84
2800	2462	300	3	873.93	2621.79
2801	595	327	3	126.09	378.27
2802	2143	159	1	15.19	15.19
2803	110	427	1	156.77	156.77
2804	2277	29	5	12.23	61.15
2805	247	152	3	70.59	211.77
2806	1704	471	2	67.11	134.22
2807	1079	247	2	23.80	47.60
2808	743	101	3	35.50	106.50
2809	125	77	2	57.74	115.48
2810	2039	467	4	100.75	403.00
2811	993	99	3	42.94	128.82
2812	189	27	2	46.75	93.50
2813	2205	300	4	873.93	3495.72
2814	1925	254	5	19.26	96.30
2815	1025	369	2	61.27	122.54
2816	2387	170	2	8.45	16.90
2817	2476	149	2	33.61	67.22
2818	2248	30	1	72.53	72.53
2819	1809	260	5	50.36	251.80
2820	2361	198	1	104.90	104.90
2821	388	196	3	36.96	110.88
2822	2059	369	2	61.27	122.54
2823	368	199	5	33.04	165.20
2824	1595	228	1	249.92	249.92
2825	2182	49	4	36.01	144.04
2826	507	297	1	15.73	15.73
2827	1123	346	3	78.72	236.16
2828	2166	264	3	51.18	153.54
2829	1927	44	4	1624.58	6498.32
2830	1346	107	2	15.08	30.16
2831	1784	477	4	183.20	732.80
2832	1318	346	1	78.72	78.72
2833	74	458	1	43.32	43.32
2834	158	144	3	115.12	345.36
2835	1615	415	4	46.59	186.36
2836	1566	352	5	21.21	106.05
2837	2072	267	1	109.12	109.12
2838	111	105	1	45.66	45.66
2839	2135	111	3	38.70	116.10
2840	1345	86	1	50.97	50.97
2841	1893	124	1	133.17	133.17
2842	1729	310	1	38.48	38.48
2843	1976	301	1	558.90	558.90
2844	1512	461	4	37.37	149.48
2845	1208	219	2	31.22	62.44
2846	2011	318	4	50.11	200.44
2847	153	456	1	39.61	39.61
2848	277	3	1	26.19	26.19
2849	2098	119	5	254.39	1271.95
2850	631	81	1	40.13	40.13
2851	1472	26	2	173.16	346.32
2852	420	70	4	194.01	776.04
2853	1113	61	3	21.85	65.55
2854	766	171	5	127.13	635.65
2855	2418	374	5	44.65	223.25
2856	2137	474	2	62.56	125.12
2857	1335	42	3	90.48	271.44
2858	265	419	4	1124.89	4499.56
2859	283	465	3	151.90	455.70
2860	2024	247	5	23.80	119.00
2861	2163	352	4	21.21	84.84
2862	283	232	5	43.21	216.05
2863	1267	202	2	20.16	40.32
2864	294	41	2	480.19	960.38
2865	2066	303	3	91.70	275.10
2866	2143	450	3	33.27	99.81
2867	1773	271	5	148.66	743.30
2868	647	368	5	234.47	1172.35
2869	51	50	2	43.57	87.14
2870	1200	457	3	10.57	31.71
2871	1727	333	4	240.47	961.88
2872	2093	98	1	13.19	13.19
2873	968	31	5	17.37	86.85
2874	516	160	2	63.03	126.06
2875	293	66	1	104.91	104.91
2876	2419	446	3	361.96	1085.88
2877	752	157	5	212.65	1063.25
2878	1990	190	4	45.03	180.12
2879	153	153	4	23.36	93.44
2880	1895	442	5	19.09	95.45
2881	2449	140	1	22.98	22.98
2882	61	293	3	77.37	232.11
2883	130	456	4	39.61	158.44
2884	2038	481	2	49.26	98.52
2885	842	380	5	41.63	208.15
2886	887	250	4	40.88	163.52
2887	845	273	4	1558.15	6232.60
2888	2344	221	3	56.85	170.55
2889	1495	19	2	34.49	68.98
2890	497	81	2	40.13	80.26
2891	2206	433	1	10.07	10.07
2892	1829	306	2	155.79	311.58
2893	884	44	1	1624.58	1624.58
2894	2062	224	4	50.63	202.52
2895	217	418	2	134.86	269.72
2896	1540	155	4	24.69	98.76
2897	785	379	4	37.51	150.04
2898	639	63	3	46.66	139.98
2899	740	243	2	56.14	112.28
2900	758	460	5	53.88	269.40
2901	732	331	2	65.98	131.96
2902	1174	382	3	139.89	419.67
2903	1761	33	4	36.04	144.16
2904	2389	179	5	224.59	1122.95
2905	23	224	3	50.63	151.89
2906	452	247	3	23.80	71.40
2907	544	344	5	39.33	196.65
2908	2245	497	2	25.76	51.52
2909	731	313	4	171.44	685.76
2910	1399	51	2	54.55	109.10
2911	2289	186	3	35.21	105.63
2912	515	194	1	37.99	37.99
2913	1529	101	1	35.50	35.50
2914	1576	43	1	87.93	87.93
2915	1613	240	2	77.63	155.26
2916	1179	51	1	54.55	54.55
2917	140	326	5	80.44	402.20
2918	2463	322	4	134.71	538.84
2919	950	289	1	1622.15	1622.15
2920	311	103	1	168.49	168.49
2921	926	104	3	50.61	151.83
2922	1895	389	4	71.80	287.20
2923	719	199	1	33.04	33.04
2924	835	227	3	1612.51	4837.53
2925	246	461	1	37.37	37.37
2926	1792	313	5	171.44	857.20
2927	1531	464	1	76.32	76.32
2928	2348	73	5	496.56	2482.80
2929	1467	102	3	93.77	281.31
2930	2454	482	3	26.78	80.34
2931	2140	250	2	40.88	81.76
2932	1491	109	2	62.66	125.32
2933	520	260	4	50.36	201.44
2934	798	460	1	53.88	53.88
2935	937	454	4	10.72	42.88
2936	2094	386	2	152.82	305.64
2937	510	275	1	44.37	44.37
2938	2260	196	2	36.96	73.92
2939	1315	263	2	1800.59	3601.18
2940	746	82	3	48.26	144.78
2941	1094	174	4	80.98	323.92
2942	898	238	2	54.26	108.52
2943	1739	359	4	53.26	213.04
2944	1210	264	5	51.18	255.90
2945	745	443	2	17.52	35.04
2946	2471	50	1	43.57	43.57
2947	1830	376	1	45.14	45.14
2948	2476	183	1	20.45	20.45
2949	2406	179	1	224.59	224.59
2950	1791	496	1	7.91	7.91
2951	1744	367	5	119.27	596.35
2952	2153	229	1	51.78	51.78
2953	459	305	5	64.25	321.25
2954	2136	324	5	74.42	372.10
2955	1893	33	5	36.04	180.20
2956	1438	35	2	47.26	94.52
2957	1936	452	1	14.12	14.12
2958	769	492	5	1644.22	8221.10
2959	1900	416	4	17.53	70.12
2960	2284	198	5	104.90	524.50
2961	174	370	1	460.14	460.14
2962	516	126	1	47.88	47.88
2963	1034	448	3	21.73	65.19
2964	736	96	5	494.22	2471.10
2965	570	24	1	18.15	18.15
2966	2075	346	2	78.72	157.44
2967	619	280	5	241.86	1209.30
2968	2017	427	2	156.77	313.54
2969	1045	26	3	173.16	519.48
2970	673	188	3	58.13	174.39
2971	520	420	1	163.63	163.63
2972	1599	258	3	34.33	102.99
2973	1657	100	5	128.64	643.20
2974	1274	187	5	131.18	655.90
2975	1863	135	2	28.66	57.32
2976	919	140	5	22.98	114.90
2977	2420	201	1	20.18	20.18
2978	1276	85	5	478.53	2392.65
2979	1504	474	2	62.56	125.12
2980	1604	72	1	6.47	6.47
2981	486	88	3	24.07	72.21
2982	1850	141	2	25.01	50.02
2983	1693	460	4	53.88	215.52
2984	2220	380	4	41.63	166.52
2985	2203	357	4	142.57	570.28
2986	1212	220	1	21.07	21.07
2987	1066	159	2	15.19	30.38
2988	1267	9	4	437.61	1750.44
2989	659	79	4	75.58	302.32
2990	1008	412	2	32.98	65.96
2991	249	234	5	59.10	295.50
2992	2132	162	1	51.77	51.77
2993	1388	210	5	117.15	585.75
2994	1194	47	1	87.81	87.81
2995	606	198	2	104.90	209.80
2996	1318	215	2	14.02	28.04
2997	2237	222	4	1222.06	4888.24
2998	2007	134	5	15.54	77.70
2999	2375	55	1	88.59	88.59
3000	1120	364	3	157.44	472.32
3001	2135	424	5	924.51	4622.55
3002	806	60	3	1576.99	4730.97
3003	1629	157	4	212.65	850.60
3004	2457	183	3	20.45	61.35
3005	314	167	4	67.26	269.04
3006	1808	420	1	163.63	163.63
3007	630	295	3	39.05	117.15
3008	1297	376	2	45.14	90.28
3009	418	53	1	25.96	25.96
3010	1677	190	1	45.03	45.03
3011	2176	348	1	5.26	5.26
3012	2408	445	3	169.10	507.30
3013	1770	333	5	240.47	1202.35
3014	2096	427	2	156.77	313.54
3015	1769	127	2	111.79	223.58
3016	677	139	1	38.32	38.32
3017	1237	334	5	22.93	114.65
3018	949	64	4	37.18	148.72
3019	847	205	4	19.42	77.68
3020	2280	9	2	437.61	875.22
3021	714	407	5	262.44	1312.20
3022	2482	355	4	42.69	170.76
3023	1510	81	5	40.13	200.65
3024	1026	216	5	316.91	1584.55
3025	1821	462	3	290.55	871.65
3026	2445	198	2	104.90	209.80
3027	64	55	1	88.59	88.59
3028	1967	177	5	74.94	374.70
3029	1091	455	5	40.50	202.50
3030	379	350	1	29.82	29.82
3031	1805	19	3	34.49	103.47
3032	2017	407	2	262.44	524.88
3033	1687	427	4	156.77	627.08
3034	1859	391	5	169.39	846.95
3035	968	291	2	62.85	125.70
3036	1216	232	4	43.21	172.84
3037	1984	24	4	18.15	72.60
3038	32	454	3	10.72	32.16
3039	358	454	1	10.72	10.72
3040	2473	89	1	127.84	127.84
3041	44	472	4	91.09	364.36
3042	1625	232	4	43.21	172.84
3043	1066	242	4	899.18	3596.72
3044	1237	24	4	18.15	72.60
3045	1425	186	1	35.21	35.21
3046	1686	404	5	18.86	94.30
3047	1384	481	4	49.26	197.04
3048	1447	336	4	12.98	51.92
3049	55	129	4	7.25	29.00
3050	2431	276	2	44.63	89.26
3051	2404	426	5	34.78	173.90
3052	1081	138	5	68.43	342.15
3053	533	128	2	38.41	76.82
3054	2410	146	4	50.37	201.48
3055	1715	218	2	34.45	68.90
3056	1273	340	4	41.26	165.04
3057	2343	33	5	36.04	180.20
3058	1824	138	5	68.43	342.15
3059	2174	193	3	56.68	170.04
3060	1474	223	1	35.37	35.37
3061	93	32	1	36.44	36.44
3062	2493	104	4	50.61	202.44
3063	2045	225	2	97.45	194.90
3064	2154	56	4	60.90	243.60
3065	1658	198	4	104.90	419.60
3066	68	105	2	45.66	91.32
3067	1542	294	5	956.29	4781.45
3068	1320	346	2	78.72	157.44
3069	1147	489	2	88.05	176.10
3070	1295	10	4	35.19	140.76
3071	561	203	4	1902.34	7609.36
3072	1425	397	4	97.03	388.12
3073	938	363	4	30.19	120.76
3074	100	319	5	1794.17	8970.85
3075	1222	303	5	91.70	458.50
3076	1061	326	1	80.44	80.44
3077	1493	131	5	16.19	80.95
3078	2431	341	2	59.37	118.74
3079	1534	262	4	55.35	221.40
3080	1439	66	4	104.91	419.64
3081	1307	366	1	437.87	437.87
3082	87	290	4	263.35	1053.40
3083	133	271	3	148.66	445.98
3084	2273	92	2	222.12	444.24
3085	468	462	2	290.55	581.10
3086	1944	220	5	21.07	105.35
3087	1426	56	5	60.90	304.50
3088	1284	270	5	17.08	85.40
3089	1931	432	5	28.57	142.85
3090	339	460	1	53.88	53.88
3091	1307	11	4	53.63	214.52
3092	276	318	3	50.11	150.33
3093	330	487	5	138.30	691.50
3094	979	112	5	17.58	87.90
3095	1333	20	2	248.39	496.78
3096	175	461	3	37.37	112.11
3097	943	358	5	68.55	342.75
3098	605	89	5	127.84	639.20
3099	1261	96	1	494.22	494.22
3100	648	235	2	32.53	65.06
3101	827	390	3	43.60	130.80
3102	551	427	3	156.77	470.31
3103	1208	180	5	432.09	2160.45
3104	1035	138	4	68.43	273.72
3105	1121	202	4	20.16	80.64
3106	2484	37	4	168.04	672.16
3107	1366	124	2	133.17	266.34
3108	1508	372	4	203.87	815.48
3109	1599	290	3	263.35	790.05
3110	755	460	5	53.88	269.40
3111	96	252	4	175.20	700.80
3112	1438	326	4	80.44	321.76
3113	791	209	3	70.93	212.79
3114	2342	252	1	175.20	175.20
3115	1038	261	5	64.39	321.95
3116	1526	336	2	12.98	25.96
3117	1793	58	5	39.85	199.25
3118	927	444	3	276.46	829.38
3119	1986	439	5	1837.39	9186.95
3120	810	97	1	1307.31	1307.31
3121	2476	249	3	17.60	52.80
3122	2338	244	1	26.32	26.32
3123	2049	143	1	432.47	432.47
3124	946	40	3	30.42	91.26
3125	1519	493	1	54.70	54.70
3126	364	191	4	49.67	198.68
3127	2013	146	1	50.37	50.37
3128	80	448	4	21.73	86.92
3129	265	459	3	53.30	159.90
3130	685	321	4	35.69	142.76
3131	1615	383	5	29.97	149.85
3132	1163	275	5	44.37	221.85
3133	1538	500	2	175.70	351.40
3134	1214	428	5	238.02	1190.10
3135	2498	256	1	175.24	175.24
3136	2104	376	2	45.14	90.28
3137	480	447	5	18.24	91.20
3138	925	97	3	1307.31	3921.93
3139	954	308	4	197.22	788.88
3140	990	5	3	23.44	70.32
3141	297	351	1	47.82	47.82
3142	1370	296	5	19.61	98.05
3143	2302	355	5	42.69	213.45
3144	1434	194	4	37.99	151.96
3145	339	209	1	70.93	70.93
3146	1541	2	1	1385.15	1385.15
3147	598	271	3	148.66	445.98
3148	355	133	5	22.04	110.20
3149	722	358	4	68.55	274.20
3150	1104	470	1	18.69	18.69
3151	833	184	1	50.91	50.91
3152	2325	441	3	97.86	293.58
3153	1625	81	1	40.13	40.13
3154	1557	429	1	135.14	135.14
3155	654	322	5	134.71	673.55
3156	907	54	2	177.79	355.58
3157	1420	337	3	71.01	213.03
3158	2084	134	3	15.54	46.62
3159	1263	461	5	37.37	186.85
3160	1016	138	2	68.43	136.86
3161	269	342	5	70.36	351.80
3162	1407	313	4	171.44	685.76
3163	2498	368	5	234.47	1172.35
3164	679	245	4	71.20	284.80
3165	809	330	3	44.43	133.29
3166	1221	239	4	28.15	112.60
3167	2028	30	1	72.53	72.53
3168	2170	207	2	76.84	153.68
3169	769	128	1	38.41	38.41
3170	1671	190	2	45.03	90.06
3171	1155	145	5	87.37	436.85
3172	584	419	2	1124.89	2249.78
3173	625	475	1	218.49	218.49
3174	1020	120	1	41.71	41.71
3175	2194	390	1	43.60	43.60
3176	2011	316	2	30.13	60.26
3177	2476	276	3	44.63	133.89
3178	1457	264	1	51.18	51.18
3179	1687	355	1	42.69	42.69
3180	1499	232	5	43.21	216.05
3181	830	176	4	94.41	377.64
3182	1170	214	1	18.50	18.50
3183	385	393	4	15.33	61.32
3184	240	278	3	39.34	118.02
3185	1427	454	2	10.72	21.44
3186	2354	361	5	67.61	338.05
3187	2186	128	1	38.41	38.41
3188	14	296	4	19.61	78.44
3189	1129	34	5	37.20	186.00
3190	2023	63	3	46.66	139.98
3191	27	372	2	203.87	407.74
3192	1639	307	2	43.66	87.32
3193	653	15	2	34.26	68.52
3194	2204	471	2	67.11	134.22
3195	5	403	2	208.42	416.84
3196	617	459	4	53.30	213.20
3197	1818	306	5	155.79	778.95
3198	1660	309	2	20.47	40.94
3199	1203	409	1	62.83	62.83
3200	2305	490	5	46.96	234.80
3201	1340	309	1	20.47	20.47
3202	215	96	4	494.22	1976.88
3203	1608	69	2	259.22	518.44
3204	2019	408	1	24.29	24.29
3205	1904	125	1	812.50	812.50
3206	1644	101	4	35.50	142.00
3207	1602	187	2	131.18	262.36
3208	1150	313	1	171.44	171.44
3209	990	241	2	101.95	203.90
3210	1415	380	3	41.63	124.89
3211	2410	293	2	77.37	154.74
3212	1446	109	4	62.66	250.64
3213	54	143	4	432.47	1729.88
3214	69	349	2	67.66	135.32
3215	1655	197	3	135.87	407.61
3216	1535	124	5	133.17	665.85
3217	733	336	4	12.98	51.92
3218	1581	79	3	75.58	226.74
3219	1995	219	2	31.22	62.44
3220	2140	154	4	17.90	71.60
3221	1029	132	3	41.64	124.92
3222	642	44	1	1624.58	1624.58
3223	1775	416	3	17.53	52.59
3224	649	58	4	39.85	159.40
3225	1235	76	1	9.20	9.20
3226	580	457	3	10.57	31.71
3227	2055	106	3	77.98	233.94
3228	390	493	4	54.70	218.80
3229	1181	269	5	33.41	167.05
3230	1112	456	3	39.61	118.83
3231	279	298	4	137.17	548.68
3232	247	207	4	76.84	307.36
3233	32	17	3	31.74	95.22
3234	1314	142	1	97.11	97.11
3235	1672	295	4	39.05	156.20
3236	50	495	5	28.08	140.40
3237	1055	324	4	74.42	297.68
3238	896	103	2	168.49	336.98
3239	2226	258	3	34.33	102.99
3240	1657	292	3	425.20	1275.60
3241	2162	281	3	12.06	36.18
3242	798	480	3	138.76	416.28
3243	1210	68	2	106.83	213.66
3244	2187	90	3	126.60	379.80
3245	1872	363	3	30.19	90.57
3246	825	288	1	656.63	656.63
3247	876	236	3	1207.15	3621.45
3248	2123	234	4	59.10	236.40
3249	1472	309	4	20.47	81.88
3250	1635	143	5	432.47	2162.35
3251	1537	253	5	82.55	412.75
3252	11	405	4	1223.24	4892.96
3253	1844	401	3	498.85	1496.55
3254	1579	439	5	1837.39	9186.95
3255	471	13	2	150.13	300.26
3256	1401	316	3	30.13	90.39
3257	2499	353	5	139.69	698.45
3258	1580	35	2	47.26	94.52
3259	1162	437	3	11.99	35.97
3260	1766	496	5	7.91	39.55
3261	1318	349	2	67.66	135.32
3262	32	429	3	135.14	405.42
3263	2345	235	5	32.53	162.65
3264	1988	443	4	17.52	70.08
3265	1511	202	2	20.16	40.32
3266	106	223	4	35.37	141.48
3267	1315	349	4	67.66	270.64
3268	954	349	2	67.66	135.32
3269	1772	1	4	31.96	127.84
3270	2021	86	4	50.97	203.88
3271	674	451	3	37.84	113.52
3272	1846	281	5	12.06	60.30
3273	2334	105	3	45.66	136.98
3274	1440	274	2	78.08	156.16
3275	729	255	2	96.70	193.40
3276	2496	422	1	57.25	57.25
3277	1041	339	4	187.08	748.32
3278	1962	396	4	34.20	136.80
3279	2144	494	3	25.21	75.63
3280	2489	472	5	91.09	455.45
3281	580	277	4	1676.49	6705.96
3282	139	225	1	97.45	97.45
3283	79	368	5	234.47	1172.35
3284	716	317	5	35.02	175.10
3285	1995	186	3	35.21	105.63
3286	1697	348	2	5.26	10.52
3287	1265	280	2	241.86	483.72
3288	1418	132	4	41.64	166.56
3289	1510	126	5	47.88	239.40
3290	121	404	5	18.86	94.30
3291	1786	461	2	37.37	74.74
3292	675	99	3	42.94	128.82
3293	444	168	3	68.11	204.33
3294	383	131	2	16.19	32.38
3295	289	466	4	43.61	174.44
3296	1446	220	5	21.07	105.35
3297	1707	127	3	111.79	335.37
3298	577	233	5	1143.94	5719.70
3299	620	190	1	45.03	45.03
3300	576	330	3	44.43	133.29
3301	1371	85	1	478.53	478.53
3302	1556	117	3	70.83	212.49
3303	2360	358	3	68.55	205.65
3304	432	358	1	68.55	68.55
3305	1938	203	3	1902.34	5707.02
3306	1464	349	1	67.66	67.66
3307	2239	173	5	112.69	563.45
3308	1989	121	2	16.58	33.16
3309	1316	62	5	37.50	187.50
3310	1129	166	3	39.81	119.43
3311	903	315	4	1323.55	5294.20
3312	1377	317	4	35.02	140.08
3313	561	465	2	151.90	303.80
3314	1614	442	1	19.09	19.09
3315	2280	52	1	1713.47	1713.47
3316	2000	460	4	53.88	215.52
3317	1596	28	2	69.72	139.44
3318	775	267	3	109.12	327.36
3319	493	125	2	812.50	1625.00
3320	2474	169	5	186.87	934.35
3321	900	462	2	290.55	581.10
3322	862	440	5	119.15	595.75
3323	2118	219	1	31.22	31.22
3324	128	2	4	1385.15	5540.60
3325	57	314	4	158.44	633.76
3326	983	372	2	203.87	407.74
3327	2296	158	4	191.11	764.44
3328	1786	490	2	46.96	93.92
3329	875	322	5	134.71	673.55
3330	2393	132	3	41.64	124.92
3331	2020	331	3	65.98	197.94
3332	258	167	3	67.26	201.78
3333	1726	101	1	35.50	35.50
3334	1479	380	2	41.63	83.26
3335	1137	63	5	46.66	233.30
3336	1856	288	1	656.63	656.63
3337	1492	146	1	50.37	50.37
3338	663	315	4	1323.55	5294.20
3339	488	370	2	460.14	920.28
3340	1818	37	3	168.04	504.12
3341	756	8	5	48.86	244.30
3342	1446	36	3	20.31	60.93
3343	292	186	1	35.21	35.21
3344	2064	173	3	112.69	338.07
3345	1593	37	1	168.04	168.04
3346	2466	247	2	23.80	47.60
3347	461	121	1	16.58	16.58
3348	1720	136	3	68.76	206.28
3349	2072	420	3	163.63	490.89
3350	325	373	1	24.06	24.06
3351	74	320	2	82.53	165.06
3352	2413	274	5	78.08	390.40
3353	134	20	1	248.39	248.39
3354	86	481	3	49.26	147.78
3355	738	65	2	70.40	140.80
3356	2350	393	3	15.33	45.99
3357	988	193	2	56.68	113.36
3358	2209	300	1	873.93	873.93
3359	2172	105	2	45.66	91.32
3360	409	463	4	25.47	101.88
3361	619	361	5	67.61	338.05
3362	269	160	3	63.03	189.09
3363	462	295	2	39.05	78.10
3364	1774	286	2	21.30	42.60
3365	15	173	4	112.69	450.76
3366	391	418	5	134.86	674.30
3367	2480	48	3	66.82	200.46
3368	1907	291	2	62.85	125.70
3369	1260	206	1	45.80	45.80
3370	1490	51	1	54.55	54.55
3371	1100	185	1	68.10	68.10
3372	356	48	2	66.82	133.64
3373	2364	450	2	33.27	66.54
3374	724	354	3	1200.13	3600.39
3375	2211	486	5	55.39	276.95
3376	1473	257	1	13.06	13.06
3377	1931	468	3	429.47	1288.41
3378	1167	446	2	361.96	723.92
3379	1215	268	4	441.06	1764.24
3380	2228	224	3	50.63	151.89
3381	1878	434	2	49.87	99.74
3382	1497	8	4	48.86	195.44
3383	1449	180	3	432.09	1296.27
3384	1871	207	2	76.84	153.68
3385	568	265	5	192.35	961.75
3386	2498	157	4	212.65	850.60
3387	812	36	4	20.31	81.24
3388	618	54	2	177.79	355.58
3389	1966	246	3	1098.58	3295.74
3390	2375	460	1	53.88	53.88
3391	1556	148	1	1809.97	1809.97
3392	2285	149	5	33.61	168.05
3393	1562	156	3	446.90	1340.70
3394	943	68	4	106.83	427.32
3395	1183	382	2	139.89	279.78
3396	2067	30	5	72.53	362.65
3397	529	20	2	248.39	496.78
3398	1839	463	5	25.47	127.35
3399	986	309	3	20.47	61.41
3400	1177	170	3	8.45	25.35
3401	1641	183	3	20.45	61.35
3402	49	211	3	127.39	382.17
3403	1071	232	1	43.21	43.21
3404	1209	13	3	150.13	450.39
3405	1577	357	4	142.57	570.28
3406	335	160	1	63.03	63.03
3407	927	209	5	70.93	354.65
3408	2003	315	1	1323.55	1323.55
3409	515	193	5	56.68	283.40
3410	2246	74	2	293.77	587.54
3411	2272	482	3	26.78	80.34
3412	2045	377	1	57.24	57.24
3413	879	463	1	25.47	25.47
3414	227	440	4	119.15	476.60
3415	1654	254	3	19.26	57.78
3416	2400	291	3	62.85	188.55
3417	1845	448	3	21.73	65.19
3418	1166	487	3	138.30	414.90
3419	2416	321	2	35.69	71.38
3420	998	79	4	75.58	302.32
3421	2347	495	1	28.08	28.08
3422	1382	77	4	57.74	230.96
3423	39	68	2	106.83	213.66
3424	1807	176	4	94.41	377.64
3425	1505	440	2	119.15	238.30
3426	2288	295	5	39.05	195.25
3427	275	489	1	88.05	88.05
3428	93	352	4	21.21	84.84
3429	1373	115	4	21.78	87.12
3430	1785	274	2	78.08	156.16
3431	2264	133	2	22.04	44.08
3432	1545	297	4	15.73	62.92
3433	1629	496	3	7.91	23.73
3434	1832	247	4	23.80	95.20
3435	2184	215	1	14.02	14.02
3436	366	410	2	178.58	357.16
3437	1578	418	1	134.86	134.86
3438	74	394	3	148.49	445.47
3439	978	286	4	21.30	85.20
3440	307	407	3	262.44	787.32
3441	1007	70	4	194.01	776.04
3442	2066	45	2	40.34	80.68
3443	2149	187	4	131.18	524.72
3444	1469	256	3	175.24	525.72
3445	1036	402	1	55.39	55.39
3446	294	424	2	924.51	1849.02
3447	814	421	4	33.87	135.48
3448	146	233	1	1143.94	1143.94
3449	2498	291	5	62.85	314.25
3450	488	203	3	1902.34	5707.02
3451	2176	493	5	54.70	273.50
3452	158	312	1	23.82	23.82
3453	1654	46	5	74.80	374.00
3454	2088	210	4	117.15	468.60
3455	1122	34	4	37.20	148.80
3456	2336	140	2	22.98	45.96
3457	1647	184	1	50.91	50.91
3458	498	394	5	148.49	742.45
3459	662	189	5	30.28	151.40
3460	1016	377	1	57.24	57.24
3461	913	374	4	44.65	178.60
3462	2263	437	5	11.99	59.95
3463	2101	454	2	10.72	21.44
3464	1065	343	1	45.18	45.18
3465	1715	122	5	158.20	791.00
3466	1490	339	4	187.08	748.32
3467	1125	161	2	183.22	366.44
3468	604	165	1	10.39	10.39
3469	698	177	2	74.94	149.88
3470	2385	463	5	25.47	127.35
3471	1382	425	5	50.74	253.70
3472	1185	421	3	33.87	101.61
3473	1614	244	1	26.32	26.32
3474	2140	385	4	13.45	53.80
3475	1880	294	4	956.29	3825.16
3476	2170	175	1	1956.92	1956.92
3477	1226	84	3	6.04	18.12
3478	1415	451	3	37.84	113.52
3479	1041	356	1	378.69	378.69
3480	2370	148	3	1809.97	5429.91
3481	424	491	5	65.83	329.15
3482	1444	311	5	475.70	2378.50
3483	79	431	5	226.93	1134.65
3484	1730	339	2	187.08	374.16
3485	475	34	2	37.20	74.40
3486	2463	35	4	47.26	189.04
3487	758	232	4	43.21	172.84
3488	1880	261	2	64.39	128.78
3489	595	311	1	475.70	475.70
3490	2014	394	2	148.49	296.98
3491	585	311	2	475.70	951.40
3492	1691	320	3	82.53	247.59
3493	1579	267	2	109.12	218.24
3494	147	259	5	44.64	223.20
3495	1233	295	5	39.05	195.25
3496	515	57	5	47.99	239.95
3497	2405	105	1	45.66	45.66
3498	1787	405	3	1223.24	3669.72
3499	2387	362	5	60.33	301.65
3500	41	200	3	50.56	151.68
3501	1860	371	1	129.51	129.51
3502	2473	363	3	30.19	90.57
3503	1566	318	2	50.11	100.22
3504	1388	448	1	21.73	21.73
3505	622	360	2	41.94	83.88
3506	1923	73	3	496.56	1489.68
3507	1318	177	5	74.94	374.70
3508	84	139	2	38.32	76.64
3509	1704	79	4	75.58	302.32
3510	1341	202	3	20.16	60.48
3511	1461	78	3	1094.06	3282.18
3512	1195	473	1	160.59	160.59
3513	2255	309	2	20.47	40.94
3514	302	241	5	101.95	509.75
3515	1002	463	2	25.47	50.94
3516	1563	200	2	50.56	101.12
3517	986	238	1	54.26	54.26
3518	1743	281	2	12.06	24.12
3519	1058	310	3	38.48	115.44
3520	2307	22	2	133.18	266.36
3521	2461	165	4	10.39	41.56
3522	557	466	3	43.61	130.83
3523	488	61	3	21.85	65.55
3524	363	185	4	68.10	272.40
3525	1544	436	4	70.65	282.60
3526	565	327	4	126.09	504.36
3527	1683	115	2	21.78	43.56
3528	281	70	5	194.01	970.05
3529	207	177	5	74.94	374.70
3530	1605	62	1	37.50	37.50
3531	640	468	1	429.47	429.47
3532	444	312	3	23.82	71.46
3533	1227	157	3	212.65	637.95
3534	68	378	5	245.22	1226.10
3535	1930	393	1	15.33	15.33
3536	44	137	3	59.63	178.89
3537	2477	14	3	201.38	604.14
3538	1732	495	2	28.08	56.16
3539	2170	349	1	67.66	67.66
3540	1518	325	5	33.89	169.45
3541	1923	271	2	148.66	297.32
3542	830	193	3	56.68	170.04
3543	2391	448	2	21.73	43.46
3544	2402	412	4	32.98	131.92
3545	1544	446	5	361.96	1809.80
3546	1548	44	3	1624.58	4873.74
3547	1880	338	2	173.05	346.10
3548	1624	309	1	20.47	20.47
3549	606	89	1	127.84	127.84
3550	286	197	2	135.87	271.74
3551	1971	288	5	656.63	3283.15
3552	548	81	4	40.13	160.52
3553	918	318	4	50.11	200.44
3554	1404	398	1	237.21	237.21
3555	2434	178	1	386.24	386.24
3556	1904	459	3	53.30	159.90
3557	1984	58	1	39.85	39.85
3558	1867	382	4	139.89	559.56
3559	198	254	2	19.26	38.52
3560	1757	280	5	241.86	1209.30
3561	321	324	1	74.42	74.42
3562	1120	65	4	70.40	281.60
3563	1636	494	5	25.21	126.05
3564	1268	411	2	40.37	80.74
3565	1765	196	4	36.96	147.84
3566	842	239	3	28.15	84.45
3567	1801	152	1	70.59	70.59
3568	1933	382	4	139.89	559.56
3569	1651	315	2	1323.55	2647.10
3570	1133	66	2	104.91	209.82
3571	837	381	5	19.94	99.70
3572	2121	245	1	71.20	71.20
3573	1729	64	4	37.18	148.72
3574	493	70	2	194.01	388.02
3575	65	2	5	1385.15	6925.75
3576	1507	64	1	37.18	37.18
3577	1382	338	1	173.05	173.05
3578	329	205	5	19.42	97.10
3579	1912	161	4	183.22	732.88
3580	1188	228	2	249.92	499.84
3581	626	500	5	175.70	878.50
3582	852	185	2	68.10	136.20
3583	1609	424	2	924.51	1849.02
3584	595	321	1	35.69	35.69
3585	28	117	5	70.83	354.15
3586	2329	67	5	47.52	237.60
3587	591	175	2	1956.92	3913.84
3588	333	173	4	112.69	450.76
3589	196	174	5	80.98	404.90
3590	751	309	1	20.47	20.47
3591	2276	128	3	38.41	115.23
3592	249	187	4	131.18	524.72
3593	2330	218	2	34.45	68.90
3594	1534	241	4	101.95	407.80
3595	192	209	4	70.93	283.72
3596	2463	156	4	446.90	1787.60
3597	1065	116	1	1031.32	1031.32
3598	542	51	1	54.55	54.55
3599	1358	293	3	77.37	232.11
3600	2102	362	2	60.33	120.66
3601	2291	212	5	43.24	216.20
3602	2486	154	5	17.90	89.50
3603	1246	72	4	6.47	25.88
3604	2225	323	4	1447.42	5789.68
3605	746	356	1	378.69	378.69
3606	1346	104	4	50.61	202.44
3607	1601	126	3	47.88	143.64
3608	1541	324	3	74.42	223.26
3609	1822	47	5	87.81	439.05
3610	1401	307	5	43.66	218.30
3611	626	171	1	127.13	127.13
3612	423	58	3	39.85	119.55
3613	654	86	2	50.97	101.94
3614	381	289	1	1622.15	1622.15
3615	1600	48	3	66.82	200.46
3616	2204	485	3	22.10	66.30
3617	2035	47	3	87.81	263.43
3618	1279	483	1	75.61	75.61
3619	1185	205	1	19.42	19.42
3620	2056	181	2	57.96	115.92
3621	1530	15	1	34.26	34.26
3622	1614	17	2	31.74	63.48
3623	1630	41	4	480.19	1920.76
3624	330	191	5	49.67	248.35
3625	1478	454	2	10.72	21.44
3626	413	247	5	23.80	119.00
3627	1935	104	4	50.61	202.44
3628	1339	172	5	450.87	2254.35
3629	830	139	5	38.32	191.60
3630	1090	188	1	58.13	58.13
3631	1405	484	2	6.41	12.82
3632	987	191	3	49.67	149.01
3633	2471	131	3	16.19	48.57
3634	2321	319	1	1794.17	1794.17
3635	1457	76	2	9.20	18.40
3636	1787	356	5	378.69	1893.45
3637	406	467	3	100.75	302.25
3638	2401	130	5	41.39	206.95
3639	520	247	4	23.80	95.20
3640	1247	245	4	71.20	284.80
3641	749	175	4	1956.92	7827.68
3642	1167	321	1	35.69	35.69
3643	1053	66	2	104.91	209.82
3644	145	25	1	48.32	48.32
3645	2235	114	3	152.22	456.66
3646	2284	197	1	135.87	135.87
3647	582	194	5	37.99	189.95
3648	1738	214	2	18.50	37.00
3649	2307	458	3	43.32	129.96
3650	1621	90	4	126.60	506.40
3651	1223	494	4	25.21	100.84
3652	1149	178	3	386.24	1158.72
3653	1075	445	3	169.10	507.30
3654	362	5	1	23.44	23.44
3655	61	225	5	97.45	487.25
3656	945	115	2	21.78	43.56
3657	221	123	2	27.40	54.80
3658	2457	149	4	33.61	134.44
3659	2094	303	5	91.70	458.50
3660	1509	220	5	21.07	105.35
3661	1580	364	1	157.44	157.44
3662	2099	296	1	19.61	19.61
3663	589	101	1	35.50	35.50
3664	1291	191	2	49.67	99.34
3665	1001	140	5	22.98	114.90
3666	1986	319	2	1794.17	3588.34
3667	2233	441	4	97.86	391.44
3668	619	500	2	175.70	351.40
3669	1637	149	1	33.61	33.61
3670	459	352	1	21.21	21.21
3671	2016	338	3	173.05	519.15
3672	2061	111	1	38.70	38.70
3673	2423	3	2	26.19	52.38
3674	804	243	2	56.14	112.28
3675	590	257	3	13.06	39.18
3676	1579	144	4	115.12	460.48
3677	864	281	1	12.06	12.06
3678	653	18	1	178.99	178.99
3679	1054	203	5	1902.34	9511.70
3680	2342	27	3	46.75	140.25
3681	1253	482	2	26.78	53.56
3682	871	10	2	35.19	70.38
3683	1941	374	1	44.65	44.65
3684	1179	449	1	36.96	36.96
3685	20	346	2	78.72	157.44
3686	287	6	5	29.06	145.30
3687	2141	341	5	59.37	296.85
3688	155	452	2	14.12	28.24
3689	2010	423	3	121.24	363.72
3690	2052	333	2	240.47	480.94
3691	2230	219	2	31.22	62.44
3692	1083	341	1	59.37	59.37
3693	1817	437	5	11.99	59.95
3694	2062	75	2	323.09	646.18
3695	980	232	1	43.21	43.21
3696	1900	336	4	12.98	51.92
3697	1823	20	5	248.39	1241.95
3698	882	28	1	69.72	69.72
3699	1862	95	4	76.13	304.52
3700	2319	228	2	249.92	499.84
3701	983	410	4	178.58	714.32
3702	164	133	1	22.04	22.04
3703	1151	147	2	289.77	579.54
3704	2080	480	5	138.76	693.80
3705	1418	468	5	429.47	2147.35
3706	1722	18	1	178.99	178.99
3707	1761	490	4	46.96	187.84
3708	535	456	2	39.61	79.22
3709	1350	464	4	76.32	305.28
3710	664	324	5	74.42	372.10
3711	2472	44	1	1624.58	1624.58
3712	1680	428	4	238.02	952.08
3713	769	175	5	1956.92	9784.60
3714	1414	156	5	446.90	2234.50
3715	2264	494	3	25.21	75.63
3716	1148	437	4	11.99	47.96
3717	980	102	4	93.77	375.08
3718	142	34	4	37.20	148.80
3719	1081	434	2	49.87	99.74
3720	1385	199	1	33.04	33.04
3721	1071	71	1	41.29	41.29
3722	259	61	1	21.85	21.85
3723	1320	288	3	656.63	1969.89
3724	1517	179	2	224.59	449.18
3725	1540	4	1	145.93	145.93
3726	2338	205	3	19.42	58.26
3727	1744	89	1	127.84	127.84
3728	68	466	1	43.61	43.61
3729	1006	500	4	175.70	702.80
3730	1315	78	1	1094.06	1094.06
3731	425	76	4	9.20	36.80
3732	2017	120	1	41.71	41.71
3733	1570	440	4	119.15	476.60
3734	256	319	2	1794.17	3588.34
3735	1105	493	3	54.70	164.10
3736	2045	418	5	134.86	674.30
3737	1369	380	3	41.63	124.89
3738	2243	384	1	5.64	5.64
3739	890	336	5	12.98	64.90
3740	596	36	5	20.31	101.55
3741	1303	317	3	35.02	105.06
3742	867	397	1	97.03	97.03
3743	2269	397	2	97.03	194.06
3744	2410	467	2	100.75	201.50
3745	898	121	4	16.58	66.32
3746	1781	432	1	28.57	28.57
3747	1330	277	5	1676.49	8382.45
3748	656	93	3	54.25	162.75
3749	125	427	1	156.77	156.77
3750	1250	490	1	46.96	46.96
3751	1495	457	5	10.57	52.85
3752	2171	334	1	22.93	22.93
3753	1753	125	5	812.50	4062.50
3754	779	255	3	96.70	290.10
3755	2317	366	3	437.87	1313.61
3756	1485	413	3	68.02	204.06
3757	131	427	3	156.77	470.31
3758	905	482	3	26.78	80.34
3759	1222	451	4	37.84	151.36
3760	1838	119	5	254.39	1271.95
3761	2006	359	4	53.26	213.04
3762	216	48	2	66.82	133.64
3763	1536	386	5	152.82	764.10
3764	509	51	4	54.55	218.20
3765	330	286	3	21.30	63.90
3766	1814	117	3	70.83	212.49
3767	159	449	4	36.96	147.84
3768	2203	76	1	9.20	9.20
3769	266	361	5	67.61	338.05
3770	215	366	2	437.87	875.74
3771	235	192	4	42.22	168.88
3772	1051	38	4	32.14	128.56
3773	1162	28	4	69.72	278.88
3774	1399	145	1	87.37	87.37
3775	566	19	2	34.49	68.98
3776	1346	405	4	1223.24	4892.96
3777	1930	206	4	45.80	183.20
3778	62	180	1	432.09	432.09
3779	2460	286	5	21.30	106.50
3780	548	434	5	49.87	249.35
3781	2250	500	4	175.70	702.80
3782	624	352	2	21.21	42.42
3783	889	443	4	17.52	70.08
3784	1815	386	2	152.82	305.64
3785	2455	38	5	32.14	160.70
3786	2276	37	3	168.04	504.12
3787	1350	292	4	425.20	1700.80
3788	1676	444	1	276.46	276.46
3789	1768	358	2	68.55	137.10
3790	373	486	4	55.39	221.56
3791	356	142	4	97.11	388.44
3792	1372	140	4	22.98	91.92
3793	1613	187	5	131.18	655.90
3794	44	457	2	10.57	21.14
3795	395	185	1	68.10	68.10
3796	1052	24	3	18.15	54.45
3797	2218	426	3	34.78	104.34
3798	818	308	4	197.22	788.88
3799	1867	305	2	64.25	128.50
3800	2353	310	4	38.48	153.92
3801	354	352	1	21.21	21.21
3802	1040	84	2	6.04	12.08
3803	2063	287	5	13.46	67.30
3804	867	339	5	187.08	935.40
3805	1144	44	4	1624.58	6498.32
3806	1527	239	3	28.15	84.45
3807	2331	353	1	139.69	139.69
3808	1848	436	2	70.65	141.30
3809	576	392	2	35.62	71.24
3810	91	46	2	74.80	149.60
3811	767	438	3	7.95	23.85
3812	2474	435	4	12.96	51.84
3813	1931	53	1	25.96	25.96
3814	1922	135	3	28.66	85.98
3815	1297	145	3	87.37	262.11
3816	269	430	4	143.84	575.36
3817	1048	237	4	24.89	99.56
3818	172	405	2	1223.24	2446.48
3819	521	69	4	259.22	1036.88
3820	1922	436	4	70.65	282.60
3821	188	153	2	23.36	46.72
3822	1093	434	2	49.87	99.74
3823	1564	380	1	41.63	41.63
3824	960	349	3	67.66	202.98
3825	1832	205	1	19.42	19.42
3826	1845	294	1	956.29	956.29
3827	21	104	4	50.61	202.44
3828	2204	169	4	186.87	747.48
3829	1341	379	1	37.51	37.51
3830	540	470	3	18.69	56.07
3831	1676	453	2	27.19	54.38
3832	792	400	1	72.50	72.50
3833	668	165	3	10.39	31.17
3834	2273	171	2	127.13	254.26
3835	1316	478	3	94.13	282.39
3836	1896	237	5	24.89	124.45
3837	546	149	2	33.61	67.22
3838	181	129	1	7.25	7.25
3839	935	121	5	16.58	82.90
3840	1435	129	4	7.25	29.00
3841	272	30	5	72.53	362.65
3842	453	26	4	173.16	692.64
3843	2474	491	2	65.83	131.66
3844	546	239	4	28.15	112.60
3845	423	262	3	55.35	166.05
3846	1665	264	4	51.18	204.72
3847	1671	59	1	248.24	248.24
3848	137	349	3	67.66	202.98
3849	2030	371	4	129.51	518.04
3850	1168	7	3	1801.75	5405.25
3851	484	115	4	21.78	87.12
3852	1234	91	5	81.18	405.90
3853	1371	3	5	26.19	130.95
3854	728	238	4	54.26	217.04
3855	2311	465	5	151.90	759.50
3856	2341	183	5	20.45	102.25
3857	2306	256	4	175.24	700.96
3858	2183	454	1	10.72	10.72
3859	134	120	2	41.71	83.42
3860	671	193	4	56.68	226.72
3861	1516	347	5	34.57	172.85
3862	1145	494	5	25.21	126.05
3863	1154	473	2	160.59	321.18
3864	1564	230	1	12.95	12.95
3865	481	39	1	28.02	28.02
3866	255	393	3	15.33	45.99
3867	73	19	5	34.49	172.45
3868	1117	431	2	226.93	453.86
3869	2072	444	4	276.46	1105.84
3870	2109	478	5	94.13	470.65
3871	1794	380	2	41.63	83.26
3872	2446	257	4	13.06	52.24
3873	45	209	2	70.93	141.86
3874	1800	88	1	24.07	24.07
3875	2253	103	3	168.49	505.47
3876	1611	169	5	186.87	934.35
3877	1067	217	2	102.71	205.42
3878	1120	423	2	121.24	242.48
3879	1579	40	5	30.42	152.10
3880	885	236	1	1207.15	1207.15
3881	1014	276	2	44.63	89.26
3882	1082	299	4	10.57	42.28
3883	38	245	1	71.20	71.20
3884	17	106	4	77.98	311.92
3885	2097	411	3	40.37	121.11
3886	2257	497	5	25.76	128.80
3887	1888	232	2	43.21	86.42
3888	2428	54	3	177.79	533.37
3889	2498	312	1	23.82	23.82
3890	719	47	1	87.81	87.81
3891	143	21	3	42.95	128.85
3892	1518	28	1	69.72	69.72
3893	173	81	4	40.13	160.52
3894	2485	51	2	54.55	109.10
3895	2451	218	5	34.45	172.25
3896	2339	84	1	6.04	6.04
3897	494	445	1	169.10	169.10
3898	1602	191	5	49.67	248.35
3899	516	197	4	135.87	543.48
3900	2230	463	2	25.47	50.94
3901	223	491	2	65.83	131.66
3902	36	76	5	9.20	46.00
3903	626	262	2	55.35	110.70
3904	813	154	3	17.90	53.70
3905	936	108	4	43.88	175.52
3906	2281	136	1	68.76	68.76
3907	384	52	5	1713.47	8567.35
3908	328	222	2	1222.06	2444.12
3909	2048	467	1	100.75	100.75
3910	1270	165	1	10.39	10.39
3911	1214	259	5	44.64	223.20
3912	612	152	1	70.59	70.59
3913	56	147	4	289.77	1159.08
3914	12	285	5	31.36	156.80
3915	177	183	4	20.45	81.80
3916	2233	297	1	15.73	15.73
3917	2322	70	4	194.01	776.04
3918	1555	90	3	126.60	379.80
3919	2298	72	4	6.47	25.88
3920	938	457	5	10.57	52.85
3921	1221	373	5	24.06	120.30
3922	1030	51	5	54.55	272.75
3923	1697	162	3	51.77	155.31
3924	1832	234	5	59.10	295.50
3925	685	409	4	62.83	251.32
3926	1611	240	3	77.63	232.89
3927	433	322	5	134.71	673.55
3928	203	212	5	43.24	216.20
3929	1122	232	4	43.21	172.84
3930	2193	269	5	33.41	167.05
3931	588	329	5	43.29	216.45
3932	2113	420	1	163.63	163.63
3933	1001	338	3	173.05	519.15
3934	9	331	2	65.98	131.96
3935	814	343	2	45.18	90.36
3936	1152	482	1	26.78	26.78
3937	1744	362	4	60.33	241.32
3938	551	418	1	134.86	134.86
3939	2216	307	1	43.66	43.66
3940	1759	499	3	31.84	95.52
3941	324	62	5	37.50	187.50
3942	1641	16	4	21.47	85.88
3943	1456	151	3	35.67	107.01
3944	1668	415	4	46.59	186.36
3945	2153	377	3	57.24	171.72
3946	1109	365	5	22.34	111.70
3947	656	335	1	45.97	45.97
3948	1840	328	5	53.11	265.55
3949	864	436	5	70.65	353.25
3950	1876	296	5	19.61	98.05
3951	704	247	1	23.80	23.80
3952	1225	30	1	72.53	72.53
3953	823	75	4	323.09	1292.36
3954	264	82	1	48.26	48.26
3955	2499	221	4	56.85	227.40
3956	55	358	2	68.55	137.10
3957	2397	199	3	33.04	99.12
3958	1110	150	4	68.63	274.52
3959	1215	279	2	16.56	33.12
3960	1	108	1	43.88	43.88
3961	426	451	4	37.84	151.36
3962	1854	18	2	178.99	357.98
3963	1893	321	1	35.69	35.69
3964	2062	288	2	656.63	1313.26
3965	1768	18	5	178.99	894.95
3966	956	63	4	46.66	186.64
3967	75	362	3	60.33	180.99
3968	1915	478	3	94.13	282.39
3969	355	133	4	22.04	88.16
3970	2474	86	2	50.97	101.94
3971	641	179	4	224.59	898.36
3972	1049	466	1	43.61	43.61
3973	53	440	4	119.15	476.60
3974	738	55	5	88.59	442.95
3975	525	40	3	30.42	91.26
3976	997	61	5	21.85	109.25
3977	533	279	4	16.56	66.24
3978	1155	118	2	396.15	792.30
3979	1813	438	4	7.95	31.80
3980	2186	131	5	16.19	80.95
3981	986	126	5	47.88	239.40
3982	895	335	1	45.97	45.97
3983	905	114	1	152.22	152.22
3984	800	186	5	35.21	176.05
3985	616	28	2	69.72	139.44
3986	162	328	5	53.11	265.55
3987	2290	41	5	480.19	2400.95
3988	754	126	5	47.88	239.40
3989	2054	264	5	51.18	255.90
3990	2404	301	1	558.90	558.90
3991	2242	88	4	24.07	96.28
3992	82	1	5	31.96	159.80
3993	1141	418	2	134.86	269.72
3994	566	440	1	119.15	119.15
3995	1550	145	1	87.37	87.37
3996	117	13	2	150.13	300.26
3997	211	457	1	10.57	10.57
3998	1135	29	4	12.23	48.92
3999	937	337	1	71.01	71.01
4000	2196	452	4	14.12	56.48
4001	426	423	4	121.24	484.96
4002	1909	316	3	30.13	90.39
4003	254	311	2	475.70	951.40
4004	933	327	2	126.09	252.18
4005	153	85	1	478.53	478.53
4006	1531	325	4	33.89	135.56
4007	2080	226	2	173.76	347.52
4008	25	17	2	31.74	63.48
4009	1602	480	4	138.76	555.04
4010	643	278	1	39.34	39.34
4011	1343	56	2	60.90	121.80
4012	245	448	1	21.73	21.73
4013	1454	353	4	139.69	558.76
4014	1539	169	5	186.87	934.35
4015	1118	351	5	47.82	239.10
4016	1745	293	3	77.37	232.11
4017	1233	222	3	1222.06	3666.18
4018	2181	227	5	1612.51	8062.55
4019	38	259	1	44.64	44.64
4020	1950	159	1	15.19	15.19
4021	2287	368	3	234.47	703.41
4022	2158	250	5	40.88	204.40
4023	346	268	1	441.06	441.06
4024	1116	397	2	97.03	194.06
4025	633	334	4	22.93	91.72
4026	218	473	2	160.59	321.18
4027	998	73	5	496.56	2482.80
4028	372	407	3	262.44	787.32
4029	851	307	3	43.66	130.98
4030	463	350	3	29.82	89.46
4031	586	367	5	119.27	596.35
4032	2367	226	3	173.76	521.28
4033	997	329	5	43.29	216.45
4034	1492	404	2	18.86	37.72
4035	2286	60	3	1576.99	4730.97
4036	1440	350	4	29.82	119.28
4037	754	13	2	150.13	300.26
4038	1732	491	5	65.83	329.15
4039	484	267	5	109.12	545.60
4040	1614	455	5	40.50	202.50
4041	1181	309	1	20.47	20.47
4042	281	171	2	127.13	254.26
4043	153	411	4	40.37	161.48
4044	2064	493	3	54.70	164.10
4045	1789	271	2	148.66	297.32
4046	1628	261	5	64.39	321.95
4047	426	158	2	191.11	382.22
4048	1797	282	2	367.58	735.16
4049	2125	138	3	68.43	205.29
4050	2016	282	3	367.58	1102.74
4051	17	463	1	25.47	25.47
4052	119	493	4	54.70	218.80
4053	792	20	3	248.39	745.17
4054	487	136	1	68.76	68.76
4055	2349	63	5	46.66	233.30
4056	576	432	2	28.57	57.14
4057	1160	226	3	173.76	521.28
4058	392	402	5	55.39	276.95
4059	2087	345	1	35.23	35.23
4060	1604	404	3	18.86	56.58
4061	144	258	4	34.33	137.32
4062	335	493	4	54.70	218.80
4063	1829	244	2	26.32	52.64
4064	1531	441	1	97.86	97.86
4065	1127	25	2	48.32	96.64
4066	1639	23	2	37.46	74.92
4067	1615	181	4	57.96	231.84
4068	680	102	1	93.77	93.77
4069	1306	270	1	17.08	17.08
4070	219	394	5	148.49	742.45
4071	325	97	4	1307.31	5229.24
4072	561	275	2	44.37	88.74
4073	126	218	5	34.45	172.25
4074	73	252	5	175.20	876.00
4075	2320	342	3	70.36	211.08
4076	580	339	3	187.08	561.24
4077	596	436	3	70.65	211.95
4078	1990	500	1	175.70	175.70
4079	1533	390	2	43.60	87.20
4080	2145	173	5	112.69	563.45
4081	1315	125	3	812.50	2437.50
4082	2287	231	3	1595.61	4786.83
4083	1461	43	2	87.93	175.86
4084	29	429	1	135.14	135.14
4085	2004	471	3	67.11	201.33
4086	1673	11	4	53.63	214.52
4087	434	39	2	28.02	56.04
4088	2471	3	1	26.19	26.19
4089	1387	325	5	33.89	169.45
4090	1659	494	2	25.21	50.42
4091	2029	70	1	194.01	194.01
4092	1179	190	4	45.03	180.12
4093	825	22	5	133.18	665.90
4094	1105	331	4	65.98	263.92
4095	693	93	5	54.25	271.25
4096	858	264	3	51.18	153.54
4097	333	373	5	24.06	120.30
4098	2072	437	1	11.99	11.99
4099	1950	266	5	243.80	1219.00
4100	742	450	4	33.27	133.08
4101	120	13	3	150.13	450.39
4102	1197	374	3	44.65	133.95
4103	1102	409	5	62.83	314.15
4104	1267	242	5	899.18	4495.90
4105	1931	308	4	197.22	788.88
4106	466	134	2	15.54	31.08
4107	2117	225	3	97.45	292.35
4108	1205	159	1	15.19	15.19
4109	8	85	5	478.53	2392.65
4110	1565	385	5	13.45	67.25
4111	1288	109	5	62.66	313.30
4112	1685	369	2	61.27	122.54
4113	2476	131	1	16.19	16.19
4114	728	488	4	47.80	191.20
4115	2373	230	4	12.95	51.80
4116	1109	280	2	241.86	483.72
4117	1426	290	3	263.35	790.05
4118	2240	485	1	22.10	22.10
4119	2114	475	4	218.49	873.96
4120	792	194	4	37.99	151.96
4121	2493	1	5	31.96	159.80
4122	1907	288	1	656.63	656.63
4123	1018	271	1	148.66	148.66
4124	101	86	2	50.97	101.94
4125	1011	44	2	1624.58	3249.16
4126	1065	351	5	47.82	239.10
4127	597	303	4	91.70	366.80
4128	2489	32	2	36.44	72.88
4129	1540	360	4	41.94	167.76
4130	850	168	4	68.11	272.44
4131	336	36	1	20.31	20.31
4132	279	446	4	361.96	1447.84
4133	2092	57	2	47.99	95.98
4134	2012	84	1	6.04	6.04
4135	1160	264	4	51.18	204.72
4136	2282	401	2	498.85	997.70
4137	467	224	3	50.63	151.89
4138	2137	270	1	17.08	17.08
4139	1056	488	2	47.80	95.60
4140	593	41	3	480.19	1440.57
4141	1056	299	2	10.57	21.14
4142	1076	399	2	71.86	143.72
4143	273	371	2	129.51	259.02
4144	1627	386	3	152.82	458.46
4145	2206	491	1	65.83	65.83
4146	403	192	5	42.22	211.10
4147	1491	474	5	62.56	312.80
4148	1675	379	2	37.51	75.02
4149	349	426	1	34.78	34.78
4150	1682	129	4	7.25	29.00
4151	1007	298	2	137.17	274.34
4152	614	367	2	119.27	238.54
4153	1539	399	2	71.86	143.72
4154	1927	319	4	1794.17	7176.68
4155	1022	436	3	70.65	211.95
4156	259	116	3	1031.32	3093.96
4157	1590	70	1	194.01	194.01
4158	878	358	1	68.55	68.55
4159	1694	404	5	18.86	94.30
4160	958	345	1	35.23	35.23
4161	1460	82	3	48.26	144.78
4162	204	338	3	173.05	519.15
4163	1737	132	3	41.64	124.92
4164	2083	92	2	222.12	444.24
4165	2188	482	3	26.78	80.34
4166	1763	311	5	475.70	2378.50
4167	1283	415	3	46.59	139.77
4168	1424	497	2	25.76	51.52
4169	889	252	1	175.20	175.20
4170	777	30	2	72.53	145.06
4171	1054	165	3	10.39	31.17
4172	1972	177	2	74.94	149.88
4173	2496	413	3	68.02	204.06
4174	9	379	1	37.51	37.51
4175	388	355	5	42.69	213.45
4176	470	400	3	72.50	217.50
4177	23	57	4	47.99	191.96
4178	1151	137	4	59.63	238.52
4179	1336	350	3	29.82	89.46
4180	609	140	1	22.98	22.98
4181	1034	202	1	20.16	20.16
4182	23	132	5	41.64	208.20
4183	311	433	4	10.07	40.28
4184	618	246	1	1098.58	1098.58
4185	311	255	3	96.70	290.10
4186	1655	214	4	18.50	74.00
4187	328	435	3	12.96	38.88
4188	2256	445	1	169.10	169.10
4189	2277	145	5	87.37	436.85
4190	1397	41	5	480.19	2400.95
4191	852	467	3	100.75	302.25
4192	2205	147	1	289.77	289.77
4193	1729	139	3	38.32	114.96
4194	1358	104	4	50.61	202.44
4195	681	327	3	126.09	378.27
4196	2167	458	2	43.32	86.64
4197	2452	287	5	13.46	67.30
4198	969	301	5	558.90	2794.50
4199	855	409	5	62.83	314.15
4200	844	333	1	240.47	240.47
4201	1825	220	2	21.07	42.14
4202	1413	394	4	148.49	593.96
4203	107	373	1	24.06	24.06
4204	1736	9	3	437.61	1312.83
4205	1394	196	3	36.96	110.88
4206	1785	388	2	15.05	30.10
4207	737	191	3	49.67	149.01
4208	1656	458	3	43.32	129.96
4209	1354	60	1	1576.99	1576.99
4210	1998	367	5	119.27	596.35
4211	1656	241	1	101.95	101.95
4212	2338	222	5	1222.06	6110.30
4213	883	301	2	558.90	1117.80
4214	2237	351	4	47.82	191.28
4215	4	296	1	19.61	19.61
4216	544	500	1	175.70	175.70
4217	1086	466	1	43.61	43.61
4218	723	343	2	45.18	90.36
4219	1909	76	3	9.20	27.60
4220	1062	201	4	20.18	80.72
4221	2079	36	3	20.31	60.93
4222	2371	99	5	42.94	214.70
4223	156	250	3	40.88	122.64
4224	1942	278	2	39.34	78.68
4225	1633	318	5	50.11	250.55
4226	1042	476	5	1824.95	9124.75
4227	2420	378	2	245.22	490.44
4228	1392	258	1	34.33	34.33
4229	530	265	2	192.35	384.70
4230	299	151	2	35.67	71.34
4231	15	410	4	178.58	714.32
4232	1653	322	4	134.71	538.84
4233	2486	46	4	74.80	299.20
4234	1080	330	4	44.43	177.72
4235	1560	351	5	47.82	239.10
4236	40	98	4	13.19	52.76
4237	965	102	5	93.77	468.85
4238	398	208	2	111.45	222.90
4239	1211	195	2	172.13	344.26
4240	2088	293	5	77.37	386.85
4241	2169	419	3	1124.89	3374.67
4242	1587	387	2	43.03	86.06
4243	1239	332	2	20.41	40.82
4244	944	185	5	68.10	340.50
4245	361	477	4	183.20	732.80
4246	775	324	1	74.42	74.42
4247	823	162	5	51.77	258.85
4248	1116	378	3	245.22	735.66
4249	1227	72	1	6.47	6.47
4250	2038	384	1	5.64	5.64
4251	960	329	5	43.29	216.45
4252	285	264	2	51.18	102.36
4253	379	25	5	48.32	241.60
4254	1216	177	1	74.94	74.94
4255	213	94	5	124.81	624.05
4256	686	211	2	127.39	254.78
4257	1422	207	3	76.84	230.52
4258	2454	277	2	1676.49	3352.98
4259	752	306	3	155.79	467.37
4260	663	35	2	47.26	94.52
4261	1489	200	3	50.56	151.68
4262	828	93	1	54.25	54.25
4263	237	84	4	6.04	24.16
4264	1854	290	4	263.35	1053.40
4265	487	465	2	151.90	303.80
4266	1914	418	5	134.86	674.30
4267	1501	108	2	43.88	87.76
4268	1027	107	3	15.08	45.24
4269	2428	32	4	36.44	145.76
4270	748	404	2	18.86	37.72
4271	1163	293	2	77.37	154.74
4272	311	161	3	183.22	549.66
4273	778	215	5	14.02	70.10
4274	2302	445	5	169.10	845.50
4275	116	206	5	45.80	229.00
4276	224	158	2	191.11	382.22
4277	2112	469	2	27.64	55.28
4278	920	452	3	14.12	42.36
4279	183	414	2	32.14	64.28
4280	184	51	4	54.55	218.20
4281	1437	146	3	50.37	151.11
4282	1911	256	1	175.24	175.24
4283	1532	363	5	30.19	150.95
4284	2206	184	4	50.91	203.64
4285	1900	136	4	68.76	275.04
4286	143	370	5	460.14	2300.70
4287	813	364	3	157.44	472.32
4288	914	277	1	1676.49	1676.49
4289	214	188	5	58.13	290.65
4290	1524	349	4	67.66	270.64
4291	35	257	3	13.06	39.18
4292	1915	452	3	14.12	42.36
4293	90	53	2	25.96	51.92
4294	1192	110	3	50.85	152.55
4295	1650	165	2	10.39	20.78
4296	2470	365	5	22.34	111.70
4297	1695	491	2	65.83	131.66
4298	497	12	4	45.14	180.56
4299	1828	442	5	19.09	95.45
4300	822	355	2	42.69	85.38
4301	506	486	5	55.39	276.95
4302	337	115	3	21.78	65.34
4303	713	407	3	262.44	787.32
4304	1278	5	1	23.44	23.44
4305	2317	1	4	31.96	127.84
4306	2355	181	3	57.96	173.88
4307	33	177	2	74.94	149.88
4308	2449	23	3	37.46	112.38
4309	1464	260	1	50.36	50.36
4310	2394	2	5	1385.15	6925.75
4311	446	166	3	39.81	119.43
4312	89	341	2	59.37	118.74
4313	2432	282	5	367.58	1837.90
4314	2225	393	5	15.33	76.65
4315	420	422	5	57.25	286.25
4316	1145	187	3	131.18	393.54
4317	744	412	5	32.98	164.90
4318	2488	232	3	43.21	129.63
4319	1620	390	4	43.60	174.40
4320	1184	119	1	254.39	254.39
4321	1201	56	2	60.90	121.80
4322	1032	472	5	91.09	455.45
4323	2203	202	4	20.16	80.64
4324	759	356	5	378.69	1893.45
4325	1148	416	4	17.53	70.12
4326	886	438	3	7.95	23.85
4327	980	396	3	34.20	102.60
4328	954	421	2	33.87	67.74
4329	1902	359	3	53.26	159.78
4330	2160	279	5	16.56	82.80
4331	540	140	1	22.98	22.98
4332	228	46	4	74.80	299.20
4333	1247	452	4	14.12	56.48
4334	1275	452	3	14.12	42.36
4335	910	194	1	37.99	37.99
4336	690	268	3	441.06	1323.18
4337	1007	186	4	35.21	140.84
4338	1461	406	1	53.06	53.06
4339	23	261	5	64.39	321.95
4340	2232	433	5	10.07	50.35
4341	684	67	2	47.52	95.04
4342	1938	215	1	14.02	14.02
4343	872	97	1	1307.31	1307.31
4344	677	18	5	178.99	894.95
4345	2317	166	5	39.81	199.05
4346	1894	295	3	39.05	117.15
4347	2317	281	3	12.06	36.18
4348	2497	272	2	120.40	240.80
4349	1715	287	5	13.46	67.30
4350	505	46	5	74.80	374.00
4351	1357	158	4	191.11	764.44
4352	1225	225	2	97.45	194.90
4353	1132	412	3	32.98	98.94
4354	350	265	3	192.35	577.05
4355	2248	228	5	249.92	1249.60
4356	962	42	4	90.48	361.92
4357	1970	28	4	69.72	278.88
4358	2131	5	5	23.44	117.20
4359	345	392	4	35.62	142.48
4360	313	195	4	172.13	688.52
4361	752	394	4	148.49	593.96
4362	1477	30	5	72.53	362.65
4363	333	208	5	111.45	557.25
4364	786	466	5	43.61	218.05
4365	2062	410	5	178.58	892.90
4366	648	137	3	59.63	178.89
4367	1964	214	4	18.50	74.00
4368	132	470	1	18.69	18.69
4369	866	63	4	46.66	186.64
4370	198	424	1	924.51	924.51
4371	2	332	4	20.41	81.64
4372	606	129	1	7.25	7.25
4373	850	457	4	10.57	42.28
4374	2328	273	5	1558.15	7790.75
4375	589	436	1	70.65	70.65
4376	1162	1	1	31.96	31.96
4377	343	234	3	59.10	177.30
4378	2500	152	5	70.59	352.95
4379	823	203	4	1902.34	7609.36
4380	230	318	1	50.11	50.11
4381	370	116	1	1031.32	1031.32
4382	1884	448	1	21.73	21.73
4383	62	308	2	197.22	394.44
4384	1628	493	5	54.70	273.50
4385	2111	283	3	26.19	78.57
4386	380	280	4	241.86	967.44
4387	1045	231	1	1595.61	1595.61
4388	1380	148	3	1809.97	5429.91
4389	2078	166	4	39.81	159.24
4390	2181	126	4	47.88	191.52
4391	1685	273	3	1558.15	4674.45
4392	2421	415	4	46.59	186.36
4393	1391	81	4	40.13	160.52
4394	88	196	3	36.96	110.88
4395	361	115	1	21.78	21.78
4396	759	128	3	38.41	115.23
4397	1294	441	1	97.86	97.86
4398	301	205	5	19.42	97.10
4399	1888	438	5	7.95	39.75
4400	1592	174	4	80.98	323.92
4401	1600	352	1	21.21	21.21
4402	1747	194	1	37.99	37.99
4403	179	250	4	40.88	163.52
4404	1286	126	4	47.88	191.52
4405	86	356	3	378.69	1136.07
4406	937	260	3	50.36	151.08
4407	1888	340	5	41.26	206.30
4408	38	82	2	48.26	96.52
4409	1563	94	2	124.81	249.62
4410	889	106	3	77.98	233.94
4411	1334	500	2	175.70	351.40
4412	286	7	3	1801.75	5405.25
4413	663	90	5	126.60	633.00
4414	2041	8	4	48.86	195.44
4415	485	1	5	31.96	159.80
4416	509	493	5	54.70	273.50
4417	1033	246	3	1098.58	3295.74
4418	2473	325	1	33.89	33.89
4419	700	54	3	177.79	533.37
4420	384	241	3	101.95	305.85
4421	1096	327	1	126.09	126.09
4422	2202	141	3	25.01	75.03
4423	1598	427	4	156.77	627.08
4424	485	109	4	62.66	250.64
4425	648	398	5	237.21	1186.05
4426	1365	106	2	77.98	155.96
4427	1173	292	4	425.20	1700.80
4428	1944	38	3	32.14	96.42
4429	1158	413	3	68.02	204.06
4430	1637	122	1	158.20	158.20
4431	1450	260	2	50.36	100.72
4432	2236	217	3	102.71	308.13
4433	2397	258	2	34.33	68.66
4434	637	381	5	19.94	99.70
4435	662	172	4	450.87	1803.48
4436	2218	343	1	45.18	45.18
4437	2488	262	4	55.35	221.40
4438	379	141	5	25.01	125.05
4439	1986	224	5	50.63	253.15
4440	54	265	2	192.35	384.70
4441	2020	318	3	50.11	150.33
4442	1585	83	4	40.42	161.68
4443	1390	414	1	32.14	32.14
4444	2237	40	3	30.42	91.26
4445	416	59	1	248.24	248.24
4446	1434	199	2	33.04	66.08
4447	1091	34	3	37.20	111.60
4448	1381	410	1	178.58	178.58
4449	1769	104	2	50.61	101.22
4450	781	57	5	47.99	239.95
4451	1407	314	3	158.44	475.32
4452	596	344	4	39.33	157.32
4453	489	56	4	60.90	243.60
4454	725	306	2	155.79	311.58
4455	1401	192	4	42.22	168.88
4456	945	167	3	67.26	201.78
4457	911	453	5	27.19	135.95
4458	651	269	1	33.41	33.41
4459	1060	199	4	33.04	132.16
4460	1813	428	2	238.02	476.04
4461	1694	296	5	19.61	98.05
4462	2407	54	3	177.79	533.37
4463	36	44	5	1624.58	8122.90
4464	1654	354	2	1200.13	2400.26
4465	819	268	4	441.06	1764.24
4466	1646	92	5	222.12	1110.60
4467	839	380	1	41.63	41.63
4468	822	272	4	120.40	481.60
4469	241	276	2	44.63	89.26
4470	188	76	3	9.20	27.60
4471	146	493	5	54.70	273.50
4472	2032	470	3	18.69	56.07
4473	1038	64	2	37.18	74.36
4474	1360	68	1	106.83	106.83
4475	163	187	1	131.18	131.18
4476	2334	366	1	437.87	437.87
4477	520	281	1	12.06	12.06
4478	368	238	2	54.26	108.52
4479	2497	264	4	51.18	204.72
4480	2468	492	5	1644.22	8221.10
4481	364	349	5	67.66	338.30
4482	1373	414	4	32.14	128.56
4483	1889	474	5	62.56	312.80
4484	1054	486	3	55.39	166.17
4485	150	401	1	498.85	498.85
4486	38	33	5	36.04	180.20
4487	2254	469	2	27.64	55.28
4488	1933	397	1	97.03	97.03
4489	529	112	3	17.58	52.74
4490	1285	160	5	63.03	315.15
4491	1342	391	3	169.39	508.17
4492	2394	310	2	38.48	76.96
4493	2299	56	4	60.90	243.60
4494	2409	252	4	175.20	700.80
4495	2023	381	3	19.94	59.82
4496	1817	240	5	77.63	388.15
4497	2421	333	4	240.47	961.88
4498	1954	153	4	23.36	93.44
4499	2215	246	1	1098.58	1098.58
4500	1750	222	2	1222.06	2444.12
4501	775	225	4	97.45	389.80
4502	2021	483	3	75.61	226.83
4503	1205	371	4	129.51	518.04
4504	1510	121	2	16.58	33.16
4505	337	492	1	1644.22	1644.22
4506	1898	91	2	81.18	162.36
4507	1433	288	4	656.63	2626.52
4508	1517	127	2	111.79	223.58
4509	1163	13	3	150.13	450.39
4510	522	358	3	68.55	205.65
4511	2322	219	3	31.22	93.66
4512	1837	298	2	137.17	274.34
4513	1584	6	5	29.06	145.30
4514	454	84	3	6.04	18.12
4515	2340	444	4	276.46	1105.84
4516	2413	38	5	32.14	160.70
4517	1109	384	5	5.64	28.20
4518	699	250	4	40.88	163.52
4519	2215	325	2	33.89	67.78
4520	1286	295	2	39.05	78.10
4521	1098	308	1	197.22	197.22
4522	1232	437	5	11.99	59.95
4523	1524	262	1	55.35	55.35
4524	760	302	2	84.18	168.36
4525	1348	196	2	36.96	73.92
4526	1336	142	2	97.11	194.22
4527	1666	383	3	29.97	89.91
4528	2177	444	4	276.46	1105.84
4529	667	487	4	138.30	553.20
4530	259	142	1	97.11	97.11
4531	2048	184	4	50.91	203.64
4532	2239	251	1	159.92	159.92
4533	279	332	4	20.41	81.64
4534	701	78	2	1094.06	2188.12
4535	797	442	1	19.09	19.09
4536	1809	449	4	36.96	147.84
4537	840	435	3	12.96	38.88
4538	2425	182	3	18.31	54.93
4539	830	249	3	17.60	52.80
4540	343	466	4	43.61	174.44
4541	686	334	4	22.93	91.72
4542	84	204	4	46.65	186.60
4543	2031	397	2	97.03	194.06
4544	737	476	4	1824.95	7299.80
4545	1126	373	2	24.06	48.12
4546	1430	393	4	15.33	61.32
4547	1518	55	2	88.59	177.18
4548	1522	409	4	62.83	251.32
4549	1125	181	4	57.96	231.84
4550	1115	442	5	19.09	95.45
4551	1503	283	3	26.19	78.57
4552	819	281	1	12.06	12.06
4553	2090	386	5	152.82	764.10
4554	2349	192	5	42.22	211.10
4555	1708	146	5	50.37	251.85
4556	889	40	5	30.42	152.10
4557	304	149	4	33.61	134.44
4558	917	214	4	18.50	74.00
4559	2093	52	3	1713.47	5140.41
4560	1442	173	4	112.69	450.76
4561	1503	492	3	1644.22	4932.66
4562	1556	258	5	34.33	171.65
4563	743	465	3	151.90	455.70
4564	2044	427	3	156.77	470.31
4565	2080	14	2	201.38	402.76
4566	1282	375	3	62.45	187.35
4567	161	34	5	37.20	186.00
4568	1993	481	3	49.26	147.78
4569	1218	147	2	289.77	579.54
4570	649	97	5	1307.31	6536.55
4571	2049	149	3	33.61	100.83
4572	252	94	2	124.81	249.62
4573	1660	395	4	48.37	193.48
4574	1811	16	4	21.47	85.88
4575	1422	84	3	6.04	18.12
4576	337	275	1	44.37	44.37
4577	421	169	2	186.87	373.74
4578	983	276	4	44.63	178.52
4579	2040	272	4	120.40	481.60
4580	773	230	4	12.95	51.80
4581	1097	226	4	173.76	695.04
4582	1783	309	5	20.47	102.35
4583	554	156	4	446.90	1787.60
4584	2262	400	3	72.50	217.50
4585	976	178	1	386.24	386.24
4586	872	413	3	68.02	204.06
4587	2315	464	2	76.32	152.64
4588	1097	415	1	46.59	46.59
4589	1134	312	4	23.82	95.28
4590	1824	180	4	432.09	1728.36
4591	1716	3	4	26.19	104.76
4592	2360	248	3	235.92	707.76
4593	1385	151	1	35.67	35.67
4594	2039	377	3	57.24	171.72
4595	439	494	5	25.21	126.05
4596	1615	125	4	812.50	3250.00
4597	2210	367	3	119.27	357.81
4598	1199	405	2	1223.24	2446.48
4599	1002	317	3	35.02	105.06
4600	2438	370	1	460.14	460.14
4601	827	250	1	40.88	40.88
4602	187	119	3	254.39	763.17
4603	1000	221	4	56.85	227.40
4604	2063	427	2	156.77	313.54
4605	1720	270	2	17.08	34.16
4606	2236	465	1	151.90	151.90
4607	799	395	5	48.37	241.85
4608	224	228	5	249.92	1249.60
4609	706	84	1	6.04	6.04
4610	2272	327	1	126.09	126.09
4611	270	454	1	10.72	10.72
4612	1723	473	5	160.59	802.95
4613	1354	319	3	1794.17	5382.51
4614	723	284	1	22.44	22.44
4615	1372	434	4	49.87	199.48
4616	1172	97	3	1307.31	3921.93
4617	108	312	4	23.82	95.28
4618	1890	193	3	56.68	170.04
4619	1021	388	5	15.05	75.25
4620	1900	87	2	192.95	385.90
4621	1995	108	2	43.88	87.76
4622	2090	296	3	19.61	58.83
4623	363	284	3	22.44	67.32
4624	1775	85	3	478.53	1435.59
4625	1494	128	2	38.41	76.82
4626	2246	457	5	10.57	52.85
4627	1789	88	3	24.07	72.21
4628	422	212	4	43.24	172.96
4629	1518	374	3	44.65	133.95
4630	2062	56	2	60.90	121.80
4631	880	261	3	64.39	193.17
4632	1324	406	2	53.06	106.12
4633	874	232	2	43.21	86.42
4634	422	169	2	186.87	373.74
4635	1263	448	4	21.73	86.92
4636	90	385	4	13.45	53.80
4637	797	437	1	11.99	11.99
4638	41	215	1	14.02	14.02
4639	2012	154	1	17.90	17.90
4640	1891	392	3	35.62	106.86
4641	1500	231	4	1595.61	6382.44
4642	635	349	1	67.66	67.66
4643	636	17	5	31.74	158.70
4644	558	72	1	6.47	6.47
4645	490	446	1	361.96	361.96
4646	886	164	1	143.24	143.24
4647	209	308	2	197.22	394.44
4648	790	366	3	437.87	1313.61
4649	1227	158	5	191.11	955.55
4650	994	478	3	94.13	282.39
4651	762	350	4	29.82	119.28
4652	1689	62	1	37.50	37.50
4653	2346	334	1	22.93	22.93
4654	2435	181	5	57.96	289.80
4655	570	421	5	33.87	169.35
4656	1815	365	5	22.34	111.70
4657	8	451	5	37.84	189.20
4658	602	273	5	1558.15	7790.75
4659	2084	258	4	34.33	137.32
4660	733	478	3	94.13	282.39
4661	1295	206	1	45.80	45.80
4662	2058	279	1	16.56	16.56
4663	883	479	5	142.79	713.95
4664	1678	104	1	50.61	50.61
4665	1364	491	3	65.83	197.49
4666	1194	74	5	293.77	1468.85
4667	1862	234	2	59.10	118.20
4668	317	50	4	43.57	174.28
4669	1268	222	3	1222.06	3666.18
4670	1695	398	4	237.21	948.84
4671	2262	290	4	263.35	1053.40
4672	2081	85	1	478.53	478.53
4673	1224	41	3	480.19	1440.57
4674	1964	61	3	21.85	65.55
4675	502	315	4	1323.55	5294.20
4676	2305	360	4	41.94	167.76
4677	2172	26	4	173.16	692.64
4678	2007	430	1	143.84	143.84
4679	744	485	5	22.10	110.50
4680	1620	27	4	46.75	187.00
4681	825	258	5	34.33	171.65
4682	187	249	4	17.60	70.40
4683	2106	12	1	45.14	45.14
4684	1596	91	3	81.18	243.54
4685	334	115	4	21.78	87.12
4686	2473	165	5	10.39	51.95
4687	2205	124	4	133.17	532.68
4688	1560	484	4	6.41	25.64
4689	1498	223	4	35.37	141.48
4690	2268	368	5	234.47	1172.35
4691	1276	2	2	1385.15	2770.30
4692	2490	432	5	28.57	142.85
4693	315	396	1	34.20	34.20
4694	1984	141	3	25.01	75.03
4695	1198	22	2	133.18	266.36
4696	120	171	3	127.13	381.39
4697	1794	496	4	7.91	31.64
4698	556	468	3	429.47	1288.41
4699	1357	250	5	40.88	204.40
4700	1956	258	5	34.33	171.65
4701	1119	139	3	38.32	114.96
4702	2036	148	1	1809.97	1809.97
4703	1819	282	5	367.58	1837.90
4704	86	261	5	64.39	321.95
4705	1490	5	1	23.44	23.44
4706	1877	176	3	94.41	283.23
4707	1561	315	2	1323.55	2647.10
4708	828	265	2	192.35	384.70
4709	1435	311	2	475.70	951.40
4710	2455	465	1	151.90	151.90
4711	1193	78	2	1094.06	2188.12
4712	1334	396	5	34.20	171.00
4713	294	123	2	27.40	54.80
4714	2116	408	4	24.29	97.16
4715	146	455	4	40.50	162.00
4716	1859	245	3	71.20	213.60
4717	8	234	1	59.10	59.10
4718	686	454	3	10.72	32.16
4719	378	421	3	33.87	101.61
4720	1022	308	4	197.22	788.88
4721	126	427	2	156.77	313.54
4722	2404	208	5	111.45	557.25
4723	1600	133	5	22.04	110.20
4724	437	17	4	31.74	126.96
4725	1455	145	2	87.37	174.74
4726	467	50	2	43.57	87.14
4727	736	27	1	46.75	46.75
4728	714	116	3	1031.32	3093.96
4729	1595	391	1	169.39	169.39
4730	786	27	3	46.75	140.25
4731	1944	434	1	49.87	49.87
4732	1478	165	2	10.39	20.78
4733	2049	151	1	35.67	35.67
4734	784	58	5	39.85	199.25
4735	246	463	4	25.47	101.88
4736	1622	388	4	15.05	60.20
4737	658	67	1	47.52	47.52
4738	1486	353	3	139.69	419.07
4739	857	33	4	36.04	144.16
4740	30	352	3	21.21	63.63
4741	2072	386	4	152.82	611.28
4742	1194	27	2	46.75	93.50
4743	233	146	2	50.37	100.74
4744	1281	345	5	35.23	176.15
4745	566	385	5	13.45	67.25
4746	866	75	1	323.09	323.09
4747	395	376	3	45.14	135.42
4748	1164	466	4	43.61	174.44
4749	1669	441	5	97.86	489.30
4750	2068	447	3	18.24	54.72
4751	1320	361	2	67.61	135.22
4752	59	31	3	17.37	52.11
4753	522	6	4	29.06	116.24
4754	701	1	3	31.96	95.88
4755	2335	319	3	1794.17	5382.51
4756	240	229	2	51.78	103.56
4757	434	337	1	71.01	71.01
4758	2380	117	2	70.83	141.66
4759	356	439	3	1837.39	5512.17
4760	1263	472	5	91.09	455.45
4761	109	360	3	41.94	125.82
4762	2418	116	3	1031.32	3093.96
4763	1869	12	1	45.14	45.14
4764	1949	429	1	135.14	135.14
4765	1185	94	2	124.81	249.62
4766	2097	372	2	203.87	407.74
4767	128	188	5	58.13	290.65
4768	2247	297	4	15.73	62.92
4769	2252	491	2	65.83	131.66
4770	2374	256	3	175.24	525.72
4771	1357	98	1	13.19	13.19
4772	1905	94	5	124.81	624.05
4773	174	474	4	62.56	250.24
4774	1723	199	4	33.04	132.16
4775	599	310	3	38.48	115.44
4776	709	338	4	173.05	692.20
4777	2496	177	4	74.94	299.76
4778	2092	332	3	20.41	61.23
4779	927	361	1	67.61	67.61
4780	486	351	2	47.82	95.64
4781	553	357	1	142.57	142.57
4782	29	38	2	32.14	64.28
4783	1243	172	3	450.87	1352.61
4784	1811	158	1	191.11	191.11
4785	488	333	5	240.47	1202.35
4786	1407	365	2	22.34	44.68
4787	959	377	1	57.24	57.24
4788	1609	229	2	51.78	103.56
4789	579	27	3	46.75	140.25
4790	2086	169	5	186.87	934.35
4791	427	418	3	134.86	404.58
4792	1505	92	2	222.12	444.24
4793	690	349	3	67.66	202.98
4794	2481	104	4	50.61	202.44
4795	1010	40	3	30.42	91.26
4796	1195	192	5	42.22	211.10
4797	1339	54	1	177.79	177.79
4798	346	104	3	50.61	151.83
4799	2244	25	2	48.32	96.64
4800	380	412	5	32.98	164.90
4801	680	392	5	35.62	178.10
4802	562	102	5	93.77	468.85
4803	2117	203	3	1902.34	5707.02
4804	2219	61	2	21.85	43.70
4805	1169	85	1	478.53	478.53
4806	628	324	4	74.42	297.68
4807	917	4	5	145.93	729.65
4808	2029	459	5	53.30	266.50
4809	1695	222	3	1222.06	3666.18
4810	386	112	3	17.58	52.74
4811	2254	50	5	43.57	217.85
4812	1896	293	5	77.37	386.85
4813	1650	415	1	46.59	46.59
4814	822	121	5	16.58	82.90
4815	1826	337	5	71.01	355.05
4816	1766	309	3	20.47	61.41
4817	458	415	1	46.59	46.59
4818	465	88	2	24.07	48.14
4819	1982	218	5	34.45	172.25
4820	1305	4	4	145.93	583.72
4821	1471	133	3	22.04	66.12
4822	1777	179	3	224.59	673.77
4823	1268	16	5	21.47	107.35
4824	1050	313	1	171.44	171.44
4825	2095	320	4	82.53	330.12
4826	2118	326	4	80.44	321.76
4827	1444	375	3	62.45	187.35
4828	840	120	5	41.71	208.55
4829	822	436	2	70.65	141.30
4830	552	327	2	126.09	252.18
4831	167	492	5	1644.22	8221.10
4832	512	365	2	22.34	44.68
4833	1244	103	1	168.49	168.49
4834	1964	354	5	1200.13	6000.65
4835	1794	128	2	38.41	76.82
4836	1625	466	3	43.61	130.83
4837	1870	205	5	19.42	97.10
4838	2009	337	5	71.01	355.05
4839	617	451	1	37.84	37.84
4840	1310	104	5	50.61	253.05
4841	883	81	1	40.13	40.13
4842	690	429	1	135.14	135.14
4843	1502	299	2	10.57	21.14
4844	2470	183	5	20.45	102.25
4845	905	406	1	53.06	53.06
4846	1116	394	3	148.49	445.47
4847	2413	333	4	240.47	961.88
4848	1324	360	2	41.94	83.88
4849	1116	421	3	33.87	101.61
4850	273	285	2	31.36	62.72
4851	1768	45	5	40.34	201.70
4852	438	390	2	43.60	87.20
4853	449	10	3	35.19	105.57
4854	83	282	2	367.58	735.16
4855	1620	17	1	31.74	31.74
4856	1726	3	5	26.19	130.95
4857	2329	328	3	53.11	159.33
4858	354	244	5	26.32	131.60
4859	2113	99	4	42.94	171.76
4860	222	89	2	127.84	255.68
4861	640	126	1	47.88	47.88
4862	1974	488	5	47.80	239.00
4863	2026	281	1	12.06	12.06
4864	5	458	2	43.32	86.64
4865	211	328	1	53.11	53.11
4866	1093	182	5	18.31	91.55
4867	83	487	3	138.30	414.90
4868	1913	332	2	20.41	40.82
4869	632	481	4	49.26	197.04
4870	1637	452	2	14.12	28.24
4871	280	281	3	12.06	36.18
4872	1178	381	1	19.94	19.94
4873	1740	326	1	80.44	80.44
4874	1116	268	3	441.06	1323.18
4875	2201	1	4	31.96	127.84
4876	471	379	1	37.51	37.51
4877	1462	95	2	76.13	152.26
4878	695	422	2	57.25	114.50
4879	2095	149	1	33.61	33.61
4880	438	14	3	201.38	604.14
4881	90	77	3	57.74	173.22
4882	956	35	3	47.26	141.78
4883	551	27	2	46.75	93.50
4884	329	398	1	237.21	237.21
4885	2365	154	1	17.90	17.90
4886	1973	238	3	54.26	162.78
4887	1944	272	2	120.40	240.80
4888	62	90	1	126.60	126.60
4889	135	89	2	127.84	255.68
4890	1813	425	1	50.74	50.74
4891	837	378	3	245.22	735.66
4892	2335	64	3	37.18	111.54
4893	750	477	1	183.20	183.20
4894	16	323	4	1447.42	5789.68
4895	1072	74	4	293.77	1175.08
4896	583	247	5	23.80	119.00
4897	1493	163	1	463.60	463.60
4898	2277	12	1	45.14	45.14
4899	2445	2	1	1385.15	1385.15
4900	386	449	5	36.96	184.80
4901	380	370	4	460.14	1840.56
4902	2467	63	3	46.66	139.98
4903	2145	194	5	37.99	189.95
4904	683	381	5	19.94	99.70
4905	2254	171	3	127.13	381.39
4906	2498	260	3	50.36	151.08
4907	423	478	3	94.13	282.39
4908	2214	418	4	134.86	539.44
4909	1593	325	4	33.89	135.56
4910	655	173	4	112.69	450.76
4911	308	224	2	50.63	101.26
4912	1442	316	3	30.13	90.39
4913	977	364	3	157.44	472.32
4914	2332	67	3	47.52	142.56
4915	1782	265	1	192.35	192.35
4916	749	272	5	120.40	602.00
4917	2430	426	2	34.78	69.56
4918	1397	337	5	71.01	355.05
4919	680	376	5	45.14	225.70
4920	570	259	1	44.64	44.64
4921	253	460	2	53.88	107.76
4922	1339	466	4	43.61	174.44
4923	1440	461	5	37.37	186.85
4924	1731	167	5	67.26	336.30
4925	225	178	3	386.24	1158.72
4926	1413	334	3	22.93	68.79
4927	322	60	2	1576.99	3153.98
4928	308	62	1	37.50	37.50
4929	2001	49	4	36.01	144.04
4930	663	223	3	35.37	106.11
4931	1891	145	1	87.37	87.37
4932	1446	426	5	34.78	173.90
4933	1412	345	1	35.23	35.23
4934	1574	303	1	91.70	91.70
4935	1581	463	4	25.47	101.88
4936	1059	443	1	17.52	17.52
4937	2468	90	4	126.60	506.40
4938	1273	80	4	33.99	135.96
4939	1320	453	5	27.19	135.95
4940	2161	459	1	53.30	53.30
4941	1046	307	1	43.66	43.66
4942	1785	108	1	43.88	43.88
4943	2163	500	5	175.70	878.50
4944	1493	322	2	134.71	269.42
4945	217	314	2	158.44	316.88
4946	1712	397	3	97.03	291.09
4947	1078	37	2	168.04	336.08
4948	1241	181	1	57.96	57.96
4949	1645	315	4	1323.55	5294.20
4950	2334	396	5	34.20	171.00
4951	1985	355	2	42.69	85.38
4952	514	403	4	208.42	833.68
4953	2112	289	5	1622.15	8110.75
4954	2156	463	2	25.47	50.94
4955	359	75	2	323.09	646.18
4956	2028	447	1	18.24	18.24
4957	2396	122	4	158.20	632.80
4958	2086	449	3	36.96	110.88
4959	2469	440	4	119.15	476.60
4960	59	446	2	361.96	723.92
4961	1884	128	4	38.41	153.64
4962	990	460	5	53.88	269.40
4963	1080	341	5	59.37	296.85
4964	1594	274	4	78.08	312.32
4965	1414	49	2	36.01	72.02
4966	433	325	1	33.89	33.89
4967	1212	13	5	150.13	750.65
4968	474	249	2	17.60	35.20
4969	2163	361	3	67.61	202.83
4970	684	320	4	82.53	330.12
4971	2280	445	5	169.10	845.50
4972	12	369	1	61.27	61.27
4973	2165	326	1	80.44	80.44
4974	924	316	1	30.13	30.13
4975	1675	373	3	24.06	72.18
4976	404	60	5	1576.99	7884.95
4977	1902	39	2	28.02	56.04
4978	1605	299	2	10.57	21.14
4979	1192	219	3	31.22	93.66
4980	2271	486	4	55.39	221.56
4981	1991	111	2	38.70	77.40
4982	1667	55	2	88.59	177.18
4983	1104	331	5	65.98	329.90
4984	1194	458	4	43.32	173.28
4985	1844	140	1	22.98	22.98
4986	1720	293	2	77.37	154.74
4987	1370	470	2	18.69	37.38
4988	875	500	2	175.70	351.40
4989	210	254	1	19.26	19.26
4990	946	192	1	42.22	42.22
4991	1638	269	4	33.41	133.64
4992	710	498	3	224.97	674.91
4993	2313	119	5	254.39	1271.95
4994	1371	221	3	56.85	170.55
4995	1030	150	5	68.63	343.15
4996	1093	258	4	34.33	137.32
4997	1873	236	2	1207.15	2414.30
4998	83	339	3	187.08	561.24
4999	1969	57	2	47.99	95.98
5000	881	147	5	289.77	1448.85
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, order_date, status, pay_method, ship_address, ship_date, delivery_date, total_amount, promotion_id, ship_city, ship_zip) FROM stdin;
1	936	1970-01-01	Delivered	Debit Card	9469 Second Ave	1970-01-01	1970-01-01	655.16	\N	Charlotte	26759.0
2	3	1970-01-01	Delivered	Apple Pay	2715 First St	1970-01-01	1970-01-01	1534.39	\N	Fort Worth	46421.0
3	850	1970-01-01	Pending	Debit Card	5039 Second Ave	\N	\N	583.30	\N	New York	66602.0
4	608	1970-01-01	Delivered	Credit Card	5287 Park Rd	1970-01-01	1970-01-01	19.61	\N	Austin	99071.0
6	747	1970-01-01	Pending	Apple Pay	6995 Second Ave	\N	\N	0.00	\N	Philadelphia	52830.0
7	607	1970-01-01	Delivered	Debit Card	2503 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Fort Worth	79632.0
8	914	1970-01-01	Delivered	Apple Pay	7812 First St	1970-01-01	1970-01-01	3970.56	\N	Chicago	76229.0
9	466	1970-01-01	Delivered	Credit Card	8883 First St	1970-01-01	1970-01-01	275.04	\N	Columbus	57925.0
10	641	1970-01-01	Cancelled	Credit Card	1490 First St	\N	\N	0.00	\N	San Diego	28342.0
11	858	1970-01-01	Delivered	Debit Card	5009 First St	1970-01-01	1970-01-01	5085.91	\N	San Jose	31270.0
12	388	1970-01-01	Delivered	Debit Card	4290 Second Ave	1970-01-01	1970-01-01	6781.00	\N	San Antonio	16368.0
13	43	1970-01-01	Delivered	Debit Card	5243 Main St	1970-01-01	1970-01-01	60.38	\N	San Jose	76469.0
14	498	1970-01-01	Delivered	Apple Pay	4222 Main St	1970-01-01	1970-01-01	3074.52	\N	Austin	31877.0
15	40	1970-01-01	Processing	Debit Card	8446 First St	\N	\N	1165.08	\N	Philadelphia	80282.0
17	94	1970-01-01	Delivered	Apple Pay	7849 First St	1970-01-01	1970-01-01	391.23	\N	Philadelphia	96991.0
19	158	1970-01-01	Shipped	Debit Card	8324 Park Rd	1970-01-01	\N	1435.75	\N	San Antonio	60615.0
21	981	1970-01-01	Delivered	Debit Card	5898 Main St	1970-01-01	1970-01-01	1346.38	\N	Phoenix	55838.0
23	722	1970-01-01	Delivered	Debit Card	1013 First St	1970-01-01	1970-01-01	1866.96	\N	Dallas	74840.0
24	551	1970-01-01	Delivered	Google Pay	6337 Second Ave	1970-01-01	1970-01-01	95.05	\N	Houston	23055.0
28	776	1970-01-01	Delivered	Debit Card	838 Second Ave	1970-01-01	1970-01-01	418.43	\N	Charlotte	76932.0
29	838	1970-01-01	Delivered	Google Pay	7680 Park Rd	1970-01-01	1970-01-01	480.12	\N	Los Angeles	68271.0
30	330	1970-01-01	Delivered	Apple Pay	2535 Main St	1970-01-01	1970-01-01	154.02	\N	San Diego	91156.0
31	736	1970-01-01	Delivered	Debit Card	8052 Second Ave	1970-01-01	1970-01-01	7237.10	\N	San Diego	65314.0
32	349	1970-01-01	Shipped	Debit Card	4712 Park Rd	1970-01-01	\N	2972.82	\N	Phoenix	22571.0
33	205	1970-01-01	Delivered	Apple Pay	4976 Park Rd	1970-01-01	1970-01-01	149.88	\N	Houston	37168.0
35	655	1970-01-01	Processing	Credit Card	7524 Main St	\N	\N	128.44	\N	Philadelphia	16875.0
37	848	1970-01-01	Delivered	Apple Pay	991 Park Rd	1970-01-01	1970-01-01	263.68	\N	Columbus	41030.0
39	183	1970-01-01	Delivered	Debit Card	2607 Park Rd	1970-01-01	1970-01-01	213.66	\N	Dallas	31229.0
40	742	1970-01-01	Delivered	Google Pay	7043 First St	1970-01-01	1970-01-01	52.76	\N	Dallas	42289.0
41	396	1970-01-01	Delivered	Credit Card	2367 Oak Ave	1970-01-01	1970-01-01	710.39	\N	New York	56861.0
42	96	1970-01-01	Delivered	Debit Card	7792 Park Rd	1970-01-01	1970-01-01	296.33	\N	Los Angeles	91691.0
43	70	1970-01-01	Delivered	Credit Card	7534 Park Rd	1970-01-01	1970-01-01	11.99	\N	Jacksonville	42951.0
44	49	1970-01-01	Delivered	Debit Card	8586 First St	1970-01-01	1970-01-01	564.39	\N	Fort Worth	83060.0
46	102	1970-01-01	Delivered	Google Pay	7051 Park Rd	1970-01-01	1970-01-01	703.57	\N	Austin	49599.0
47	55	1970-01-01	Delivered	Apple Pay	9047 Second Ave	1970-01-01	1970-01-01	0.00	\N	Dallas	73993.0
48	902	1970-01-01	Delivered	Credit Card	5281 Main St	1970-01-01	1970-01-01	0.00	\N	San Antonio	37887.0
49	165	1970-01-01	Shipped	Debit Card	1798 Second Ave	1970-01-01	\N	992.08	\N	Houston	27486.0
50	161	1970-01-01	Delivered	Credit Card	882 Oak Ave	1970-01-01	1970-01-01	368.79	\N	Los Angeles	93748.0
51	726	1970-01-01	Delivered	Apple Pay	7021 Second Ave	1970-01-01	1970-01-01	87.14	\N	Austin	65203.0
52	115	1970-01-01	Processing	Apple Pay	2163 Second Ave	\N	\N	37.38	\N	Houston	18992.0
53	885	1970-01-01	Delivered	Google Pay	2672 Main St	1970-01-01	1970-01-01	541.40	\N	San Antonio	80313.0
54	949	1970-01-01	Processing	Debit Card	2244 Park Rd	\N	\N	3000.78	\N	Los Angeles	17094.0
55	991	1970-01-01	Shipped	Debit Card	2267 First St	1970-01-01	\N	10520.63	\N	Los Angeles	45895.0
56	396	1970-01-01	Processing	Google Pay	2367 Oak Ave	\N	\N	1707.76	\N	New York	56861.0
57	763	1970-01-01	Processing	Debit Card	7804 Park Rd	\N	\N	749.25	\N	New York	71228.0
58	47	1970-01-01	Pending	Debit Card	500 Main St	\N	\N	1866.71	\N	Chicago	72277.0
59	747	1970-01-01	Shipped	Debit Card	6995 Second Ave	1970-01-01	\N	3026.84	\N	Philadelphia	52830.0
60	32	1970-01-01	Delivered	Apple Pay	1797 Oak Ave	1970-01-01	1970-01-01	169.10	\N	Charlotte	25129.0
61	815	1970-01-01	Delivered	Credit Card	4916 First St	1970-01-01	1970-01-01	761.72	\N	Phoenix	28726.0
62	511	1970-01-01	Delivered	Google Pay	8265 Park Rd	1970-01-01	1970-01-01	953.13	\N	Fort Worth	14159.0
63	738	1970-01-01	Shipped	Apple Pay	4982 Main St	1970-01-01	\N	0.00	\N	San Jose	57636.0
65	48	1970-01-01	Delivered	Debit Card	6391 First St	1970-01-01	1970-01-01	7305.55	\N	Jacksonville	41979.0
66	692	1970-01-01	Delivered	Google Pay	140 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Fort Worth	49343.0
67	877	1970-01-01	Shipped	Google Pay	8499 Oak Ave	1970-01-01	\N	496.56	\N	San Diego	39829.0
68	539	1970-01-01	Shipped	Google Pay	5093 Second Ave	1970-01-01	\N	3139.19	\N	New York	51853.0
69	535	1970-01-01	Delivered	Apple Pay	718 First St	1970-01-01	1970-01-01	319.20	\N	Los Angeles	30461.0
70	269	1970-01-01	Delivered	Apple Pay	8466 Second Ave	1970-01-01	1970-01-01	16.56	\N	Houston	86089.0
71	517	1970-01-01	Cancelled	Google Pay	1566 Oak Ave	\N	\N	617.78	\N	Fort Worth	75525.0
72	956	1970-01-01	Shipped	Credit Card	8906 Oak Ave	1970-01-01	\N	3261.64	\N	Los Angeles	12588.0
73	411	1970-01-01	Delivered	Debit Card	5636 Main St	1970-01-01	1970-01-01	4171.86	\N	Jacksonville	16094.0
75	326	1970-01-01	Delivered	Apple Pay	1769 Oak Ave	1970-01-01	1970-01-01	180.99	\N	San Diego	11567.0
77	729	1970-01-01	Delivered	Debit Card	9496 First St	1970-01-01	1970-01-01	0.00	\N	Phoenix	91863.0
78	970	1970-01-01	Delivered	Apple Pay	5310 First St	1970-01-01	1970-01-01	683.80	\N	Chicago	55242.0
79	54	1970-01-01	Delivered	Debit Card	9669 Main St	1970-01-01	1970-01-01	2482.62	\N	San Antonio	59857.0
80	697	1970-01-01	Delivered	Debit Card	5385 Park Rd	1970-01-01	1970-01-01	86.92	\N	Dallas	49462.0
81	730	1970-01-01	Delivered	Credit Card	8800 First St	1970-01-01	1970-01-01	45.57	\N	San Jose	37490.0
82	336	1970-01-01	Processing	Credit Card	9334 Oak Ave	\N	\N	770.28	\N	San Jose	34672.0
83	353	1970-01-01	Delivered	Apple Pay	4415 Oak Ave	1970-01-01	1970-01-01	1918.42	\N	San Diego	83956.0
84	225	1970-01-01	Delivered	Credit Card	6987 Park Rd	1970-01-01	1970-01-01	548.82	\N	Fort Worth	68790.0
85	660	1970-01-01	Shipped	Apple Pay	1920 First St	1970-01-01	\N	0.00	\N	Chicago	64817.0
86	555	1970-01-01	Delivered	Apple Pay	6362 Second Ave	1970-01-01	1970-01-01	4651.86	\N	Los Angeles	90274.0
87	375	1970-01-01	Pending	Credit Card	4350 First St	\N	\N	1053.40	\N	Phoenix	60891.0
88	184	1970-01-01	Delivered	Debit Card	3316 Second Ave	1970-01-01	1970-01-01	922.96	\N	Phoenix	26406.0
89	525	1970-01-01	Delivered	Credit Card	8052 Oak Ave	1970-01-01	1970-01-01	3788.46	\N	Los Angeles	14170.0
90	301	1970-01-01	Shipped	Credit Card	9166 Second Ave	1970-01-01	\N	572.71	\N	Houston	89638.0
91	454	1970-01-01	Delivered	Google Pay	9963 Main St	1970-01-01	1970-01-01	149.60	\N	Philadelphia	40191.0
92	712	1970-01-01	Shipped	Google Pay	6120 Oak Ave	1970-01-01	\N	2071.52	\N	Austin	98363.0
93	764	1970-01-01	Processing	Debit Card	8177 Main St	\N	\N	1638.25	\N	San Diego	26207.0
94	905	1970-01-01	Processing	Apple Pay	7999 Main St	\N	\N	76.93	\N	Columbus	12313.0
95	613	1970-01-01	Pending	Apple Pay	6913 First St	\N	\N	137.52	\N	Chicago	89223.0
96	474	1970-01-01	Delivered	Google Pay	6644 Park Rd	1970-01-01	1970-01-01	1258.15	\N	Phoenix	61792.0
99	2	1970-01-01	Shipped	Credit Card	534 Second Ave	1970-01-01	\N	607.60	\N	San Jose	95181.0
100	213	1970-01-01	Delivered	Apple Pay	9001 Second Ave	1970-01-01	1970-01-01	8970.85	\N	San Diego	27589.0
104	999	1970-01-01	Delivered	Google Pay	2194 Oak Ave	1970-01-01	1970-01-01	0.00	\N	New York	82154.0
105	191	1970-01-01	Delivered	Apple Pay	2716 Park Rd	1970-01-01	1970-01-01	0.00	\N	Columbus	50988.0
107	917	1970-01-01	Shipped	Apple Pay	3206 Main St	1970-01-01	\N	562.90	\N	Chicago	75627.0
108	164	1970-01-01	Delivered	Google Pay	7802 Main St	1970-01-01	1970-01-01	204.38	\N	San Antonio	60709.0
109	417	1970-01-01	Delivered	Apple Pay	8847 Park Rd	1970-01-01	1970-01-01	125.82	\N	Austin	11673.0
110	219	1970-01-01	Delivered	Credit Card	6221 First St	1970-01-01	1970-01-01	495.07	\N	San Diego	81989.0
111	170	1970-01-01	Delivered	Google Pay	7155 Second Ave	1970-01-01	1970-01-01	182.25	\N	Los Angeles	81496.0
112	97	1970-01-01	Delivered	Google Pay	5288 First St	1970-01-01	1970-01-01	102.21	\N	San Antonio	14705.0
113	327	1970-01-01	Cancelled	Debit Card	1476 Second Ave	\N	\N	88.00	\N	Austin	43924.0
114	18	1970-01-01	Delivered	Apple Pay	3781 Main St	1970-01-01	1970-01-01	88.86	\N	Houston	12757.0
115	945	1970-01-01	Cancelled	Google Pay	5345 Park Rd	\N	\N	193.50	\N	San Jose	26182.0
117	405	1970-01-01	Delivered	Debit Card	8248 Main St	1970-01-01	1970-01-01	442.12	\N	Los Angeles	62879.0
119	38	1970-01-01	Delivered	Apple Pay	4165 Park Rd	1970-01-01	1970-01-01	1442.04	\N	Fort Worth	24168.0
120	20	1970-01-01	Delivered	Credit Card	9455 Second Ave	1970-01-01	1970-01-01	1072.52	\N	Chicago	41850.0
121	934	1970-01-01	Delivered	Debit Card	6001 Main St	1970-01-01	1970-01-01	94.30	\N	New York	98857.0
122	205	1970-01-01	Delivered	Credit Card	4976 Park Rd	1970-01-01	1970-01-01	0.00	\N	Houston	37168.0
123	746	1970-01-01	Processing	Credit Card	8155 First St	\N	\N	46.00	\N	Columbus	53610.0
124	606	1970-01-01	Cancelled	Debit Card	1881 Second Ave	\N	\N	0.00	\N	San Jose	52914.0
125	345	1970-01-01	Delivered	Credit Card	6883 First St	1970-01-01	1970-01-01	377.60	\N	Charlotte	56036.0
126	444	1970-01-01	Pending	Credit Card	9138 Main St	\N	\N	485.79	\N	San Diego	94613.0
127	626	1970-01-01	Processing	Debit Card	4831 First St	\N	\N	1269.89	\N	New York	98931.0
129	775	1970-01-01	Cancelled	Apple Pay	2534 Oak Ave	\N	\N	40.36	\N	Phoenix	49375.0
130	401	1970-01-01	Delivered	Google Pay	8670 Second Ave	1970-01-01	1970-01-01	546.88	\N	Dallas	66734.0
132	92	1970-01-01	Delivered	Google Pay	2534 First St	1970-01-01	1970-01-01	3950.30	\N	Columbus	73483.0
133	564	1970-01-01	Pending	Apple Pay	6332 Park Rd	\N	\N	466.43	\N	San Jose	90151.0
135	906	1970-01-01	Delivered	Google Pay	317 Oak Ave	1970-01-01	1970-01-01	255.68	\N	San Jose	90786.0
137	473	1970-01-01	Cancelled	Apple Pay	3895 Second Ave	\N	\N	943.96	\N	Dallas	98345.0
138	327	1970-01-01	Cancelled	Credit Card	1476 Second Ave	\N	\N	88.75	\N	Austin	43924.0
139	703	1970-01-01	Shipped	Credit Card	408 First St	1970-01-01	\N	191.58	\N	Los Angeles	15572.0
140	541	1970-01-01	Delivered	Credit Card	2265 Park Rd	1970-01-01	1970-01-01	402.20	\N	Chicago	72371.0
141	457	1970-01-01	Delivered	Google Pay	9334 Main St	1970-01-01	1970-01-01	39.57	\N	San Jose	47152.0
143	789	1970-01-01	Shipped	Credit Card	5656 Second Ave	1970-01-01	\N	2520.81	\N	San Jose	71402.0
144	180	1970-01-01	Delivered	Credit Card	9476 Park Rd	1970-01-01	1970-01-01	169.28	\N	Dallas	82305.0
145	782	1970-01-01	Delivered	Apple Pay	539 Oak Ave	1970-01-01	1970-01-01	48.32	\N	Columbus	95016.0
146	340	1970-01-01	Delivered	Google Pay	7257 First St	1970-01-01	1970-01-01	1579.44	\N	Chicago	51586.0
147	967	1970-01-01	Shipped	Google Pay	1180 Park Rd	1970-01-01	\N	8346.10	\N	San Antonio	21662.0
149	729	1970-01-01	Pending	Google Pay	9496 First St	\N	\N	1198.39	\N	Phoenix	91863.0
150	393	1970-01-01	Delivered	Credit Card	3942 Main St	1970-01-01	1970-01-01	6223.81	\N	Philadelphia	98032.0
151	986	1970-01-01	Delivered	Apple Pay	4454 Main St	1970-01-01	1970-01-01	41.56	\N	San Diego	74103.0
152	532	1970-01-01	Delivered	Debit Card	5399 Second Ave	1970-01-01	1970-01-01	0.00	\N	Columbus	83812.0
153	667	1970-01-01	Delivered	Apple Pay	7707 Main St	1970-01-01	1970-01-01	773.06	\N	Austin	19266.0
154	953	1970-01-01	Delivered	Credit Card	9867 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Phoenix	59200.0
155	937	1970-01-01	Processing	Google Pay	7411 Main St	\N	\N	1335.84	\N	Chicago	96853.0
156	555	1970-01-01	Pending	Apple Pay	6362 Second Ave	\N	\N	122.64	\N	Los Angeles	90274.0
157	480	1970-01-01	Delivered	Google Pay	4806 Main St	1970-01-01	1970-01-01	376.81	\N	Houston	98302.0
158	861	1970-01-01	Delivered	Apple Pay	3285 Second Ave	1970-01-01	1970-01-01	369.18	\N	San Diego	15754.0
159	667	1970-01-01	Pending	Apple Pay	7707 Main St	\N	\N	376.84	\N	Austin	19266.0
160	10	1970-01-01	Delivered	Credit Card	9677 First St	1970-01-01	1970-01-01	525.72	\N	Phoenix	62350.0
161	823	1970-01-01	Delivered	Apple Pay	7260 Oak Ave	1970-01-01	1970-01-01	4562.24	\N	Philadelphia	13153.0
162	868	1970-01-01	Delivered	Credit Card	8268 Second Ave	1970-01-01	1970-01-01	1108.33	\N	Philadelphia	33461.0
163	868	1970-01-01	Shipped	Debit Card	8268 Second Ave	1970-01-01	\N	838.94	\N	Philadelphia	33461.0
164	546	1970-01-01	Shipped	Google Pay	6224 Oak Ave	1970-01-01	\N	557.96	\N	Austin	24728.0
165	576	1970-01-01	Delivered	Debit Card	1536 Main St	1970-01-01	1970-01-01	1951.34	\N	Philadelphia	64651.0
166	655	1970-01-01	Delivered	Debit Card	7524 Main St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	16875.0
167	470	1970-01-01	Processing	Debit Card	2481 First St	\N	\N	8413.70	\N	Columbus	67065.0
168	121	1970-01-01	Pending	Credit Card	2167 Park Rd	\N	\N	436.48	\N	Los Angeles	92978.0
170	99	1970-01-01	Pending	Debit Card	7156 Oak Ave	\N	\N	762.32	\N	Philadelphia	79621.0
171	503	1970-01-01	Delivered	Debit Card	5788 First St	1970-01-01	1970-01-01	135.14	\N	Charlotte	39770.0
172	946	1970-01-01	Delivered	Debit Card	6271 Main St	1970-01-01	1970-01-01	2504.60	\N	Phoenix	30014.0
173	926	1970-01-01	Shipped	Google Pay	8334 Main St	1970-01-01	\N	554.12	\N	Chicago	84329.0
174	148	1970-01-01	Processing	Debit Card	4228 Second Ave	\N	\N	710.38	\N	Phoenix	53694.0
175	801	1970-01-01	Processing	Credit Card	2573 Second Ave	\N	\N	2569.31	\N	Austin	92786.0
176	564	1970-01-01	Delivered	Debit Card	6332 Park Rd	1970-01-01	1970-01-01	104.76	\N	San Jose	90151.0
178	37	1970-01-01	Delivered	Apple Pay	2632 Oak Ave	1970-01-01	1970-01-01	1105.84	\N	San Jose	33206.0
179	454	1970-01-01	Delivered	Debit Card	9963 Main St	1970-01-01	1970-01-01	163.52	\N	Philadelphia	40191.0
180	599	1970-01-01	Delivered	Apple Pay	7564 Park Rd	1970-01-01	1970-01-01	0.00	\N	Los Angeles	94465.0
181	676	1970-01-01	Delivered	Debit Card	8613 Park Rd	1970-01-01	1970-01-01	7.25	\N	Columbus	85851.0
182	876	1970-01-01	Delivered	Debit Card	4378 Main St	1970-01-01	1970-01-01	0.00	\N	Charlotte	46942.0
183	992	1970-01-01	Delivered	Credit Card	934 First St	1970-01-01	1970-01-01	64.28	\N	Columbus	78809.0
184	577	1970-01-01	Delivered	Google Pay	9585 Park Rd	1970-01-01	1970-01-01	218.20	\N	San Diego	22206.0
185	772	1970-01-01	Delivered	Credit Card	7398 First St	1970-01-01	1970-01-01	0.00	\N	San Diego	45190.0
186	886	1970-01-01	Shipped	Apple Pay	3469 Park Rd	1970-01-01	\N	0.00	\N	Columbus	97135.0
187	739	1970-01-01	Delivered	Google Pay	2076 Second Ave	1970-01-01	1970-01-01	1544.81	\N	Charlotte	86076.0
188	295	1970-01-01	Delivered	Apple Pay	6593 Park Rd	1970-01-01	1970-01-01	482.12	\N	New York	40689.0
189	86	1970-01-01	Delivered	Google Pay	1999 First St	1970-01-01	1970-01-01	125.21	\N	Philadelphia	10150.0
190	873	1970-01-01	Delivered	Apple Pay	3930 Park Rd	1970-01-01	1970-01-01	739.15	\N	San Diego	19946.0
191	191	1970-01-01	Delivered	Credit Card	2716 Park Rd	1970-01-01	1970-01-01	0.00	\N	Columbus	50988.0
193	157	1970-01-01	Delivered	Debit Card	8510 Oak Ave	1970-01-01	1970-01-01	81.18	\N	San Diego	22021.0
194	42	1970-01-01	Shipped	Debit Card	827 First St	1970-01-01	\N	0.00	\N	Phoenix	78146.0
196	344	1970-01-01	Delivered	Google Pay	1210 Park Rd	1970-01-01	1970-01-01	692.40	\N	Jacksonville	24160.0
197	857	1970-01-01	Delivered	Debit Card	3397 Main St	1970-01-01	1970-01-01	685.44	\N	Austin	34819.0
198	223	1970-01-01	Delivered	Google Pay	5149 Main St	1970-01-01	1970-01-01	1040.66	\N	Austin	43352.0
199	445	1970-01-01	Shipped	Google Pay	1352 Main St	1970-01-01	\N	187.03	\N	Jacksonville	76476.0
202	252	1970-01-01	Delivered	Debit Card	6475 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Jose	60311.0
203	708	1970-01-01	Delivered	Apple Pay	9756 Oak Ave	1970-01-01	1970-01-01	216.20	\N	Philadelphia	98280.0
204	304	1970-01-01	Delivered	Credit Card	7817 Main St	1970-01-01	1970-01-01	519.15	\N	Fort Worth	86986.0
205	671	1970-01-01	Processing	Apple Pay	3793 Park Rd	\N	\N	182.18	\N	Fort Worth	45043.0
206	745	1970-01-01	Cancelled	Credit Card	3957 Park Rd	\N	\N	67.35	\N	Charlotte	31001.0
207	25	1970-01-01	Shipped	Apple Pay	7554 Park Rd	1970-01-01	\N	547.54	\N	Charlotte	82845.0
209	222	1970-01-01	Delivered	Credit Card	8461 First St	1970-01-01	1970-01-01	680.92	\N	Los Angeles	69432.0
210	182	1970-01-01	Delivered	Credit Card	2202 Second Ave	1970-01-01	1970-01-01	19.26	\N	Philadelphia	87042.0
211	776	1970-01-01	Delivered	Debit Card	838 Second Ave	1970-01-01	1970-01-01	130.70	\N	Charlotte	76932.0
212	307	1970-01-01	Processing	Credit Card	7267 Oak Ave	\N	\N	0.00	\N	Phoenix	42044.0
213	669	1970-01-01	Delivered	Google Pay	944 Main St	1970-01-01	1970-01-01	739.08	\N	Charlotte	57918.0
214	919	1970-01-01	Shipped	Apple Pay	7248 Park Rd	1970-01-01	\N	290.65	\N	Houston	76795.0
215	937	1970-01-01	Pending	Google Pay	7411 Main St	\N	\N	2852.62	\N	Chicago	96853.0
217	500	1970-01-01	Shipped	Debit Card	3857 Oak Ave	1970-01-01	\N	841.16	\N	Phoenix	68085.0
219	673	1970-01-01	Delivered	Credit Card	1175 Oak Ave	1970-01-01	1970-01-01	12534.70	\N	Fort Worth	21443.0
220	216	1970-01-01	Delivered	Apple Pay	4164 Main St	1970-01-01	1970-01-01	1222.06	\N	Charlotte	60275.0
221	607	1970-01-01	Delivered	Credit Card	2503 Oak Ave	1970-01-01	1970-01-01	360.91	\N	Fort Worth	79632.0
222	518	1970-01-01	Delivered	Apple Pay	5924 Oak Ave	1970-01-01	1970-01-01	1115.56	\N	New York	80300.0
223	468	1970-01-01	Processing	Apple Pay	2362 Main St	\N	\N	131.66	\N	Jacksonville	68536.0
224	276	1970-01-01	Shipped	Debit Card	8119 Second Ave	1970-01-01	\N	2031.01	\N	Phoenix	51078.0
225	438	1970-01-01	Delivered	Credit Card	5733 Oak Ave	1970-01-01	1970-01-01	1309.62	\N	Jacksonville	94663.0
226	864	1970-01-01	Delivered	Google Pay	2907 Second Ave	1970-01-01	1970-01-01	43.03	\N	Austin	66848.0
227	348	1970-01-01	Delivered	Credit Card	2803 Second Ave	1970-01-01	1970-01-01	476.60	\N	San Antonio	30591.0
228	132	1970-01-01	Delivered	Apple Pay	8494 Main St	1970-01-01	1970-01-01	1022.42	\N	Fort Worth	66349.0
230	797	1970-01-01	Delivered	Google Pay	3407 First St	1970-01-01	1970-01-01	100.13	\N	Columbus	10863.0
231	108	1970-01-01	Delivered	Google Pay	9231 Park Rd	1970-01-01	1970-01-01	505.47	\N	Columbus	61717.0
233	818	1970-01-01	Delivered	Apple Pay	7457 Oak Ave	1970-01-01	1970-01-01	866.59	\N	Austin	21706.0
236	361	1970-01-01	Delivered	Google Pay	6584 Park Rd	1970-01-01	1970-01-01	0.00	\N	New York	41139.0
237	946	1970-01-01	Delivered	Credit Card	6271 Main St	1970-01-01	1970-01-01	400.99	\N	Phoenix	30014.0
238	926	1970-01-01	Delivered	Credit Card	8334 Main St	1970-01-01	1970-01-01	0.00	\N	Chicago	84329.0
239	542	1970-01-01	Delivered	Credit Card	7218 Oak Ave	1970-01-01	1970-01-01	107.26	\N	Dallas	73035.0
241	135	1970-01-01	Delivered	Debit Card	3870 Second Ave	1970-01-01	1970-01-01	141.21	\N	Jacksonville	97562.0
242	244	1970-01-01	Shipped	Google Pay	2574 Main St	1970-01-01	\N	0.00	\N	Los Angeles	76287.0
243	366	1970-01-01	Delivered	Credit Card	6004 Oak Ave	1970-01-01	1970-01-01	121.12	\N	Charlotte	58280.0
244	597	1970-01-01	Shipped	Debit Card	926 Main St	1970-01-01	\N	287.25	\N	Charlotte	17051.0
246	923	1970-01-01	Delivered	Debit Card	6371 Second Ave	1970-01-01	1970-01-01	595.81	\N	Dallas	63950.0
247	569	1970-01-01	Processing	Apple Pay	4197 Park Rd	\N	\N	5386.80	\N	Los Angeles	95010.0
248	747	1970-01-01	Delivered	Apple Pay	6995 Second Ave	1970-01-01	1970-01-01	35.37	\N	Philadelphia	52830.0
249	241	1970-01-01	Shipped	Debit Card	2597 Oak Ave	1970-01-01	\N	893.46	\N	Phoenix	40149.0
250	713	1970-01-01	Delivered	Debit Card	2448 First St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	87405.0
251	215	1970-01-01	Delivered	Debit Card	6743 First St	1970-01-01	1970-01-01	0.00	\N	San Jose	52982.0
252	863	1970-01-01	Delivered	Credit Card	2348 First St	1970-01-01	1970-01-01	462.72	\N	New York	24544.0
253	196	1970-01-01	Delivered	Debit Card	1684 First St	1970-01-01	1970-01-01	354.31	\N	Chicago	54444.0
255	340	1970-01-01	Shipped	Debit Card	7257 First St	1970-01-01	\N	1643.40	\N	Chicago	51586.0
257	921	1970-01-01	Delivered	Credit Card	4153 Second Ave	1970-01-01	1970-01-01	97.88	\N	Phoenix	96848.0
258	483	1970-01-01	Processing	Credit Card	208 Second Ave	\N	\N	5603.55	\N	San Jose	73214.0
259	861	1970-01-01	Shipped	Debit Card	3285 Second Ave	1970-01-01	\N	3510.24	\N	San Diego	15754.0
260	659	1970-01-01	Delivered	Debit Card	3281 Park Rd	1970-01-01	1970-01-01	419.67	\N	San Diego	36504.0
261	300	1970-01-01	Shipped	Debit Card	2117 Second Ave	1970-01-01	\N	0.00	\N	Chicago	56076.0
262	416	1970-01-01	Delivered	Apple Pay	2273 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Charlotte	81105.0
263	861	1970-01-01	Pending	Apple Pay	3285 Second Ave	\N	\N	0.00	\N	San Diego	15754.0
264	143	1970-01-01	Delivered	Apple Pay	7665 First St	1970-01-01	1970-01-01	287.68	\N	Phoenix	17456.0
265	106	1970-01-01	Delivered	Apple Pay	6907 Oak Ave	1970-01-01	1970-01-01	5107.42	\N	Philadelphia	27322.0
266	7	1970-01-01	Delivered	Apple Pay	2903 Second Ave	1970-01-01	1970-01-01	338.05	\N	San Jose	31417.0
267	522	1970-01-01	Delivered	Google Pay	7539 Main St	1970-01-01	1970-01-01	193.82	\N	Philadelphia	76316.0
268	611	1970-01-01	Processing	Credit Card	2941 First St	\N	\N	0.00	\N	Houston	34671.0
270	558	1970-01-01	Processing	Apple Pay	9231 Second Ave	\N	\N	135.77	\N	Los Angeles	34134.0
272	198	1970-01-01	Shipped	Debit Card	5473 Second Ave	1970-01-01	\N	1371.58	\N	Chicago	31299.0
273	30	1970-01-01	Delivered	Google Pay	9324 Main St	1970-01-01	1970-01-01	457.94	\N	San Diego	80468.0
274	596	1970-01-01	Delivered	Debit Card	4111 Oak Ave	1970-01-01	1970-01-01	0.00	\N	San Jose	50812.0
275	52	1970-01-01	Pending	Debit Card	4551 Park Rd	\N	\N	265.57	\N	Houston	80798.0
276	57	1970-01-01	Shipped	Apple Pay	7122 Oak Ave	1970-01-01	\N	150.33	\N	Los Angeles	33819.0
277	64	1970-01-01	Delivered	Debit Card	2606 First St	1970-01-01	1970-01-01	26.19	\N	Jacksonville	78386.0
278	938	1970-01-01	Cancelled	Debit Card	7225 Main St	\N	\N	6426.25	\N	Los Angeles	52795.0
280	558	1970-01-01	Delivered	Apple Pay	9231 Second Ave	1970-01-01	1970-01-01	1948.76	\N	Los Angeles	34134.0
281	306	1970-01-01	Delivered	Google Pay	5177 Main St	1970-01-01	1970-01-01	6158.59	\N	Los Angeles	36633.0
283	54	1970-01-01	Shipped	Debit Card	9669 Main St	1970-01-01	\N	671.75	\N	San Antonio	59857.0
284	80	1970-01-01	Cancelled	Debit Card	2541 Park Rd	\N	\N	776.04	\N	Austin	19359.0
285	274	1970-01-01	Delivered	Credit Card	7180 First St	1970-01-01	1970-01-01	3471.42	\N	Chicago	90492.0
287	896	1970-01-01	Delivered	Google Pay	8859 First St	1970-01-01	1970-01-01	145.30	\N	Los Angeles	20169.0
289	138	1970-01-01	Delivered	Apple Pay	9748 First St	1970-01-01	1970-01-01	8473.76	\N	San Antonio	20308.0
290	862	1970-01-01	Delivered	Google Pay	2955 Park Rd	1970-01-01	1970-01-01	265.55	\N	Jacksonville	42239.0
291	883	1970-01-01	Delivered	Debit Card	9985 First St	1970-01-01	1970-01-01	5815.68	\N	New York	34470.0
293	630	1970-01-01	Processing	Debit Card	3263 Main St	\N	\N	104.91	\N	Phoenix	91185.0
294	574	1970-01-01	Delivered	Debit Card	6819 First St	1970-01-01	1970-01-01	3008.17	\N	San Diego	88802.0
295	652	1970-01-01	Pending	Credit Card	6961 Main St	\N	\N	468.23	\N	Philadelphia	40885.0
296	113	1970-01-01	Shipped	Debit Card	7364 First St	1970-01-01	\N	0.00	\N	Houston	57537.0
297	3	1970-01-01	Delivered	Google Pay	2715 First St	1970-01-01	1970-01-01	796.14	\N	Fort Worth	46421.0
298	678	1970-01-01	Shipped	Credit Card	6193 Park Rd	1970-01-01	\N	173.05	\N	San Diego	29443.0
300	68	1970-01-01	Delivered	Debit Card	4037 First St	1970-01-01	1970-01-01	223.60	\N	Dallas	74332.0
301	265	1970-01-01	Delivered	Apple Pay	4873 Main St	1970-01-01	1970-01-01	116.71	\N	San Diego	98208.0
302	438	1970-01-01	Delivered	Apple Pay	5733 Oak Ave	1970-01-01	1970-01-01	1394.32	\N	Jacksonville	94663.0
304	85	1970-01-01	Delivered	Google Pay	6844 First St	1970-01-01	1970-01-01	134.44	\N	Philadelphia	96846.0
305	861	1970-01-01	Delivered	Debit Card	3285 Second Ave	1970-01-01	1970-01-01	2160.45	\N	San Diego	15754.0
307	239	1970-01-01	Delivered	Apple Pay	4385 Park Rd	1970-01-01	1970-01-01	787.32	\N	Phoenix	75179.0
309	514	1970-01-01	Processing	Debit Card	5213 Park Rd	\N	\N	54.80	\N	Austin	92465.0
310	237	1970-01-01	Shipped	Debit Card	3522 Park Rd	1970-01-01	\N	2548.39	\N	San Diego	12009.0
311	618	1970-01-01	Delivered	Google Pay	276 First St	1970-01-01	1970-01-01	1165.73	\N	Fort Worth	77195.0
312	501	1970-01-01	Delivered	Apple Pay	5946 Park Rd	1970-01-01	1970-01-01	0.00	\N	Austin	71235.0
313	394	1970-01-01	Delivered	Debit Card	8483 Main St	1970-01-01	1970-01-01	898.52	\N	Fort Worth	43540.0
315	219	1970-01-01	Delivered	Apple Pay	6221 First St	1970-01-01	1970-01-01	6799.89	\N	San Diego	81989.0
317	741	1970-01-01	Processing	Debit Card	7300 First St	\N	\N	509.83	\N	Phoenix	87264.0
318	327	1970-01-01	Delivered	Google Pay	1476 Second Ave	1970-01-01	1970-01-01	369.25	\N	Austin	43924.0
319	859	1970-01-01	Delivered	Debit Card	3872 First St	1970-01-01	1970-01-01	352.20	\N	Jacksonville	37936.0
320	637	1970-01-01	Delivered	Google Pay	6511 Second Ave	1970-01-01	1970-01-01	616.10	\N	Charlotte	77552.0
321	973	1970-01-01	Delivered	Credit Card	4799 Park Rd	1970-01-01	1970-01-01	106.95	\N	Dallas	78235.0
322	236	1970-01-01	Delivered	Google Pay	3220 Main St	1970-01-01	1970-01-01	3153.98	\N	Jacksonville	59436.0
323	889	1970-01-01	Delivered	Debit Card	4973 First St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	32954.0
324	501	1970-01-01	Pending	Debit Card	5946 Park Rd	\N	\N	607.10	\N	Austin	71235.0
326	767	1970-01-01	Delivered	Google Pay	6220 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Antonio	52406.0
328	188	1970-01-01	Processing	Google Pay	6909 First St	\N	\N	2483.00	\N	San Diego	36741.0
329	391	1970-01-01	Cancelled	Google Pay	2028 Park Rd	\N	\N	334.31	\N	Dallas	23928.0
330	387	1970-01-01	Delivered	Debit Card	3775 Oak Ave	1970-01-01	1970-01-01	1082.05	\N	Houston	12872.0
332	373	1970-01-01	Delivered	Google Pay	1145 Park Rd	1970-01-01	1970-01-01	308.31	\N	San Diego	93964.0
333	444	1970-01-01	Processing	Apple Pay	9138 Main St	\N	\N	1699.25	\N	San Diego	94613.0
334	191	1970-01-01	Delivered	Google Pay	2716 Park Rd	1970-01-01	1970-01-01	87.12	\N	Columbus	50988.0
336	903	1970-01-01	Delivered	Debit Card	1203 Oak Ave	1970-01-01	1970-01-01	1304.83	\N	New York	49522.0
338	457	1970-01-01	Delivered	Debit Card	9334 Main St	1970-01-01	1970-01-01	711.16	\N	San Jose	47152.0
339	753	1970-01-01	Delivered	Apple Pay	2022 Main St	1970-01-01	1970-01-01	825.88	\N	San Jose	67037.0
340	626	1970-01-01	Delivered	Credit Card	4831 First St	1970-01-01	1970-01-01	598.43	\N	New York	98931.0
341	973	1970-01-01	Delivered	Apple Pay	4799 Park Rd	1970-01-01	1970-01-01	0.00	\N	Dallas	78235.0
342	303	1970-01-01	Processing	Credit Card	297 Park Rd	\N	\N	857.30	\N	Dallas	27299.0
343	803	1970-01-01	Delivered	Google Pay	9019 Second Ave	1970-01-01	1970-01-01	483.58	\N	Charlotte	95463.0
344	197	1970-01-01	Delivered	Credit Card	759 Main St	1970-01-01	1970-01-01	344.26	\N	Dallas	27961.0
345	106	1970-01-01	Delivered	Debit Card	6907 Oak Ave	1970-01-01	1970-01-01	206.40	\N	Philadelphia	27322.0
346	290	1970-01-01	Delivered	Apple Pay	8547 Park Rd	1970-01-01	1970-01-01	991.48	\N	San Antonio	58374.0
348	738	1970-01-01	Shipped	Apple Pay	4982 Main St	1970-01-01	\N	24.12	\N	San Jose	57636.0
351	932	1970-01-01	Delivered	Debit Card	1741 Main St	1970-01-01	1970-01-01	1031.32	\N	Fort Worth	62665.0
352	232	1970-01-01	Delivered	Apple Pay	9793 Oak Ave	1970-01-01	1970-01-01	1161.99	\N	Dallas	98965.0
353	196	1970-01-01	Delivered	Credit Card	1684 First St	1970-01-01	1970-01-01	0.00	\N	Chicago	54444.0
354	799	1970-01-01	Shipped	Apple Pay	7125 First St	1970-01-01	\N	274.49	\N	Fort Worth	70129.0
355	96	1970-01-01	Delivered	Apple Pay	7792 Park Rd	1970-01-01	1970-01-01	251.99	\N	Los Angeles	91691.0
357	531	1970-01-01	Delivered	Credit Card	9929 First St	1970-01-01	1970-01-01	0.00	\N	Dallas	51307.0
358	560	1970-01-01	Delivered	Debit Card	9390 Second Ave	1970-01-01	1970-01-01	10.72	\N	San Jose	88166.0
359	467	1970-01-01	Delivered	Google Pay	6165 Second Ave	1970-01-01	1970-01-01	1037.12	\N	Chicago	73407.0
360	211	1970-01-01	Delivered	Google Pay	9506 Oak Ave	1970-01-01	1970-01-01	104.76	\N	Austin	14888.0
361	589	1970-01-01	Shipped	Credit Card	3993 Park Rd	1970-01-01	\N	754.58	\N	Charlotte	49666.0
362	269	1970-01-01	Cancelled	Google Pay	8466 Second Ave	\N	\N	8505.63	\N	Houston	86089.0
363	800	1970-01-01	Shipped	Credit Card	8576 Main St	1970-01-01	\N	401.07	\N	Jacksonville	54342.0
364	284	1970-01-01	Delivered	Credit Card	7331 Second Ave	1970-01-01	1970-01-01	639.23	\N	Fort Worth	65725.0
365	117	1970-01-01	Delivered	Google Pay	522 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Austin	56955.0
366	969	1970-01-01	Delivered	Apple Pay	8121 Main St	1970-01-01	1970-01-01	1915.31	\N	San Jose	55731.0
367	484	1970-01-01	Delivered	Credit Card	3096 Second Ave	1970-01-01	1970-01-01	156.20	\N	San Diego	62150.0
368	56	1970-01-01	Delivered	Apple Pay	6724 Oak Ave	1970-01-01	1970-01-01	273.72	\N	Austin	26728.0
369	981	1970-01-01	Pending	Debit Card	5898 Main St	\N	\N	192.40	\N	Phoenix	55838.0
370	663	1970-01-01	Shipped	Debit Card	9499 Main St	1970-01-01	\N	2254.56	\N	Charlotte	15796.0
371	766	1970-01-01	Pending	Credit Card	1358 Oak Ave	\N	\N	916.60	\N	San Antonio	98723.0
372	143	1970-01-01	Delivered	Google Pay	7665 First St	1970-01-01	1970-01-01	1203.60	\N	Phoenix	17456.0
374	756	1970-01-01	Delivered	Google Pay	4168 Park Rd	1970-01-01	1970-01-01	2770.30	\N	Charlotte	99688.0
375	262	1970-01-01	Delivered	Credit Card	5584 First St	1970-01-01	1970-01-01	5291.86	\N	San Diego	87908.0
377	535	1970-01-01	Delivered	Apple Pay	718 First St	1970-01-01	1970-01-01	1533.87	\N	Los Angeles	30461.0
378	294	1970-01-01	Delivered	Credit Card	5045 Oak Ave	1970-01-01	1970-01-01	101.61	\N	Charlotte	22234.0
380	992	1970-01-01	Delivered	Apple Pay	934 First St	1970-01-01	1970-01-01	3605.70	\N	Columbus	78809.0
381	666	1970-01-01	Delivered	Debit Card	9445 Second Ave	1970-01-01	1970-01-01	2399.81	\N	Columbus	69616.0
383	98	1970-01-01	Cancelled	Google Pay	1746 First St	\N	\N	32.38	\N	Los Angeles	49251.0
384	290	1970-01-01	Processing	Debit Card	8547 Park Rd	\N	\N	9298.40	\N	San Antonio	58374.0
385	858	1970-01-01	Processing	Credit Card	5009 First St	\N	\N	61.32	\N	San Jose	31270.0
387	631	1970-01-01	Processing	Apple Pay	2065 Main St	\N	\N	101.97	\N	Jacksonville	27027.0
388	967	1970-01-01	Processing	Google Pay	1180 Park Rd	\N	\N	324.33	\N	San Antonio	21662.0
389	399	1970-01-01	Delivered	Google Pay	6321 Park Rd	1970-01-01	1970-01-01	0.00	\N	Chicago	13777.0
390	395	1970-01-01	Delivered	Credit Card	2962 Main St	1970-01-01	1970-01-01	1300.52	\N	Columbus	57214.0
391	382	1970-01-01	Shipped	Google Pay	2862 Second Ave	1970-01-01	\N	765.50	\N	Fort Worth	74169.0
392	92	1970-01-01	Shipped	Google Pay	2534 First St	1970-01-01	\N	412.91	\N	Columbus	73483.0
393	931	1970-01-01	Cancelled	Credit Card	4025 Park Rd	\N	\N	81.80	\N	Philadelphia	62228.0
394	651	1970-01-01	Shipped	Debit Card	4019 Oak Ave	1970-01-01	\N	265.17	\N	San Antonio	14931.0
395	964	1970-01-01	Delivered	Apple Pay	1464 Park Rd	1970-01-01	1970-01-01	203.52	\N	San Diego	65750.0
396	163	1970-01-01	Delivered	Apple Pay	1502 Second Ave	1970-01-01	1970-01-01	0.00	\N	Chicago	18870.0
397	134	1970-01-01	Delivered	Google Pay	4286 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	25726.0
398	986	1970-01-01	Shipped	Google Pay	4454 Main St	1970-01-01	\N	320.00	\N	San Diego	74103.0
399	559	1970-01-01	Delivered	Credit Card	7358 Park Rd	1970-01-01	1970-01-01	51.18	\N	Phoenix	34632.0
400	731	1970-01-01	Delivered	Apple Pay	8946 Park Rd	1970-01-01	1970-01-01	0.00	\N	Austin	64304.0
401	233	1970-01-01	Delivered	Credit Card	8692 Park Rd	1970-01-01	1970-01-01	685.76	\N	Fort Worth	64568.0
404	456	1970-01-01	Delivered	Credit Card	8499 Main St	1970-01-01	1970-01-01	9910.67	\N	Chicago	29249.0
405	340	1970-01-01	Delivered	Credit Card	7257 First St	1970-01-01	1970-01-01	74.00	\N	Chicago	51586.0
406	286	1970-01-01	Delivered	Debit Card	2381 Oak Ave	1970-01-01	1970-01-01	398.01	\N	Chicago	17780.0
409	456	1970-01-01	Delivered	Credit Card	8499 Main St	1970-01-01	1970-01-01	262.58	\N	Chicago	29249.0
413	500	1970-01-01	Delivered	Apple Pay	3857 Oak Ave	1970-01-01	1970-01-01	119.00	\N	Phoenix	68085.0
415	940	1970-01-01	Shipped	Debit Card	5723 First St	1970-01-01	\N	0.00	\N	Austin	95710.0
417	26	1970-01-01	Delivered	Debit Card	5238 Main St	1970-01-01	1970-01-01	0.00	\N	New York	86569.0
419	603	1970-01-01	Delivered	Google Pay	4092 Second Ave	1970-01-01	1970-01-01	0.00	\N	Houston	73225.0
420	355	1970-01-01	Delivered	Google Pay	3960 First St	1970-01-01	1970-01-01	1160.81	\N	San Jose	20348.0
422	357	1970-01-01	Delivered	Apple Pay	2522 Second Ave	1970-01-01	1970-01-01	1212.55	\N	Houston	51910.0
423	849	1970-01-01	Delivered	Credit Card	2145 Main St	1970-01-01	1970-01-01	567.99	\N	San Jose	14370.0
424	398	1970-01-01	Processing	Google Pay	7009 Oak Ave	\N	\N	1714.30	\N	Fort Worth	27368.0
425	33	1970-01-01	Processing	Apple Pay	5717 Oak Ave	\N	\N	825.56	\N	Jacksonville	93130.0
426	183	1970-01-01	Delivered	Google Pay	2607 Park Rd	1970-01-01	1970-01-01	1018.54	\N	Dallas	31229.0
427	930	1970-01-01	Shipped	Google Pay	8620 Park Rd	1970-01-01	\N	404.58	\N	San Jose	72027.0
428	275	1970-01-01	Shipped	Debit Card	4660 Main St	1970-01-01	\N	344.65	\N	Houston	23336.0
429	274	1970-01-01	Delivered	Credit Card	7180 First St	1970-01-01	1970-01-01	1576.99	\N	Chicago	90492.0
430	173	1970-01-01	Delivered	Debit Card	2439 Second Ave	1970-01-01	1970-01-01	172.27	\N	New York	67432.0
431	271	1970-01-01	Delivered	Debit Card	5210 Park Rd	1970-01-01	1970-01-01	1039.87	\N	Philadelphia	37114.0
432	326	1970-01-01	Pending	Google Pay	1769 Oak Ave	\N	\N	122.18	\N	San Diego	11567.0
433	545	1970-01-01	Delivered	Debit Card	5829 Second Ave	1970-01-01	1970-01-01	844.84	\N	Chicago	91681.0
434	24	1970-01-01	Delivered	Debit Card	6758 First St	1970-01-01	1970-01-01	2865.54	\N	Chicago	38016.0
435	623	1970-01-01	Delivered	Google Pay	1482 Oak Ave	1970-01-01	1970-01-01	4556.37	\N	Philadelphia	30204.0
436	880	1970-01-01	Delivered	Apple Pay	6708 Second Ave	1970-01-01	1970-01-01	0.00	\N	Austin	52739.0
437	410	1970-01-01	Shipped	Google Pay	4266 Second Ave	1970-01-01	\N	956.34	\N	Los Angeles	34581.0
439	967	1970-01-01	Pending	Credit Card	1180 Park Rd	\N	\N	548.25	\N	San Antonio	21662.0
440	565	1970-01-01	Delivered	Debit Card	1891 First St	1970-01-01	1970-01-01	32.14	\N	Dallas	15559.0
441	919	1970-01-01	Shipped	Google Pay	7248 Park Rd	1970-01-01	\N	228.96	\N	Houston	76795.0
442	934	1970-01-01	Cancelled	Debit Card	6001 Main St	\N	\N	300.04	\N	New York	98857.0
443	491	1970-01-01	Delivered	Credit Card	4211 Second Ave	1970-01-01	1970-01-01	9415.09	\N	Phoenix	16253.0
445	4	1970-01-01	Delivered	Credit Card	5735 Second Ave	1970-01-01	1970-01-01	128.34	\N	Philadelphia	15695.0
446	549	1970-01-01	Pending	Credit Card	9651 Second Ave	\N	\N	192.30	\N	San Antonio	43483.0
447	712	1970-01-01	Shipped	Debit Card	6120 Oak Ave	1970-01-01	\N	0.00	\N	Austin	98363.0
449	373	1970-01-01	Cancelled	Apple Pay	1145 Park Rd	\N	\N	192.15	\N	San Diego	93964.0
450	112	1970-01-01	Delivered	Debit Card	9722 Oak Ave	1970-01-01	1970-01-01	42.95	\N	San Antonio	95841.0
451	966	1970-01-01	Processing	Apple Pay	7204 First St	\N	\N	516.19	\N	Fort Worth	89116.0
452	831	1970-01-01	Shipped	Debit Card	8000 Park Rd	1970-01-01	\N	71.40	\N	New York	42884.0
453	656	1970-01-01	Delivered	Credit Card	1260 Oak Ave	1970-01-01	1970-01-01	692.64	\N	Los Angeles	87687.0
454	13	1970-01-01	Pending	Apple Pay	7223 Oak Ave	\N	\N	86.78	\N	Phoenix	10425.0
455	94	1970-01-01	Processing	Credit Card	7849 First St	\N	\N	322.29	\N	Philadelphia	96991.0
456	335	1970-01-01	Delivered	Credit Card	2946 Oak Ave	1970-01-01	1970-01-01	1047.08	\N	Philadelphia	87662.0
458	813	1970-01-01	Delivered	Google Pay	3583 First St	1970-01-01	1970-01-01	276.44	\N	Los Angeles	14273.0
459	708	1970-01-01	Delivered	Debit Card	9756 Oak Ave	1970-01-01	1970-01-01	802.69	\N	Philadelphia	98280.0
460	871	1970-01-01	Shipped	Apple Pay	1476 Park Rd	1970-01-01	\N	114.96	\N	Fort Worth	78002.0
461	671	1970-01-01	Shipped	Debit Card	3793 Park Rd	1970-01-01	\N	394.48	\N	Fort Worth	45043.0
462	594	1970-01-01	Delivered	Debit Card	7327 Main St	1970-01-01	1970-01-01	541.70	\N	Philadelphia	29571.0
463	636	1970-01-01	Delivered	Debit Card	8254 Oak Ave	1970-01-01	1970-01-01	722.46	\N	New York	93930.0
464	962	1970-01-01	Shipped	Google Pay	701 Oak Ave	1970-01-01	\N	0.00	\N	Houston	49283.0
465	489	1970-01-01	Delivered	Google Pay	1736 Park Rd	1970-01-01	1970-01-01	48.14	\N	Columbus	82789.0
466	504	1970-01-01	Delivered	Google Pay	272 Main St	1970-01-01	1970-01-01	390.02	\N	Phoenix	27865.0
468	426	1970-01-01	Delivered	Google Pay	1606 Park Rd	1970-01-01	1970-01-01	1338.48	\N	San Antonio	37964.0
469	574	1970-01-01	Delivered	Apple Pay	6819 First St	1970-01-01	1970-01-01	80.74	\N	San Diego	88802.0
470	877	1970-01-01	Pending	Credit Card	8499 Oak Ave	\N	\N	2942.68	\N	San Diego	39829.0
471	397	1970-01-01	Delivered	Google Pay	5715 Oak Ave	1970-01-01	1970-01-01	399.12	\N	Columbus	62530.0
472	187	1970-01-01	Pending	Debit Card	5049 First St	\N	\N	0.00	\N	Phoenix	99783.0
474	344	1970-01-01	Shipped	Google Pay	1210 Park Rd	1970-01-01	\N	35.20	\N	Jacksonville	24160.0
475	146	1970-01-01	Delivered	Google Pay	4159 First St	1970-01-01	1970-01-01	155.08	\N	New York	78690.0
476	436	1970-01-01	Delivered	Apple Pay	6506 Second Ave	1970-01-01	1970-01-01	1162.20	\N	Jacksonville	93105.0
478	181	1970-01-01	Delivered	Debit Card	6830 First St	1970-01-01	1970-01-01	3690.79	\N	Dallas	19666.0
479	77	1970-01-01	Delivered	Google Pay	1725 Oak Ave	1970-01-01	1970-01-01	217.00	\N	San Jose	37659.0
480	400	1970-01-01	Delivered	Debit Card	4386 Park Rd	1970-01-01	1970-01-01	91.20	\N	Los Angeles	98857.0
481	968	1970-01-01	Delivered	Apple Pay	261 Main St	1970-01-01	1970-01-01	28.02	\N	Phoenix	39127.0
482	194	1970-01-01	Delivered	Credit Card	4433 Park Rd	1970-01-01	1970-01-01	0.00	\N	Chicago	57964.0
483	790	1970-01-01	Delivered	Debit Card	7838 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Fort Worth	37159.0
484	461	1970-01-01	Delivered	Credit Card	8806 Second Ave	1970-01-01	1970-01-01	632.72	\N	Charlotte	22214.0
486	452	1970-01-01	Delivered	Debit Card	4221 First St	1970-01-01	1970-01-01	167.85	\N	Dallas	77681.0
488	323	1970-01-01	Delivered	Debit Card	3501 First St	1970-01-01	1970-01-01	7946.44	\N	Philadelphia	70731.0
489	639	1970-01-01	Delivered	Debit Card	1004 Main St	1970-01-01	1970-01-01	2249.71	\N	San Antonio	80074.0
490	965	1970-01-01	Delivered	Apple Pay	3256 Park Rd	1970-01-01	1970-01-01	476.63	\N	Austin	96155.0
491	618	1970-01-01	Delivered	Credit Card	276 First St	1970-01-01	1970-01-01	0.00	\N	Fort Worth	77195.0
492	422	1970-01-01	Delivered	Credit Card	3270 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	33255.0
493	632	1970-01-01	Delivered	Apple Pay	4926 First St	1970-01-01	1970-01-01	6990.20	\N	Phoenix	19924.0
494	816	1970-01-01	Delivered	Credit Card	8108 Main St	1970-01-01	1970-01-01	1934.20	\N	Chicago	81766.0
495	993	1970-01-01	Delivered	Debit Card	7097 Main St	1970-01-01	1970-01-01	44.72	\N	Dallas	24425.0
496	976	1970-01-01	Delivered	Credit Card	2142 First St	1970-01-01	1970-01-01	358.55	\N	Jacksonville	90777.0
497	243	1970-01-01	Shipped	Debit Card	8982 Main St	1970-01-01	\N	392.00	\N	Charlotte	14433.0
498	802	1970-01-01	Shipped	Apple Pay	5239 Park Rd	1970-01-01	\N	1105.10	\N	Jacksonville	46671.0
499	829	1970-01-01	Delivered	Debit Card	6764 First St	1970-01-01	1970-01-01	707.76	\N	San Jose	93335.0
500	242	1970-01-01	Delivered	Apple Pay	8105 First St	1970-01-01	1970-01-01	0.00	\N	Phoenix	32050.0
501	225	1970-01-01	Delivered	Apple Pay	6987 Park Rd	1970-01-01	1970-01-01	202.44	\N	Fort Worth	68790.0
502	660	1970-01-01	Shipped	Google Pay	1920 First St	1970-01-01	\N	5729.84	\N	Chicago	64817.0
503	461	1970-01-01	Delivered	Credit Card	8806 Second Ave	1970-01-01	1970-01-01	37.38	\N	Charlotte	22214.0
504	590	1970-01-01	Shipped	Apple Pay	3411 Main St	1970-01-01	\N	0.00	\N	Fort Worth	76321.0
505	343	1970-01-01	Delivered	Debit Card	5782 Park Rd	1970-01-01	1970-01-01	427.11	\N	Houston	93386.0
506	843	1970-01-01	Delivered	Google Pay	4243 Second Ave	1970-01-01	1970-01-01	2545.26	\N	San Jose	10256.0
507	987	1970-01-01	Delivered	Apple Pay	6470 Oak Ave	1970-01-01	1970-01-01	147.69	\N	Dallas	24139.0
508	809	1970-01-01	Delivered	Google Pay	5471 Second Ave	1970-01-01	1970-01-01	1556.92	\N	Los Angeles	35238.0
509	107	1970-01-01	Cancelled	Apple Pay	7994 Park Rd	\N	\N	491.70	\N	Phoenix	25095.0
511	296	1970-01-01	Delivered	Credit Card	9826 Oak Ave	1970-01-01	1970-01-01	913.32	\N	Chicago	99126.0
512	618	1970-01-01	Delivered	Google Pay	276 First St	1970-01-01	1970-01-01	44.68	\N	Fort Worth	77195.0
513	711	1970-01-01	Delivered	Debit Card	7373 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Austin	63383.0
514	606	1970-01-01	Shipped	Google Pay	1881 Second Ave	1970-01-01	\N	833.68	\N	San Jose	52914.0
515	490	1970-01-01	Delivered	Google Pay	259 Oak Ave	1970-01-01	1970-01-01	561.34	\N	San Diego	75483.0
516	981	1970-01-01	Delivered	Google Pay	5898 Main St	1970-01-01	1970-01-01	1532.48	\N	Phoenix	55838.0
517	812	1970-01-01	Delivered	Debit Card	6930 Oak Ave	1970-01-01	1970-01-01	7617.21	\N	Jacksonville	76294.0
518	19	1970-01-01	Delivered	Google Pay	1204 Main St	1970-01-01	1970-01-01	0.00	\N	Houston	19287.0
519	236	1970-01-01	Shipped	Credit Card	3220 Main St	1970-01-01	\N	177.50	\N	Jacksonville	59436.0
521	901	1970-01-01	Delivered	Apple Pay	8975 First St	1970-01-01	1970-01-01	1115.56	\N	Charlotte	25834.0
522	10	1970-01-01	Delivered	Debit Card	9677 First St	1970-01-01	1970-01-01	475.53	\N	Phoenix	62350.0
523	978	1970-01-01	Delivered	Google Pay	2284 Second Ave	1970-01-01	1970-01-01	0.00	\N	Philadelphia	16672.0
524	327	1970-01-01	Processing	Google Pay	1476 Second Ave	\N	\N	1997.60	\N	Austin	43924.0
525	435	1970-01-01	Delivered	Debit Card	1517 Park Rd	1970-01-01	1970-01-01	3778.50	\N	San Jose	59992.0
526	901	1970-01-01	Shipped	Credit Card	8975 First St	1970-01-01	\N	98.76	\N	Charlotte	25834.0
527	844	1970-01-01	Delivered	Credit Card	8591 First St	1970-01-01	1970-01-01	1448.85	\N	Los Angeles	57378.0
528	785	1970-01-01	Processing	Debit Card	5569 Main St	\N	\N	483.43	\N	New York	92629.0
529	372	1970-01-01	Processing	Debit Card	1776 Main St	\N	\N	1330.01	\N	San Jose	96816.0
530	245	1970-01-01	Cancelled	Credit Card	8093 Main St	\N	\N	422.88	\N	Austin	79758.0
532	355	1970-01-01	Delivered	Credit Card	3960 First St	1970-01-01	1970-01-01	263.32	\N	San Jose	20348.0
535	285	1970-01-01	Shipped	Google Pay	1525 First St	1970-01-01	\N	142.70	\N	Philadelphia	41056.0
536	840	1970-01-01	Delivered	Apple Pay	3525 Main St	1970-01-01	1970-01-01	515.22	\N	San Diego	93681.0
537	76	1970-01-01	Delivered	Debit Card	8661 First St	1970-01-01	1970-01-01	351.72	\N	Fort Worth	68028.0
538	442	1970-01-01	Delivered	Credit Card	9671 Oak Ave	1970-01-01	1970-01-01	20.78	\N	Jacksonville	84299.0
539	474	1970-01-01	Delivered	Apple Pay	6644 Park Rd	1970-01-01	1970-01-01	0.00	\N	Phoenix	61792.0
540	591	1970-01-01	Pending	Google Pay	8679 Park Rd	\N	\N	348.45	\N	Jacksonville	28781.0
543	256	1970-01-01	Delivered	Google Pay	1599 Main St	1970-01-01	1970-01-01	3944.63	\N	Los Angeles	68292.0
544	401	1970-01-01	Delivered	Debit Card	8670 Second Ave	1970-01-01	1970-01-01	2480.94	\N	Dallas	66734.0
548	575	1970-01-01	Delivered	Credit Card	3128 Oak Ave	1970-01-01	1970-01-01	474.67	\N	New York	95626.0
549	522	1970-01-01	Delivered	Credit Card	7539 Main St	1970-01-01	1970-01-01	213.20	\N	Philadelphia	76316.0
550	107	1970-01-01	Shipped	Google Pay	7994 Park Rd	1970-01-01	\N	875.74	\N	Phoenix	25095.0
551	39	1970-01-01	Delivered	Credit Card	5100 Oak Ave	1970-01-01	1970-01-01	2000.92	\N	Philadelphia	13101.0
552	486	1970-01-01	Delivered	Google Pay	237 Main St	1970-01-01	1970-01-01	3921.90	\N	Philadelphia	37623.0
553	425	1970-01-01	Processing	Credit Card	5307 Second Ave	\N	\N	142.57	\N	Los Angeles	34100.0
554	871	1970-01-01	Delivered	Apple Pay	1476 Park Rd	1970-01-01	1970-01-01	2946.68	\N	Fort Worth	78002.0
555	134	1970-01-01	Delivered	Google Pay	4286 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	25726.0
557	542	1970-01-01	Shipped	Apple Pay	7218 Oak Ave	1970-01-01	\N	2234.72	\N	Dallas	73035.0
558	835	1970-01-01	Delivered	Debit Card	7907 Main St	1970-01-01	1970-01-01	7183.15	\N	San Jose	98172.0
559	658	1970-01-01	Delivered	Debit Card	8036 Main St	1970-01-01	1970-01-01	0.00	\N	San Jose	28997.0
560	964	1970-01-01	Delivered	Apple Pay	1464 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Diego	65750.0
561	765	1970-01-01	Delivered	Google Pay	8435 Park Rd	1970-01-01	1970-01-01	8001.90	\N	Jacksonville	96918.0
563	692	1970-01-01	Shipped	Debit Card	140 Oak Ave	1970-01-01	\N	0.00	\N	Fort Worth	49343.0
564	667	1970-01-01	Delivered	Google Pay	7707 Main St	1970-01-01	1970-01-01	156.16	\N	Austin	19266.0
566	449	1970-01-01	Delivered	Apple Pay	762 Oak Ave	1970-01-01	1970-01-01	557.72	\N	Philadelphia	40375.0
567	212	1970-01-01	Delivered	Debit Card	8216 Oak Ave	1970-01-01	1970-01-01	2232.01	\N	Fort Worth	14910.0
570	776	1970-01-01	Delivered	Debit Card	838 Second Ave	1970-01-01	1970-01-01	568.43	\N	Charlotte	76932.0
571	308	1970-01-01	Pending	Credit Card	2977 Main St	\N	\N	258.76	\N	Phoenix	27984.0
573	241	1970-01-01	Shipped	Google Pay	2597 Oak Ave	1970-01-01	\N	60.84	\N	Phoenix	40149.0
574	921	1970-01-01	Delivered	Debit Card	4153 Second Ave	1970-01-01	1970-01-01	0.00	\N	Phoenix	96848.0
575	606	1970-01-01	Processing	Debit Card	1881 Second Ave	\N	\N	292.64	\N	San Jose	52914.0
576	621	1970-01-01	Delivered	Debit Card	2271 Second Ave	1970-01-01	1970-01-01	3009.24	\N	Phoenix	46073.0
578	303	1970-01-01	Shipped	Credit Card	297 Park Rd	1970-01-01	\N	993.12	\N	Dallas	27299.0
579	279	1970-01-01	Shipped	Debit Card	6386 First St	1970-01-01	\N	2525.88	\N	San Jose	73788.0
580	165	1970-01-01	Delivered	Google Pay	1798 Second Ave	1970-01-01	1970-01-01	7298.91	\N	Houston	27486.0
581	844	1970-01-01	Delivered	Apple Pay	8591 First St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	57378.0
582	167	1970-01-01	Shipped	Credit Card	3368 Main St	1970-01-01	\N	7427.05	\N	Fort Worth	50642.0
583	68	1970-01-01	Processing	Google Pay	4037 First St	\N	\N	119.00	\N	Dallas	74332.0
584	288	1970-01-01	Delivered	Credit Card	1071 Park Rd	1970-01-01	1970-01-01	2249.78	\N	Charlotte	26631.0
585	218	1970-01-01	Pending	Debit Card	5195 Main St	\N	\N	1126.76	\N	Charlotte	48671.0
586	971	1970-01-01	Delivered	Debit Card	2190 Park Rd	1970-01-01	1970-01-01	596.35	\N	San Jose	77314.0
588	318	1970-01-01	Pending	Apple Pay	123 First St	\N	\N	686.76	\N	Philadelphia	23624.0
589	519	1970-01-01	Delivered	Google Pay	7287 Oak Ave	1970-01-01	1970-01-01	346.71	\N	Fort Worth	59514.0
590	315	1970-01-01	Delivered	Credit Card	1229 First St	1970-01-01	1970-01-01	4888.34	\N	San Antonio	50723.0
591	637	1970-01-01	Cancelled	Apple Pay	6511 Second Ave	\N	\N	4185.58	\N	Charlotte	77552.0
592	114	1970-01-01	Delivered	Credit Card	4620 Oak Ave	1970-01-01	1970-01-01	456.41	\N	San Antonio	69600.0
593	693	1970-01-01	Shipped	Credit Card	2055 Park Rd	1970-01-01	\N	2059.89	\N	New York	18745.0
594	62	1970-01-01	Processing	Apple Pay	9800 Oak Ave	\N	\N	0.00	\N	Los Angeles	49529.0
595	220	1970-01-01	Delivered	Credit Card	7419 Second Ave	1970-01-01	1970-01-01	1161.10	\N	Dallas	57419.0
596	331	1970-01-01	Delivered	Apple Pay	4683 First St	1970-01-01	1970-01-01	496.29	\N	Los Angeles	64949.0
597	264	1970-01-01	Delivered	Apple Pay	1965 Second Ave	1970-01-01	1970-01-01	366.80	\N	Philadelphia	87624.0
598	519	1970-01-01	Delivered	Apple Pay	7287 Oak Ave	1970-01-01	1970-01-01	686.96	\N	Fort Worth	59514.0
599	992	1970-01-01	Delivered	Credit Card	934 First St	1970-01-01	1970-01-01	427.79	\N	Columbus	78809.0
600	315	1970-01-01	Delivered	Credit Card	1229 First St	1970-01-01	1970-01-01	1620.89	\N	San Antonio	50723.0
601	258	1970-01-01	Delivered	Credit Card	6411 Main St	1970-01-01	1970-01-01	546.16	\N	Columbus	64238.0
602	57	1970-01-01	Shipped	Apple Pay	7122 Oak Ave	1970-01-01	\N	7790.75	\N	Los Angeles	33819.0
603	513	1970-01-01	Delivered	Debit Card	7357 Oak Ave	1970-01-01	1970-01-01	0.00	\N	San Antonio	36106.0
604	730	1970-01-01	Shipped	Debit Card	8800 First St	1970-01-01	\N	884.32	\N	San Jose	37490.0
605	717	1970-01-01	Delivered	Credit Card	538 Oak Ave	1970-01-01	1970-01-01	915.56	\N	San Diego	89244.0
606	835	1970-01-01	Delivered	Apple Pay	7907 Main St	1970-01-01	1970-01-01	1024.24	\N	San Jose	98172.0
607	583	1970-01-01	Processing	Credit Card	3396 Park Rd	\N	\N	766.28	\N	New York	18891.0
608	239	1970-01-01	Processing	Google Pay	4385 Park Rd	\N	\N	2465.97	\N	Phoenix	75179.0
611	605	1970-01-01	Delivered	Apple Pay	9802 Second Ave	1970-01-01	1970-01-01	0.00	\N	Los Angeles	52647.0
612	179	1970-01-01	Delivered	Debit Card	6022 Second Ave	1970-01-01	1970-01-01	70.59	\N	Fort Worth	25907.0
613	467	1970-01-01	Delivered	Debit Card	6165 Second Ave	1970-01-01	1970-01-01	468.85	\N	Chicago	73407.0
614	523	1970-01-01	Delivered	Apple Pay	1137 Second Ave	1970-01-01	1970-01-01	238.54	\N	Philadelphia	34886.0
615	621	1970-01-01	Delivered	Credit Card	2271 Second Ave	1970-01-01	1970-01-01	0.00	\N	Phoenix	46073.0
616	776	1970-01-01	Shipped	Credit Card	838 Second Ave	1970-01-01	\N	7077.78	\N	Charlotte	76932.0
617	631	1970-01-01	Delivered	Debit Card	2065 Main St	1970-01-01	1970-01-01	251.04	\N	Jacksonville	27027.0
619	395	1970-01-01	Delivered	Debit Card	2962 Main St	1970-01-01	1970-01-01	1898.75	\N	Columbus	57214.0
620	717	1970-01-01	Delivered	Apple Pay	538 Oak Ave	1970-01-01	1970-01-01	15569.57	\N	San Diego	89244.0
621	304	1970-01-01	Delivered	Google Pay	7817 Main St	1970-01-01	1970-01-01	1393.50	\N	Fort Worth	86986.0
623	352	1970-01-01	Delivered	Debit Card	9014 First St	1970-01-01	1970-01-01	875.74	\N	Austin	58630.0
624	751	1970-01-01	Delivered	Google Pay	9445 Oak Ave	1970-01-01	1970-01-01	91.34	\N	Columbus	13010.0
625	837	1970-01-01	Delivered	Debit Card	2122 Park Rd	1970-01-01	1970-01-01	973.76	\N	Austin	88815.0
626	913	1970-01-01	Delivered	Google Pay	4775 Second Ave	1970-01-01	1970-01-01	1116.33	\N	Phoenix	93309.0
629	166	1970-01-01	Delivered	Credit Card	7712 First St	1970-01-01	1970-01-01	43.61	\N	Columbus	33891.0
630	199	1970-01-01	Delivered	Credit Card	8125 Second Ave	1970-01-01	1970-01-01	117.15	\N	Dallas	72245.0
631	242	1970-01-01	Shipped	Credit Card	8105 First St	1970-01-01	\N	40.13	\N	Phoenix	32050.0
632	77	1970-01-01	Cancelled	Google Pay	1725 Oak Ave	\N	\N	197.04	\N	San Jose	37659.0
633	716	1970-01-01	Delivered	Google Pay	8117 First St	1970-01-01	1970-01-01	91.72	\N	Phoenix	92361.0
634	70	1970-01-01	Delivered	Google Pay	7534 Park Rd	1970-01-01	1970-01-01	222.12	\N	Jacksonville	42951.0
635	236	1970-01-01	Delivered	Google Pay	3220 Main St	1970-01-01	1970-01-01	284.47	\N	Jacksonville	59436.0
636	141	1970-01-01	Delivered	Apple Pay	8195 First St	1970-01-01	1970-01-01	158.70	\N	Chicago	85952.0
637	75	1970-01-01	Delivered	Google Pay	2544 Second Ave	1970-01-01	1970-01-01	265.26	\N	Chicago	21164.0
638	43	1970-01-01	Delivered	Google Pay	5243 Main St	1970-01-01	1970-01-01	50.94	\N	San Jose	76469.0
639	986	1970-01-01	Processing	Google Pay	4454 Main St	\N	\N	579.11	\N	San Diego	74103.0
641	364	1970-01-01	Delivered	Debit Card	8562 Park Rd	1970-01-01	1970-01-01	1476.33	\N	Fort Worth	77537.0
643	794	1970-01-01	Delivered	Google Pay	9226 Park Rd	1970-01-01	1970-01-01	39.34	\N	Fort Worth	77552.0
644	309	1970-01-01	Cancelled	Credit Card	4347 Oak Ave	\N	\N	0.00	\N	Fort Worth	26637.0
645	881	1970-01-01	Delivered	Apple Pay	9979 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Jose	61234.0
646	696	1970-01-01	Delivered	Apple Pay	4878 Second Ave	1970-01-01	1970-01-01	727.27	\N	Phoenix	20069.0
647	442	1970-01-01	Delivered	Debit Card	9671 Oak Ave	1970-01-01	1970-01-01	1172.35	\N	Jacksonville	84299.0
648	729	1970-01-01	Delivered	Google Pay	9496 First St	1970-01-01	1970-01-01	1430.00	\N	Phoenix	91863.0
649	256	1970-01-01	Shipped	Google Pay	1599 Main St	1970-01-01	\N	6829.13	\N	Los Angeles	68292.0
650	229	1970-01-01	Delivered	Google Pay	1202 Main St	1970-01-01	1970-01-01	0.00	\N	Houston	14400.0
652	659	1970-01-01	Delivered	Credit Card	3281 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Diego	36504.0
653	181	1970-01-01	Delivered	Apple Pay	6830 First St	1970-01-01	1970-01-01	247.51	\N	Dallas	19666.0
654	567	1970-01-01	Pending	Debit Card	993 Second Ave	\N	\N	2970.17	\N	San Jose	70762.0
655	374	1970-01-01	Delivered	Debit Card	2556 Second Ave	1970-01-01	1970-01-01	1692.80	\N	Houston	17441.0
656	327	1970-01-01	Delivered	Google Pay	1476 Second Ave	1970-01-01	1970-01-01	208.72	\N	Austin	43924.0
657	243	1970-01-01	Delivered	Credit Card	8982 Main St	1970-01-01	1970-01-01	4995.08	\N	Charlotte	14433.0
658	368	1970-01-01	Pending	Apple Pay	4337 Main St	\N	\N	229.85	\N	Columbus	13597.0
659	704	1970-01-01	Processing	Debit Card	2048 Park Rd	\N	\N	443.24	\N	San Diego	18683.0
663	314	1970-01-01	Shipped	Credit Card	1376 Second Ave	1970-01-01	\N	6127.83	\N	Columbus	25650.0
664	932	1970-01-01	Delivered	Credit Card	1741 Main St	1970-01-01	1970-01-01	372.10	\N	Fort Worth	62665.0
665	883	1970-01-01	Delivered	Apple Pay	9985 First St	1970-01-01	1970-01-01	143.42	\N	New York	34470.0
666	515	1970-01-01	Delivered	Credit Card	6005 Main St	1970-01-01	1970-01-01	0.00	\N	Houston	38545.0
667	776	1970-01-01	Delivered	Debit Card	838 Second Ave	1970-01-01	1970-01-01	935.40	\N	Charlotte	76932.0
668	20	1970-01-01	Delivered	Credit Card	9455 Second Ave	1970-01-01	1970-01-01	31.17	\N	Chicago	41850.0
670	424	1970-01-01	Shipped	Credit Card	2636 Main St	1970-01-01	\N	0.00	\N	San Diego	52287.0
671	806	1970-01-01	Processing	Apple Pay	7026 Second Ave	\N	\N	652.02	\N	Jacksonville	17857.0
672	788	1970-01-01	Delivered	Google Pay	7247 Main St	1970-01-01	1970-01-01	404.90	\N	Jacksonville	47750.0
673	753	1970-01-01	Delivered	Credit Card	2022 Main St	1970-01-01	1970-01-01	204.58	\N	San Jose	67037.0
675	39	1970-01-01	Delivered	Google Pay	5100 Oak Ave	1970-01-01	1970-01-01	2378.60	\N	Philadelphia	13101.0
676	254	1970-01-01	Delivered	Apple Pay	3837 Park Rd	1970-01-01	1970-01-01	3970.65	\N	San Diego	59207.0
677	737	1970-01-01	Delivered	Debit Card	4651 Second Ave	1970-01-01	1970-01-01	933.27	\N	Fort Worth	94448.0
678	175	1970-01-01	Processing	Credit Card	2355 Second Ave	\N	\N	0.00	\N	San Jose	62171.0
679	233	1970-01-01	Delivered	Apple Pay	8692 Park Rd	1970-01-01	1970-01-01	1842.95	\N	Fort Worth	64568.0
680	776	1970-01-01	Delivered	Debit Card	838 Second Ave	1970-01-01	1970-01-01	684.17	\N	Charlotte	76932.0
681	334	1970-01-01	Delivered	Apple Pay	1740 Oak Ave	1970-01-01	1970-01-01	378.27	\N	Chicago	41608.0
682	452	1970-01-01	Delivered	Debit Card	4221 First St	1970-01-01	1970-01-01	0.00	\N	Dallas	77681.0
683	139	1970-01-01	Shipped	Credit Card	8463 Main St	1970-01-01	\N	99.70	\N	Los Angeles	76840.0
686	898	1970-01-01	Processing	Google Pay	9900 Main St	\N	\N	378.66	\N	New York	59465.0
687	319	1970-01-01	Delivered	Debit Card	4684 Main St	1970-01-01	1970-01-01	0.00	\N	Jacksonville	40339.0
688	644	1970-01-01	Processing	Google Pay	9592 Oak Ave	\N	\N	95.52	\N	Chicago	14833.0
689	448	1970-01-01	Pending	Credit Card	8523 Oak Ave	\N	\N	97.36	\N	Fort Worth	30869.0
690	171	1970-01-01	Delivered	Google Pay	7405 Second Ave	1970-01-01	1970-01-01	7917.28	\N	Phoenix	31842.0
691	28	1970-01-01	Processing	Apple Pay	1443 First St	\N	\N	990.63	\N	San Jose	86503.0
692	544	1970-01-01	Delivered	Credit Card	6876 First St	1970-01-01	1970-01-01	58.01	\N	Austin	55653.0
693	643	1970-01-01	Shipped	Google Pay	5633 Main St	1970-01-01	\N	271.25	\N	New York	25491.0
694	673	1970-01-01	Delivered	Debit Card	1175 Oak Ave	1970-01-01	1970-01-01	3144.05	\N	Fort Worth	21443.0
695	456	1970-01-01	Delivered	Apple Pay	8499 Main St	1970-01-01	1970-01-01	206.22	\N	Chicago	29249.0
697	166	1970-01-01	Cancelled	Debit Card	7712 First St	\N	\N	107.12	\N	Columbus	33891.0
698	279	1970-01-01	Shipped	Credit Card	6386 First St	1970-01-01	\N	3114.07	\N	San Jose	73788.0
699	64	1970-01-01	Delivered	Apple Pay	2606 First St	1970-01-01	1970-01-01	985.21	\N	Jacksonville	78386.0
700	28	1970-01-01	Delivered	Credit Card	1443 First St	1970-01-01	1970-01-01	533.37	\N	San Jose	86503.0
701	697	1970-01-01	Delivered	Apple Pay	5385 Park Rd	1970-01-01	1970-01-01	2427.97	\N	Dallas	49462.0
702	669	1970-01-01	Delivered	Debit Card	944 Main St	1970-01-01	1970-01-01	700.45	\N	Charlotte	57918.0
703	692	1970-01-01	Delivered	Google Pay	140 Oak Ave	1970-01-01	1970-01-01	464.03	\N	Fort Worth	49343.0
704	380	1970-01-01	Delivered	Google Pay	4988 First St	1970-01-01	1970-01-01	23.80	\N	Dallas	29762.0
705	291	1970-01-01	Shipped	Debit Card	7611 Park Rd	1970-01-01	\N	0.00	\N	Jacksonville	80048.0
706	930	1970-01-01	Shipped	Google Pay	8620 Park Rd	1970-01-01	\N	2443.54	\N	San Jose	72027.0
707	232	1970-01-01	Delivered	Credit Card	9793 Oak Ave	1970-01-01	1970-01-01	98.52	\N	Dallas	98965.0
708	850	1970-01-01	Shipped	Credit Card	5039 Second Ave	1970-01-01	\N	0.00	\N	New York	66602.0
709	656	1970-01-01	Delivered	Apple Pay	1260 Oak Ave	1970-01-01	1970-01-01	942.12	\N	Los Angeles	87687.0
710	402	1970-01-01	Delivered	Apple Pay	9247 Second Ave	1970-01-01	1970-01-01	674.91	\N	Chicago	11526.0
711	797	1970-01-01	Processing	Apple Pay	3407 First St	\N	\N	624.05	\N	Columbus	10863.0
712	459	1970-01-01	Delivered	Debit Card	7529 Second Ave	1970-01-01	1970-01-01	172.58	\N	Charlotte	19023.0
713	205	1970-01-01	Delivered	Google Pay	4976 Park Rd	1970-01-01	1970-01-01	787.32	\N	Houston	37168.0
714	833	1970-01-01	Processing	Debit Card	9217 Park Rd	\N	\N	5194.24	\N	Jacksonville	37636.0
717	999	1970-01-01	Delivered	Credit Card	2194 Oak Ave	1970-01-01	1970-01-01	0.00	\N	New York	82154.0
718	881	1970-01-01	Shipped	Debit Card	9979 Second Ave	1970-01-01	\N	283.86	\N	San Jose	61234.0
719	278	1970-01-01	Delivered	Google Pay	4008 Park Rd	1970-01-01	1970-01-01	120.85	\N	Los Angeles	33992.0
720	377	1970-01-01	Delivered	Google Pay	1699 First St	1970-01-01	1970-01-01	0.00	\N	Phoenix	43902.0
723	489	1970-01-01	Delivered	Credit Card	1736 Park Rd	1970-01-01	1970-01-01	1329.74	\N	Columbus	82789.0
724	144	1970-01-01	Delivered	Debit Card	9833 Second Ave	1970-01-01	1970-01-01	3600.39	\N	San Jose	70648.0
726	866	1970-01-01	Cancelled	Debit Card	8873 Park Rd	\N	\N	0.00	\N	Columbus	52949.0
727	675	1970-01-01	Delivered	Google Pay	2263 First St	1970-01-01	1970-01-01	7997.31	\N	Charlotte	65067.0
728	946	1970-01-01	Delivered	Credit Card	6271 Main St	1970-01-01	1970-01-01	408.24	\N	Phoenix	30014.0
729	738	1970-01-01	Delivered	Google Pay	4982 Main St	1970-01-01	1970-01-01	261.38	\N	San Jose	57636.0
730	517	1970-01-01	Cancelled	Credit Card	1566 Oak Ave	\N	\N	203.90	\N	Fort Worth	75525.0
731	450	1970-01-01	Processing	Debit Card	6018 First St	\N	\N	2583.16	\N	Dallas	69591.0
732	32	1970-01-01	Delivered	Apple Pay	1797 Oak Ave	1970-01-01	1970-01-01	896.40	\N	Charlotte	25129.0
733	786	1970-01-01	Shipped	Debit Card	8087 First St	1970-01-01	\N	1447.39	\N	New York	77286.0
734	770	1970-01-01	Delivered	Apple Pay	4033 First St	1970-01-01	1970-01-01	111.60	\N	Chicago	12688.0
735	383	1970-01-01	Processing	Google Pay	7921 First St	\N	\N	842.45	\N	San Antonio	14944.0
736	664	1970-01-01	Delivered	Apple Pay	1705 First St	1970-01-01	1970-01-01	2544.23	\N	San Diego	41524.0
737	498	1970-01-01	Delivered	Google Pay	4222 Main St	1970-01-01	1970-01-01	7448.81	\N	Austin	31877.0
738	674	1970-01-01	Delivered	Debit Card	1935 Oak Ave	1970-01-01	1970-01-01	675.30	\N	Phoenix	29726.0
739	181	1970-01-01	Delivered	Google Pay	6830 First St	1970-01-01	1970-01-01	431.02	\N	Dallas	19666.0
740	742	1970-01-01	Delivered	Google Pay	7043 First St	1970-01-01	1970-01-01	112.28	\N	Dallas	42289.0
741	294	1970-01-01	Delivered	Debit Card	5045 Oak Ave	1970-01-01	1970-01-01	165.56	\N	Charlotte	22234.0
742	687	1970-01-01	Delivered	Credit Card	6426 Park Rd	1970-01-01	1970-01-01	1040.33	\N	Philadelphia	47309.0
744	26	1970-01-01	Delivered	Apple Pay	5238 Main St	1970-01-01	1970-01-01	527.52	\N	New York	86569.0
745	12	1970-01-01	Pending	Credit Card	4219 Second Ave	\N	\N	35.04	\N	Dallas	99166.0
746	679	1970-01-01	Shipped	Debit Card	8870 Park Rd	1970-01-01	\N	807.72	\N	Jacksonville	32984.0
747	179	1970-01-01	Delivered	Debit Card	6022 Second Ave	1970-01-01	1970-01-01	193.48	\N	Fort Worth	25907.0
748	860	1970-01-01	Delivered	Debit Card	3118 Main St	1970-01-01	1970-01-01	37.72	\N	San Antonio	11296.0
749	617	1970-01-01	Delivered	Debit Card	7840 Main St	1970-01-01	1970-01-01	8807.95	\N	Houston	93058.0
750	138	1970-01-01	Delivered	Google Pay	9748 First St	1970-01-01	1970-01-01	183.20	\N	San Antonio	20308.0
751	51	1970-01-01	Delivered	Debit Card	4346 Oak Ave	1970-01-01	1970-01-01	20.47	\N	San Diego	46347.0
752	527	1970-01-01	Delivered	Credit Card	1094 Park Rd	1970-01-01	1970-01-01	2476.56	\N	Fort Worth	64519.0
754	55	1970-01-01	Delivered	Apple Pay	9047 Second Ave	1970-01-01	1970-01-01	539.66	\N	Dallas	73993.0
755	508	1970-01-01	Delivered	Debit Card	1221 Oak Ave	1970-01-01	1970-01-01	2094.35	\N	Columbus	47957.0
756	449	1970-01-01	Shipped	Debit Card	762 Oak Ave	1970-01-01	\N	514.58	\N	Philadelphia	40375.0
758	266	1970-01-01	Shipped	Credit Card	7032 First St	1970-01-01	\N	442.24	\N	Jacksonville	68860.0
759	853	1970-01-01	Delivered	Credit Card	3272 Second Ave	1970-01-01	1970-01-01	2790.82	\N	San Jose	93540.0
760	261	1970-01-01	Delivered	Apple Pay	1852 Oak Ave	1970-01-01	1970-01-01	246.06	\N	San Diego	10887.0
761	118	1970-01-01	Delivered	Apple Pay	6997 Second Ave	1970-01-01	1970-01-01	432.09	\N	Chicago	18330.0
762	474	1970-01-01	Delivered	Credit Card	6644 Park Rd	1970-01-01	1970-01-01	119.28	\N	Phoenix	61792.0
763	503	1970-01-01	Delivered	Google Pay	5788 First St	1970-01-01	1970-01-01	4430.23	\N	Charlotte	39770.0
764	512	1970-01-01	Processing	Credit Card	8999 First St	\N	\N	215.69	\N	Los Angeles	35191.0
765	889	1970-01-01	Delivered	Debit Card	4973 First St	1970-01-01	1970-01-01	70.46	\N	Philadelphia	32954.0
766	560	1970-01-01	Delivered	Debit Card	9390 Second Ave	1970-01-01	1970-01-01	864.04	\N	San Jose	88166.0
770	807	1970-01-01	Processing	Debit Card	4981 Second Ave	\N	\N	48.24	\N	San Diego	69394.0
771	110	1970-01-01	Delivered	Apple Pay	1135 First St	1970-01-01	1970-01-01	178.99	\N	Austin	49608.0
772	680	1970-01-01	Delivered	Debit Card	4366 Park Rd	1970-01-01	1970-01-01	319.25	\N	San Diego	36890.0
773	204	1970-01-01	Delivered	Credit Card	8834 Park Rd	1970-01-01	1970-01-01	51.80	\N	San Diego	56437.0
774	892	1970-01-01	Shipped	Credit Card	1823 Second Ave	1970-01-01	\N	0.00	\N	Los Angeles	63752.0
775	989	1970-01-01	Cancelled	Credit Card	2598 Second Ave	\N	\N	791.58	\N	Houston	42698.0
776	723	1970-01-01	Delivered	Apple Pay	9774 Main St	1970-01-01	1970-01-01	0.00	\N	New York	58026.0
777	47	1970-01-01	Delivered	Google Pay	500 Main St	1970-01-01	1970-01-01	145.06	\N	Chicago	72277.0
778	861	1970-01-01	Delivered	Debit Card	3285 Second Ave	1970-01-01	1970-01-01	170.94	\N	San Diego	15754.0
780	700	1970-01-01	Shipped	Google Pay	7644 Main St	1970-01-01	\N	0.00	\N	San Antonio	27200.0
781	129	1970-01-01	Delivered	Debit Card	6666 Main St	1970-01-01	1970-01-01	544.22	\N	San Jose	92991.0
782	251	1970-01-01	Delivered	Apple Pay	5252 Main St	1970-01-01	1970-01-01	114.65	\N	Chicago	86943.0
784	806	1970-01-01	Delivered	Apple Pay	7026 Second Ave	1970-01-01	1970-01-01	199.25	\N	Jacksonville	17857.0
785	676	1970-01-01	Shipped	Debit Card	8613 Park Rd	1970-01-01	\N	689.26	\N	Columbus	85851.0
787	611	1970-01-01	Delivered	Apple Pay	2941 First St	1970-01-01	1970-01-01	4509.66	\N	Houston	34671.0
788	724	1970-01-01	Delivered	Google Pay	7114 Park Rd	1970-01-01	1970-01-01	387.71	\N	Los Angeles	63992.0
790	231	1970-01-01	Cancelled	Apple Pay	9896 Park Rd	\N	\N	1880.56	\N	San Jose	49552.0
791	745	1970-01-01	Pending	Credit Card	3957 Park Rd	\N	\N	535.88	\N	Charlotte	31001.0
792	96	1970-01-01	Pending	Debit Card	7792 Park Rd	\N	\N	1341.78	\N	Los Angeles	91691.0
793	470	1970-01-01	Delivered	Debit Card	2481 First St	1970-01-01	1970-01-01	0.00	\N	Columbus	67065.0
794	488	1970-01-01	Cancelled	Debit Card	6966 Park Rd	\N	\N	557.62	\N	Houston	62506.0
795	286	1970-01-01	Delivered	Debit Card	2381 Oak Ave	1970-01-01	1970-01-01	2697.54	\N	Chicago	17780.0
796	540	1970-01-01	Delivered	Google Pay	927 First St	1970-01-01	1970-01-01	90.48	\N	Chicago	88005.0
797	300	1970-01-01	Delivered	Debit Card	2117 Second Ave	1970-01-01	1970-01-01	154.83	\N	Chicago	56076.0
798	620	1970-01-01	Shipped	Google Pay	945 Park Rd	1970-01-01	\N	513.86	\N	San Jose	13578.0
799	157	1970-01-01	Delivered	Google Pay	8510 Oak Ave	1970-01-01	1970-01-01	241.85	\N	San Diego	22021.0
800	145	1970-01-01	Processing	Debit Card	7892 Second Ave	\N	\N	450.69	\N	Philadelphia	18109.0
801	649	1970-01-01	Delivered	Apple Pay	1737 Second Ave	1970-01-01	1970-01-01	0.00	\N	Chicago	30677.0
802	829	1970-01-01	Delivered	Credit Card	6764 First St	1970-01-01	1970-01-01	1119.43	\N	San Jose	93335.0
803	562	1970-01-01	Delivered	Debit Card	3807 Main St	1970-01-01	1970-01-01	0.00	\N	Houston	11967.0
804	523	1970-01-01	Shipped	Google Pay	1137 Second Ave	1970-01-01	\N	526.89	\N	Philadelphia	34886.0
805	239	1970-01-01	Delivered	Google Pay	4385 Park Rd	1970-01-01	1970-01-01	0.00	\N	Phoenix	75179.0
806	19	1970-01-01	Delivered	Debit Card	1204 Main St	1970-01-01	1970-01-01	4833.32	\N	Houston	19287.0
807	254	1970-01-01	Processing	Debit Card	3837 Park Rd	\N	\N	131.64	\N	San Diego	59207.0
808	607	1970-01-01	Processing	Credit Card	2503 Oak Ave	\N	\N	0.00	\N	Fort Worth	79632.0
809	60	1970-01-01	Delivered	Credit Card	1974 Second Ave	1970-01-01	1970-01-01	133.29	\N	Austin	70952.0
810	153	1970-01-01	Delivered	Apple Pay	7270 Main St	1970-01-01	1970-01-01	1788.25	\N	Jacksonville	57749.0
811	689	1970-01-01	Shipped	Apple Pay	3504 Park Rd	1970-01-01	\N	0.00	\N	Chicago	78852.0
812	222	1970-01-01	Pending	Debit Card	8461 First St	\N	\N	81.24	\N	Los Angeles	69432.0
813	576	1970-01-01	Delivered	Apple Pay	1536 Main St	1970-01-01	1970-01-01	940.04	\N	Philadelphia	64651.0
814	249	1970-01-01	Delivered	Apple Pay	254 Oak Ave	1970-01-01	1970-01-01	1483.45	\N	New York	75517.0
815	828	1970-01-01	Shipped	Google Pay	3929 Main St	1970-01-01	\N	186.53	\N	Austin	82623.0
816	462	1970-01-01	Shipped	Apple Pay	6992 Park Rd	1970-01-01	\N	321.63	\N	Dallas	79444.0
817	70	1970-01-01	Delivered	Debit Card	7534 Park Rd	1970-01-01	1970-01-01	0.00	\N	Jacksonville	42951.0
818	760	1970-01-01	Processing	Apple Pay	1568 Park Rd	\N	\N	5328.80	\N	Chicago	79523.0
819	478	1970-01-01	Delivered	Credit Card	4085 Park Rd	1970-01-01	1970-01-01	1948.02	\N	Fort Worth	99337.0
820	120	1970-01-01	Processing	Debit Card	6680 First St	\N	\N	0.00	\N	Columbus	24150.0
821	581	1970-01-01	Cancelled	Apple Pay	8254 First St	\N	\N	249.24	\N	Dallas	89876.0
822	436	1970-01-01	Processing	Debit Card	6506 Second Ave	\N	\N	1133.63	\N	Jacksonville	93105.0
823	682	1970-01-01	Delivered	Debit Card	170 Second Ave	1970-01-01	1970-01-01	10741.20	\N	Chicago	53421.0
824	59	1970-01-01	Delivered	Credit Card	1224 Main St	1970-01-01	1970-01-01	2189.35	\N	Houston	42411.0
825	865	1970-01-01	Shipped	Google Pay	8825 First St	1970-01-01	\N	1494.18	\N	Houston	59054.0
826	287	1970-01-01	Delivered	Apple Pay	4894 Park Rd	1970-01-01	1970-01-01	110.99	\N	Philadelphia	45041.0
827	881	1970-01-01	Cancelled	Apple Pay	9979 Second Ave	\N	\N	171.68	\N	San Jose	61234.0
829	534	1970-01-01	Delivered	Debit Card	5020 Oak Ave	1970-01-01	1970-01-01	1293.64	\N	New York	51275.0
830	787	1970-01-01	Delivered	Google Pay	1140 Park Rd	1970-01-01	1970-01-01	881.44	\N	Dallas	64675.0
831	905	1970-01-01	Delivered	Google Pay	7999 Main St	1970-01-01	1970-01-01	170.76	\N	Columbus	12313.0
832	539	1970-01-01	Shipped	Apple Pay	5093 Second Ave	1970-01-01	\N	0.00	\N	New York	51853.0
833	4	1970-01-01	Delivered	Debit Card	5735 Second Ave	1970-01-01	1970-01-01	50.91	\N	Philadelphia	15695.0
834	896	1970-01-01	Shipped	Google Pay	8859 First St	1970-01-01	\N	460.14	\N	Los Angeles	20169.0
835	149	1970-01-01	Shipped	Google Pay	9849 Main St	1970-01-01	\N	4837.53	\N	Chicago	83259.0
836	524	1970-01-01	Delivered	Debit Card	5376 Main St	1970-01-01	1970-01-01	2736.61	\N	San Antonio	78576.0
837	430	1970-01-01	Delivered	Credit Card	8914 Second Ave	1970-01-01	1970-01-01	835.36	\N	Fort Worth	92173.0
838	13	1970-01-01	Delivered	Debit Card	7223 Oak Ave	1970-01-01	1970-01-01	901.74	\N	Phoenix	10425.0
839	379	1970-01-01	Delivered	Apple Pay	9661 Second Ave	1970-01-01	1970-01-01	314.86	\N	New York	19334.0
840	593	1970-01-01	Delivered	Credit Card	5219 Main St	1970-01-01	1970-01-01	463.66	\N	Dallas	50913.0
841	323	1970-01-01	Delivered	Google Pay	3501 First St	1970-01-01	1970-01-01	5492.90	\N	Philadelphia	70731.0
842	853	1970-01-01	Delivered	Debit Card	3272 Second Ave	1970-01-01	1970-01-01	292.60	\N	San Jose	93540.0
843	998	1970-01-01	Pending	Credit Card	7403 Main St	\N	\N	0.00	\N	Houston	81641.0
844	498	1970-01-01	Delivered	Credit Card	4222 Main St	1970-01-01	1970-01-01	9579.05	\N	Austin	31877.0
845	322	1970-01-01	Shipped	Credit Card	9679 Main St	1970-01-01	\N	7205.19	\N	Fort Worth	23848.0
846	243	1970-01-01	Delivered	Apple Pay	8982 Main St	1970-01-01	1970-01-01	135.22	\N	Charlotte	14433.0
849	722	1970-01-01	Delivered	Google Pay	1013 First St	1970-01-01	1970-01-01	0.00	\N	Dallas	74840.0
850	144	1970-01-01	Delivered	Credit Card	9833 Second Ave	1970-01-01	1970-01-01	314.72	\N	San Jose	70648.0
851	41	1970-01-01	Cancelled	Debit Card	1876 Second Ave	\N	\N	977.93	\N	New York	55309.0
852	529	1970-01-01	Delivered	Google Pay	4175 Second Ave	1970-01-01	1970-01-01	962.95	\N	Dallas	33448.0
853	529	1970-01-01	Processing	Credit Card	4175 Second Ave	\N	\N	1062.63	\N	Dallas	33448.0
854	783	1970-01-01	Delivered	Google Pay	1510 Park Rd	1970-01-01	1970-01-01	297.68	\N	Houston	29420.0
855	363	1970-01-01	Pending	Debit Card	6928 Second Ave	\N	\N	481.91	\N	Phoenix	21703.0
857	487	1970-01-01	Processing	Debit Card	9087 Park Rd	\N	\N	144.16	\N	Chicago	45311.0
858	378	1970-01-01	Shipped	Google Pay	5131 First St	1970-01-01	\N	153.54	\N	Houston	58717.0
859	812	1970-01-01	Processing	Debit Card	6930 Oak Ave	\N	\N	790.44	\N	Jacksonville	76294.0
860	231	1970-01-01	Delivered	Debit Card	9896 Park Rd	1970-01-01	1970-01-01	119.44	\N	San Jose	49552.0
861	180	1970-01-01	Delivered	Debit Card	9476 Park Rd	1970-01-01	1970-01-01	746.14	\N	Dallas	82305.0
862	411	1970-01-01	Pending	Debit Card	5636 Main St	\N	\N	1456.40	\N	Jacksonville	16094.0
863	773	1970-01-01	Processing	Debit Card	3153 First St	\N	\N	757.33	\N	San Jose	65838.0
864	95	1970-01-01	Delivered	Apple Pay	1744 First St	1970-01-01	1970-01-01	365.31	\N	Columbus	78937.0
865	444	1970-01-01	Delivered	Credit Card	9138 Main St	1970-01-01	1970-01-01	1328.93	\N	San Diego	94613.0
866	304	1970-01-01	Delivered	Credit Card	7817 Main St	1970-01-01	1970-01-01	509.73	\N	Fort Worth	86986.0
867	624	1970-01-01	Delivered	Debit Card	9565 Park Rd	1970-01-01	1970-01-01	1032.43	\N	Houston	94182.0
868	704	1970-01-01	Processing	Credit Card	2048 Park Rd	\N	\N	273.62	\N	San Diego	18683.0
870	299	1970-01-01	Delivered	Google Pay	5853 Oak Ave	1970-01-01	1970-01-01	0.00	\N	San Diego	29840.0
871	911	1970-01-01	Pending	Google Pay	2418 Oak Ave	\N	\N	70.38	\N	New York	22027.0
872	398	1970-01-01	Delivered	Google Pay	7009 Oak Ave	1970-01-01	1970-01-01	3239.73	\N	Fort Worth	27368.0
876	659	1970-01-01	Delivered	Google Pay	3281 Park Rd	1970-01-01	1970-01-01	3853.97	\N	San Diego	36504.0
878	508	1970-01-01	Shipped	Apple Pay	1221 Oak Ave	1970-01-01	\N	164.15	\N	Columbus	47957.0
879	286	1970-01-01	Pending	Google Pay	2381 Oak Ave	\N	\N	91.42	\N	Chicago	17780.0
880	562	1970-01-01	Delivered	Apple Pay	3807 Main St	1970-01-01	1970-01-01	337.06	\N	Houston	11967.0
881	948	1970-01-01	Delivered	Credit Card	6512 First St	1970-01-01	1970-01-01	5123.63	\N	Philadelphia	79185.0
883	3	1970-01-01	Delivered	Credit Card	2715 First St	1970-01-01	1970-01-01	1907.57	\N	Fort Worth	46421.0
884	55	1970-01-01	Shipped	Credit Card	9047 Second Ave	1970-01-01	\N	1851.32	\N	Dallas	73993.0
886	672	1970-01-01	Delivered	Debit Card	8066 Second Ave	1970-01-01	1970-01-01	473.23	\N	San Diego	26083.0
887	667	1970-01-01	Delivered	Debit Card	7707 Main St	1970-01-01	1970-01-01	163.52	\N	Austin	19266.0
888	665	1970-01-01	Processing	Apple Pay	5972 Park Rd	\N	\N	17.58	\N	Chicago	94887.0
889	194	1970-01-01	Delivered	Debit Card	4433 Park Rd	1970-01-01	1970-01-01	895.82	\N	Chicago	57964.0
891	965	1970-01-01	Shipped	Credit Card	3256 Park Rd	1970-01-01	\N	0.00	\N	Austin	96155.0
892	236	1970-01-01	Delivered	Apple Pay	3220 Main St	1970-01-01	1970-01-01	6622.15	\N	Jacksonville	59436.0
893	56	1970-01-01	Pending	Debit Card	6724 Oak Ave	\N	\N	0.00	\N	Austin	26728.0
896	470	1970-01-01	Cancelled	Debit Card	2481 First St	\N	\N	2189.61	\N	Columbus	67065.0
898	695	1970-01-01	Shipped	Credit Card	7653 Oak Ave	1970-01-01	\N	289.80	\N	Philadelphia	31405.0
899	954	1970-01-01	Delivered	Google Pay	290 Main St	1970-01-01	1970-01-01	6057.39	\N	Philadelphia	20831.0
901	893	1970-01-01	Processing	Apple Pay	1299 First St	\N	\N	0.00	\N	New York	55043.0
903	303	1970-01-01	Delivered	Apple Pay	297 Park Rd	1970-01-01	1970-01-01	5749.98	\N	Dallas	27299.0
905	237	1970-01-01	Delivered	Google Pay	3522 Park Rd	1970-01-01	1970-01-01	5728.47	\N	San Diego	12009.0
906	934	1970-01-01	Delivered	Credit Card	6001 Main St	1970-01-01	1970-01-01	348.10	\N	New York	98857.0
907	155	1970-01-01	Pending	Apple Pay	6356 Second Ave	\N	\N	355.58	\N	Fort Worth	64874.0
908	791	1970-01-01	Shipped	Apple Pay	8163 Main St	1970-01-01	\N	0.00	\N	San Jose	74713.0
909	740	1970-01-01	Delivered	Debit Card	5234 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	61111.0
910	139	1970-01-01	Delivered	Google Pay	8463 Main St	1970-01-01	1970-01-01	113.39	\N	Los Angeles	76840.0
911	621	1970-01-01	Delivered	Apple Pay	2271 Second Ave	1970-01-01	1970-01-01	135.95	\N	Phoenix	46073.0
912	926	1970-01-01	Processing	Credit Card	8334 Main St	\N	\N	291.17	\N	Chicago	84329.0
913	543	1970-01-01	Cancelled	Credit Card	8689 Oak Ave	\N	\N	419.45	\N	Dallas	19390.0
914	468	1970-01-01	Processing	Google Pay	2362 Main St	\N	\N	6667.68	\N	Jacksonville	68536.0
915	903	1970-01-01	Delivered	Credit Card	1203 Oak Ave	1970-01-01	1970-01-01	241.32	\N	New York	49522.0
916	205	1970-01-01	Delivered	Credit Card	4976 Park Rd	1970-01-01	1970-01-01	51.92	\N	Houston	37168.0
917	991	1970-01-01	Delivered	Apple Pay	2267 First St	1970-01-01	1970-01-01	1485.58	\N	Los Angeles	45895.0
918	25	1970-01-01	Shipped	Debit Card	7554 Park Rd	1970-01-01	\N	775.80	\N	Charlotte	82845.0
919	849	1970-01-01	Delivered	Google Pay	2145 Main St	1970-01-01	1970-01-01	215.36	\N	San Jose	14370.0
920	229	1970-01-01	Shipped	Google Pay	1202 Main St	1970-01-01	\N	157.32	\N	Houston	14400.0
921	715	1970-01-01	Delivered	Apple Pay	7895 Second Ave	1970-01-01	1970-01-01	2188.12	\N	Philadelphia	73508.0
922	777	1970-01-01	Shipped	Debit Card	4275 Second Ave	1970-01-01	\N	2515.13	\N	Philadelphia	75987.0
923	325	1970-01-01	Delivered	Debit Card	4996 Park Rd	1970-01-01	1970-01-01	136.22	\N	New York	14073.0
924	269	1970-01-01	Delivered	Apple Pay	8466 Second Ave	1970-01-01	1970-01-01	478.35	\N	Houston	86089.0
926	641	1970-01-01	Processing	Debit Card	1490 First St	\N	\N	493.98	\N	San Diego	28342.0
927	621	1970-01-01	Delivered	Credit Card	2271 Second Ave	1970-01-01	1970-01-01	1251.64	\N	Phoenix	46073.0
928	168	1970-01-01	Cancelled	Apple Pay	5948 Main St	\N	\N	1837.39	\N	Phoenix	53506.0
929	222	1970-01-01	Delivered	Google Pay	8461 First St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	69432.0
930	754	1970-01-01	Delivered	Apple Pay	4461 Park Rd	1970-01-01	1970-01-01	496.28	\N	Columbus	60079.0
933	264	1970-01-01	Shipped	Credit Card	1965 Second Ave	1970-01-01	\N	252.18	\N	Philadelphia	87624.0
935	996	1970-01-01	Pending	Debit Card	9140 Oak Ave	\N	\N	523.96	\N	Austin	57260.0
937	723	1970-01-01	Delivered	Google Pay	9774 Main St	1970-01-01	1970-01-01	695.56	\N	New York	58026.0
938	687	1970-01-01	Delivered	Apple Pay	6426 Park Rd	1970-01-01	1970-01-01	173.61	\N	Philadelphia	47309.0
939	579	1970-01-01	Delivered	Debit Card	6879 Second Ave	1970-01-01	1970-01-01	231.84	\N	Dallas	37400.0
940	348	1970-01-01	Processing	Apple Pay	2803 Second Ave	\N	\N	0.00	\N	San Antonio	30591.0
941	863	1970-01-01	Delivered	Google Pay	2348 First St	1970-01-01	1970-01-01	1210.12	\N	New York	24544.0
942	363	1970-01-01	Delivered	Apple Pay	6928 Second Ave	1970-01-01	1970-01-01	0.00	\N	Phoenix	21703.0
943	489	1970-01-01	Processing	Apple Pay	1736 Park Rd	\N	\N	770.07	\N	Columbus	82789.0
944	371	1970-01-01	Cancelled	Apple Pay	6268 Park Rd	\N	\N	606.86	\N	San Antonio	43029.0
945	889	1970-01-01	Delivered	Debit Card	4973 First St	1970-01-01	1970-01-01	865.16	\N	Philadelphia	32954.0
946	739	1970-01-01	Delivered	Google Pay	2076 Second Ave	1970-01-01	1970-01-01	133.48	\N	Charlotte	86076.0
947	585	1970-01-01	Delivered	Apple Pay	7874 Main St	1970-01-01	1970-01-01	402.92	\N	Charlotte	27793.0
949	516	1970-01-01	Delivered	Credit Card	2060 First St	1970-01-01	1970-01-01	425.32	\N	San Jose	11170.0
950	380	1970-01-01	Delivered	Google Pay	4988 First St	1970-01-01	1970-01-01	2953.42	\N	Dallas	29762.0
951	268	1970-01-01	Processing	Apple Pay	825 Second Ave	\N	\N	287.44	\N	Austin	98797.0
952	360	1970-01-01	Delivered	Credit Card	7850 Main St	1970-01-01	1970-01-01	287.63	\N	San Jose	46099.0
953	358	1970-01-01	Delivered	Credit Card	4625 Second Ave	1970-01-01	1970-01-01	184.80	\N	Columbus	11620.0
955	196	1970-01-01	Delivered	Google Pay	1684 First St	1970-01-01	1970-01-01	763.42	\N	Chicago	54444.0
956	326	1970-01-01	Delivered	Debit Card	1769 Oak Ave	1970-01-01	1970-01-01	441.11	\N	San Diego	11567.0
957	991	1970-01-01	Processing	Apple Pay	2267 First St	\N	\N	195.47	\N	Los Angeles	45895.0
958	22	1970-01-01	Delivered	Google Pay	3239 Oak Ave	1970-01-01	1970-01-01	639.65	\N	Houston	68800.0
959	643	1970-01-01	Delivered	Credit Card	5633 Main St	1970-01-01	1970-01-01	478.20	\N	New York	25491.0
960	470	1970-01-01	Delivered	Google Pay	2481 First St	1970-01-01	1970-01-01	985.43	\N	Columbus	67065.0
961	117	1970-01-01	Shipped	Apple Pay	522 Oak Ave	1970-01-01	\N	0.00	\N	Austin	56955.0
962	988	1970-01-01	Delivered	Google Pay	5705 First St	1970-01-01	1970-01-01	361.92	\N	New York	11052.0
964	736	1970-01-01	Delivered	Credit Card	8052 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Diego	65314.0
965	225	1970-01-01	Shipped	Apple Pay	6987 Park Rd	1970-01-01	\N	468.85	\N	Fort Worth	68790.0
966	103	1970-01-01	Delivered	Debit Card	4947 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Jose	96275.0
967	820	1970-01-01	Delivered	Google Pay	2128 Second Ave	1970-01-01	1970-01-01	509.60	\N	Dallas	35221.0
968	136	1970-01-01	Processing	Credit Card	7632 Main St	\N	\N	212.55	\N	New York	85465.0
969	981	1970-01-01	Delivered	Google Pay	5898 Main St	1970-01-01	1970-01-01	2794.50	\N	Phoenix	55838.0
970	653	1970-01-01	Delivered	Apple Pay	3692 First St	1970-01-01	1970-01-01	53.11	\N	Dallas	96419.0
971	449	1970-01-01	Delivered	Apple Pay	762 Oak Ave	1970-01-01	1970-01-01	3045.77	\N	Philadelphia	40375.0
972	279	1970-01-01	Delivered	Apple Pay	6386 First St	1970-01-01	1970-01-01	3579.78	\N	San Jose	73788.0
974	225	1970-01-01	Delivered	Credit Card	6987 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	68790.0
975	121	1970-01-01	Delivered	Credit Card	2167 Park Rd	1970-01-01	1970-01-01	28.24	\N	Los Angeles	92978.0
976	554	1970-01-01	Delivered	Debit Card	4321 First St	1970-01-01	1970-01-01	1053.46	\N	Austin	82737.0
977	542	1970-01-01	Shipped	Google Pay	7218 Oak Ave	1970-01-01	\N	472.32	\N	Dallas	73035.0
978	338	1970-01-01	Shipped	Apple Pay	3007 Park Rd	1970-01-01	\N	85.20	\N	Philadelphia	12872.0
979	767	1970-01-01	Processing	Apple Pay	6220 Second Ave	\N	\N	189.87	\N	San Antonio	52406.0
980	616	1970-01-01	Delivered	Apple Pay	7989 Main St	1970-01-01	1970-01-01	2284.70	\N	San Jose	78997.0
981	570	1970-01-01	Shipped	Google Pay	8682 First St	1970-01-01	\N	3674.78	\N	Los Angeles	90225.0
982	60	1970-01-01	Delivered	Google Pay	1974 Second Ave	1970-01-01	1970-01-01	317.37	\N	Austin	70952.0
984	425	1970-01-01	Pending	Apple Pay	5307 Second Ave	\N	\N	609.21	\N	Los Angeles	34100.0
985	452	1970-01-01	Delivered	Credit Card	4221 First St	1970-01-01	1970-01-01	613.99	\N	Dallas	77681.0
986	501	1970-01-01	Delivered	Debit Card	5946 Park Rd	1970-01-01	1970-01-01	5060.27	\N	Austin	71235.0
989	672	1970-01-01	Pending	Google Pay	8066 Second Ave	\N	\N	50.36	\N	San Diego	26083.0
990	878	1970-01-01	Shipped	Google Pay	7659 Park Rd	1970-01-01	\N	4144.80	\N	Jacksonville	51035.0
991	757	1970-01-01	Shipped	Apple Pay	6613 Oak Ave	1970-01-01	\N	0.00	\N	Jacksonville	60265.0
992	175	1970-01-01	Cancelled	Apple Pay	2355 Second Ave	\N	\N	582.03	\N	San Jose	62171.0
993	669	1970-01-01	Shipped	Apple Pay	944 Main St	1970-01-01	\N	128.82	\N	Charlotte	57918.0
994	118	1970-01-01	Delivered	Google Pay	6997 Second Ave	1970-01-01	1970-01-01	282.39	\N	Chicago	18330.0
995	288	1970-01-01	Processing	Credit Card	1071 Park Rd	\N	\N	0.00	\N	Charlotte	26631.0
996	65	1970-01-01	Cancelled	Credit Card	9807 Park Rd	\N	\N	0.00	\N	Columbus	42177.0
998	687	1970-01-01	Delivered	Debit Card	6426 Park Rd	1970-01-01	1970-01-01	3310.00	\N	Philadelphia	47309.0
999	920	1970-01-01	Delivered	Credit Card	7927 Main St	1970-01-01	1970-01-01	767.10	\N	Houston	92700.0
1000	943	1970-01-01	Shipped	Apple Pay	2169 Second Ave	1970-01-01	\N	7974.81	\N	Fort Worth	88855.0
1001	178	1970-01-01	Pending	Debit Card	5792 Main St	\N	\N	688.85	\N	Austin	81063.0
1005	819	1970-01-01	Processing	Credit Card	7359 Park Rd	\N	\N	0.00	\N	New York	21603.0
1008	423	1970-01-01	Delivered	Credit Card	7120 Park Rd	1970-01-01	1970-01-01	65.96	\N	New York	44634.0
1009	182	1970-01-01	Delivered	Credit Card	2202 Second Ave	1970-01-01	1970-01-01	1157.43	\N	Philadelphia	87042.0
1011	488	1970-01-01	Delivered	Credit Card	6966 Park Rd	1970-01-01	1970-01-01	3721.82	\N	Houston	62506.0
1012	588	1970-01-01	Delivered	Apple Pay	6482 Oak Ave	1970-01-01	1970-01-01	1867.67	\N	San Jose	25315.0
1014	589	1970-01-01	Delivered	Credit Card	3993 Park Rd	1970-01-01	1970-01-01	89.26	\N	Charlotte	49666.0
1015	567	1970-01-01	Delivered	Apple Pay	993 Second Ave	1970-01-01	1970-01-01	223.26	\N	San Jose	70762.0
1016	732	1970-01-01	Delivered	Google Pay	404 Second Ave	1970-01-01	1970-01-01	691.90	\N	Chicago	85608.0
1017	374	1970-01-01	Delivered	Google Pay	2556 Second Ave	1970-01-01	1970-01-01	0.00	\N	Houston	17441.0
1019	62	1970-01-01	Delivered	Credit Card	9800 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Los Angeles	49529.0
1020	780	1970-01-01	Delivered	Credit Card	317 Oak Ave	1970-01-01	1970-01-01	945.14	\N	Los Angeles	72537.0
1021	593	1970-01-01	Processing	Debit Card	5219 Main St	\N	\N	494.89	\N	Dallas	50913.0
1022	881	1970-01-01	Delivered	Apple Pay	9979 Second Ave	1970-01-01	1970-01-01	1000.83	\N	San Jose	61234.0
1023	673	1970-01-01	Shipped	Credit Card	1175 Oak Ave	1970-01-01	\N	893.47	\N	Fort Worth	21443.0
1024	825	1970-01-01	Processing	Apple Pay	5429 Oak Ave	\N	\N	119.55	\N	New York	17667.0
1025	185	1970-01-01	Delivered	Debit Card	9613 Oak Ave	1970-01-01	1970-01-01	122.54	\N	San Jose	96341.0
1026	120	1970-01-01	Delivered	Apple Pay	6680 First St	1970-01-01	1970-01-01	1584.55	\N	Columbus	24150.0
1027	445	1970-01-01	Delivered	Debit Card	1352 Main St	1970-01-01	1970-01-01	215.19	\N	Jacksonville	76476.0
1029	266	1970-01-01	Processing	Apple Pay	7032 First St	\N	\N	289.57	\N	Jacksonville	68860.0
1030	55	1970-01-01	Pending	Google Pay	9047 Second Ave	\N	\N	880.05	\N	Dallas	73993.0
1031	199	1970-01-01	Delivered	Debit Card	8125 Second Ave	1970-01-01	1970-01-01	0.00	\N	Dallas	72245.0
1032	592	1970-01-01	Delivered	Debit Card	8658 Main St	1970-01-01	1970-01-01	946.46	\N	San Antonio	50760.0
1033	263	1970-01-01	Shipped	Apple Pay	3010 First St	1970-01-01	\N	3295.74	\N	Philadelphia	48200.0
1034	179	1970-01-01	Delivered	Google Pay	6022 Second Ave	1970-01-01	1970-01-01	85.35	\N	Fort Worth	25907.0
1035	462	1970-01-01	Delivered	Credit Card	6992 Park Rd	1970-01-01	1970-01-01	410.82	\N	Dallas	79444.0
1036	370	1970-01-01	Delivered	Credit Card	2267 Oak Ave	1970-01-01	1970-01-01	87.10	\N	San Diego	11109.0
1037	573	1970-01-01	Delivered	Apple Pay	7614 First St	1970-01-01	1970-01-01	133.64	\N	New York	81237.0
1038	513	1970-01-01	Delivered	Apple Pay	7357 Oak Ave	1970-01-01	1970-01-01	1017.29	\N	San Antonio	36106.0
1039	795	1970-01-01	Delivered	Google Pay	1769 Second Ave	1970-01-01	1970-01-01	295.43	\N	Los Angeles	76493.0
1040	990	1970-01-01	Pending	Debit Card	7864 Main St	\N	\N	12.08	\N	Houston	75841.0
1041	256	1970-01-01	Delivered	Apple Pay	1599 Main St	1970-01-01	1970-01-01	1244.96	\N	Los Angeles	68292.0
1042	461	1970-01-01	Delivered	Apple Pay	8806 Second Ave	1970-01-01	1970-01-01	9476.47	\N	Charlotte	22214.0
1043	413	1970-01-01	Delivered	Apple Pay	9579 Oak Ave	1970-01-01	1970-01-01	112.60	\N	Jacksonville	23573.0
1044	359	1970-01-01	Delivered	Debit Card	1830 Second Ave	1970-01-01	1970-01-01	155.87	\N	Charlotte	47498.0
1045	329	1970-01-01	Pending	Apple Pay	583 First St	\N	\N	2288.25	\N	San Diego	65923.0
1046	897	1970-01-01	Delivered	Debit Card	664 Second Ave	1970-01-01	1970-01-01	4807.07	\N	Jacksonville	67941.0
1047	11	1970-01-01	Shipped	Apple Pay	1896 Oak Ave	1970-01-01	\N	0.00	\N	Columbus	30969.0
1048	569	1970-01-01	Delivered	Apple Pay	4197 Park Rd	1970-01-01	1970-01-01	99.56	\N	Los Angeles	95010.0
1049	916	1970-01-01	Delivered	Apple Pay	4740 First St	1970-01-01	1970-01-01	103.94	\N	San Diego	89432.0
1050	920	1970-01-01	Processing	Debit Card	7927 Main St	\N	\N	207.88	\N	Houston	92700.0
1052	676	1970-01-01	Delivered	Google Pay	8613 Park Rd	1970-01-01	1970-01-01	326.84	\N	Columbus	85851.0
1053	680	1970-01-01	Cancelled	Credit Card	4366 Park Rd	\N	\N	245.62	\N	San Diego	36890.0
1054	391	1970-01-01	Pending	Apple Pay	2028 Park Rd	\N	\N	9755.04	\N	Dallas	23928.0
1055	943	1970-01-01	Delivered	Apple Pay	2169 Second Ave	1970-01-01	1970-01-01	297.68	\N	Fort Worth	88855.0
1056	433	1970-01-01	Processing	Credit Card	6726 First St	\N	\N	116.74	\N	San Diego	12213.0
1057	514	1970-01-01	Delivered	Credit Card	5213 Park Rd	1970-01-01	1970-01-01	151.89	\N	Austin	92465.0
1059	550	1970-01-01	Delivered	Debit Card	7717 Main St	1970-01-01	1970-01-01	74.77	\N	New York	60940.0
1060	670	1970-01-01	Processing	Debit Card	3454 Oak Ave	\N	\N	474.16	\N	Dallas	41278.0
1061	145	1970-01-01	Shipped	Debit Card	7892 Second Ave	1970-01-01	\N	255.12	\N	Philadelphia	18109.0
1062	931	1970-01-01	Delivered	Debit Card	4025 Park Rd	1970-01-01	1970-01-01	852.15	\N	Philadelphia	62228.0
1063	250	1970-01-01	Delivered	Apple Pay	3563 Second Ave	1970-01-01	1970-01-01	966.44	\N	Houston	45532.0
1064	263	1970-01-01	Delivered	Google Pay	3010 First St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	48200.0
1065	474	1970-01-01	Cancelled	Debit Card	6644 Park Rd	\N	\N	2448.40	\N	Phoenix	61792.0
1066	769	1970-01-01	Cancelled	Google Pay	897 Park Rd	\N	\N	3686.92	\N	Houston	17279.0
1067	853	1970-01-01	Delivered	Google Pay	3272 Second Ave	1970-01-01	1970-01-01	1585.84	\N	San Jose	93540.0
1069	17	1970-01-01	Delivered	Credit Card	8935 Oak Ave	1970-01-01	1970-01-01	7898.79	\N	Houston	50857.0
1071	971	1970-01-01	Delivered	Debit Card	2190 Park Rd	1970-01-01	1970-01-01	440.17	\N	San Jose	77314.0
1072	647	1970-01-01	Shipped	Credit Card	2079 Second Ave	1970-01-01	\N	3024.10	\N	Philadelphia	28000.0
1073	319	1970-01-01	Delivered	Apple Pay	4684 Main St	1970-01-01	1970-01-01	106.01	\N	Jacksonville	40339.0
1074	562	1970-01-01	Delivered	Apple Pay	3807 Main St	1970-01-01	1970-01-01	817.61	\N	Houston	11967.0
1075	842	1970-01-01	Delivered	Debit Card	4353 Second Ave	1970-01-01	1970-01-01	507.30	\N	Chicago	78561.0
1076	690	1970-01-01	Delivered	Debit Card	4578 First St	1970-01-01	1970-01-01	143.72	\N	San Antonio	82851.0
1077	779	1970-01-01	Shipped	Google Pay	3166 Oak Ave	1970-01-01	\N	1207.23	\N	Philadelphia	20252.0
1078	728	1970-01-01	Delivered	Credit Card	5007 Park Rd	1970-01-01	1970-01-01	626.20	\N	Chicago	36444.0
1079	612	1970-01-01	Delivered	Google Pay	2156 Oak Ave	1970-01-01	1970-01-01	47.60	\N	Columbus	19403.0
1080	471	1970-01-01	Delivered	Apple Pay	6396 First St	1970-01-01	1970-01-01	474.57	\N	Jacksonville	96006.0
1081	227	1970-01-01	Delivered	Debit Card	472 Park Rd	1970-01-01	1970-01-01	441.89	\N	Fort Worth	98276.0
1082	216	1970-01-01	Delivered	Google Pay	4164 Main St	1970-01-01	1970-01-01	3589.91	\N	Charlotte	60275.0
1083	546	1970-01-01	Delivered	Debit Card	6224 Oak Ave	1970-01-01	1970-01-01	59.37	\N	Austin	24728.0
1084	178	1970-01-01	Delivered	Credit Card	5792 Main St	1970-01-01	1970-01-01	0.00	\N	Austin	81063.0
1085	536	1970-01-01	Delivered	Credit Card	5020 Main St	1970-01-01	1970-01-01	143.30	\N	Phoenix	62402.0
1086	925	1970-01-01	Processing	Apple Pay	6929 Park Rd	\N	\N	179.08	\N	Dallas	32365.0
1087	605	1970-01-01	Delivered	Credit Card	9802 Second Ave	1970-01-01	1970-01-01	3645.58	\N	Los Angeles	52647.0
1090	921	1970-01-01	Processing	Google Pay	4153 Second Ave	\N	\N	58.13	\N	Phoenix	96848.0
1091	293	1970-01-01	Delivered	Credit Card	1731 First St	1970-01-01	1970-01-01	540.10	\N	New York	26284.0
1092	290	1970-01-01	Delivered	Google Pay	8547 Park Rd	1970-01-01	1970-01-01	304.03	\N	San Antonio	58374.0
1094	837	1970-01-01	Delivered	Google Pay	2122 Park Rd	1970-01-01	1970-01-01	323.92	\N	Austin	88815.0
1095	616	1970-01-01	Cancelled	Google Pay	7989 Main St	\N	\N	846.95	\N	San Jose	78997.0
1096	79	1970-01-01	Shipped	Apple Pay	7538 Main St	1970-01-01	\N	154.24	\N	Jacksonville	40595.0
1097	695	1970-01-01	Delivered	Google Pay	7653 Oak Ave	1970-01-01	1970-01-01	741.63	\N	Philadelphia	31405.0
1098	278	1970-01-01	Delivered	Google Pay	4008 Park Rd	1970-01-01	1970-01-01	197.22	\N	Los Angeles	33992.0
1099	813	1970-01-01	Delivered	Google Pay	3583 First St	1970-01-01	1970-01-01	1360.31	\N	Los Angeles	14273.0
1100	437	1970-01-01	Processing	Apple Pay	784 Main St	\N	\N	1971.62	\N	Los Angeles	88204.0
1101	439	1970-01-01	Shipped	Debit Card	1977 Oak Ave	1970-01-01	\N	0.00	\N	Houston	84356.0
1102	926	1970-01-01	Delivered	Credit Card	8334 Main St	1970-01-01	1970-01-01	820.56	\N	Chicago	84329.0
1103	315	1970-01-01	Delivered	Debit Card	1229 First St	1970-01-01	1970-01-01	193.28	\N	San Antonio	50723.0
1104	553	1970-01-01	Delivered	Google Pay	2672 Main St	1970-01-01	1970-01-01	1756.41	\N	Jacksonville	99694.0
1105	877	1970-01-01	Shipped	Debit Card	8499 Oak Ave	1970-01-01	\N	428.02	\N	San Diego	39829.0
1106	437	1970-01-01	Delivered	Google Pay	784 Main St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	88204.0
1107	31	1970-01-01	Pending	Debit Card	4769 Oak Ave	\N	\N	412.01	\N	Philadelphia	81200.0
1108	471	1970-01-01	Shipped	Google Pay	6396 First St	1970-01-01	\N	141.71	\N	Jacksonville	96006.0
1109	449	1970-01-01	Delivered	Google Pay	762 Oak Ave	1970-01-01	1970-01-01	3478.90	\N	Philadelphia	40375.0
1110	666	1970-01-01	Shipped	Credit Card	9445 Second Ave	1970-01-01	\N	517.46	\N	Columbus	69616.0
1111	928	1970-01-01	Pending	Debit Card	1152 Park Rd	\N	\N	0.00	\N	Phoenix	86761.0
1112	783	1970-01-01	Delivered	Google Pay	1510 Park Rd	1970-01-01	1970-01-01	118.83	\N	Houston	29420.0
1113	581	1970-01-01	Delivered	Credit Card	8254 First St	1970-01-01	1970-01-01	65.55	\N	Dallas	89876.0
1114	274	1970-01-01	Delivered	Google Pay	7180 First St	1970-01-01	1970-01-01	1396.81	\N	Chicago	90492.0
1115	680	1970-01-01	Delivered	Google Pay	4366 Park Rd	1970-01-01	1970-01-01	125.55	\N	San Diego	36890.0
1116	401	1970-01-01	Delivered	Apple Pay	8670 Second Ave	1970-01-01	1970-01-01	2799.98	\N	Dallas	66734.0
1117	714	1970-01-01	Shipped	Debit Card	6723 Main St	1970-01-01	\N	708.12	\N	San Jose	65666.0
1118	158	1970-01-01	Delivered	Credit Card	8324 Park Rd	1970-01-01	1970-01-01	1003.50	\N	San Antonio	60615.0
1119	130	1970-01-01	Delivered	Apple Pay	2678 Park Rd	1970-01-01	1970-01-01	2665.08	\N	Philadelphia	52517.0
1120	428	1970-01-01	Delivered	Debit Card	5358 First St	1970-01-01	1970-01-01	996.40	\N	New York	60577.0
1121	733	1970-01-01	Delivered	Google Pay	9375 Main St	1970-01-01	1970-01-01	80.64	\N	Charlotte	36299.0
1122	749	1970-01-01	Delivered	Credit Card	2231 Second Ave	1970-01-01	1970-01-01	1196.86	\N	Dallas	63780.0
1123	285	1970-01-01	Delivered	Apple Pay	1525 First St	1970-01-01	1970-01-01	343.51	\N	Philadelphia	41056.0
1125	459	1970-01-01	Cancelled	Google Pay	7529 Second Ave	\N	\N	817.78	\N	Charlotte	19023.0
1126	877	1970-01-01	Delivered	Credit Card	8499 Oak Ave	1970-01-01	1970-01-01	139.44	\N	San Diego	39829.0
1127	176	1970-01-01	Delivered	Apple Pay	8582 First St	1970-01-01	1970-01-01	330.39	\N	San Diego	25435.0
1128	306	1970-01-01	Shipped	Credit Card	5177 Main St	1970-01-01	\N	497.68	\N	Los Angeles	36633.0
1129	867	1970-01-01	Delivered	Credit Card	8111 Oak Ave	1970-01-01	1970-01-01	3578.20	\N	San Jose	71691.0
1130	438	1970-01-01	Processing	Debit Card	5733 Oak Ave	\N	\N	56.58	\N	Jacksonville	94663.0
1131	586	1970-01-01	Pending	Apple Pay	6882 Main St	\N	\N	0.00	\N	San Diego	49235.0
1132	269	1970-01-01	Delivered	Google Pay	8466 Second Ave	1970-01-01	1970-01-01	98.94	\N	Houston	86089.0
1133	54	1970-01-01	Delivered	Google Pay	9669 Main St	1970-01-01	1970-01-01	268.79	\N	San Antonio	59857.0
1134	957	1970-01-01	Pending	Google Pay	8601 Second Ave	\N	\N	3391.02	\N	Los Angeles	95419.0
1135	958	1970-01-01	Shipped	Google Pay	9188 First St	1970-01-01	\N	48.92	\N	New York	26127.0
1136	256	1970-01-01	Shipped	Apple Pay	1599 Main St	1970-01-01	\N	0.00	\N	Los Angeles	68292.0
1137	174	1970-01-01	Delivered	Apple Pay	6372 Second Ave	1970-01-01	1970-01-01	253.71	\N	Philadelphia	89310.0
1138	640	1970-01-01	Delivered	Credit Card	9184 Main St	1970-01-01	1970-01-01	10559.63	\N	Chicago	96603.0
1139	262	1970-01-01	Shipped	Google Pay	5584 First St	1970-01-01	\N	241.51	\N	San Diego	87908.0
1140	32	1970-01-01	Delivered	Apple Pay	1797 Oak Ave	1970-01-01	1970-01-01	125.13	\N	Charlotte	25129.0
1141	389	1970-01-01	Cancelled	Apple Pay	6330 Main St	\N	\N	269.72	\N	San Diego	43126.0
1142	249	1970-01-01	Processing	Credit Card	254 Oak Ave	\N	\N	1275.60	\N	New York	75517.0
1144	38	1970-01-01	Delivered	Apple Pay	4165 Park Rd	1970-01-01	1970-01-01	15685.27	\N	Fort Worth	24168.0
1145	546	1970-01-01	Delivered	Credit Card	6224 Oak Ave	1970-01-01	1970-01-01	655.13	\N	Austin	24728.0
1147	690	1970-01-01	Delivered	Google Pay	4578 First St	1970-01-01	1970-01-01	1458.82	\N	San Antonio	82851.0
1148	222	1970-01-01	Delivered	Credit Card	8461 First St	1970-01-01	1970-01-01	1223.21	\N	Los Angeles	69432.0
1149	56	1970-01-01	Cancelled	Google Pay	6724 Oak Ave	\N	\N	1158.72	\N	Austin	26728.0
1150	99	1970-01-01	Delivered	Debit Card	7156 Oak Ave	1970-01-01	1970-01-01	171.44	\N	Philadelphia	79621.0
1151	1000	1970-01-01	Delivered	Google Pay	7245 Main St	1970-01-01	1970-01-01	2618.10	\N	Charlotte	64919.0
1152	616	1970-01-01	Cancelled	Credit Card	7989 Main St	\N	\N	297.22	\N	San Jose	78997.0
1153	851	1970-01-01	Delivered	Credit Card	1670 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Antonio	40554.0
1154	851	1970-01-01	Delivered	Apple Pay	1670 Second Ave	1970-01-01	1970-01-01	3201.70	\N	San Antonio	40554.0
1155	336	1970-01-01	Shipped	Credit Card	9334 Oak Ave	1970-01-01	\N	1553.07	\N	San Jose	34672.0
1156	339	1970-01-01	Delivered	Debit Card	6078 Main St	1970-01-01	1970-01-01	323.09	\N	Columbus	96787.0
1157	359	1970-01-01	Processing	Google Pay	1830 Second Ave	\N	\N	1092.45	\N	Charlotte	47498.0
1158	473	1970-01-01	Delivered	Debit Card	3895 Second Ave	1970-01-01	1970-01-01	204.06	\N	Dallas	98345.0
1159	555	1970-01-01	Processing	Apple Pay	6362 Second Ave	\N	\N	595.88	\N	Los Angeles	90274.0
1160	590	1970-01-01	Delivered	Credit Card	3411 Main St	1970-01-01	1970-01-01	969.53	\N	Fort Worth	76321.0
1161	774	1970-01-01	Delivered	Debit Card	2640 First St	1970-01-01	1970-01-01	64.39	\N	Austin	92517.0
1163	862	1970-01-01	Delivered	Apple Pay	2955 Park Rd	1970-01-01	1970-01-01	1266.76	\N	Jacksonville	42239.0
1164	293	1970-01-01	Processing	Google Pay	1731 First St	\N	\N	1719.72	\N	New York	26284.0
1166	677	1970-01-01	Delivered	Credit Card	9086 First St	1970-01-01	1970-01-01	1050.81	\N	Columbus	49856.0
1167	335	1970-01-01	Processing	Apple Pay	2946 Oak Ave	\N	\N	759.61	\N	Philadelphia	87662.0
1169	597	1970-01-01	Delivered	Debit Card	926 Main St	1970-01-01	1970-01-01	656.25	\N	Charlotte	17051.0
1170	807	1970-01-01	Delivered	Google Pay	4981 Second Ave	1970-01-01	1970-01-01	231.95	\N	San Diego	69394.0
1172	1000	1970-01-01	Processing	Apple Pay	7245 Main St	\N	\N	5105.66	\N	Charlotte	64919.0
1173	682	1970-01-01	Delivered	Debit Card	170 Second Ave	1970-01-01	1970-01-01	1700.80	\N	Chicago	53421.0
1174	860	1970-01-01	Shipped	Debit Card	3118 Main St	1970-01-01	\N	419.67	\N	San Antonio	11296.0
1175	42	1970-01-01	Processing	Apple Pay	827 First St	\N	\N	187.38	\N	Phoenix	78146.0
1178	845	1970-01-01	Delivered	Credit Card	5281 Main St	1970-01-01	1970-01-01	5312.27	\N	San Diego	35507.0
1179	508	1970-01-01	Delivered	Debit Card	1221 Oak Ave	1970-01-01	1970-01-01	4094.73	\N	Columbus	47957.0
1180	373	1970-01-01	Delivered	Credit Card	1145 Park Rd	1970-01-01	1970-01-01	316.51	\N	San Diego	93964.0
1181	24	1970-01-01	Shipped	Credit Card	6758 First St	1970-01-01	\N	456.94	\N	Chicago	38016.0
1182	467	1970-01-01	Delivered	Google Pay	6165 Second Ave	1970-01-01	1970-01-01	0.00	\N	Chicago	73407.0
1183	336	1970-01-01	Shipped	Apple Pay	9334 Oak Ave	1970-01-01	\N	279.78	\N	San Jose	34672.0
1184	116	1970-01-01	Delivered	Credit Card	2517 Second Ave	1970-01-01	1970-01-01	254.39	\N	Philadelphia	46342.0
1186	566	1970-01-01	Delivered	Google Pay	907 Oak Ave	1970-01-01	1970-01-01	811.54	\N	Dallas	67613.0
1188	655	1970-01-01	Delivered	Google Pay	7524 Main St	1970-01-01	1970-01-01	881.23	\N	Philadelphia	16875.0
1189	618	1970-01-01	Delivered	Google Pay	276 First St	1970-01-01	1970-01-01	251.80	\N	Fort Worth	77195.0
1190	449	1970-01-01	Delivered	Debit Card	762 Oak Ave	1970-01-01	1970-01-01	309.24	\N	Philadelphia	40375.0
1191	967	1970-01-01	Shipped	Credit Card	1180 Park Rd	1970-01-01	\N	441.52	\N	San Antonio	21662.0
1192	553	1970-01-01	Delivered	Google Pay	2672 Main St	1970-01-01	1970-01-01	340.13	\N	Jacksonville	99694.0
1193	761	1970-01-01	Cancelled	Debit Card	4703 Park Rd	\N	\N	2188.12	\N	San Diego	47083.0
1194	684	1970-01-01	Delivered	Credit Card	6680 Second Ave	1970-01-01	1970-01-01	1823.44	\N	New York	68454.0
1195	190	1970-01-01	Shipped	Debit Card	7466 Oak Ave	1970-01-01	\N	613.01	\N	Phoenix	22689.0
1196	499	1970-01-01	Delivered	Apple Pay	531 First St	1970-01-01	1970-01-01	140.80	\N	New York	20911.0
1201	977	1970-01-01	Delivered	Apple Pay	8752 Second Ave	1970-01-01	1970-01-01	121.80	\N	Houston	89609.0
1203	605	1970-01-01	Delivered	Google Pay	9802 Second Ave	1970-01-01	1970-01-01	6512.87	\N	Los Angeles	52647.0
1207	250	1970-01-01	Processing	Apple Pay	3563 Second Ave	\N	\N	0.00	\N	Houston	45532.0
1208	206	1970-01-01	Delivered	Apple Pay	2096 Second Ave	1970-01-01	1970-01-01	2222.89	\N	Phoenix	81197.0
1209	869	1970-01-01	Delivered	Apple Pay	4496 Second Ave	1970-01-01	1970-01-01	788.46	\N	San Diego	93637.0
1210	952	1970-01-01	Shipped	Credit Card	5645 Second Ave	1970-01-01	\N	469.56	\N	Austin	29473.0
1212	498	1970-01-01	Processing	Apple Pay	4222 Main St	\N	\N	771.72	\N	Austin	31877.0
1213	225	1970-01-01	Delivered	Google Pay	6987 Park Rd	1970-01-01	1970-01-01	3708.14	\N	Fort Worth	68790.0
1214	262	1970-01-01	Delivered	Credit Card	5584 First St	1970-01-01	1970-01-01	1413.30	\N	San Diego	87908.0
1215	321	1970-01-01	Delivered	Google Pay	5261 First St	1970-01-01	1970-01-01	1870.24	\N	Phoenix	52762.0
1217	506	1970-01-01	Delivered	Debit Card	6845 Second Ave	1970-01-01	1970-01-01	606.74	\N	Houston	61740.0
1218	460	1970-01-01	Delivered	Google Pay	8363 First St	1970-01-01	1970-01-01	579.54	\N	Dallas	89365.0
1220	940	1970-01-01	Delivered	Credit Card	5723 First St	1970-01-01	1970-01-01	212.44	\N	Austin	95710.0
1222	42	1970-01-01	Delivered	Credit Card	827 First St	1970-01-01	1970-01-01	795.82	\N	Phoenix	78146.0
1223	916	1970-01-01	Shipped	Credit Card	4740 First St	1970-01-01	\N	100.84	\N	San Diego	89432.0
1224	420	1970-01-01	Delivered	Debit Card	8470 Park Rd	1970-01-01	1970-01-01	1820.37	\N	Houston	97096.0
1225	504	1970-01-01	Cancelled	Google Pay	272 Main St	\N	\N	420.34	\N	Phoenix	27865.0
1226	227	1970-01-01	Delivered	Credit Card	472 Park Rd	1970-01-01	1970-01-01	18.12	\N	Fort Worth	98276.0
1227	38	1970-01-01	Shipped	Credit Card	4165 Park Rd	1970-01-01	\N	2765.61	\N	Fort Worth	24168.0
1228	328	1970-01-01	Delivered	Google Pay	5532 Main St	1970-01-01	1970-01-01	433.06	\N	Los Angeles	70423.0
1230	754	1970-01-01	Delivered	Credit Card	4461 Park Rd	1970-01-01	1970-01-01	0.00	\N	Columbus	60079.0
1231	940	1970-01-01	Pending	Apple Pay	5723 First St	\N	\N	450.35	\N	Austin	95710.0
1232	622	1970-01-01	Cancelled	Google Pay	7417 Park Rd	\N	\N	653.91	\N	Austin	44242.0
1233	559	1970-01-01	Cancelled	Credit Card	7358 Park Rd	\N	\N	5699.08	\N	Phoenix	34632.0
1234	564	1970-01-01	Delivered	Credit Card	6332 Park Rd	1970-01-01	1970-01-01	885.66	\N	San Jose	90151.0
1235	514	1970-01-01	Delivered	Apple Pay	5213 Park Rd	1970-01-01	1970-01-01	26.57	\N	Austin	92465.0
1240	306	1970-01-01	Delivered	Google Pay	5177 Main St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	36633.0
1242	16	1970-01-01	Processing	Credit Card	8062 Main St	\N	\N	12324.77	\N	Los Angeles	26483.0
1243	19	1970-01-01	Cancelled	Google Pay	1204 Main St	\N	\N	1352.61	\N	Houston	19287.0
1244	664	1970-01-01	Pending	Credit Card	1705 First St	\N	\N	9171.44	\N	San Diego	41524.0
1245	929	1970-01-01	Delivered	Credit Card	4459 Main St	1970-01-01	1970-01-01	236.30	\N	New York	86342.0
1246	235	1970-01-01	Delivered	Credit Card	6463 Oak Ave	1970-01-01	1970-01-01	209.76	\N	Chicago	36651.0
1248	360	1970-01-01	Delivered	Debit Card	7850 Main St	1970-01-01	1970-01-01	0.00	\N	San Jose	46099.0
1250	229	1970-01-01	Pending	Apple Pay	1202 Main St	\N	\N	217.50	\N	Houston	14400.0
1253	83	1970-01-01	Processing	Debit Card	4515 Second Ave	\N	\N	240.16	\N	Fort Worth	32962.0
1254	691	1970-01-01	Delivered	Debit Card	9174 First St	1970-01-01	1970-01-01	52.41	\N	Phoenix	49582.0
1255	180	1970-01-01	Processing	Google Pay	9476 Park Rd	\N	\N	573.33	\N	Dallas	82305.0
1256	314	1970-01-01	Shipped	Debit Card	1376 Second Ave	1970-01-01	\N	892.58	\N	Columbus	25650.0
1258	393	1970-01-01	Delivered	Credit Card	3942 Main St	1970-01-01	1970-01-01	106.12	\N	Philadelphia	98032.0
1259	882	1970-01-01	Pending	Apple Pay	1879 Park Rd	\N	\N	929.16	\N	San Diego	69183.0
1260	892	1970-01-01	Delivered	Credit Card	1823 Second Ave	1970-01-01	1970-01-01	1871.35	\N	Los Angeles	63752.0
1261	713	1970-01-01	Delivered	Apple Pay	2448 First St	1970-01-01	1970-01-01	592.91	\N	Los Angeles	87405.0
1262	184	1970-01-01	Shipped	Debit Card	3316 Second Ave	1970-01-01	\N	450.76	\N	Phoenix	26406.0
1263	864	1970-01-01	Processing	Apple Pay	2907 Second Ave	\N	\N	816.82	\N	Austin	66848.0
1264	19	1970-01-01	Shipped	Google Pay	1204 Main St	1970-01-01	\N	0.00	\N	Houston	19287.0
1266	527	1970-01-01	Delivered	Google Pay	1094 Park Rd	1970-01-01	1970-01-01	356.16	\N	Fort Worth	64519.0
1267	118	1970-01-01	Delivered	Debit Card	6997 Second Ave	1970-01-01	1970-01-01	6501.15	\N	Chicago	18330.0
1268	750	1970-01-01	Shipped	Google Pay	9816 Park Rd	1970-01-01	\N	4060.16	\N	Chicago	36039.0
1269	38	1970-01-01	Delivered	Debit Card	4165 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	24168.0
1270	526	1970-01-01	Delivered	Credit Card	6102 Oak Ave	1970-01-01	1970-01-01	2138.84	\N	New York	19289.0
1271	457	1970-01-01	Delivered	Debit Card	9334 Main St	1970-01-01	1970-01-01	134.16	\N	San Jose	47152.0
1272	466	1970-01-01	Shipped	Credit Card	8883 First St	1970-01-01	\N	183.40	\N	Columbus	57925.0
1273	35	1970-01-01	Delivered	Credit Card	258 Main St	1970-01-01	1970-01-01	362.41	\N	Dallas	29536.0
1274	347	1970-01-01	Delivered	Google Pay	6251 Oak Ave	1970-01-01	1970-01-01	655.90	\N	Chicago	81702.0
1275	568	1970-01-01	Shipped	Debit Card	6540 First St	1970-01-01	\N	460.33	\N	Chicago	69098.0
1276	387	1970-01-01	Delivered	Debit Card	3775 Oak Ave	1970-01-01	1970-01-01	5162.95	\N	Houston	12872.0
1277	443	1970-01-01	Delivered	Credit Card	3729 First St	1970-01-01	1970-01-01	281.44	\N	Fort Worth	57118.0
1278	336	1970-01-01	Delivered	Credit Card	9334 Oak Ave	1970-01-01	1970-01-01	23.44	\N	San Jose	34672.0
1279	200	1970-01-01	Delivered	Credit Card	536 Second Ave	1970-01-01	1970-01-01	158.49	\N	Fort Worth	44803.0
1282	922	1970-01-01	Delivered	Credit Card	9703 Main St	1970-01-01	1970-01-01	187.35	\N	San Antonio	34749.0
1283	821	1970-01-01	Delivered	Credit Card	7896 Second Ave	1970-01-01	1970-01-01	1761.92	\N	Fort Worth	25765.0
1284	13	1970-01-01	Delivered	Google Pay	7223 Oak Ave	1970-01-01	1970-01-01	85.40	\N	Phoenix	10425.0
1285	839	1970-01-01	Processing	Apple Pay	1574 Second Ave	\N	\N	365.26	\N	Houston	49738.0
1286	429	1970-01-01	Delivered	Debit Card	8435 First St	1970-01-01	1970-01-01	590.80	\N	Dallas	15747.0
1287	273	1970-01-01	Shipped	Credit Card	2958 Second Ave	1970-01-01	\N	276.46	\N	Dallas	53383.0
1288	561	1970-01-01	Cancelled	Debit Card	8330 Second Ave	\N	\N	856.78	\N	Chicago	95140.0
1289	164	1970-01-01	Delivered	Credit Card	7802 Main St	1970-01-01	1970-01-01	0.00	\N	San Antonio	60709.0
1290	871	1970-01-01	Shipped	Google Pay	1476 Park Rd	1970-01-01	\N	197.04	\N	Fort Worth	78002.0
1291	350	1970-01-01	Delivered	Debit Card	6011 Main St	1970-01-01	1970-01-01	311.99	\N	New York	21485.0
1294	20	1970-01-01	Delivered	Google Pay	9455 Second Ave	1970-01-01	1970-01-01	624.96	\N	Chicago	41850.0
1296	352	1970-01-01	Delivered	Credit Card	9014 First St	1970-01-01	1970-01-01	85.20	\N	Austin	58630.0
1297	323	1970-01-01	Processing	Credit Card	3501 First St	\N	\N	352.39	\N	Philadelphia	70731.0
1298	990	1970-01-01	Pending	Debit Card	7864 Main St	\N	\N	3861.85	\N	Houston	75841.0
1299	717	1970-01-01	Shipped	Debit Card	538 Oak Ave	1970-01-01	\N	3807.04	\N	San Diego	89244.0
1300	335	1970-01-01	Delivered	Apple Pay	2946 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Philadelphia	87662.0
1301	31	1970-01-01	Delivered	Credit Card	4769 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Philadelphia	81200.0
1302	459	1970-01-01	Delivered	Debit Card	7529 Second Ave	1970-01-01	1970-01-01	524.72	\N	Charlotte	19023.0
1304	815	1970-01-01	Delivered	Credit Card	4916 First St	1970-01-01	1970-01-01	0.00	\N	Phoenix	28726.0
1305	998	1970-01-01	Cancelled	Credit Card	7403 Main St	\N	\N	620.20	\N	Houston	81641.0
1306	512	1970-01-01	Delivered	Apple Pay	8999 First St	1970-01-01	1970-01-01	731.03	\N	Los Angeles	35191.0
1307	734	1970-01-01	Delivered	Credit Card	7233 First St	1970-01-01	1970-01-01	685.51	\N	Columbus	18444.0
1308	788	1970-01-01	Delivered	Credit Card	7247 Main St	1970-01-01	1970-01-01	0.00	\N	Jacksonville	47750.0
1309	614	1970-01-01	Delivered	Apple Pay	5921 Oak Ave	1970-01-01	1970-01-01	82.78	\N	San Antonio	65675.0
1310	298	1970-01-01	Delivered	Google Pay	6122 Park Rd	1970-01-01	1970-01-01	253.05	\N	Philadelphia	60164.0
1311	325	1970-01-01	Delivered	Google Pay	4996 Park Rd	1970-01-01	1970-01-01	0.00	\N	New York	14073.0
1312	82	1970-01-01	Processing	Credit Card	753 First St	\N	\N	352.20	\N	San Jose	89129.0
1313	939	1970-01-01	Shipped	Google Pay	2116 Oak Ave	1970-01-01	\N	6714.24	\N	Charlotte	93040.0
1314	779	1970-01-01	Processing	Apple Pay	3166 Oak Ave	\N	\N	197.86	\N	Philadelphia	20252.0
1315	396	1970-01-01	Shipped	Credit Card	2367 Oak Ave	1970-01-01	\N	7403.38	\N	New York	56861.0
1316	265	1970-01-01	Delivered	Credit Card	4873 Main St	1970-01-01	1970-01-01	2777.77	\N	San Diego	98208.0
1317	57	1970-01-01	Processing	Apple Pay	7122 Oak Ave	\N	\N	172.12	\N	Los Angeles	33819.0
1318	176	1970-01-01	Delivered	Apple Pay	8582 First St	1970-01-01	1970-01-01	616.78	\N	San Diego	25435.0
1319	562	1970-01-01	Cancelled	Credit Card	3807 Main St	\N	\N	303.55	\N	Houston	11967.0
1320	725	1970-01-01	Shipped	Debit Card	1491 Main St	1970-01-01	\N	3406.53	\N	San Jose	25003.0
1323	720	1970-01-01	Delivered	Apple Pay	7631 Main St	1970-01-01	1970-01-01	269.02	\N	San Diego	33182.0
1324	217	1970-01-01	Delivered	Debit Card	5990 Oak Ave	1970-01-01	1970-01-01	785.88	\N	Phoenix	97528.0
1326	124	1970-01-01	Delivered	Debit Card	7870 Main St	1970-01-01	1970-01-01	802.95	\N	Austin	21188.0
1327	63	1970-01-01	Shipped	Apple Pay	8389 Park Rd	1970-01-01	\N	70.46	\N	Los Angeles	65057.0
1329	14	1970-01-01	Shipped	Debit Card	8417 Second Ave	1970-01-01	\N	3841.03	\N	Columbus	30032.0
1331	764	1970-01-01	Delivered	Google Pay	8177 Main St	1970-01-01	1970-01-01	0.00	\N	San Diego	26207.0
1332	622	1970-01-01	Delivered	Apple Pay	7417 Park Rd	1970-01-01	1970-01-01	6935.86	\N	Austin	44242.0
1333	625	1970-01-01	Delivered	Debit Card	7903 Second Ave	1970-01-01	1970-01-01	496.78	\N	Phoenix	59781.0
1334	943	1970-01-01	Delivered	Google Pay	2169 Second Ave	1970-01-01	1970-01-01	643.90	\N	Fort Worth	88855.0
1335	524	1970-01-01	Delivered	Debit Card	5376 Main St	1970-01-01	1970-01-01	271.44	\N	San Antonio	78576.0
1337	941	1970-01-01	Cancelled	Debit Card	1924 Main St	\N	\N	391.20	\N	Los Angeles	87620.0
1338	254	1970-01-01	Delivered	Google Pay	3837 Park Rd	1970-01-01	1970-01-01	389.90	\N	San Diego	59207.0
1339	981	1970-01-01	Shipped	Debit Card	5898 Main St	1970-01-01	\N	2606.58	\N	Phoenix	55838.0
1340	737	1970-01-01	Delivered	Credit Card	4651 Second Ave	1970-01-01	1970-01-01	273.00	\N	Fort Worth	94448.0
1341	498	1970-01-01	Delivered	Apple Pay	4222 Main St	1970-01-01	1970-01-01	665.70	\N	Austin	31877.0
1343	518	1970-01-01	Delivered	Google Pay	5924 Oak Ave	1970-01-01	1970-01-01	121.80	\N	New York	80300.0
1344	370	1970-01-01	Shipped	Apple Pay	2267 Oak Ave	1970-01-01	\N	257.07	\N	San Diego	11109.0
1346	565	1970-01-01	Delivered	Debit Card	1891 First St	1970-01-01	1970-01-01	6945.44	\N	Dallas	15559.0
1348	773	1970-01-01	Delivered	Google Pay	3153 First St	1970-01-01	1970-01-01	589.79	\N	San Jose	65838.0
1349	629	1970-01-01	Cancelled	Credit Card	1213 Main St	\N	\N	0.00	\N	Columbus	22805.0
1350	118	1970-01-01	Shipped	Debit Card	6997 Second Ave	1970-01-01	\N	2355.58	\N	Chicago	18330.0
1353	834	1970-01-01	Delivered	Credit Card	4129 Park Rd	1970-01-01	1970-01-01	125.82	\N	Phoenix	37606.0
1354	947	1970-01-01	Delivered	Debit Card	8087 First St	1970-01-01	1970-01-01	6995.68	\N	Columbus	96409.0
1355	340	1970-01-01	Delivered	Apple Pay	7257 First St	1970-01-01	1970-01-01	1914.12	\N	Chicago	51586.0
1356	968	1970-01-01	Delivered	Credit Card	261 Main St	1970-01-01	1970-01-01	898.36	\N	Phoenix	39127.0
1358	898	1970-01-01	Shipped	Google Pay	9900 Main St	1970-01-01	\N	545.30	\N	New York	59465.0
1359	236	1970-01-01	Shipped	Credit Card	3220 Main St	1970-01-01	\N	66.08	\N	Jacksonville	59436.0
1361	311	1970-01-01	Delivered	Debit Card	9387 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Columbus	30618.0
1363	680	1970-01-01	Shipped	Apple Pay	4366 Park Rd	1970-01-01	\N	5381.09	\N	San Diego	36890.0
1364	820	1970-01-01	Delivered	Apple Pay	2128 Second Ave	1970-01-01	1970-01-01	197.49	\N	Dallas	35221.0
1365	591	1970-01-01	Processing	Credit Card	8679 Park Rd	\N	\N	538.46	\N	Jacksonville	28781.0
1366	504	1970-01-01	Delivered	Credit Card	272 Main St	1970-01-01	1970-01-01	1557.15	\N	Phoenix	27865.0
1367	157	1970-01-01	Delivered	Debit Card	8510 Oak Ave	1970-01-01	1970-01-01	1208.35	\N	San Diego	22021.0
1368	173	1970-01-01	Processing	Google Pay	2439 Second Ave	\N	\N	0.00	\N	New York	67432.0
1369	610	1970-01-01	Processing	Google Pay	4723 Main St	\N	\N	131.30	\N	Los Angeles	66585.0
1371	491	1970-01-01	Delivered	Apple Pay	4211 Second Ave	1970-01-01	1970-01-01	1050.33	\N	Phoenix	16253.0
1372	688	1970-01-01	Shipped	Apple Pay	7378 First St	1970-01-01	\N	1060.45	\N	Houston	47831.0
1373	814	1970-01-01	Processing	Debit Card	2080 Park Rd	\N	\N	722.18	\N	Los Angeles	47957.0
1374	622	1970-01-01	Delivered	Google Pay	7417 Park Rd	1970-01-01	1970-01-01	342.70	\N	Austin	44242.0
1375	203	1970-01-01	Delivered	Debit Card	1120 Oak Ave	1970-01-01	1970-01-01	186.85	\N	Columbus	37176.0
1376	691	1970-01-01	Delivered	Debit Card	9174 First St	1970-01-01	1970-01-01	238.83	\N	Phoenix	49582.0
1377	525	1970-01-01	Delivered	Apple Pay	8052 Oak Ave	1970-01-01	1970-01-01	838.90	\N	Los Angeles	14170.0
1378	612	1970-01-01	Shipped	Credit Card	2156 Oak Ave	1970-01-01	\N	0.00	\N	Columbus	19403.0
1379	254	1970-01-01	Delivered	Credit Card	3837 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Diego	59207.0
1380	713	1970-01-01	Delivered	Debit Card	2448 First St	1970-01-01	1970-01-01	6719.97	\N	Los Angeles	87405.0
1382	13	1970-01-01	Delivered	Credit Card	7223 Oak Ave	1970-01-01	1970-01-01	768.59	\N	Phoenix	10425.0
1383	157	1970-01-01	Delivered	Debit Card	8510 Oak Ave	1970-01-01	1970-01-01	180.12	\N	San Diego	22021.0
1384	271	1970-01-01	Processing	Debit Card	5210 Park Rd	\N	\N	299.44	\N	Philadelphia	37114.0
1385	910	1970-01-01	Delivered	Apple Pay	6350 Second Ave	1970-01-01	1970-01-01	68.71	\N	San Jose	34057.0
1386	648	1970-01-01	Delivered	Credit Card	4587 Oak Ave	1970-01-01	1970-01-01	180.99	\N	Los Angeles	32026.0
1387	671	1970-01-01	Delivered	Credit Card	3793 Park Rd	1970-01-01	1970-01-01	169.45	\N	Fort Worth	45043.0
1388	378	1970-01-01	Cancelled	Credit Card	5131 First St	\N	\N	675.22	\N	Houston	58717.0
1389	128	1970-01-01	Processing	Apple Pay	4481 Main St	\N	\N	0.00	\N	San Jose	45818.0
1390	792	1970-01-01	Delivered	Google Pay	4373 Park Rd	1970-01-01	1970-01-01	257.52	\N	Charlotte	30788.0
1391	997	1970-01-01	Shipped	Credit Card	9673 First St	1970-01-01	\N	160.52	\N	Houston	23941.0
1392	671	1970-01-01	Delivered	Apple Pay	3793 Park Rd	1970-01-01	1970-01-01	34.33	\N	Fort Worth	45043.0
1394	899	1970-01-01	Delivered	Debit Card	7008 Main St	1970-01-01	1970-01-01	191.83	\N	New York	54186.0
1395	627	1970-01-01	Processing	Debit Card	7174 Second Ave	\N	\N	163.63	\N	Columbus	45728.0
1396	835	1970-01-01	Delivered	Google Pay	7907 Main St	1970-01-01	1970-01-01	56.14	\N	San Jose	98172.0
1397	246	1970-01-01	Delivered	Debit Card	4797 Main St	1970-01-01	1970-01-01	4537.71	\N	Dallas	98346.0
1398	58	1970-01-01	Shipped	Debit Card	6311 Park Rd	1970-01-01	\N	40.45	\N	Philadelphia	43065.0
1399	925	1970-01-01	Shipped	Apple Pay	6929 Park Rd	1970-01-01	\N	766.90	\N	Dallas	32365.0
1401	94	1970-01-01	Delivered	Google Pay	7849 First St	1970-01-01	1970-01-01	584.07	\N	Philadelphia	96991.0
1402	43	1970-01-01	Pending	Debit Card	5243 Main St	\N	\N	0.00	\N	San Jose	76469.0
1403	98	1970-01-01	Delivered	Google Pay	1746 First St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	49251.0
1404	742	1970-01-01	Shipped	Apple Pay	7043 First St	1970-01-01	\N	356.17	\N	Dallas	42289.0
1405	965	1970-01-01	Processing	Apple Pay	3256 Park Rd	\N	\N	12.82	\N	Austin	96155.0
1407	565	1970-01-01	Delivered	Google Pay	1891 First St	1970-01-01	1970-01-01	2298.21	\N	Dallas	15559.0
1408	999	1970-01-01	Delivered	Credit Card	2194 Oak Ave	1970-01-01	1970-01-01	461.94	\N	New York	82154.0
1410	173	1970-01-01	Delivered	Debit Card	2439 Second Ave	1970-01-01	1970-01-01	298.16	\N	New York	67432.0
1411	207	1970-01-01	Delivered	Debit Card	789 Park Rd	1970-01-01	1970-01-01	0.00	\N	Phoenix	55398.0
1412	455	1970-01-01	Cancelled	Debit Card	9779 Oak Ave	\N	\N	35.23	\N	Houston	63857.0
1413	48	1970-01-01	Cancelled	Debit Card	6391 First St	\N	\N	662.75	\N	Jacksonville	41979.0
1414	628	1970-01-01	Delivered	Credit Card	4061 Second Ave	1970-01-01	1970-01-01	4103.91	\N	San Diego	78151.0
1416	197	1970-01-01	Cancelled	Google Pay	759 Main St	\N	\N	125.70	\N	Dallas	27961.0
1417	794	1970-01-01	Delivered	Debit Card	9226 Park Rd	1970-01-01	1970-01-01	6765.85	\N	Fort Worth	77552.0
1418	106	1970-01-01	Delivered	Credit Card	6907 Oak Ave	1970-01-01	1970-01-01	3265.99	\N	Philadelphia	27322.0
1420	350	1970-01-01	Delivered	Debit Card	6011 Main St	1970-01-01	1970-01-01	451.33	\N	New York	21485.0
1421	582	1970-01-01	Delivered	Debit Card	2032 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Austin	64346.0
1422	900	1970-01-01	Delivered	Credit Card	2836 Main St	1970-01-01	1970-01-01	511.32	\N	Jacksonville	77174.0
1423	487	1970-01-01	Delivered	Credit Card	9087 Park Rd	1970-01-01	1970-01-01	105.69	\N	Chicago	45311.0
1425	311	1970-01-01	Delivered	Credit Card	9387 Oak Ave	1970-01-01	1970-01-01	423.33	\N	Columbus	30618.0
1426	323	1970-01-01	Delivered	Credit Card	3501 First St	1970-01-01	1970-01-01	1094.55	\N	Philadelphia	70731.0
1427	647	1970-01-01	Delivered	Credit Card	2079 Second Ave	1970-01-01	1970-01-01	421.62	\N	Philadelphia	28000.0
1428	261	1970-01-01	Delivered	Debit Card	1852 Oak Ave	1970-01-01	1970-01-01	0.00	\N	San Diego	10887.0
1430	678	1970-01-01	Shipped	Credit Card	6193 Park Rd	1970-01-01	\N	61.32	\N	San Diego	29443.0
1431	540	1970-01-01	Delivered	Debit Card	927 First St	1970-01-01	1970-01-01	2614.62	\N	Chicago	88005.0
1432	259	1970-01-01	Delivered	Apple Pay	6337 Oak Ave	1970-01-01	1970-01-01	1379.64	\N	Chicago	45247.0
1433	630	1970-01-01	Shipped	Google Pay	3263 Main St	1970-01-01	\N	2653.44	\N	Phoenix	91185.0
1434	502	1970-01-01	Delivered	Google Pay	9780 Second Ave	1970-01-01	1970-01-01	218.04	\N	Chicago	92712.0
1435	50	1970-01-01	Processing	Apple Pay	9855 Park Rd	\N	\N	1924.54	\N	Dallas	90301.0
1436	637	1970-01-01	Cancelled	Google Pay	6511 Second Ave	\N	\N	0.00	\N	Charlotte	77552.0
1437	666	1970-01-01	Delivered	Debit Card	9445 Second Ave	1970-01-01	1970-01-01	193.39	\N	Columbus	69616.0
1438	905	1970-01-01	Delivered	Debit Card	7999 Main St	1970-01-01	1970-01-01	629.48	\N	Columbus	12313.0
1439	5	1970-01-01	Shipped	Debit Card	6025 Second Ave	1970-01-01	\N	419.64	\N	Columbus	19116.0
1440	989	1970-01-01	Processing	Apple Pay	2598 Second Ave	\N	\N	511.55	\N	Houston	42698.0
1441	264	1970-01-01	Processing	Credit Card	1965 Second Ave	\N	\N	0.00	\N	Philadelphia	87624.0
1442	731	1970-01-01	Delivered	Debit Card	8946 Park Rd	1970-01-01	1970-01-01	541.15	\N	Austin	64304.0
1443	486	1970-01-01	Delivered	Apple Pay	237 Main St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	37623.0
1444	812	1970-01-01	Delivered	Credit Card	6930 Oak Ave	1970-01-01	1970-01-01	2619.69	\N	Jacksonville	76294.0
1445	172	1970-01-01	Cancelled	Apple Pay	7226 Park Rd	\N	\N	0.00	\N	San Jose	17518.0
1446	720	1970-01-01	Processing	Apple Pay	7631 Main St	\N	\N	3537.55	\N	San Diego	33182.0
1447	696	1970-01-01	Delivered	Google Pay	4878 Second Ave	1970-01-01	1970-01-01	390.68	\N	Phoenix	20069.0
1448	35	1970-01-01	Processing	Apple Pay	258 Main St	\N	\N	306.35	\N	Dallas	29536.0
1449	234	1970-01-01	Delivered	Google Pay	4048 Oak Ave	1970-01-01	1970-01-01	1339.15	\N	San Diego	28920.0
1450	639	1970-01-01	Delivered	Google Pay	1004 Main St	1970-01-01	1970-01-01	171.46	\N	San Antonio	80074.0
1451	641	1970-01-01	Delivered	Google Pay	1490 First St	1970-01-01	1970-01-01	560.62	\N	San Diego	28342.0
1452	763	1970-01-01	Shipped	Credit Card	7804 Park Rd	1970-01-01	\N	0.00	\N	New York	71228.0
1453	971	1970-01-01	Delivered	Debit Card	2190 Park Rd	1970-01-01	1970-01-01	440.25	\N	San Jose	77314.0
1454	682	1970-01-01	Cancelled	Google Pay	170 Second Ave	\N	\N	817.38	\N	Chicago	53421.0
1455	666	1970-01-01	Delivered	Debit Card	9445 Second Ave	1970-01-01	1970-01-01	174.74	\N	Columbus	69616.0
1456	539	1970-01-01	Shipped	Credit Card	5093 Second Ave	1970-01-01	\N	234.85	\N	New York	51853.0
1457	903	1970-01-01	Delivered	Apple Pay	1203 Oak Ave	1970-01-01	1970-01-01	127.54	\N	New York	49522.0
1458	224	1970-01-01	Cancelled	Google Pay	1144 Second Ave	\N	\N	0.00	\N	Jacksonville	19046.0
1459	335	1970-01-01	Delivered	Credit Card	2946 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Philadelphia	87662.0
1460	473	1970-01-01	Pending	Apple Pay	3895 Second Ave	\N	\N	2038.23	\N	Dallas	98345.0
1461	567	1970-01-01	Delivered	Google Pay	993 Second Ave	1970-01-01	1970-01-01	3511.10	\N	San Jose	70762.0
1463	65	1970-01-01	Delivered	Credit Card	9807 Park Rd	1970-01-01	1970-01-01	24.16	\N	Columbus	42177.0
1464	88	1970-01-01	Delivered	Apple Pay	572 Second Ave	1970-01-01	1970-01-01	118.02	\N	Los Angeles	30758.0
1465	95	1970-01-01	Shipped	Credit Card	1744 First St	1970-01-01	\N	208.57	\N	Columbus	78937.0
1466	60	1970-01-01	Delivered	Debit Card	1974 Second Ave	1970-01-01	1970-01-01	2443.55	\N	Austin	70952.0
1467	358	1970-01-01	Shipped	Apple Pay	4625 Second Ave	1970-01-01	\N	884.83	\N	Columbus	11620.0
1468	258	1970-01-01	Shipped	Google Pay	6411 Main St	1970-01-01	\N	7884.95	\N	Columbus	64238.0
1469	166	1970-01-01	Cancelled	Apple Pay	7712 First St	\N	\N	815.49	\N	Columbus	33891.0
1470	672	1970-01-01	Processing	Google Pay	8066 Second Ave	\N	\N	1893.45	\N	San Diego	26083.0
1471	764	1970-01-01	Processing	Apple Pay	8177 Main St	\N	\N	220.86	\N	San Diego	26207.0
1474	208	1970-01-01	Processing	Google Pay	9308 Park Rd	\N	\N	420.14	\N	Phoenix	24316.0
1475	998	1970-01-01	Delivered	Apple Pay	7403 Main St	1970-01-01	1970-01-01	5818.68	\N	Houston	81641.0
1477	547	1970-01-01	Shipped	Google Pay	5724 Main St	1970-01-01	\N	362.65	\N	New York	68990.0
1478	384	1970-01-01	Delivered	Apple Pay	393 Main St	1970-01-01	1970-01-01	72.41	\N	Houston	42613.0
1479	948	1970-01-01	Delivered	Apple Pay	6512 First St	1970-01-01	1970-01-01	120.06	\N	Philadelphia	79185.0
1482	29	1970-01-01	Delivered	Credit Card	4451 First St	1970-01-01	1970-01-01	1720.67	\N	Houston	98039.0
1483	42	1970-01-01	Delivered	Debit Card	827 First St	1970-01-01	1970-01-01	14.12	\N	Phoenix	78146.0
1484	789	1970-01-01	Delivered	Google Pay	5656 Second Ave	1970-01-01	1970-01-01	347.70	\N	San Jose	71402.0
1486	974	1970-01-01	Shipped	Google Pay	1576 Main St	1970-01-01	\N	958.57	\N	Columbus	41462.0
1487	242	1970-01-01	Processing	Credit Card	8105 First St	\N	\N	75.25	\N	Phoenix	32050.0
1488	47	1970-01-01	Delivered	Apple Pay	500 Main St	1970-01-01	1970-01-01	0.00	\N	Chicago	72277.0
1489	586	1970-01-01	Cancelled	Google Pay	6882 Main St	\N	\N	151.68	\N	San Diego	49235.0
1491	340	1970-01-01	Shipped	Credit Card	7257 First St	1970-01-01	\N	438.12	\N	Chicago	51586.0
1492	483	1970-01-01	Delivered	Debit Card	208 Second Ave	1970-01-01	1970-01-01	2134.40	\N	San Jose	73214.0
1494	635	1970-01-01	Delivered	Debit Card	1840 First St	1970-01-01	1970-01-01	428.92	\N	Houston	23538.0
1496	603	1970-01-01	Delivered	Debit Card	4092 Second Ave	1970-01-01	1970-01-01	412.65	\N	Houston	73225.0
1498	381	1970-01-01	Delivered	Credit Card	3054 Main St	1970-01-01	1970-01-01	822.27	\N	Philadelphia	53598.0
1499	543	1970-01-01	Delivered	Credit Card	8689 Oak Ave	1970-01-01	1970-01-01	4997.50	\N	Dallas	19390.0
1501	703	1970-01-01	Processing	Credit Card	408 First St	\N	\N	87.76	\N	Los Angeles	15572.0
1502	951	1970-01-01	Delivered	Apple Pay	7097 Oak Ave	1970-01-01	1970-01-01	1888.22	\N	San Antonio	22589.0
1503	824	1970-01-01	Delivered	Debit Card	2855 Park Rd	1970-01-01	1970-01-01	5011.23	\N	Dallas	33942.0
1504	877	1970-01-01	Delivered	Apple Pay	8499 Oak Ave	1970-01-01	1970-01-01	125.12	\N	San Diego	39829.0
1505	953	1970-01-01	Delivered	Credit Card	9867 Oak Ave	1970-01-01	1970-01-01	682.54	\N	Phoenix	59200.0
1508	558	1970-01-01	Delivered	Debit Card	9231 Second Ave	1970-01-01	1970-01-01	995.92	\N	Los Angeles	34134.0
1510	23	1970-01-01	Shipped	Debit Card	9116 Main St	1970-01-01	\N	1330.77	\N	San Diego	95477.0
1511	136	1970-01-01	Delivered	Debit Card	7632 Main St	1970-01-01	1970-01-01	1889.71	\N	New York	85465.0
1513	345	1970-01-01	Shipped	Credit Card	6883 First St	1970-01-01	\N	180.05	\N	Charlotte	56036.0
1514	256	1970-01-01	Shipped	Google Pay	1599 Main St	1970-01-01	\N	51.77	\N	Los Angeles	68292.0
1515	536	1970-01-01	Delivered	Apple Pay	5020 Main St	1970-01-01	1970-01-01	815.76	\N	Phoenix	62402.0
1518	841	1970-01-01	Delivered	Credit Card	3274 Second Ave	1970-01-01	1970-01-01	889.54	\N	Dallas	99441.0
1521	659	1970-01-01	Delivered	Debit Card	3281 Park Rd	1970-01-01	1970-01-01	19.42	\N	San Diego	36504.0
1522	781	1970-01-01	Delivered	Debit Card	6571 Park Rd	1970-01-01	1970-01-01	424.54	\N	Jacksonville	26395.0
1523	957	1970-01-01	Delivered	Apple Pay	8601 Second Ave	1970-01-01	1970-01-01	0.00	\N	Los Angeles	95419.0
1525	138	1970-01-01	Shipped	Google Pay	9748 First St	1970-01-01	\N	153.68	\N	San Antonio	20308.0
1526	541	1970-01-01	Delivered	Debit Card	2265 Park Rd	1970-01-01	1970-01-01	359.83	\N	Chicago	72371.0
1527	660	1970-01-01	Processing	Apple Pay	1920 First St	\N	\N	309.27	\N	Chicago	64817.0
1528	671	1970-01-01	Cancelled	Debit Card	3793 Park Rd	\N	\N	170.09	\N	Fort Worth	45043.0
1529	985	1970-01-01	Delivered	Debit Card	3205 Park Rd	1970-01-01	1970-01-01	8990.55	\N	Los Angeles	27521.0
1530	534	1970-01-01	Shipped	Apple Pay	5020 Oak Ave	1970-01-01	\N	548.58	\N	New York	51275.0
1531	677	1970-01-01	Delivered	Apple Pay	9086 First St	1970-01-01	1970-01-01	446.84	\N	Columbus	49856.0
1532	485	1970-01-01	Delivered	Apple Pay	8959 Main St	1970-01-01	1970-01-01	232.98	\N	San Diego	55519.0
1534	608	1970-01-01	Delivered	Credit Card	5287 Park Rd	1970-01-01	1970-01-01	629.20	\N	Austin	99071.0
1535	195	1970-01-01	Shipped	Debit Card	4828 Main St	1970-01-01	\N	665.85	\N	Dallas	76093.0
1536	868	1970-01-01	Processing	Debit Card	8268 Second Ave	\N	\N	805.66	\N	Philadelphia	33461.0
1538	63	1970-01-01	Shipped	Debit Card	8389 Park Rd	1970-01-01	\N	351.40	\N	Los Angeles	65057.0
1539	352	1970-01-01	Delivered	Debit Card	9014 First St	1970-01-01	1970-01-01	1078.07	\N	Austin	58630.0
1540	153	1970-01-01	Shipped	Google Pay	7270 Main St	1970-01-01	\N	412.45	\N	Jacksonville	57749.0
1541	39	1970-01-01	Processing	Debit Card	5100 Oak Ave	\N	\N	1608.41	\N	Philadelphia	13101.0
1542	190	1970-01-01	Delivered	Credit Card	7466 Oak Ave	1970-01-01	1970-01-01	4997.50	\N	Phoenix	22689.0
1543	198	1970-01-01	Delivered	Apple Pay	5473 Second Ave	1970-01-01	1970-01-01	409.75	\N	Chicago	31299.0
1544	5	1970-01-01	Delivered	Credit Card	6025 Second Ave	1970-01-01	1970-01-01	2404.64	\N	Columbus	19116.0
1546	23	1970-01-01	Delivered	Google Pay	9116 Main St	1970-01-01	1970-01-01	213.60	\N	San Diego	95477.0
1548	661	1970-01-01	Delivered	Apple Pay	2884 Second Ave	1970-01-01	1970-01-01	5023.78	\N	Fort Worth	40107.0
1549	161	1970-01-01	Delivered	Debit Card	882 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Los Angeles	93748.0
1550	52	1970-01-01	Delivered	Debit Card	4551 Park Rd	1970-01-01	1970-01-01	87.37	\N	Houston	80798.0
1553	586	1970-01-01	Delivered	Apple Pay	6882 Main St	1970-01-01	1970-01-01	0.00	\N	San Diego	49235.0
1554	120	1970-01-01	Delivered	Credit Card	6680 First St	1970-01-01	1970-01-01	152.17	\N	Columbus	24150.0
1555	326	1970-01-01	Processing	Credit Card	1769 Oak Ave	\N	\N	596.84	\N	San Diego	11567.0
1556	964	1970-01-01	Cancelled	Credit Card	1464 Park Rd	\N	\N	2194.11	\N	San Diego	65750.0
1557	401	1970-01-01	Delivered	Debit Card	8670 Second Ave	1970-01-01	1970-01-01	201.46	\N	Dallas	66734.0
1558	959	1970-01-01	Delivered	Apple Pay	4306 Main St	1970-01-01	1970-01-01	126.69	\N	Dallas	26346.0
1559	885	1970-01-01	Pending	Credit Card	2672 Main St	\N	\N	251.28	\N	San Antonio	80313.0
1560	501	1970-01-01	Delivered	Credit Card	5946 Park Rd	1970-01-01	1970-01-01	2333.76	\N	Austin	71235.0
1561	360	1970-01-01	Delivered	Google Pay	7850 Main St	1970-01-01	1970-01-01	2647.10	\N	San Jose	46099.0
1563	368	1970-01-01	Delivered	Debit Card	4337 Main St	1970-01-01	1970-01-01	479.24	\N	Columbus	13597.0
1564	789	1970-01-01	Delivered	Debit Card	5656 Second Ave	1970-01-01	1970-01-01	99.46	\N	San Jose	71402.0
1565	173	1970-01-01	Delivered	Credit Card	2439 Second Ave	1970-01-01	1970-01-01	2135.94	\N	New York	67432.0
1566	952	1970-01-01	Delivered	Credit Card	5645 Second Ave	1970-01-01	1970-01-01	365.51	\N	Austin	29473.0
1568	418	1970-01-01	Delivered	Debit Card	4474 Oak Ave	1970-01-01	1970-01-01	693.88	\N	Houston	99573.0
1569	182	1970-01-01	Delivered	Google Pay	2202 Second Ave	1970-01-01	1970-01-01	345.31	\N	Philadelphia	87042.0
1571	185	1970-01-01	Delivered	Google Pay	9613 Oak Ave	1970-01-01	1970-01-01	2248.35	\N	San Jose	96341.0
1573	462	1970-01-01	Shipped	Debit Card	6992 Park Rd	1970-01-01	\N	388.15	\N	Dallas	79444.0
1574	153	1970-01-01	Delivered	Apple Pay	7270 Main St	1970-01-01	1970-01-01	91.70	\N	Jacksonville	57749.0
1575	191	1970-01-01	Delivered	Google Pay	2716 Park Rd	1970-01-01	1970-01-01	367.58	\N	Columbus	50988.0
1576	683	1970-01-01	Delivered	Apple Pay	9360 First St	1970-01-01	1970-01-01	87.93	\N	Fort Worth	24721.0
1577	946	1970-01-01	Shipped	Debit Card	6271 Main St	1970-01-01	\N	2278.42	\N	Phoenix	30014.0
1578	880	1970-01-01	Delivered	Debit Card	6708 Second Ave	1970-01-01	1970-01-01	134.86	\N	Austin	52739.0
1581	154	1970-01-01	Shipped	Google Pay	8849 Oak Ave	1970-01-01	\N	328.62	\N	Houston	71474.0
1582	794	1970-01-01	Pending	Credit Card	9226 Park Rd	\N	\N	225.33	\N	Fort Worth	77552.0
1583	38	1970-01-01	Delivered	Google Pay	4165 Park Rd	1970-01-01	1970-01-01	262.36	\N	Fort Worth	24168.0
1585	435	1970-01-01	Delivered	Google Pay	1517 Park Rd	1970-01-01	1970-01-01	437.22	\N	San Jose	59992.0
1587	619	1970-01-01	Shipped	Google Pay	2844 Main St	1970-01-01	\N	123.56	\N	Phoenix	88333.0
1588	103	1970-01-01	Delivered	Google Pay	4947 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Jose	96275.0
1589	552	1970-01-01	Shipped	Apple Pay	7603 Second Ave	1970-01-01	\N	0.00	\N	Dallas	12816.0
1590	15	1970-01-01	Delivered	Apple Pay	5410 First St	1970-01-01	1970-01-01	194.01	\N	San Jose	24662.0
1591	863	1970-01-01	Delivered	Debit Card	2348 First St	1970-01-01	1970-01-01	114.64	\N	New York	24544.0
1593	253	1970-01-01	Delivered	Google Pay	3903 Main St	1970-01-01	1970-01-01	1000.37	\N	San Antonio	89320.0
1594	223	1970-01-01	Processing	Debit Card	5149 Main St	\N	\N	465.14	\N	Austin	43352.0
1595	108	1970-01-01	Shipped	Credit Card	9231 Park Rd	1970-01-01	\N	857.05	\N	Columbus	61717.0
1596	111	1970-01-01	Shipped	Debit Card	1692 Oak Ave	1970-01-01	\N	577.20	\N	Los Angeles	27781.0
1597	613	1970-01-01	Delivered	Credit Card	6913 First St	1970-01-01	1970-01-01	0.00	\N	Chicago	89223.0
1598	613	1970-01-01	Delivered	Debit Card	6913 First St	1970-01-01	1970-01-01	1360.91	\N	Chicago	89223.0
1599	650	1970-01-01	Delivered	Credit Card	9827 Park Rd	1970-01-01	1970-01-01	893.04	\N	Jacksonville	72391.0
1600	343	1970-01-01	Delivered	Apple Pay	5782 Park Rd	1970-01-01	1970-01-01	9993.05	\N	Houston	93386.0
1601	637	1970-01-01	Delivered	Credit Card	6511 Second Ave	1970-01-01	1970-01-01	249.27	\N	Charlotte	77552.0
1604	351	1970-01-01	Delivered	Credit Card	4881 Main St	1970-01-01	1970-01-01	257.03	\N	Chicago	25139.0
1605	195	1970-01-01	Delivered	Apple Pay	4828 Main St	1970-01-01	1970-01-01	58.64	\N	Dallas	76093.0
1607	422	1970-01-01	Delivered	Apple Pay	3270 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	33255.0
1609	44	1970-01-01	Delivered	Debit Card	6988 First St	1970-01-01	1970-01-01	2233.89	\N	Houston	32810.0
1610	469	1970-01-01	Shipped	Credit Card	9120 Second Ave	1970-01-01	\N	0.00	\N	Fort Worth	99727.0
1611	534	1970-01-01	Delivered	Debit Card	5020 Oak Ave	1970-01-01	1970-01-01	1288.36	\N	New York	51275.0
1612	607	1970-01-01	Processing	Debit Card	2503 Oak Ave	\N	\N	91.72	\N	Fort Worth	79632.0
1614	834	1970-01-01	Delivered	Credit Card	4129 Park Rd	1970-01-01	1970-01-01	526.14	\N	Phoenix	37606.0
1615	359	1970-01-01	Delivered	Credit Card	1830 Second Ave	1970-01-01	1970-01-01	3818.05	\N	Charlotte	47498.0
1616	286	1970-01-01	Delivered	Debit Card	2381 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Chicago	17780.0
1618	21	1970-01-01	Delivered	Debit Card	7039 First St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	17100.0
1619	470	1970-01-01	Delivered	Google Pay	2481 First St	1970-01-01	1970-01-01	109.36	\N	Columbus	67065.0
1620	913	1970-01-01	Processing	Apple Pay	4775 Second Ave	\N	\N	393.14	\N	Phoenix	93309.0
1621	170	1970-01-01	Delivered	Debit Card	7155 Second Ave	1970-01-01	1970-01-01	707.31	\N	Los Angeles	81496.0
1622	40	1970-01-01	Pending	Credit Card	8446 First St	\N	\N	122.36	\N	Philadelphia	80282.0
1623	557	1970-01-01	Delivered	Google Pay	2362 Park Rd	1970-01-01	1970-01-01	404.95	\N	Columbus	78656.0
1624	405	1970-01-01	Shipped	Debit Card	8248 Main St	1970-01-01	\N	20.47	\N	Los Angeles	62879.0
1625	434	1970-01-01	Pending	Credit Card	9694 Main St	\N	\N	992.47	\N	Fort Worth	19514.0
1626	621	1970-01-01	Delivered	Google Pay	2271 Second Ave	1970-01-01	1970-01-01	174.44	\N	Phoenix	46073.0
1627	507	1970-01-01	Delivered	Google Pay	7017 Oak Ave	1970-01-01	1970-01-01	458.46	\N	Los Angeles	90375.0
1628	513	1970-01-01	Shipped	Google Pay	7357 Oak Ave	1970-01-01	\N	648.09	\N	San Antonio	36106.0
1629	299	1970-01-01	Delivered	Google Pay	5853 Oak Ave	1970-01-01	1970-01-01	874.33	\N	San Diego	29840.0
1630	232	1970-01-01	Processing	Apple Pay	9793 Oak Ave	\N	\N	2826.88	\N	Dallas	98965.0
1631	684	1970-01-01	Delivered	Apple Pay	6680 Second Ave	1970-01-01	1970-01-01	0.00	\N	New York	68454.0
1632	650	1970-01-01	Delivered	Google Pay	9827 Park Rd	1970-01-01	1970-01-01	0.00	\N	Jacksonville	72391.0
1633	908	1970-01-01	Shipped	Google Pay	9898 First St	1970-01-01	\N	250.55	\N	Houston	27598.0
1634	218	1970-01-01	Delivered	Apple Pay	5195 Main St	1970-01-01	1970-01-01	403.00	\N	Charlotte	48671.0
1636	658	1970-01-01	Processing	Google Pay	8036 Main St	\N	\N	271.11	\N	San Jose	28997.0
1637	654	1970-01-01	Shipped	Credit Card	7872 First St	1970-01-01	\N	220.05	\N	Austin	30940.0
1638	859	1970-01-01	Delivered	Credit Card	3872 First St	1970-01-01	1970-01-01	133.64	\N	Jacksonville	37936.0
1639	209	1970-01-01	Cancelled	Debit Card	1741 First St	\N	\N	288.06	\N	New York	71918.0
1640	30	1970-01-01	Delivered	Debit Card	9324 Main St	1970-01-01	1970-01-01	1227.86	\N	San Diego	80468.0
1641	702	1970-01-01	Delivered	Google Pay	2432 Oak Ave	1970-01-01	1970-01-01	147.23	\N	Chicago	26429.0
1642	450	1970-01-01	Delivered	Debit Card	6018 First St	1970-01-01	1970-01-01	1959.31	\N	Dallas	69591.0
1643	338	1970-01-01	Delivered	Credit Card	3007 Park Rd	1970-01-01	1970-01-01	0.00	\N	Philadelphia	12872.0
1644	765	1970-01-01	Delivered	Credit Card	8435 Park Rd	1970-01-01	1970-01-01	552.84	\N	Jacksonville	96918.0
1645	120	1970-01-01	Cancelled	Apple Pay	6680 First St	\N	\N	6516.26	\N	Columbus	24150.0
1646	689	1970-01-01	Delivered	Apple Pay	3504 Park Rd	1970-01-01	1970-01-01	1379.88	\N	Chicago	78852.0
1647	904	1970-01-01	Delivered	Google Pay	1652 Second Ave	1970-01-01	1970-01-01	50.91	\N	Phoenix	92689.0
1648	126	1970-01-01	Pending	Google Pay	942 Park Rd	\N	\N	2189.35	\N	Columbus	50953.0
1650	59	1970-01-01	Delivered	Apple Pay	1224 Main St	1970-01-01	1970-01-01	293.27	\N	Houston	42411.0
1651	431	1970-01-01	Cancelled	Credit Card	8910 First St	\N	\N	2647.10	\N	Houston	19452.0
1653	94	1970-01-01	Delivered	Debit Card	7849 First St	1970-01-01	1970-01-01	1009.21	\N	Philadelphia	96991.0
1654	902	1970-01-01	Delivered	Apple Pay	5281 Main St	1970-01-01	1970-01-01	2832.04	\N	San Antonio	37887.0
1655	830	1970-01-01	Delivered	Debit Card	7042 Second Ave	1970-01-01	1970-01-01	938.27	\N	Dallas	15477.0
1656	23	1970-01-01	Delivered	Apple Pay	9116 Main St	1970-01-01	1970-01-01	231.91	\N	San Diego	95477.0
1658	798	1970-01-01	Delivered	Apple Pay	6201 First St	1970-01-01	1970-01-01	419.60	\N	Phoenix	92502.0
1659	986	1970-01-01	Delivered	Google Pay	4454 Main St	1970-01-01	1970-01-01	408.40	\N	San Diego	74103.0
1661	47	1970-01-01	Delivered	Apple Pay	500 Main St	1970-01-01	1970-01-01	211.41	\N	Chicago	72277.0
1662	422	1970-01-01	Delivered	Google Pay	3270 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	33255.0
1663	849	1970-01-01	Delivered	Debit Card	2145 Main St	1970-01-01	1970-01-01	337.59	\N	San Jose	14370.0
1664	342	1970-01-01	Delivered	Credit Card	9969 Park Rd	1970-01-01	1970-01-01	78.57	\N	Chicago	38953.0
1665	636	1970-01-01	Delivered	Credit Card	8254 Oak Ave	1970-01-01	1970-01-01	1121.40	\N	New York	93930.0
1666	930	1970-01-01	Pending	Google Pay	8620 Park Rd	\N	\N	277.26	\N	San Jose	72027.0
1668	35	1970-01-01	Delivered	Google Pay	258 Main St	1970-01-01	1970-01-01	419.61	\N	Dallas	29536.0
1669	611	1970-01-01	Delivered	Debit Card	2941 First St	1970-01-01	1970-01-01	824.75	\N	Houston	34671.0
1670	757	1970-01-01	Delivered	Apple Pay	6613 Oak Ave	1970-01-01	1970-01-01	548.59	\N	Jacksonville	60265.0
1671	733	1970-01-01	Shipped	Google Pay	9375 Main St	1970-01-01	\N	338.30	\N	Charlotte	36299.0
1672	350	1970-01-01	Delivered	Google Pay	6011 Main St	1970-01-01	1970-01-01	1760.15	\N	New York	21485.0
1675	445	1970-01-01	Delivered	Google Pay	1352 Main St	1970-01-01	1970-01-01	147.20	\N	Jacksonville	76476.0
1676	935	1970-01-01	Delivered	Credit Card	7110 First St	1970-01-01	1970-01-01	417.96	\N	Philadelphia	23166.0
1677	825	1970-01-01	Shipped	Apple Pay	5429 Oak Ave	1970-01-01	\N	92.99	\N	New York	17667.0
1678	249	1970-01-01	Delivered	Google Pay	254 Oak Ave	1970-01-01	1970-01-01	50.61	\N	New York	75517.0
1679	41	1970-01-01	Pending	Google Pay	1876 Second Ave	\N	\N	549.78	\N	New York	55309.0
1681	840	1970-01-01	Processing	Debit Card	3525 Main St	\N	\N	973.69	\N	San Diego	93681.0
1682	583	1970-01-01	Delivered	Google Pay	3396 Park Rd	1970-01-01	1970-01-01	181.46	\N	New York	18891.0
1683	878	1970-01-01	Delivered	Apple Pay	7659 Park Rd	1970-01-01	1970-01-01	43.56	\N	Jacksonville	51035.0
1684	807	1970-01-01	Delivered	Debit Card	4981 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Diego	69394.0
1685	767	1970-01-01	Delivered	Credit Card	6220 Second Ave	1970-01-01	1970-01-01	5059.77	\N	San Antonio	52406.0
1686	522	1970-01-01	Delivered	Debit Card	7539 Main St	1970-01-01	1970-01-01	94.30	\N	Philadelphia	76316.0
1687	593	1970-01-01	Delivered	Credit Card	5219 Main St	1970-01-01	1970-01-01	767.82	\N	Dallas	50913.0
1689	577	1970-01-01	Delivered	Credit Card	9585 Park Rd	1970-01-01	1970-01-01	183.05	\N	San Diego	22206.0
1690	541	1970-01-01	Delivered	Debit Card	2265 Park Rd	1970-01-01	1970-01-01	0.00	\N	Chicago	72371.0
1692	559	1970-01-01	Delivered	Apple Pay	7358 Park Rd	1970-01-01	1970-01-01	0.00	\N	Phoenix	34632.0
1693	148	1970-01-01	Delivered	Apple Pay	4228 Second Ave	1970-01-01	1970-01-01	499.77	\N	Phoenix	53694.0
1694	550	1970-01-01	Processing	Apple Pay	7717 Main St	\N	\N	1090.71	\N	New York	60940.0
1695	52	1970-01-01	Delivered	Credit Card	4551 Park Rd	1970-01-01	1970-01-01	4746.68	\N	Houston	80798.0
1696	387	1970-01-01	Delivered	Credit Card	3775 Oak Ave	1970-01-01	1970-01-01	44.37	\N	Houston	12872.0
1697	879	1970-01-01	Processing	Debit Card	2376 Second Ave	\N	\N	165.83	\N	Philadelphia	50051.0
1698	833	1970-01-01	Delivered	Credit Card	9217 Park Rd	1970-01-01	1970-01-01	121.68	\N	Jacksonville	37636.0
1700	96	1970-01-01	Processing	Google Pay	7792 Park Rd	\N	\N	2156.27	\N	Los Angeles	91691.0
1703	373	1970-01-01	Delivered	Debit Card	1145 Park Rd	1970-01-01	1970-01-01	363.88	\N	San Diego	93964.0
1706	292	1970-01-01	Delivered	Debit Card	4746 Park Rd	1970-01-01	1970-01-01	206.28	\N	Philadelphia	85750.0
1707	936	1970-01-01	Delivered	Debit Card	9469 Second Ave	1970-01-01	1970-01-01	335.37	\N	Charlotte	26759.0
1708	274	1970-01-01	Delivered	Credit Card	7180 First St	1970-01-01	1970-01-01	295.09	\N	Chicago	90492.0
1712	789	1970-01-01	Processing	Debit Card	5656 Second Ave	\N	\N	291.09	\N	San Jose	71402.0
1713	703	1970-01-01	Shipped	Apple Pay	408 First St	1970-01-01	\N	777.66	\N	Los Angeles	15572.0
1714	491	1970-01-01	Processing	Debit Card	4211 Second Ave	\N	\N	684.99	\N	Phoenix	16253.0
1715	617	1970-01-01	Delivered	Credit Card	7840 Main St	1970-01-01	1970-01-01	1272.56	\N	Houston	93058.0
1716	503	1970-01-01	Delivered	Credit Card	5788 First St	1970-01-01	1970-01-01	1141.64	\N	Charlotte	39770.0
1717	306	1970-01-01	Delivered	Credit Card	5177 Main St	1970-01-01	1970-01-01	2394.59	\N	Los Angeles	36633.0
1718	845	1970-01-01	Delivered	Debit Card	5281 Main St	1970-01-01	1970-01-01	64.90	\N	San Diego	35507.0
1720	43	1970-01-01	Delivered	Google Pay	5243 Main St	1970-01-01	1970-01-01	395.18	\N	San Jose	76469.0
1724	561	1970-01-01	Delivered	Apple Pay	8330 Second Ave	1970-01-01	1970-01-01	613.05	\N	Chicago	95140.0
1725	403	1970-01-01	Delivered	Credit Card	8155 Park Rd	1970-01-01	1970-01-01	0.00	\N	Los Angeles	53371.0
1726	539	1970-01-01	Delivered	Credit Card	5093 Second Ave	1970-01-01	1970-01-01	1516.50	\N	New York	51853.0
1727	535	1970-01-01	Delivered	Apple Pay	718 First St	1970-01-01	1970-01-01	1113.10	\N	Los Angeles	30461.0
1732	817	1970-01-01	Delivered	Debit Card	7511 Park Rd	1970-01-01	1970-01-01	658.94	\N	San Jose	72289.0
1733	965	1970-01-01	Shipped	Debit Card	3256 Park Rd	1970-01-01	\N	0.00	\N	Austin	96155.0
1734	309	1970-01-01	Delivered	Google Pay	4347 Oak Ave	1970-01-01	1970-01-01	237.67	\N	Fort Worth	26637.0
1735	723	1970-01-01	Shipped	Google Pay	9774 Main St	1970-01-01	\N	201.54	\N	New York	58026.0
1736	876	1970-01-01	Delivered	Debit Card	4378 Main St	1970-01-01	1970-01-01	1616.63	\N	Charlotte	46942.0
1737	788	1970-01-01	Delivered	Debit Card	7247 Main St	1970-01-01	1970-01-01	1095.51	\N	Jacksonville	47750.0
1738	840	1970-01-01	Delivered	Google Pay	3525 Main St	1970-01-01	1970-01-01	37.00	\N	San Diego	93681.0
1740	914	1970-01-01	Delivered	Credit Card	7812 First St	1970-01-01	1970-01-01	80.44	\N	Chicago	76229.0
1744	970	1970-01-01	Delivered	Credit Card	5310 First St	1970-01-01	1970-01-01	1251.87	\N	Chicago	55242.0
1745	236	1970-01-01	Delivered	Apple Pay	3220 Main St	1970-01-01	1970-01-01	495.43	\N	Jacksonville	59436.0
1746	279	1970-01-01	Shipped	Apple Pay	6386 First St	1970-01-01	\N	969.36	\N	San Jose	73788.0
1747	43	1970-01-01	Processing	Apple Pay	5243 Main St	\N	\N	1493.60	\N	San Jose	76469.0
1748	50	1970-01-01	Delivered	Apple Pay	9855 Park Rd	1970-01-01	1970-01-01	998.17	\N	Dallas	90301.0
1749	652	1970-01-01	Delivered	Debit Card	6961 Main St	1970-01-01	1970-01-01	720.02	\N	Philadelphia	40885.0
1750	880	1970-01-01	Delivered	Google Pay	6708 Second Ave	1970-01-01	1970-01-01	2794.52	\N	Austin	52739.0
1751	507	1970-01-01	Delivered	Apple Pay	7017 Oak Ave	1970-01-01	1970-01-01	48.86	\N	Los Angeles	90375.0
1753	593	1970-01-01	Delivered	Credit Card	5219 Main St	1970-01-01	1970-01-01	4804.95	\N	Dallas	50913.0
1754	121	1970-01-01	Processing	Google Pay	2167 Park Rd	\N	\N	361.75	\N	Los Angeles	92978.0
1755	263	1970-01-01	Delivered	Google Pay	3010 First St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	48200.0
1757	892	1970-01-01	Processing	Credit Card	1823 Second Ave	\N	\N	1209.30	\N	Los Angeles	63752.0
1760	499	1970-01-01	Shipped	Google Pay	531 First St	1970-01-01	\N	0.00	\N	New York	20911.0
1761	717	1970-01-01	Delivered	Apple Pay	538 Oak Ave	1970-01-01	1970-01-01	352.31	\N	San Diego	89244.0
1764	769	1970-01-01	Delivered	Credit Card	897 Park Rd	1970-01-01	1970-01-01	401.07	\N	Houston	17279.0
1765	20	1970-01-01	Processing	Debit Card	9455 Second Ave	\N	\N	246.78	\N	Chicago	41850.0
1766	168	1970-01-01	Delivered	Google Pay	5948 Main St	1970-01-01	1970-01-01	298.19	\N	Phoenix	53506.0
1767	387	1970-01-01	Delivered	Google Pay	3775 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Houston	12872.0
1768	215	1970-01-01	Delivered	Apple Pay	6743 First St	1970-01-01	1970-01-01	1311.38	\N	San Jose	52982.0
1771	547	1970-01-01	Delivered	Debit Card	5724 Main St	1970-01-01	1970-01-01	21.30	\N	New York	68990.0
1772	930	1970-01-01	Cancelled	Google Pay	8620 Park Rd	\N	\N	127.84	\N	San Jose	72027.0
1773	17	1970-01-01	Processing	Debit Card	8935 Oak Ave	\N	\N	1841.48	\N	Houston	50857.0
1774	209	1970-01-01	Pending	Google Pay	1741 First St	\N	\N	814.40	\N	New York	71918.0
1775	70	1970-01-01	Delivered	Google Pay	7534 Park Rd	1970-01-01	1970-01-01	1633.14	\N	Jacksonville	42951.0
1776	830	1970-01-01	Delivered	Google Pay	7042 Second Ave	1970-01-01	1970-01-01	0.00	\N	Dallas	15477.0
1778	62	1970-01-01	Pending	Credit Card	9800 Oak Ave	\N	\N	0.00	\N	Los Angeles	49529.0
1779	588	1970-01-01	Delivered	Google Pay	6482 Oak Ave	1970-01-01	1970-01-01	666.36	\N	San Jose	25315.0
1780	56	1970-01-01	Delivered	Apple Pay	6724 Oak Ave	1970-01-01	1970-01-01	520.94	\N	Austin	26728.0
1781	324	1970-01-01	Delivered	Apple Pay	9984 Main St	1970-01-01	1970-01-01	263.49	\N	Columbus	52964.0
1783	720	1970-01-01	Delivered	Google Pay	7631 Main St	1970-01-01	1970-01-01	345.48	\N	San Diego	33182.0
1784	775	1970-01-01	Delivered	Credit Card	2534 Oak Ave	1970-01-01	1970-01-01	984.22	\N	Phoenix	49375.0
1785	167	1970-01-01	Delivered	Debit Card	3368 Main St	1970-01-01	1970-01-01	705.46	\N	Fort Worth	50642.0
1786	13	1970-01-01	Pending	Credit Card	7223 Oak Ave	\N	\N	168.66	\N	Phoenix	10425.0
1787	462	1970-01-01	Delivered	Credit Card	6992 Park Rd	1970-01-01	1970-01-01	6668.68	\N	Dallas	79444.0
1788	884	1970-01-01	Cancelled	Google Pay	8691 Main St	\N	\N	0.00	\N	Austin	17530.0
1789	359	1970-01-01	Delivered	Debit Card	1830 Second Ave	1970-01-01	1970-01-01	369.53	\N	Charlotte	47498.0
1790	327	1970-01-01	Delivered	Debit Card	1476 Second Ave	1970-01-01	1970-01-01	3388.44	\N	Austin	43924.0
1791	517	1970-01-01	Pending	Credit Card	1566 Oak Ave	\N	\N	2083.35	\N	Fort Worth	75525.0
1792	89	1970-01-01	Delivered	Credit Card	1958 First St	1970-01-01	1970-01-01	1212.78	\N	Columbus	94896.0
1794	716	1970-01-01	Delivered	Apple Pay	8117 First St	1970-01-01	1970-01-01	191.72	\N	Phoenix	92361.0
1795	683	1970-01-01	Delivered	Google Pay	9360 First St	1970-01-01	1970-01-01	0.00	\N	Fort Worth	24721.0
1796	307	1970-01-01	Shipped	Debit Card	7267 Oak Ave	1970-01-01	\N	112.32	\N	Phoenix	42044.0
1798	281	1970-01-01	Delivered	Debit Card	8381 First St	1970-01-01	1970-01-01	0.00	\N	Dallas	99744.0
1799	245	1970-01-01	Delivered	Credit Card	8093 Main St	1970-01-01	1970-01-01	961.88	\N	Austin	79758.0
1800	963	1970-01-01	Delivered	Apple Pay	2205 Second Ave	1970-01-01	1970-01-01	24.07	\N	Phoenix	19746.0
1801	63	1970-01-01	Delivered	Debit Card	8389 Park Rd	1970-01-01	1970-01-01	3097.52	\N	Los Angeles	65057.0
1802	587	1970-01-01	Delivered	Apple Pay	5893 Main St	1970-01-01	1970-01-01	0.00	\N	Fort Worth	46760.0
1804	243	1970-01-01	Delivered	Apple Pay	8982 Main St	1970-01-01	1970-01-01	100.23	\N	Charlotte	14433.0
1805	954	1970-01-01	Shipped	Google Pay	290 Main St	1970-01-01	\N	103.47	\N	Philadelphia	20831.0
1806	765	1970-01-01	Delivered	Apple Pay	8435 Park Rd	1970-01-01	1970-01-01	0.00	\N	Jacksonville	96918.0
1807	628	1970-01-01	Shipped	Debit Card	4061 Second Ave	1970-01-01	\N	1825.06	\N	San Diego	78151.0
1808	705	1970-01-01	Delivered	Apple Pay	3377 Oak Ave	1970-01-01	1970-01-01	486.72	\N	San Jose	56076.0
1809	808	1970-01-01	Delivered	Debit Card	9857 Oak Ave	1970-01-01	1970-01-01	399.64	\N	Columbus	49216.0
1811	402	1970-01-01	Processing	Apple Pay	9247 Second Ave	\N	\N	857.52	\N	Chicago	11526.0
1812	816	1970-01-01	Pending	Credit Card	8108 Main St	\N	\N	0.00	\N	Chicago	81766.0
1815	113	1970-01-01	Delivered	Credit Card	7364 First St	1970-01-01	1970-01-01	1213.07	\N	Houston	57537.0
1816	121	1970-01-01	Shipped	Google Pay	2167 Park Rd	1970-01-01	\N	374.43	\N	Los Angeles	92978.0
1817	954	1970-01-01	Processing	Debit Card	290 Main St	\N	\N	923.80	\N	Philadelphia	20831.0
1818	841	1970-01-01	Shipped	Apple Pay	3274 Second Ave	1970-01-01	\N	1283.07	\N	Dallas	99441.0
1819	434	1970-01-01	Delivered	Credit Card	9694 Main St	1970-01-01	1970-01-01	1837.90	\N	Fort Worth	19514.0
1820	701	1970-01-01	Delivered	Apple Pay	7340 Second Ave	1970-01-01	1970-01-01	958.14	\N	Columbus	54832.0
1821	689	1970-01-01	Delivered	Google Pay	3504 Park Rd	1970-01-01	1970-01-01	871.65	\N	Chicago	78852.0
1822	839	1970-01-01	Delivered	Apple Pay	1574 Second Ave	1970-01-01	1970-01-01	484.23	\N	Houston	49738.0
1823	143	1970-01-01	Delivered	Apple Pay	7665 First St	1970-01-01	1970-01-01	1478.35	\N	Phoenix	17456.0
1824	576	1970-01-01	Delivered	Google Pay	1536 Main St	1970-01-01	1970-01-01	2555.07	\N	Philadelphia	64651.0
1825	450	1970-01-01	Cancelled	Credit Card	6018 First St	\N	\N	260.19	\N	Dallas	69591.0
1826	94	1970-01-01	Shipped	Google Pay	7849 First St	1970-01-01	\N	560.14	\N	Philadelphia	96991.0
1827	466	1970-01-01	Delivered	Apple Pay	8883 First St	1970-01-01	1970-01-01	0.00	\N	Columbus	57925.0
1828	543	1970-01-01	Delivered	Debit Card	8689 Oak Ave	1970-01-01	1970-01-01	95.45	\N	Dallas	19390.0
1829	872	1970-01-01	Delivered	Apple Pay	7491 First St	1970-01-01	1970-01-01	364.22	\N	San Antonio	63602.0
1830	741	1970-01-01	Delivered	Apple Pay	7300 First St	1970-01-01	1970-01-01	45.14	\N	Phoenix	87264.0
1831	808	1970-01-01	Delivered	Credit Card	9857 Oak Ave	1970-01-01	1970-01-01	939.90	\N	Columbus	49216.0
1832	321	1970-01-01	Delivered	Credit Card	5261 First St	1970-01-01	1970-01-01	1374.22	\N	Phoenix	52762.0
1833	486	1970-01-01	Delivered	Google Pay	237 Main St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	37623.0
1834	1	1970-01-01	Delivered	Debit Card	1779 Second Ave	1970-01-01	1970-01-01	9590.56	\N	Chicago	87397.0
1836	631	1970-01-01	Shipped	Debit Card	2065 Main St	1970-01-01	\N	935.40	\N	Jacksonville	27027.0
1837	36	1970-01-01	Shipped	Apple Pay	785 Park Rd	1970-01-01	\N	359.74	\N	Chicago	15229.0
1838	489	1970-01-01	Delivered	Credit Card	1736 Park Rd	1970-01-01	1970-01-01	1271.95	\N	Columbus	82789.0
1839	632	1970-01-01	Delivered	Debit Card	4926 First St	1970-01-01	1970-01-01	669.28	\N	Phoenix	19924.0
1840	362	1970-01-01	Cancelled	Debit Card	5065 Park Rd	\N	\N	398.83	\N	Columbus	74437.0
1841	108	1970-01-01	Processing	Debit Card	9231 Park Rd	\N	\N	635.76	\N	Columbus	61717.0
1842	345	1970-01-01	Shipped	Credit Card	6883 First St	1970-01-01	\N	279.08	\N	Charlotte	56036.0
1843	611	1970-01-01	Processing	Debit Card	2941 First St	\N	\N	0.00	\N	Houston	34671.0
1846	572	1970-01-01	Pending	Apple Pay	5171 First St	\N	\N	108.42	\N	Phoenix	92110.0
1847	185	1970-01-01	Delivered	Google Pay	9613 Oak Ave	1970-01-01	1970-01-01	87.65	\N	San Jose	96341.0
1848	82	1970-01-01	Shipped	Debit Card	753 First St	1970-01-01	\N	6718.18	\N	San Jose	89129.0
1849	122	1970-01-01	Delivered	Apple Pay	7148 Main St	1970-01-01	1970-01-01	0.00	\N	Dallas	24996.0
1850	748	1970-01-01	Delivered	Debit Card	2329 Main St	1970-01-01	1970-01-01	214.62	\N	Fort Worth	36224.0
1851	140	1970-01-01	Delivered	Credit Card	1784 Oak Ave	1970-01-01	1970-01-01	60.84	\N	Houston	35856.0
1856	570	1970-01-01	Shipped	Credit Card	8682 First St	1970-01-01	\N	656.63	\N	Los Angeles	90225.0
1857	316	1970-01-01	Delivered	Debit Card	9337 Park Rd	1970-01-01	1970-01-01	94.52	\N	Phoenix	41795.0
1858	699	1970-01-01	Delivered	Apple Pay	8347 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Chicago	83224.0
1859	203	1970-01-01	Processing	Credit Card	1120 Oak Ave	\N	\N	1185.60	\N	Columbus	37176.0
1860	559	1970-01-01	Delivered	Debit Card	7358 Park Rd	1970-01-01	1970-01-01	5803.53	\N	Phoenix	34632.0
1861	672	1970-01-01	Delivered	Credit Card	8066 Second Ave	1970-01-01	1970-01-01	712.85	\N	San Diego	26083.0
1862	647	1970-01-01	Delivered	Apple Pay	2079 Second Ave	1970-01-01	1970-01-01	422.72	\N	Philadelphia	28000.0
1863	470	1970-01-01	Processing	Google Pay	2481 First St	\N	\N	57.32	\N	Columbus	67065.0
1864	477	1970-01-01	Shipped	Google Pay	5670 Main St	1970-01-01	\N	0.00	\N	Phoenix	43776.0
1865	670	1970-01-01	Pending	Apple Pay	3454 Oak Ave	\N	\N	2069.33	\N	Dallas	41278.0
1866	768	1970-01-01	Delivered	Credit Card	4512 Second Ave	1970-01-01	1970-01-01	1296.10	\N	San Diego	10760.0
1867	220	1970-01-01	Shipped	Google Pay	7419 Second Ave	1970-01-01	\N	688.06	\N	Dallas	57419.0
1868	817	1970-01-01	Pending	Apple Pay	7511 Park Rd	\N	\N	0.00	\N	San Jose	72289.0
1869	896	1970-01-01	Delivered	Credit Card	8859 First St	1970-01-01	1970-01-01	137.22	\N	Los Angeles	20169.0
1870	972	1970-01-01	Delivered	Credit Card	6164 Oak Ave	1970-01-01	1970-01-01	97.10	\N	New York	89783.0
1871	724	1970-01-01	Delivered	Credit Card	7114 Park Rd	1970-01-01	1970-01-01	153.68	\N	Los Angeles	63992.0
1872	580	1970-01-01	Delivered	Apple Pay	4805 First St	1970-01-01	1970-01-01	90.57	\N	San Diego	51482.0
1873	864	1970-01-01	Processing	Credit Card	2907 Second Ave	\N	\N	2514.11	\N	Austin	66848.0
1875	775	1970-01-01	Delivered	Credit Card	2534 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Phoenix	49375.0
1876	423	1970-01-01	Shipped	Apple Pay	7120 Park Rd	1970-01-01	\N	98.05	\N	New York	44634.0
1877	285	1970-01-01	Delivered	Apple Pay	1525 First St	1970-01-01	1970-01-01	727.85	\N	Philadelphia	41056.0
1878	985	1970-01-01	Cancelled	Debit Card	3205 Park Rd	\N	\N	195.34	\N	Los Angeles	27521.0
1879	6	1970-01-01	Delivered	Debit Card	4654 First St	1970-01-01	1970-01-01	5551.54	\N	San Antonio	57819.0
1880	735	1970-01-01	Delivered	Apple Pay	9950 Oak Ave	1970-01-01	1970-01-01	4300.04	\N	Phoenix	41258.0
1881	764	1970-01-01	Processing	Debit Card	8177 Main St	\N	\N	0.00	\N	San Diego	26207.0
1882	519	1970-01-01	Delivered	Credit Card	7287 Oak Ave	1970-01-01	1970-01-01	127.10	\N	Fort Worth	59514.0
1883	900	1970-01-01	Cancelled	Credit Card	2836 Main St	\N	\N	254.98	\N	Jacksonville	77174.0
1884	143	1970-01-01	Shipped	Apple Pay	7665 First St	1970-01-01	\N	175.37	\N	Phoenix	17456.0
1885	467	1970-01-01	Delivered	Google Pay	6165 Second Ave	1970-01-01	1970-01-01	45.03	\N	Chicago	73407.0
1886	131	1970-01-01	Shipped	Apple Pay	915 Main St	1970-01-01	\N	0.00	\N	Fort Worth	68079.0
1887	324	1970-01-01	Delivered	Apple Pay	9984 Main St	1970-01-01	1970-01-01	44.20	\N	Columbus	52964.0
1888	415	1970-01-01	Processing	Apple Pay	9075 Park Rd	\N	\N	472.42	\N	Phoenix	82559.0
1889	993	1970-01-01	Delivered	Credit Card	7097 Main St	1970-01-01	1970-01-01	861.48	\N	Dallas	24425.0
1891	607	1970-01-01	Delivered	Credit Card	2503 Oak Ave	1970-01-01	1970-01-01	194.23	\N	Fort Worth	79632.0
1892	24	1970-01-01	Processing	Google Pay	6758 First St	\N	\N	0.00	\N	Chicago	38016.0
1893	415	1970-01-01	Delivered	Credit Card	9075 Park Rd	1970-01-01	1970-01-01	376.25	\N	Phoenix	82559.0
1895	631	1970-01-01	Delivered	Apple Pay	2065 Main St	1970-01-01	1970-01-01	1423.61	\N	Jacksonville	27027.0
1896	836	1970-01-01	Delivered	Apple Pay	6535 Second Ave	1970-01-01	1970-01-01	511.30	\N	Fort Worth	95078.0
1897	29	1970-01-01	Shipped	Credit Card	4451 First St	1970-01-01	\N	915.24	\N	Houston	98039.0
1898	547	1970-01-01	Pending	Google Pay	5724 Main St	\N	\N	376.02	\N	New York	68990.0
1899	407	1970-01-01	Delivered	Google Pay	989 Oak Ave	1970-01-01	1970-01-01	6617.75	\N	Philadelphia	53512.0
1900	301	1970-01-01	Shipped	Google Pay	9166 Second Ave	1970-01-01	\N	782.98	\N	Houston	89638.0
1901	924	1970-01-01	Cancelled	Credit Card	3532 First St	\N	\N	366.99	\N	Phoenix	50383.0
1902	481	1970-01-01	Delivered	Google Pay	3680 Second Ave	1970-01-01	1970-01-01	215.82	\N	Philadelphia	33957.0
1904	998	1970-01-01	Processing	Google Pay	7403 Main St	\N	\N	972.40	\N	Houston	81641.0
1905	650	1970-01-01	Delivered	Debit Card	9827 Park Rd	1970-01-01	1970-01-01	663.38	\N	Jacksonville	72391.0
1906	513	1970-01-01	Delivered	Debit Card	7357 Oak Ave	1970-01-01	1970-01-01	189.09	\N	San Antonio	36106.0
1907	479	1970-01-01	Shipped	Debit Card	3710 Oak Ave	1970-01-01	\N	782.33	\N	San Antonio	64057.0
1909	726	1970-01-01	Delivered	Debit Card	7021 Second Ave	1970-01-01	1970-01-01	117.99	\N	Austin	65203.0
1910	27	1970-01-01	Shipped	Apple Pay	3144 Main St	1970-01-01	\N	3426.94	\N	Columbus	18907.0
1911	24	1970-01-01	Shipped	Debit Card	6758 First St	1970-01-01	\N	175.24	\N	Chicago	38016.0
1912	111	1970-01-01	Shipped	Debit Card	1692 Oak Ave	1970-01-01	\N	732.88	\N	Los Angeles	27781.0
1913	292	1970-01-01	Delivered	Debit Card	4746 Park Rd	1970-01-01	1970-01-01	40.82	\N	Philadelphia	85750.0
1915	973	1970-01-01	Delivered	Credit Card	4799 Park Rd	1970-01-01	1970-01-01	376.45	\N	Dallas	78235.0
1916	585	1970-01-01	Pending	Google Pay	7874 Main St	\N	\N	1668.52	\N	Charlotte	27793.0
1917	715	1970-01-01	Shipped	Apple Pay	7895 Second Ave	1970-01-01	\N	0.00	\N	Philadelphia	73508.0
1918	142	1970-01-01	Shipped	Google Pay	7305 Main St	1970-01-01	\N	0.00	\N	Chicago	67961.0
1919	656	1970-01-01	Pending	Google Pay	1260 Oak Ave	\N	\N	0.00	\N	Los Angeles	87687.0
1920	169	1970-01-01	Delivered	Credit Card	6434 Park Rd	1970-01-01	1970-01-01	1267.64	\N	Charlotte	75038.0
1921	662	1970-01-01	Processing	Credit Card	7681 Park Rd	\N	\N	0.00	\N	Columbus	66113.0
1922	383	1970-01-01	Delivered	Google Pay	7921 First St	1970-01-01	1970-01-01	368.58	\N	San Antonio	14944.0
1923	963	1970-01-01	Shipped	Debit Card	2205 Second Ave	1970-01-01	\N	1981.60	\N	Phoenix	19746.0
1924	821	1970-01-01	Delivered	Google Pay	7896 Second Ave	1970-01-01	1970-01-01	194.01	\N	Fort Worth	25765.0
1925	438	1970-01-01	Delivered	Apple Pay	5733 Oak Ave	1970-01-01	1970-01-01	300.18	\N	Jacksonville	94663.0
1926	597	1970-01-01	Delivered	Credit Card	926 Main St	1970-01-01	1970-01-01	223.58	\N	Charlotte	17051.0
1927	139	1970-01-01	Delivered	Google Pay	8463 Main St	1970-01-01	1970-01-01	14504.38	\N	Los Angeles	76840.0
1928	577	1970-01-01	Delivered	Debit Card	9585 Park Rd	1970-01-01	1970-01-01	176.15	\N	San Diego	22206.0
1929	932	1970-01-01	Processing	Google Pay	1741 Main St	\N	\N	103.47	\N	Fort Worth	62665.0
1930	444	1970-01-01	Delivered	Debit Card	9138 Main St	1970-01-01	1970-01-01	406.73	\N	San Diego	94613.0
1931	440	1970-01-01	Processing	Credit Card	1203 Park Rd	\N	\N	2320.46	\N	Austin	35875.0
1932	305	1970-01-01	Delivered	Credit Card	4793 Second Ave	1970-01-01	1970-01-01	0.00	\N	Dallas	65518.0
1933	849	1970-01-01	Delivered	Google Pay	2145 Main St	1970-01-01	1970-01-01	656.59	\N	San Jose	14370.0
1934	158	1970-01-01	Delivered	Debit Card	8324 Park Rd	1970-01-01	1970-01-01	200.65	\N	San Antonio	60615.0
1935	455	1970-01-01	Shipped	Debit Card	9779 Oak Ave	1970-01-01	\N	416.10	\N	Houston	63857.0
1936	956	1970-01-01	Shipped	Credit Card	8906 Oak Ave	1970-01-01	\N	236.27	\N	Los Angeles	12588.0
1937	305	1970-01-01	Delivered	Debit Card	4793 Second Ave	1970-01-01	1970-01-01	0.00	\N	Dallas	65518.0
1940	633	1970-01-01	Delivered	Apple Pay	2753 Main St	1970-01-01	1970-01-01	0.00	\N	Phoenix	18177.0
1941	831	1970-01-01	Delivered	Credit Card	8000 Park Rd	1970-01-01	1970-01-01	1326.02	\N	New York	42884.0
1942	272	1970-01-01	Delivered	Credit Card	1200 Park Rd	1970-01-01	1970-01-01	3361.83	\N	Philadelphia	25084.0
1943	15	1970-01-01	Delivered	Google Pay	5410 First St	1970-01-01	1970-01-01	0.00	\N	San Jose	24662.0
1944	645	1970-01-01	Delivered	Google Pay	2238 Main St	1970-01-01	1970-01-01	492.44	\N	Jacksonville	92924.0
1945	362	1970-01-01	Delivered	Debit Card	5065 Park Rd	1970-01-01	1970-01-01	161.96	\N	Columbus	74437.0
1946	849	1970-01-01	Processing	Google Pay	2145 Main St	\N	\N	208.42	\N	San Jose	14370.0
1949	321	1970-01-01	Cancelled	Apple Pay	5261 First St	\N	\N	135.14	\N	Phoenix	52762.0
1952	260	1970-01-01	Shipped	Google Pay	6999 Park Rd	1970-01-01	\N	0.00	\N	Phoenix	20082.0
1953	619	1970-01-01	Delivered	Google Pay	2844 Main St	1970-01-01	1970-01-01	20.41	\N	Phoenix	88333.0
1954	652	1970-01-01	Delivered	Debit Card	6961 Main St	1970-01-01	1970-01-01	222.26	\N	Philadelphia	40885.0
1956	144	1970-01-01	Pending	Apple Pay	9833 Second Ave	\N	\N	171.65	\N	San Jose	70648.0
1957	671	1970-01-01	Delivered	Google Pay	3793 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	45043.0
1958	813	1970-01-01	Shipped	Apple Pay	3583 First St	1970-01-01	\N	0.00	\N	Los Angeles	14273.0
1959	126	1970-01-01	Pending	Credit Card	942 Park Rd	\N	\N	0.00	\N	Columbus	50953.0
1960	873	1970-01-01	Delivered	Apple Pay	3930 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Diego	19946.0
1961	23	1970-01-01	Pending	Debit Card	9116 Main St	\N	\N	273.50	\N	San Diego	95477.0
1962	475	1970-01-01	Cancelled	Debit Card	1577 Second Ave	\N	\N	179.22	\N	Charlotte	83284.0
1963	28	1970-01-01	Processing	Credit Card	1443 First St	\N	\N	321.95	\N	San Jose	86503.0
1965	745	1970-01-01	Delivered	Apple Pay	3957 Park Rd	1970-01-01	1970-01-01	907.72	\N	Charlotte	31001.0
1967	733	1970-01-01	Delivered	Debit Card	9375 Main St	1970-01-01	1970-01-01	770.55	\N	Charlotte	36299.0
1968	426	1970-01-01	Cancelled	Apple Pay	1606 Park Rd	\N	\N	0.00	\N	San Antonio	37964.0
1969	398	1970-01-01	Delivered	Credit Card	7009 Oak Ave	1970-01-01	1970-01-01	95.98	\N	Fort Worth	27368.0
1970	692	1970-01-01	Delivered	Credit Card	140 Oak Ave	1970-01-01	1970-01-01	328.99	\N	Fort Worth	49343.0
1971	714	1970-01-01	Delivered	Debit Card	6723 Main St	1970-01-01	1970-01-01	3409.91	\N	San Jose	65666.0
1972	409	1970-01-01	Delivered	Debit Card	8652 Park Rd	1970-01-01	1970-01-01	1912.03	\N	Dallas	23935.0
1973	817	1970-01-01	Delivered	Apple Pay	7511 Park Rd	1970-01-01	1970-01-01	748.53	\N	San Jose	72289.0
1974	347	1970-01-01	Delivered	Credit Card	6251 Oak Ave	1970-01-01	1970-01-01	239.00	\N	Chicago	81702.0
1975	762	1970-01-01	Delivered	Debit Card	8149 Oak Ave	1970-01-01	1970-01-01	239.00	\N	Philadelphia	96169.0
1976	647	1970-01-01	Delivered	Apple Pay	2079 Second Ave	1970-01-01	1970-01-01	631.50	\N	Philadelphia	28000.0
1977	848	1970-01-01	Delivered	Apple Pay	991 Park Rd	1970-01-01	1970-01-01	0.00	\N	Columbus	41030.0
1978	836	1970-01-01	Delivered	Google Pay	6535 Second Ave	1970-01-01	1970-01-01	1808.01	\N	Fort Worth	95078.0
1979	745	1970-01-01	Delivered	Google Pay	3957 Park Rd	1970-01-01	1970-01-01	232.97	\N	Charlotte	31001.0
1980	890	1970-01-01	Delivered	Google Pay	6402 Oak Ave	1970-01-01	1970-01-01	3191.22	\N	San Diego	84529.0
1981	797	1970-01-01	Delivered	Debit Card	3407 First St	1970-01-01	1970-01-01	334.75	\N	Columbus	10863.0
1982	143	1970-01-01	Processing	Debit Card	7665 First St	\N	\N	920.34	\N	Phoenix	17456.0
1983	218	1970-01-01	Pending	Apple Pay	5195 Main St	\N	\N	1249.60	\N	Charlotte	48671.0
1984	592	1970-01-01	Delivered	Google Pay	8658 Main St	1970-01-01	1970-01-01	310.54	\N	San Antonio	50760.0
1985	645	1970-01-01	Cancelled	Debit Card	2238 Main St	\N	\N	175.77	\N	Jacksonville	92924.0
1986	52	1970-01-01	Shipped	Debit Card	4551 Park Rd	1970-01-01	\N	13028.44	\N	Houston	80798.0
1987	573	1970-01-01	Processing	Apple Pay	7614 First St	\N	\N	398.65	\N	New York	81237.0
1988	35	1970-01-01	Delivered	Credit Card	258 Main St	1970-01-01	1970-01-01	259.12	\N	Dallas	29536.0
1991	492	1970-01-01	Delivered	Apple Pay	1677 First St	1970-01-01	1970-01-01	77.40	\N	San Diego	44048.0
1992	842	1970-01-01	Delivered	Credit Card	4353 Second Ave	1970-01-01	1970-01-01	481.77	\N	Chicago	78561.0
1993	952	1970-01-01	Processing	Google Pay	5645 Second Ave	\N	\N	147.78	\N	Austin	29473.0
1994	409	1970-01-01	Delivered	Credit Card	8652 Park Rd	1970-01-01	1970-01-01	0.00	\N	Dallas	23935.0
1995	18	1970-01-01	Processing	Debit Card	3781 Main St	\N	\N	508.88	\N	Houston	12757.0
1998	443	1970-01-01	Delivered	Debit Card	3729 First St	1970-01-01	1970-01-01	1596.03	\N	Fort Worth	57118.0
1999	349	1970-01-01	Delivered	Apple Pay	4712 Park Rd	1970-01-01	1970-01-01	172.96	\N	Phoenix	22571.0
2000	226	1970-01-01	Pending	Apple Pay	5797 Main St	\N	\N	1670.46	\N	Chicago	80419.0
2002	608	1970-01-01	Processing	Credit Card	5287 Park Rd	\N	\N	7663.99	\N	Austin	99071.0
2005	697	1970-01-01	Delivered	Credit Card	5385 Park Rd	1970-01-01	1970-01-01	8468.51	\N	Dallas	49462.0
2006	171	1970-01-01	Delivered	Google Pay	7405 Second Ave	1970-01-01	1970-01-01	400.88	\N	Phoenix	31842.0
2007	353	1970-01-01	Pending	Debit Card	4415 Oak Ave	\N	\N	231.93	\N	San Diego	83956.0
2008	936	1970-01-01	Processing	Google Pay	9469 Second Ave	\N	\N	0.00	\N	Charlotte	26759.0
2009	199	1970-01-01	Processing	Credit Card	8125 Second Ave	\N	\N	959.19	\N	Dallas	72245.0
2010	309	1970-01-01	Shipped	Debit Card	4347 Oak Ave	1970-01-01	\N	363.72	\N	Fort Worth	26637.0
2011	740	1970-01-01	Delivered	Google Pay	5234 Park Rd	1970-01-01	1970-01-01	260.70	\N	Fort Worth	61111.0
2013	582	1970-01-01	Delivered	Apple Pay	2032 Oak Ave	1970-01-01	1970-01-01	929.34	\N	Austin	64346.0
2014	891	1970-01-01	Processing	Credit Card	8910 Park Rd	\N	\N	1332.72	\N	Charlotte	18748.0
2015	299	1970-01-01	Delivered	Apple Pay	5853 Oak Ave	1970-01-01	1970-01-01	80.74	\N	San Diego	29840.0
2016	286	1970-01-01	Delivered	Apple Pay	2381 Oak Ave	1970-01-01	1970-01-01	2824.24	\N	Chicago	17780.0
2017	938	1970-01-01	Delivered	Google Pay	7225 Main St	1970-01-01	1970-01-01	1404.09	\N	Los Angeles	52795.0
2018	98	1970-01-01	Delivered	Google Pay	1746 First St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	49251.0
2019	434	1970-01-01	Shipped	Apple Pay	9694 Main St	1970-01-01	\N	24.29	\N	Fort Worth	19514.0
2020	241	1970-01-01	Delivered	Credit Card	2597 Oak Ave	1970-01-01	1970-01-01	401.97	\N	Phoenix	40149.0
2022	297	1970-01-01	Delivered	Credit Card	7019 Oak Ave	1970-01-01	1970-01-01	198.05	\N	Columbus	19283.0
2023	203	1970-01-01	Delivered	Google Pay	1120 Oak Ave	1970-01-01	1970-01-01	199.80	\N	Columbus	37176.0
2024	287	1970-01-01	Delivered	Credit Card	4894 Park Rd	1970-01-01	1970-01-01	139.18	\N	Philadelphia	45041.0
2025	886	1970-01-01	Processing	Apple Pay	3469 Park Rd	\N	\N	379.80	\N	Columbus	97135.0
2026	745	1970-01-01	Delivered	Apple Pay	3957 Park Rd	1970-01-01	1970-01-01	12.06	\N	Charlotte	31001.0
2027	897	1970-01-01	Delivered	Google Pay	664 Second Ave	1970-01-01	1970-01-01	71.00	\N	Jacksonville	67941.0
2028	831	1970-01-01	Delivered	Debit Card	8000 Park Rd	1970-01-01	1970-01-01	215.65	\N	New York	42884.0
2029	661	1970-01-01	Delivered	Google Pay	2884 Second Ave	1970-01-01	1970-01-01	1001.43	\N	Fort Worth	40107.0
2030	104	1970-01-01	Shipped	Credit Card	8238 Park Rd	1970-01-01	\N	898.69	\N	Charlotte	89569.0
2031	508	1970-01-01	Shipped	Debit Card	1221 Oak Ave	1970-01-01	\N	194.06	\N	Columbus	47957.0
2032	956	1970-01-01	Delivered	Credit Card	8906 Oak Ave	1970-01-01	1970-01-01	164.57	\N	Los Angeles	12588.0
2033	792	1970-01-01	Shipped	Google Pay	4373 Park Rd	1970-01-01	\N	137.96	\N	Charlotte	30788.0
2035	331	1970-01-01	Delivered	Credit Card	4683 First St	1970-01-01	1970-01-01	723.57	\N	Los Angeles	64949.0
2037	697	1970-01-01	Delivered	Apple Pay	5385 Park Rd	1970-01-01	1970-01-01	0.00	\N	Dallas	49462.0
2038	697	1970-01-01	Shipped	Apple Pay	5385 Park Rd	1970-01-01	\N	218.81	\N	Dallas	49462.0
2039	627	1970-01-01	Delivered	Apple Pay	7174 Second Ave	1970-01-01	1970-01-01	697.54	\N	Columbus	45728.0
2040	970	1970-01-01	Delivered	Apple Pay	5310 First St	1970-01-01	1970-01-01	481.60	\N	Chicago	55242.0
2041	278	1970-01-01	Delivered	Apple Pay	4008 Park Rd	1970-01-01	1970-01-01	195.44	\N	Los Angeles	33992.0
2042	756	1970-01-01	Delivered	Google Pay	4168 Park Rd	1970-01-01	1970-01-01	241.30	\N	Charlotte	99688.0
2043	28	1970-01-01	Shipped	Debit Card	1443 First St	1970-01-01	\N	30.28	\N	San Jose	86503.0
2044	103	1970-01-01	Delivered	Apple Pay	4947 Park Rd	1970-01-01	1970-01-01	470.31	\N	San Jose	96275.0
2045	473	1970-01-01	Delivered	Credit Card	3895 Second Ave	1970-01-01	1970-01-01	926.44	\N	Dallas	98345.0
2047	185	1970-01-01	Cancelled	Google Pay	9613 Oak Ave	\N	\N	0.00	\N	San Jose	96341.0
2048	324	1970-01-01	Delivered	Debit Card	9984 Main St	1970-01-01	1970-01-01	2869.75	\N	Columbus	52964.0
2049	989	1970-01-01	Delivered	Debit Card	2598 Second Ave	1970-01-01	1970-01-01	568.97	\N	Houston	42698.0
2050	633	1970-01-01	Delivered	Credit Card	2753 Main St	1970-01-01	1970-01-01	449.74	\N	Phoenix	18177.0
2052	587	1970-01-01	Delivered	Credit Card	5893 Main St	1970-01-01	1970-01-01	480.94	\N	Fort Worth	46760.0
2053	320	1970-01-01	Delivered	Debit Card	2287 First St	1970-01-01	1970-01-01	80.44	\N	Dallas	87580.0
2054	530	1970-01-01	Delivered	Apple Pay	7615 First St	1970-01-01	1970-01-01	752.46	\N	Austin	31864.0
2055	759	1970-01-01	Delivered	Apple Pay	6176 Oak Ave	1970-01-01	1970-01-01	1335.44	\N	San Antonio	15390.0
2056	135	1970-01-01	Shipped	Debit Card	3870 Second Ave	1970-01-01	\N	211.89	\N	Jacksonville	97562.0
2058	212	1970-01-01	Delivered	Credit Card	8216 Oak Ave	1970-01-01	1970-01-01	380.92	\N	Fort Worth	14910.0
2059	185	1970-01-01	Pending	Credit Card	9613 Oak Ave	\N	\N	823.62	\N	San Jose	96341.0
2061	51	1970-01-01	Delivered	Apple Pay	4346 Oak Ave	1970-01-01	1970-01-01	244.35	\N	San Diego	46347.0
2063	446	1970-01-01	Delivered	Google Pay	700 Second Ave	1970-01-01	1970-01-01	380.84	\N	Charlotte	81233.0
2064	359	1970-01-01	Delivered	Credit Card	1830 Second Ave	1970-01-01	1970-01-01	658.37	\N	Charlotte	47498.0
2065	928	1970-01-01	Shipped	Google Pay	1152 Park Rd	1970-01-01	\N	0.00	\N	Phoenix	86761.0
2067	654	1970-01-01	Delivered	Google Pay	7872 First St	1970-01-01	1970-01-01	362.65	\N	Austin	30940.0
2068	991	1970-01-01	Shipped	Apple Pay	2267 First St	1970-01-01	\N	105.90	\N	Los Angeles	45895.0
2069	534	1970-01-01	Shipped	Apple Pay	5020 Oak Ave	1970-01-01	\N	51.78	\N	New York	51275.0
2070	689	1970-01-01	Delivered	Apple Pay	3504 Park Rd	1970-01-01	1970-01-01	1801.75	\N	Chicago	78852.0
2072	84	1970-01-01	Delivered	Debit Card	8156 Main St	1970-01-01	1970-01-01	2329.12	\N	Austin	55607.0
2074	446	1970-01-01	Delivered	Google Pay	700 Second Ave	1970-01-01	1970-01-01	143.40	\N	Charlotte	81233.0
2075	796	1970-01-01	Delivered	Debit Card	4886 First St	1970-01-01	1970-01-01	1604.62	\N	Jacksonville	75325.0
2076	777	1970-01-01	Delivered	Google Pay	4275 Second Ave	1970-01-01	1970-01-01	886.73	\N	Philadelphia	75987.0
2077	762	1970-01-01	Delivered	Credit Card	8149 Oak Ave	1970-01-01	1970-01-01	211.12	\N	Philadelphia	96169.0
2078	399	1970-01-01	Delivered	Apple Pay	6321 Park Rd	1970-01-01	1970-01-01	159.24	\N	Chicago	13777.0
2079	17	1970-01-01	Delivered	Debit Card	8935 Oak Ave	1970-01-01	1970-01-01	107.59	\N	Houston	50857.0
2080	922	1970-01-01	Shipped	Google Pay	9703 Main St	1970-01-01	\N	8351.02	\N	San Antonio	34749.0
2081	58	1970-01-01	Cancelled	Apple Pay	6311 Park Rd	\N	\N	2327.55	\N	Philadelphia	43065.0
2082	346	1970-01-01	Delivered	Apple Pay	7493 Main St	1970-01-01	1970-01-01	161.48	\N	Chicago	48654.0
2083	611	1970-01-01	Delivered	Apple Pay	2941 First St	1970-01-01	1970-01-01	513.80	\N	Houston	34671.0
2084	285	1970-01-01	Delivered	Debit Card	1525 First St	1970-01-01	1970-01-01	183.94	\N	Philadelphia	41056.0
2086	226	1970-01-01	Delivered	Apple Pay	5797 Main St	1970-01-01	1970-01-01	1720.73	\N	Chicago	80419.0
2087	845	1970-01-01	Processing	Google Pay	5281 Main St	\N	\N	287.77	\N	San Diego	35507.0
2088	984	1970-01-01	Shipped	Apple Pay	7298 Oak Ave	1970-01-01	\N	1769.26	\N	San Diego	56365.0
2089	445	1970-01-01	Delivered	Credit Card	1352 Main St	1970-01-01	1970-01-01	31.71	\N	Jacksonville	76476.0
2091	483	1970-01-01	Delivered	Google Pay	208 Second Ave	1970-01-01	1970-01-01	273.50	\N	San Jose	73214.0
2093	163	1970-01-01	Delivered	Credit Card	1502 Second Ave	1970-01-01	1970-01-01	5463.12	\N	Chicago	18870.0
2094	485	1970-01-01	Delivered	Google Pay	8959 Main St	1970-01-01	1970-01-01	804.49	\N	San Diego	55519.0
2095	653	1970-01-01	Delivered	Credit Card	3692 First St	1970-01-01	1970-01-01	878.03	\N	Dallas	96419.0
2098	879	1970-01-01	Delivered	Google Pay	2376 Second Ave	1970-01-01	1970-01-01	1470.00	\N	Philadelphia	50051.0
2100	982	1970-01-01	Shipped	Credit Card	1488 Second Ave	1970-01-01	\N	557.19	\N	Houston	30147.0
2101	961	1970-01-01	Delivered	Google Pay	5227 Second Ave	1970-01-01	1970-01-01	21.44	\N	Jacksonville	89452.0
2102	839	1970-01-01	Processing	Debit Card	1574 Second Ave	\N	\N	1838.54	\N	Houston	49738.0
2103	471	1970-01-01	Shipped	Debit Card	6396 First St	1970-01-01	\N	0.00	\N	Jacksonville	96006.0
2104	783	1970-01-01	Delivered	Debit Card	1510 Park Rd	1970-01-01	1970-01-01	483.82	\N	Houston	29420.0
2105	980	1970-01-01	Delivered	Credit Card	5094 Second Ave	1970-01-01	1970-01-01	476.40	\N	Houston	70693.0
2107	393	1970-01-01	Delivered	Credit Card	3942 Main St	1970-01-01	1970-01-01	1277.65	\N	Philadelphia	98032.0
2108	655	1970-01-01	Processing	Debit Card	7524 Main St	\N	\N	1070.03	\N	Philadelphia	16875.0
2109	91	1970-01-01	Delivered	Google Pay	1243 Park Rd	1970-01-01	1970-01-01	470.65	\N	Columbus	54548.0
2111	220	1970-01-01	Delivered	Credit Card	7419 Second Ave	1970-01-01	1970-01-01	360.93	\N	Dallas	57419.0
2112	876	1970-01-01	Shipped	Apple Pay	4378 Main St	1970-01-01	\N	9103.91	\N	Charlotte	46942.0
2113	128	1970-01-01	Pending	Google Pay	4481 Main St	\N	\N	403.49	\N	San Jose	45818.0
2114	492	1970-01-01	Delivered	Debit Card	1677 First St	1970-01-01	1970-01-01	2896.14	\N	San Diego	44048.0
2115	544	1970-01-01	Delivered	Google Pay	6876 First St	1970-01-01	1970-01-01	5475.87	\N	Austin	55653.0
2117	953	1970-01-01	Delivered	Credit Card	9867 Oak Ave	1970-01-01	1970-01-01	6099.60	\N	Phoenix	59200.0
2118	632	1970-01-01	Delivered	Credit Card	4926 First St	1970-01-01	1970-01-01	352.98	\N	Phoenix	19924.0
2119	871	1970-01-01	Delivered	Credit Card	1476 Park Rd	1970-01-01	1970-01-01	119.28	\N	Fort Worth	78002.0
2120	459	1970-01-01	Delivered	Credit Card	7529 Second Ave	1970-01-01	1970-01-01	49.67	\N	Charlotte	19023.0
2121	625	1970-01-01	Delivered	Google Pay	7903 Second Ave	1970-01-01	1970-01-01	5101.34	\N	Phoenix	59781.0
2122	616	1970-01-01	Shipped	Apple Pay	7989 Main St	1970-01-01	\N	0.00	\N	San Jose	78997.0
2123	725	1970-01-01	Shipped	Apple Pay	1491 Main St	1970-01-01	\N	236.40	\N	San Jose	25003.0
2124	765	1970-01-01	Shipped	Apple Pay	8435 Park Rd	1970-01-01	\N	6.41	\N	Jacksonville	96918.0
2125	305	1970-01-01	Delivered	Debit Card	4793 Second Ave	1970-01-01	1970-01-01	205.29	\N	Dallas	65518.0
2126	927	1970-01-01	Pending	Debit Card	6797 First St	\N	\N	707.76	\N	Phoenix	91844.0
2127	31	1970-01-01	Pending	Apple Pay	4769 Oak Ave	\N	\N	0.00	\N	Philadelphia	81200.0
2129	193	1970-01-01	Processing	Google Pay	8208 Second Ave	\N	\N	0.00	\N	Phoenix	98148.0
2130	992	1970-01-01	Delivered	Apple Pay	934 First St	1970-01-01	1970-01-01	1375.82	\N	Columbus	78809.0
2131	659	1970-01-01	Cancelled	Apple Pay	3281 Park Rd	\N	\N	3544.14	\N	San Diego	36504.0
2132	660	1970-01-01	Delivered	Google Pay	1920 First St	1970-01-01	1970-01-01	2534.57	\N	Chicago	64817.0
2133	894	1970-01-01	Delivered	Credit Card	2336 Park Rd	1970-01-01	1970-01-01	0.00	\N	Jacksonville	70849.0
2134	933	1970-01-01	Cancelled	Google Pay	4172 Park Rd	\N	\N	50.42	\N	Jacksonville	91048.0
2135	481	1970-01-01	Processing	Apple Pay	3680 Second Ave	\N	\N	4966.58	\N	Philadelphia	33957.0
2138	213	1970-01-01	Cancelled	Google Pay	9001 Second Ave	\N	\N	101.67	\N	San Diego	27589.0
2139	944	1970-01-01	Shipped	Google Pay	2470 Park Rd	1970-01-01	\N	0.00	\N	Philadelphia	75514.0
2140	483	1970-01-01	Pending	Credit Card	208 Second Ave	\N	\N	207.16	\N	San Jose	73214.0
2141	444	1970-01-01	Delivered	Credit Card	9138 Main St	1970-01-01	1970-01-01	327.01	\N	San Diego	94613.0
2142	887	1970-01-01	Delivered	Apple Pay	7619 Park Rd	1970-01-01	1970-01-01	0.00	\N	Dallas	10975.0
2143	810	1970-01-01	Shipped	Credit Card	1611 Main St	1970-01-01	\N	115.00	\N	Los Angeles	27047.0
2144	298	1970-01-01	Delivered	Credit Card	6122 Park Rd	1970-01-01	1970-01-01	397.71	\N	Philadelphia	60164.0
2146	109	1970-01-01	Delivered	Credit Card	6342 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Jose	98452.0
2147	370	1970-01-01	Shipped	Credit Card	2267 Oak Ave	1970-01-01	\N	0.00	\N	San Diego	11109.0
2149	847	1970-01-01	Shipped	Credit Card	7963 First St	1970-01-01	\N	524.72	\N	New York	87664.0
2150	698	1970-01-01	Shipped	Credit Card	2343 Second Ave	1970-01-01	\N	0.00	\N	New York	58891.0
2152	779	1970-01-01	Delivered	Google Pay	3166 Oak Ave	1970-01-01	1970-01-01	239.24	\N	Philadelphia	20252.0
2154	469	1970-01-01	Delivered	Debit Card	9120 Second Ave	1970-01-01	1970-01-01	516.00	\N	Fort Worth	99727.0
2155	667	1970-01-01	Delivered	Google Pay	7707 Main St	1970-01-01	1970-01-01	1293.65	\N	Austin	19266.0
2156	220	1970-01-01	Delivered	Debit Card	7419 Second Ave	1970-01-01	1970-01-01	1498.36	\N	Dallas	57419.0
2158	713	1970-01-01	Delivered	Apple Pay	2448 First St	1970-01-01	1970-01-01	404.10	\N	Los Angeles	87405.0
2159	55	1970-01-01	Pending	Google Pay	9047 Second Ave	\N	\N	75.95	\N	Dallas	73993.0
2160	780	1970-01-01	Delivered	Google Pay	317 Oak Ave	1970-01-01	1970-01-01	82.80	\N	Los Angeles	72537.0
2162	858	1970-01-01	Shipped	Google Pay	5009 First St	1970-01-01	\N	7775.18	\N	San Jose	31270.0
2163	82	1970-01-01	Delivered	Google Pay	753 First St	1970-01-01	1970-01-01	1166.17	\N	San Jose	89129.0
2164	997	1970-01-01	Delivered	Google Pay	9673 First St	1970-01-01	1970-01-01	0.00	\N	Houston	23941.0
2165	407	1970-01-01	Cancelled	Credit Card	989 Oak Ave	\N	\N	178.30	\N	Philadelphia	53512.0
2166	233	1970-01-01	Shipped	Apple Pay	8692 Park Rd	1970-01-01	\N	153.54	\N	Fort Worth	64568.0
2167	854	1970-01-01	Processing	Apple Pay	4083 Oak Ave	\N	\N	86.64	\N	Chicago	17928.0
2168	677	1970-01-01	Delivered	Credit Card	9086 First St	1970-01-01	1970-01-01	279.74	\N	Columbus	49856.0
2170	22	1970-01-01	Delivered	Google Pay	3239 Oak Ave	1970-01-01	1970-01-01	2269.10	\N	Houston	68800.0
2171	203	1970-01-01	Delivered	Apple Pay	1120 Oak Ave	1970-01-01	1970-01-01	22.93	\N	Columbus	37176.0
2174	589	1970-01-01	Delivered	Google Pay	3993 Park Rd	1970-01-01	1970-01-01	299.84	\N	Charlotte	49666.0
2175	744	1970-01-01	Shipped	Debit Card	2099 Second Ave	1970-01-01	\N	256.18	\N	Charlotte	67986.0
2176	123	1970-01-01	Pending	Google Pay	7530 First St	\N	\N	278.76	\N	Columbus	22463.0
2177	692	1970-01-01	Processing	Debit Card	140 Oak Ave	\N	\N	1294.88	\N	Fort Worth	49343.0
2178	777	1970-01-01	Pending	Google Pay	4275 Second Ave	\N	\N	0.00	\N	Philadelphia	75987.0
2180	846	1970-01-01	Shipped	Debit Card	7043 Main St	1970-01-01	\N	0.00	\N	Jacksonville	35805.0
2183	733	1970-01-01	Shipped	Debit Card	9375 Main St	1970-01-01	\N	10.72	\N	Charlotte	36299.0
2184	560	1970-01-01	Delivered	Debit Card	9390 Second Ave	1970-01-01	1970-01-01	14.02	\N	San Jose	88166.0
2185	25	1970-01-01	Delivered	Apple Pay	7554 Park Rd	1970-01-01	1970-01-01	0.00	\N	Charlotte	82845.0
2186	826	1970-01-01	Delivered	Debit Card	6252 Main St	1970-01-01	1970-01-01	367.71	\N	Phoenix	36549.0
2188	208	1970-01-01	Shipped	Google Pay	9308 Park Rd	1970-01-01	\N	80.34	\N	Phoenix	24316.0
2190	455	1970-01-01	Delivered	Credit Card	9779 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Houston	63857.0
2191	64	1970-01-01	Delivered	Credit Card	2606 First St	1970-01-01	1970-01-01	1918.15	\N	Jacksonville	78386.0
2192	800	1970-01-01	Delivered	Google Pay	8576 Main St	1970-01-01	1970-01-01	48.92	\N	Jacksonville	54342.0
2193	847	1970-01-01	Cancelled	Debit Card	7963 First St	\N	\N	645.30	\N	New York	87664.0
2194	966	1970-01-01	Shipped	Google Pay	7204 First St	1970-01-01	\N	483.25	\N	Fort Worth	89116.0
2195	565	1970-01-01	Delivered	Google Pay	1891 First St	1970-01-01	1970-01-01	66.30	\N	Dallas	15559.0
2196	310	1970-01-01	Shipped	Google Pay	1146 Park Rd	1970-01-01	\N	104.39	\N	Dallas	85582.0
2198	502	1970-01-01	Delivered	Google Pay	9780 Second Ave	1970-01-01	1970-01-01	410.71	\N	Chicago	92712.0
2199	558	1970-01-01	Delivered	Google Pay	9231 Second Ave	1970-01-01	1970-01-01	0.00	\N	Los Angeles	34134.0
2201	61	1970-01-01	Delivered	Apple Pay	2783 Park Rd	1970-01-01	1970-01-01	127.84	\N	Fort Worth	85849.0
2202	950	1970-01-01	Pending	Google Pay	2472 Oak Ave	\N	\N	577.47	\N	Phoenix	35644.0
2203	50	1970-01-01	Delivered	Google Pay	9855 Park Rd	1970-01-01	1970-01-01	1194.27	\N	Dallas	90301.0
2205	438	1970-01-01	Delivered	Debit Card	5733 Oak Ave	1970-01-01	1970-01-01	6916.05	\N	Jacksonville	94663.0
2208	433	1970-01-01	Delivered	Debit Card	6726 First St	1970-01-01	1970-01-01	4800.37	\N	San Diego	12213.0
2209	242	1970-01-01	Delivered	Debit Card	8105 First St	1970-01-01	1970-01-01	873.93	\N	Phoenix	32050.0
2210	776	1970-01-01	Delivered	Credit Card	838 Second Ave	1970-01-01	1970-01-01	1501.09	\N	Charlotte	76932.0
2211	915	1970-01-01	Delivered	Debit Card	1463 Park Rd	1970-01-01	1970-01-01	544.43	\N	Columbus	80411.0
2212	577	1970-01-01	Delivered	Google Pay	9585 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Diego	22206.0
2213	920	1970-01-01	Shipped	Credit Card	7927 Main St	1970-01-01	\N	145.62	\N	Houston	92700.0
2214	105	1970-01-01	Delivered	Debit Card	1691 Main St	1970-01-01	1970-01-01	5374.52	\N	Austin	67779.0
2215	91	1970-01-01	Delivered	Apple Pay	1243 Park Rd	1970-01-01	1970-01-01	1425.21	\N	Columbus	54548.0
2216	848	1970-01-01	Shipped	Credit Card	991 Park Rd	1970-01-01	\N	435.10	\N	Columbus	41030.0
2217	310	1970-01-01	Delivered	Credit Card	1146 Park Rd	1970-01-01	1970-01-01	0.00	\N	Dallas	85582.0
2218	478	1970-01-01	Delivered	Credit Card	4085 Park Rd	1970-01-01	1970-01-01	187.51	\N	Fort Worth	99337.0
2219	481	1970-01-01	Delivered	Credit Card	3680 Second Ave	1970-01-01	1970-01-01	749.09	\N	Philadelphia	33957.0
2220	554	1970-01-01	Shipped	Debit Card	4321 First St	1970-01-01	\N	166.52	\N	Austin	82737.0
2222	584	1970-01-01	Processing	Google Pay	5560 Park Rd	\N	\N	0.00	\N	Los Angeles	84569.0
2223	501	1970-01-01	Delivered	Credit Card	5946 Park Rd	1970-01-01	1970-01-01	1195.33	\N	Austin	71235.0
2224	873	1970-01-01	Cancelled	Google Pay	3930 Park Rd	\N	\N	134.22	\N	San Diego	19946.0
2226	668	1970-01-01	Shipped	Apple Pay	8987 Second Ave	1970-01-01	\N	3769.17	\N	Jacksonville	99740.0
2227	114	1970-01-01	Delivered	Debit Card	4620 Oak Ave	1970-01-01	1970-01-01	219.86	\N	San Antonio	69600.0
2228	944	1970-01-01	Shipped	Google Pay	2470 Park Rd	1970-01-01	\N	151.89	\N	Philadelphia	75514.0
2229	101	1970-01-01	Delivered	Google Pay	7722 Park Rd	1970-01-01	1970-01-01	0.00	\N	Charlotte	81643.0
2230	909	1970-01-01	Shipped	Debit Card	488 Oak Ave	1970-01-01	\N	113.38	\N	Fort Worth	54922.0
2231	433	1970-01-01	Delivered	Apple Pay	6726 First St	1970-01-01	1970-01-01	0.00	\N	San Diego	12213.0
2232	13	1970-01-01	Processing	Debit Card	7223 Oak Ave	\N	\N	50.35	\N	Phoenix	10425.0
2233	634	1970-01-01	Shipped	Apple Pay	7318 Main St	1970-01-01	\N	413.64	\N	Chicago	36302.0
2234	593	1970-01-01	Pending	Google Pay	5219 Main St	\N	\N	0.00	\N	Dallas	50913.0
2235	735	1970-01-01	Shipped	Apple Pay	9950 Oak Ave	1970-01-01	\N	456.66	\N	Phoenix	41258.0
2236	637	1970-01-01	Processing	Debit Card	6511 Second Ave	\N	\N	460.03	\N	Charlotte	77552.0
2238	454	1970-01-01	Delivered	Debit Card	9963 Main St	1970-01-01	1970-01-01	0.00	\N	Philadelphia	40191.0
2240	763	1970-01-01	Cancelled	Credit Card	7804 Park Rd	\N	\N	182.66	\N	New York	71228.0
2244	318	1970-01-01	Delivered	Credit Card	123 First St	1970-01-01	1970-01-01	1810.11	\N	Philadelphia	23624.0
2245	147	1970-01-01	Delivered	Debit Card	5643 Second Ave	1970-01-01	1970-01-01	1103.22	\N	San Antonio	92691.0
2248	929	1970-01-01	Shipped	Debit Card	4459 Main St	1970-01-01	\N	1955.95	\N	New York	86342.0
2252	267	1970-01-01	Delivered	Debit Card	702 Park Rd	1970-01-01	1970-01-01	131.66	\N	Dallas	80373.0
2253	638	1970-01-01	Delivered	Google Pay	3800 Main St	1970-01-01	1970-01-01	1991.28	\N	Dallas	73185.0
2254	778	1970-01-01	Pending	Apple Pay	1464 First St	\N	\N	778.30	\N	New York	49013.0
2258	361	1970-01-01	Delivered	Credit Card	6584 Park Rd	1970-01-01	1970-01-01	0.00	\N	New York	41139.0
2259	899	1970-01-01	Delivered	Google Pay	7008 Main St	1970-01-01	1970-01-01	0.00	\N	New York	54186.0
2260	499	1970-01-01	Delivered	Debit Card	531 First St	1970-01-01	1970-01-01	73.92	\N	New York	20911.0
2261	597	1970-01-01	Delivered	Apple Pay	926 Main St	1970-01-01	1970-01-01	0.00	\N	Charlotte	17051.0
2262	578	1970-01-01	Delivered	Apple Pay	7101 Second Ave	1970-01-01	1970-01-01	1295.91	\N	Fort Worth	48382.0
2263	808	1970-01-01	Processing	Debit Card	9857 Oak Ave	\N	\N	108.81	\N	Columbus	49216.0
2265	264	1970-01-01	Delivered	Apple Pay	1965 Second Ave	1970-01-01	1970-01-01	86.58	\N	Philadelphia	87624.0
2267	76	1970-01-01	Shipped	Apple Pay	8661 First St	1970-01-01	\N	98.05	\N	Fort Worth	68028.0
2268	790	1970-01-01	Delivered	Debit Card	7838 Oak Ave	1970-01-01	1970-01-01	8349.03	\N	Fort Worth	37159.0
2270	381	1970-01-01	Delivered	Google Pay	3054 Main St	1970-01-01	1970-01-01	2770.30	\N	Philadelphia	53598.0
2271	749	1970-01-01	Pending	Credit Card	2231 Second Ave	\N	\N	323.04	\N	Dallas	63780.0
2272	565	1970-01-01	Delivered	Google Pay	1891 First St	1970-01-01	1970-01-01	301.47	\N	Dallas	15559.0
2273	227	1970-01-01	Pending	Google Pay	472 Park Rd	\N	\N	778.76	\N	Fort Worth	98276.0
2274	357	1970-01-01	Delivered	Google Pay	2522 Second Ave	1970-01-01	1970-01-01	698.45	\N	Houston	51910.0
2275	199	1970-01-01	Pending	Debit Card	8125 Second Ave	\N	\N	0.00	\N	Dallas	72245.0
2277	68	1970-01-01	Shipped	Apple Pay	4037 First St	1970-01-01	\N	1319.91	\N	Dallas	74332.0
2278	309	1970-01-01	Delivered	Debit Card	4347 Oak Ave	1970-01-01	1970-01-01	3718.52	\N	Fort Worth	26637.0
2279	211	1970-01-01	Pending	Apple Pay	9506 Oak Ave	\N	\N	50.85	\N	Austin	14888.0
2280	617	1970-01-01	Delivered	Apple Pay	7840 Main St	1970-01-01	1970-01-01	3628.28	\N	Houston	93058.0
2281	933	1970-01-01	Delivered	Debit Card	4172 Park Rd	1970-01-01	1970-01-01	326.88	\N	Jacksonville	91048.0
2282	300	1970-01-01	Delivered	Apple Pay	2117 Second Ave	1970-01-01	1970-01-01	1636.90	\N	Chicago	56076.0
2283	700	1970-01-01	Delivered	Credit Card	7644 Main St	1970-01-01	1970-01-01	702.16	\N	San Antonio	27200.0
2284	86	1970-01-01	Delivered	Apple Pay	1999 First St	1970-01-01	1970-01-01	1517.24	\N	Philadelphia	10150.0
2285	750	1970-01-01	Shipped	Google Pay	9816 Park Rd	1970-01-01	\N	217.83	\N	Chicago	36039.0
2286	20	1970-01-01	Delivered	Apple Pay	9455 Second Ave	1970-01-01	1970-01-01	7348.41	\N	Chicago	41850.0
2287	301	1970-01-01	Delivered	Google Pay	9166 Second Ave	1970-01-01	1970-01-01	5490.24	\N	Houston	89638.0
2288	40	1970-01-01	Delivered	Apple Pay	8446 First St	1970-01-01	1970-01-01	573.94	\N	Philadelphia	80282.0
2291	923	1970-01-01	Processing	Credit Card	6371 Second Ave	\N	\N	253.71	\N	Dallas	63950.0
2292	606	1970-01-01	Delivered	Google Pay	1881 Second Ave	1970-01-01	1970-01-01	0.00	\N	San Jose	52914.0
2293	160	1970-01-01	Delivered	Apple Pay	4293 Oak Ave	1970-01-01	1970-01-01	61.35	\N	New York	81932.0
2294	249	1970-01-01	Delivered	Apple Pay	254 Oak Ave	1970-01-01	1970-01-01	68.63	\N	New York	75517.0
2295	84	1970-01-01	Shipped	Credit Card	8156 Main St	1970-01-01	\N	0.00	\N	Austin	55607.0
2296	759	1970-01-01	Delivered	Credit Card	6176 Oak Ave	1970-01-01	1970-01-01	1204.69	\N	San Antonio	15390.0
2297	761	1970-01-01	Shipped	Google Pay	4703 Park Rd	1970-01-01	\N	78.08	\N	San Diego	47083.0
2298	608	1970-01-01	Delivered	Google Pay	5287 Park Rd	1970-01-01	1970-01-01	25.88	\N	Austin	99071.0
2299	526	1970-01-01	Delivered	Google Pay	6102 Oak Ave	1970-01-01	1970-01-01	243.60	\N	New York	19289.0
2300	415	1970-01-01	Delivered	Apple Pay	9075 Park Rd	1970-01-01	1970-01-01	1074.28	\N	Phoenix	82559.0
2301	864	1970-01-01	Cancelled	Debit Card	2907 Second Ave	\N	\N	475.26	\N	Austin	66848.0
2302	801	1970-01-01	Delivered	Credit Card	2573 Second Ave	1970-01-01	1970-01-01	2317.28	\N	Austin	92786.0
2304	527	1970-01-01	Delivered	Credit Card	1094 Park Rd	1970-01-01	1970-01-01	115.44	\N	Fort Worth	64519.0
2305	185	1970-01-01	Delivered	Debit Card	9613 Oak Ave	1970-01-01	1970-01-01	423.03	\N	San Jose	96341.0
2308	136	1970-01-01	Delivered	Credit Card	7632 Main St	1970-01-01	1970-01-01	0.00	\N	New York	85465.0
2311	88	1970-01-01	Cancelled	Google Pay	572 Second Ave	\N	\N	779.91	\N	Los Angeles	30758.0
2314	188	1970-01-01	Delivered	Credit Card	6909 First St	1970-01-01	1970-01-01	0.00	\N	San Diego	36741.0
2315	499	1970-01-01	Delivered	Apple Pay	531 First St	1970-01-01	1970-01-01	1543.59	\N	New York	20911.0
2316	475	1970-01-01	Delivered	Apple Pay	1577 Second Ave	1970-01-01	1970-01-01	3426.94	\N	Charlotte	83284.0
2318	631	1970-01-01	Delivered	Apple Pay	2065 Main St	1970-01-01	1970-01-01	0.00	\N	Jacksonville	27027.0
2319	787	1970-01-01	Delivered	Debit Card	1140 Park Rd	1970-01-01	1970-01-01	1016.00	\N	Dallas	64675.0
2320	91	1970-01-01	Delivered	Debit Card	1243 Park Rd	1970-01-01	1970-01-01	211.08	\N	Columbus	54548.0
2321	126	1970-01-01	Delivered	Credit Card	942 Park Rd	1970-01-01	1970-01-01	1831.67	\N	Columbus	50953.0
2322	863	1970-01-01	Delivered	Apple Pay	2348 First St	1970-01-01	1970-01-01	869.70	\N	New York	24544.0
2323	826	1970-01-01	Shipped	Google Pay	6252 Main St	1970-01-01	\N	0.00	\N	Phoenix	36549.0
2324	172	1970-01-01	Delivered	Debit Card	7226 Park Rd	1970-01-01	1970-01-01	1479.44	\N	San Jose	17518.0
2325	116	1970-01-01	Shipped	Google Pay	2517 Second Ave	1970-01-01	\N	293.58	\N	Philadelphia	46342.0
2327	944	1970-01-01	Delivered	Credit Card	2470 Park Rd	1970-01-01	1970-01-01	626.24	\N	Philadelphia	75514.0
2328	369	1970-01-01	Delivered	Google Pay	3726 Oak Ave	1970-01-01	1970-01-01	7889.27	\N	Columbus	37096.0
2329	364	1970-01-01	Delivered	Debit Card	8562 Park Rd	1970-01-01	1970-01-01	471.95	\N	Fort Worth	77537.0
2330	439	1970-01-01	Delivered	Credit Card	1977 Oak Ave	1970-01-01	1970-01-01	362.26	\N	Houston	84356.0
2331	524	1970-01-01	Delivered	Google Pay	5376 Main St	1970-01-01	1970-01-01	139.69	\N	San Antonio	78576.0
2332	128	1970-01-01	Delivered	Credit Card	4481 Main St	1970-01-01	1970-01-01	756.05	\N	San Jose	45818.0
2333	645	1970-01-01	Delivered	Debit Card	2238 Main St	1970-01-01	1970-01-01	2115.48	\N	Jacksonville	92924.0
2334	129	1970-01-01	Delivered	Credit Card	6666 Main St	1970-01-01	1970-01-01	1904.93	\N	San Jose	92991.0
2335	606	1970-01-01	Delivered	Debit Card	1881 Second Ave	1970-01-01	1970-01-01	5494.05	\N	San Jose	52914.0
2337	405	1970-01-01	Shipped	Apple Pay	8248 Main St	1970-01-01	\N	135.87	\N	Los Angeles	62879.0
2339	188	1970-01-01	Delivered	Credit Card	6909 First St	1970-01-01	1970-01-01	241.46	\N	San Diego	36741.0
2342	194	1970-01-01	Delivered	Apple Pay	4433 Park Rd	1970-01-01	1970-01-01	2895.83	\N	Chicago	57964.0
2343	769	1970-01-01	Pending	Credit Card	897 Park Rd	\N	\N	217.16	\N	Houston	17279.0
2344	835	1970-01-01	Cancelled	Apple Pay	7907 Main St	\N	\N	300.06	\N	San Jose	98172.0
2345	218	1970-01-01	Shipped	Google Pay	5195 Main St	1970-01-01	\N	341.16	\N	Charlotte	48671.0
2346	459	1970-01-01	Delivered	Credit Card	7529 Second Ave	1970-01-01	1970-01-01	2565.18	\N	Charlotte	19023.0
2347	211	1970-01-01	Delivered	Apple Pay	9506 Oak Ave	1970-01-01	1970-01-01	28.08	\N	Austin	14888.0
2350	592	1970-01-01	Delivered	Apple Pay	8658 Main St	1970-01-01	1970-01-01	196.64	\N	San Antonio	50760.0
2351	60	1970-01-01	Delivered	Google Pay	1974 Second Ave	1970-01-01	1970-01-01	680.18	\N	Austin	70952.0
2353	625	1970-01-01	Cancelled	Apple Pay	7903 Second Ave	\N	\N	1536.22	\N	Phoenix	59781.0
2354	935	1970-01-01	Delivered	Debit Card	7110 First St	1970-01-01	1970-01-01	847.61	\N	Philadelphia	23166.0
2355	84	1970-01-01	Delivered	Apple Pay	8156 Main St	1970-01-01	1970-01-01	8741.23	\N	Austin	55607.0
2357	783	1970-01-01	Delivered	Debit Card	1510 Park Rd	1970-01-01	1970-01-01	1021.72	\N	Houston	29420.0
2358	159	1970-01-01	Pending	Apple Pay	2492 Oak Ave	\N	\N	186.60	\N	Fort Worth	47601.0
2359	790	1970-01-01	Delivered	Apple Pay	7838 Oak Ave	1970-01-01	1970-01-01	0.00	\N	Fort Worth	37159.0
2360	560	1970-01-01	Delivered	Google Pay	9390 Second Ave	1970-01-01	1970-01-01	1497.13	\N	San Jose	88166.0
2361	229	1970-01-01	Delivered	Debit Card	1202 Main St	1970-01-01	1970-01-01	337.42	\N	Houston	14400.0
2362	816	1970-01-01	Delivered	Google Pay	8108 Main St	1970-01-01	1970-01-01	0.00	\N	Chicago	81766.0
2363	404	1970-01-01	Delivered	Google Pay	3950 Main St	1970-01-01	1970-01-01	48.26	\N	San Antonio	68220.0
2364	521	1970-01-01	Processing	Apple Pay	9908 Second Ave	\N	\N	275.09	\N	Phoenix	19027.0
2365	641	1970-01-01	Delivered	Google Pay	1490 First St	1970-01-01	1970-01-01	17.90	\N	San Diego	28342.0
2366	312	1970-01-01	Shipped	Apple Pay	8436 Main St	1970-01-01	\N	0.00	\N	Jacksonville	11610.0
2367	64	1970-01-01	Cancelled	Google Pay	2606 First St	\N	\N	521.28	\N	Jacksonville	78386.0
2368	219	1970-01-01	Delivered	Google Pay	6221 First St	1970-01-01	1970-01-01	0.00	\N	San Diego	81989.0
2369	128	1970-01-01	Shipped	Google Pay	4481 Main St	1970-01-01	\N	0.00	\N	San Jose	45818.0
2370	584	1970-01-01	Delivered	Google Pay	5560 Park Rd	1970-01-01	1970-01-01	5969.94	\N	Los Angeles	84569.0
2371	744	1970-01-01	Delivered	Debit Card	2099 Second Ave	1970-01-01	1970-01-01	214.70	\N	Charlotte	67986.0
2373	431	1970-01-01	Shipped	Debit Card	8910 First St	1970-01-01	\N	555.70	\N	Houston	19452.0
2374	177	1970-01-01	Delivered	Debit Card	2109 Oak Ave	1970-01-01	1970-01-01	525.72	\N	Houston	69250.0
2375	260	1970-01-01	Delivered	Debit Card	6999 Park Rd	1970-01-01	1970-01-01	232.75	\N	Phoenix	20082.0
2376	405	1970-01-01	Processing	Debit Card	8248 Main St	\N	\N	731.40	\N	Los Angeles	62879.0
2377	690	1970-01-01	Pending	Credit Card	4578 First St	\N	\N	0.00	\N	San Antonio	82851.0
2378	567	1970-01-01	Shipped	Apple Pay	993 Second Ave	1970-01-01	\N	0.00	\N	San Jose	70762.0
2379	737	1970-01-01	Processing	Google Pay	4651 Second Ave	\N	\N	239.10	\N	Fort Worth	94448.0
2383	235	1970-01-01	Pending	Google Pay	6463 Oak Ave	\N	\N	1053.40	\N	Chicago	36651.0
2384	407	1970-01-01	Delivered	Google Pay	989 Oak Ave	1970-01-01	1970-01-01	405.90	\N	Philadelphia	53512.0
2385	650	1970-01-01	Processing	Google Pay	9827 Park Rd	\N	\N	127.35	\N	Jacksonville	72391.0
2386	34	1970-01-01	Delivered	Apple Pay	7039 Park Rd	1970-01-01	1970-01-01	0.00	\N	Austin	10464.0
2387	353	1970-01-01	Shipped	Debit Card	4415 Oak Ave	1970-01-01	\N	929.01	\N	San Diego	83956.0
2388	826	1970-01-01	Delivered	Debit Card	6252 Main St	1970-01-01	1970-01-01	254.26	\N	Phoenix	36549.0
2389	979	1970-01-01	Delivered	Debit Card	4192 Second Ave	1970-01-01	1970-01-01	1160.32	\N	Charlotte	48019.0
2390	161	1970-01-01	Delivered	Apple Pay	882 Oak Ave	1970-01-01	1970-01-01	5220.25	\N	Los Angeles	93748.0
2391	698	1970-01-01	Delivered	Google Pay	2343 Second Ave	1970-01-01	1970-01-01	1288.28	\N	New York	58891.0
2392	598	1970-01-01	Processing	Google Pay	5926 Park Rd	\N	\N	0.00	\N	San Jose	35971.0
2394	497	1970-01-01	Delivered	Apple Pay	6050 Second Ave	1970-01-01	1970-01-01	7218.76	\N	Fort Worth	69020.0
2395	247	1970-01-01	Shipped	Apple Pay	3244 Second Ave	1970-01-01	\N	0.00	\N	Houston	43084.0
2396	250	1970-01-01	Delivered	Apple Pay	3563 Second Ave	1970-01-01	1970-01-01	632.80	\N	Houston	45532.0
2399	117	1970-01-01	Delivered	Credit Card	522 Oak Ave	1970-01-01	1970-01-01	90.84	\N	Austin	56955.0
2400	984	1970-01-01	Delivered	Apple Pay	7298 Oak Ave	1970-01-01	1970-01-01	1084.98	\N	San Diego	56365.0
2401	205	1970-01-01	Pending	Apple Pay	4976 Park Rd	\N	\N	206.95	\N	Houston	37168.0
2402	219	1970-01-01	Delivered	Credit Card	6221 First St	1970-01-01	1970-01-01	131.92	\N	San Diego	81989.0
2404	488	1970-01-01	Shipped	Google Pay	6966 Park Rd	1970-01-01	\N	1411.16	\N	Houston	62506.0
2406	555	1970-01-01	Delivered	Credit Card	6362 Second Ave	1970-01-01	1970-01-01	521.85	\N	Los Angeles	90274.0
2407	283	1970-01-01	Shipped	Debit Card	8469 Main St	1970-01-01	\N	557.35	\N	Dallas	24969.0
2408	81	1970-01-01	Delivered	Debit Card	2137 First St	1970-01-01	1970-01-01	507.30	\N	San Diego	49857.0
2409	721	1970-01-01	Delivered	Apple Pay	6474 First St	1970-01-01	1970-01-01	700.80	\N	Jacksonville	84560.0
2411	577	1970-01-01	Delivered	Google Pay	9585 Park Rd	1970-01-01	1970-01-01	24.69	\N	San Diego	22206.0
2412	793	1970-01-01	Delivered	Credit Card	3814 Main St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	39372.0
2413	943	1970-01-01	Cancelled	Credit Card	2169 Second Ave	\N	\N	1708.88	\N	Fort Worth	88855.0
2414	585	1970-01-01	Delivered	Google Pay	7874 Main St	1970-01-01	1970-01-01	304.52	\N	Charlotte	27793.0
2415	422	1970-01-01	Delivered	Google Pay	3270 Park Rd	1970-01-01	1970-01-01	0.00	\N	Fort Worth	33255.0
2416	829	1970-01-01	Processing	Debit Card	6764 First St	\N	\N	71.38	\N	San Jose	93335.0
2417	578	1970-01-01	Shipped	Google Pay	7101 Second Ave	1970-01-01	\N	4894.72	\N	Fort Worth	48382.0
2419	445	1970-01-01	Shipped	Credit Card	1352 Main St	1970-01-01	\N	1085.88	\N	Jacksonville	76476.0
2422	433	1970-01-01	Delivered	Credit Card	6726 First St	1970-01-01	1970-01-01	161.64	\N	San Diego	12213.0
2424	64	1970-01-01	Delivered	Credit Card	2606 First St	1970-01-01	1970-01-01	390.12	\N	Jacksonville	78386.0
2425	530	1970-01-01	Pending	Apple Pay	7615 First St	\N	\N	54.93	\N	Austin	31864.0
2429	191	1970-01-01	Cancelled	Debit Card	2716 Park Rd	\N	\N	0.00	\N	Columbus	50988.0
2430	861	1970-01-01	Delivered	Debit Card	3285 Second Ave	1970-01-01	1970-01-01	497.12	\N	San Diego	15754.0
2431	492	1970-01-01	Processing	Google Pay	1677 First St	\N	\N	946.37	\N	San Diego	44048.0
2432	176	1970-01-01	Delivered	Apple Pay	8582 First St	1970-01-01	1970-01-01	2613.27	\N	San Diego	25435.0
2433	631	1970-01-01	Delivered	Credit Card	2065 Main St	1970-01-01	1970-01-01	825.86	\N	Jacksonville	27027.0
2434	693	1970-01-01	Delivered	Apple Pay	2055 Park Rd	1970-01-01	1970-01-01	386.24	\N	New York	18745.0
2435	584	1970-01-01	Delivered	Credit Card	5560 Park Rd	1970-01-01	1970-01-01	566.72	\N	Los Angeles	84569.0
2436	941	1970-01-01	Delivered	Debit Card	1924 Main St	1970-01-01	1970-01-01	0.00	\N	Los Angeles	87620.0
2438	551	1970-01-01	Cancelled	Apple Pay	6337 Second Ave	\N	\N	1480.64	\N	Houston	23055.0
2439	367	1970-01-01	Delivered	Debit Card	6202 First St	1970-01-01	1970-01-01	51.92	\N	Houston	68471.0
2441	73	1970-01-01	Processing	Credit Card	2168 First St	\N	\N	0.00	\N	Jacksonville	11607.0
2443	397	1970-01-01	Delivered	Apple Pay	5715 Oak Ave	1970-01-01	1970-01-01	712.85	\N	Columbus	62530.0
2444	493	1970-01-01	Pending	Google Pay	6846 Main St	\N	\N	42.94	\N	New York	99074.0
2445	122	1970-01-01	Delivered	Debit Card	7148 Main St	1970-01-01	1970-01-01	1594.95	\N	Dallas	24996.0
2446	353	1970-01-01	Cancelled	Credit Card	4415 Oak Ave	\N	\N	52.24	\N	San Diego	83956.0
2448	946	1970-01-01	Shipped	Debit Card	6271 Main St	1970-01-01	\N	6141.97	\N	Phoenix	30014.0
2449	712	1970-01-01	Delivered	Apple Pay	6120 Oak Ave	1970-01-01	1970-01-01	135.36	\N	Austin	98363.0
2451	143	1970-01-01	Shipped	Google Pay	7665 First St	1970-01-01	\N	688.79	\N	Phoenix	17456.0
2452	618	1970-01-01	Delivered	Debit Card	276 First St	1970-01-01	1970-01-01	117.04	\N	Fort Worth	77195.0
2453	847	1970-01-01	Processing	Google Pay	7963 First St	\N	\N	825.44	\N	New York	87664.0
2454	165	1970-01-01	Delivered	Debit Card	1798 Second Ave	1970-01-01	1970-01-01	3433.32	\N	Houston	27486.0
2455	452	1970-01-01	Pending	Debit Card	4221 First St	\N	\N	679.54	\N	Dallas	77681.0
2456	992	1970-01-01	Delivered	Apple Pay	934 First St	1970-01-01	1970-01-01	0.00	\N	Columbus	78809.0
2458	583	1970-01-01	Shipped	Credit Card	3396 Park Rd	1970-01-01	\N	0.00	\N	New York	18891.0
2459	743	1970-01-01	Delivered	Debit Card	670 Main St	1970-01-01	1970-01-01	105.69	\N	New York	98027.0
2460	425	1970-01-01	Processing	Credit Card	5307 Second Ave	\N	\N	213.62	\N	Los Angeles	34100.0
2461	526	1970-01-01	Delivered	Google Pay	6102 Oak Ave	1970-01-01	1970-01-01	1404.30	\N	New York	19289.0
2463	6	1970-01-01	Delivered	Apple Pay	4654 First St	1970-01-01	1970-01-01	2515.48	\N	San Antonio	57819.0
2464	909	1970-01-01	Processing	Apple Pay	488 Oak Ave	\N	\N	7334.99	\N	Fort Worth	54922.0
2465	629	1970-01-01	Shipped	Google Pay	1213 Main St	1970-01-01	\N	1162.20	\N	Columbus	22805.0
2466	653	1970-01-01	Delivered	Credit Card	3692 First St	1970-01-01	1970-01-01	152.88	\N	Dallas	96419.0
2467	333	1970-01-01	Delivered	Google Pay	5324 Second Ave	1970-01-01	1970-01-01	139.98	\N	New York	13840.0
2469	42	1970-01-01	Delivered	Debit Card	827 First St	1970-01-01	1970-01-01	610.76	\N	Phoenix	78146.0
2471	319	1970-01-01	Delivered	Apple Pay	4684 Main St	1970-01-01	1970-01-01	436.07	\N	Jacksonville	40339.0
2472	288	1970-01-01	Delivered	Credit Card	1071 Park Rd	1970-01-01	1970-01-01	1640.31	\N	Charlotte	26631.0
2473	432	1970-01-01	Delivered	Apple Pay	989 Oak Ave	1970-01-01	1970-01-01	463.43	\N	Los Angeles	83149.0
2474	316	1970-01-01	Delivered	Google Pay	9337 Park Rd	1970-01-01	1970-01-01	1597.43	\N	Phoenix	41795.0
2475	558	1970-01-01	Pending	Debit Card	9231 Second Ave	\N	\N	0.00	\N	Los Angeles	34134.0
2476	521	1970-01-01	Pending	Credit Card	9908 Second Ave	\N	\N	1666.94	\N	Phoenix	19027.0
2477	57	1970-01-01	Processing	Debit Card	7122 Oak Ave	\N	\N	2009.86	\N	Los Angeles	33819.0
2480	472	1970-01-01	Shipped	Apple Pay	8199 First St	1970-01-01	\N	200.46	\N	Austin	36438.0
2482	38	1970-01-01	Delivered	Debit Card	4165 Park Rd	1970-01-01	1970-01-01	1567.21	\N	Fort Worth	24168.0
2483	678	1970-01-01	Pending	Google Pay	6193 Park Rd	\N	\N	66.32	\N	San Diego	29443.0
2484	359	1970-01-01	Delivered	Apple Pay	1830 Second Ave	1970-01-01	1970-01-01	873.86	\N	Charlotte	47498.0
2486	922	1970-01-01	Delivered	Debit Card	9703 Main St	1970-01-01	1970-01-01	4214.01	\N	San Antonio	34749.0
2487	274	1970-01-01	Delivered	Google Pay	7180 First St	1970-01-01	1970-01-01	9352.15	\N	Chicago	90492.0
2488	140	1970-01-01	Delivered	Google Pay	1784 Oak Ave	1970-01-01	1970-01-01	351.03	\N	Houston	35856.0
2489	438	1970-01-01	Processing	Credit Card	5733 Oak Ave	\N	\N	528.33	\N	Jacksonville	94663.0
2490	144	1970-01-01	Delivered	Google Pay	9833 Second Ave	1970-01-01	1970-01-01	457.73	\N	San Jose	70648.0
2491	997	1970-01-01	Delivered	Debit Card	9673 First St	1970-01-01	1970-01-01	321.93	\N	Houston	23941.0
2493	442	1970-01-01	Cancelled	Debit Card	9671 Oak Ave	\N	\N	445.66	\N	Jacksonville	84299.0
2494	659	1970-01-01	Delivered	Debit Card	3281 Park Rd	1970-01-01	1970-01-01	0.00	\N	San Diego	36504.0
2496	959	1970-01-01	Delivered	Apple Pay	4306 Main St	1970-01-01	1970-01-01	686.20	\N	Dallas	26346.0
2497	649	1970-01-01	Delivered	Google Pay	1737 Second Ave	1970-01-01	1970-01-01	445.52	\N	Chicago	30677.0
2498	225	1970-01-01	Pending	Credit Card	6987 Park Rd	\N	\N	2687.34	\N	Fort Worth	68790.0
2499	841	1970-01-01	Delivered	Apple Pay	3274 Second Ave	1970-01-01	1970-01-01	2411.75	\N	Dallas	99441.0
2500	153	1970-01-01	Pending	Debit Card	7270 Main St	\N	\N	352.95	\N	Jacksonville	57749.0
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (product_id, product_name, category_id, brand, price, cost, stock_quantity, weight_kg, dimension, description, created_date) FROM stdin;
1	BrandC Coffee Beans	9	BrandC	31.96	19.46	33	2.97	41x8x24	High-quality coffee beans from BrandC	2020-01-25
2	Elite Camera	1	Elite	1385.15	915.69	19	1.74	37x29x19	High-quality camera from Elite	2021-03-10
3	Deluxe Glue Set	10	Deluxe	26.19	11.92	40	5.76	42x49x2	High-quality glue set from Deluxe	2021-11-16
4	Standard Hat	2	Standard	145.93	81.36	77	8.54	23x50x10	High-quality hat from Standard	2019-09-01
5	BrandD Dress	2	BrandD	23.44	11.05	10	6.43	22x13x10	High-quality dress from BrandD	2019-04-16
6	BrandD Tea Set	9	BrandD	29.06	11.64	88	6.36	28x25x4	High-quality tea set from BrandD	2020-06-24
7	Basic Headphones	1	Basic	1801.75	880.10	14	6.30	5x27x9	High-quality headphones from Basic	2020-07-26
8	BrandE Cookbook	5	BrandE	48.86	27.42	199	9.40	42x11x25	High-quality cookbook from BrandE	2021-02-21
9	BrandE Lamp	3	BrandE	437.61	258.32	141	2.14	33x19x12	High-quality lamp from BrandE	2020-07-04
10	Deluxe Cookbook	5	Deluxe	35.19	23.14	101	1.64	19x32x13	High-quality cookbook from Deluxe	2019-10-31
11	BrandB Perfume	6	BrandB	53.63	28.84	45	1.97	36x16x22	High-quality perfume from BrandB	2020-07-31
12	BrandE T-Shirt	2	BrandE	45.14	20.46	100	6.90	17x9x6	High-quality t-shirt from BrandE	2019-05-28
13	BrandD Backpack	4	BrandD	150.13	89.11	103	1.09	38x13x25	High-quality backpack from BrandD	2019-01-25
14	BrandB Bedding Set	3	BrandB	201.38	81.80	3	7.66	46x7x6	High-quality bedding set from BrandB	2020-05-23
15	BrandE Car Mat	8	BrandE	34.26	20.15	3	7.94	5x11x19	High-quality car mat from BrandE	2020-11-24
16	BrandD Board Game	7	BrandD	21.47	13.48	113	8.17	24x26x17	High-quality board game from BrandD	2019-11-13
17	BrandA Cookbook	5	BrandA	31.74	15.24	139	1.32	7x11x19	High-quality cookbook from BrandA	2020-08-30
18	Standard Jeans	2	Standard	178.99	93.90	0	9.13	6x19x15	High-quality jeans from Standard	2021-02-28
19	Premium Tea Set	9	Premium	34.49	16.13	175	3.91	50x12x17	High-quality tea set from Premium	2019-12-14
20	BrandD Laptop	1	BrandD	248.39	170.58	91	0.86	26x12x13	High-quality laptop from BrandD	2019-06-23
21	Deluxe T-Shirt	2	Deluxe	42.95	22.70	85	6.04	48x32x6	High-quality t-shirt from Deluxe	2020-09-09
22	Premium Phone Mount	8	Premium	133.18	64.10	127	6.65	21x50x4	High-quality phone mount from Premium	2019-01-05
23	BrandC Shampoo	6	BrandC	37.46	19.37	184	7.99	35x9x5	High-quality shampoo from BrandC	2021-05-25
24	BrandC Puzzle	7	BrandC	18.15	12.68	46	7.70	27x25x17	High-quality puzzle from BrandC	2021-05-18
25	Basic Glue Set	10	Basic	48.32	28.56	35	8.04	46x20x14	High-quality glue set from Basic	2021-05-07
26	Elite Water Bottle	4	Elite	173.16	94.85	137	8.23	29x10x20	High-quality water bottle from Elite	2021-05-13
27	BrandB Air Freshener	8	BrandB	46.75	18.74	4	3.69	35x13x5	High-quality air freshener from BrandB	2019-05-03
28	Premium Puzzle	7	Premium	69.72	46.02	35	3.02	14x40x15	High-quality puzzle from Premium	2020-05-11
29	BrandD Cookbook	5	BrandD	12.23	5.40	178	7.07	29x6x24	High-quality cookbook from BrandD	2021-05-19
30	BrandA Vitamins	6	BrandA	72.53	43.43	18	4.82	43x15x2	High-quality vitamins from BrandA	2019-10-28
31	BrandC Puzzle	7	BrandC	17.37	7.35	145	8.33	31x14x7	High-quality puzzle from BrandC	2021-08-20
32	Standard Tea Set	9	Standard	36.44	17.85	105	7.25	33x46x24	High-quality tea set from Standard	2019-01-28
33	BrandB Phone Mount	8	BrandB	36.04	23.94	8	6.08	16x37x7	High-quality phone mount from BrandB	2019-01-23
34	Basic Biography	5	Basic	37.20	24.66	141	7.14	21x41x18	High-quality biography from Basic	2020-09-18
35	Basic Cookbook	5	Basic	47.26	22.76	23	5.26	13x18x14	High-quality cookbook from Basic	2019-04-25
36	Basic Sketchbook	10	Basic	20.31	12.67	143	6.09	9x49x16	High-quality sketchbook from Basic	2021-09-04
37	Basic Sneakers	2	Basic	168.04	75.53	95	6.50	17x22x5	High-quality sneakers from Basic	2019-08-02
38	Premium Coffee Beans	9	Premium	32.14	21.02	7	2.47	15x39x5	High-quality coffee beans from Premium	2019-05-14
39	Deluxe Yoga Mat	4	Deluxe	28.02	18.85	48	5.56	45x7x9	High-quality yoga mat from Deluxe	2020-07-05
40	Deluxe Coffee Beans	9	Deluxe	30.42	17.31	123	0.55	25x10x11	High-quality coffee beans from Deluxe	2019-01-18
41	BrandE Garden Hose	3	BrandE	480.19	264.14	80	7.54	27x13x24	High-quality garden hose from BrandE	2019-07-19
42	Basic Vitamins	6	Basic	90.48	49.86	128	8.09	14x6x20	High-quality vitamins from Basic	2021-02-21
43	Deluxe Perfume	6	Deluxe	87.93	36.16	41	1.60	34x10x22	High-quality perfume from Deluxe	2019-07-11
44	BrandD Tablet	1	BrandD	1624.58	968.68	196	7.21	37x38x25	High-quality tablet from BrandD	2021-12-07
45	Elite Chocolate	9	Elite	40.34	20.24	92	6.27	32x7x24	High-quality chocolate from Elite	2021-03-04
46	BrandD Sketchbook	10	BrandD	74.80	43.54	39	5.71	36x11x2	High-quality sketchbook from BrandD	2019-10-20
47	Standard Vitamins	6	Standard	87.81	56.13	22	5.04	34x25x7	High-quality vitamins from Standard	2020-08-28
48	BrandB Dress	2	BrandB	66.82	34.01	22	0.80	50x34x10	High-quality dress from BrandB	2021-08-27
49	Elite Science Textbook	5	Elite	36.01	15.92	31	9.72	36x7x13	High-quality science textbook from Elite	2020-08-10
50	Basic Protein Bar	9	Basic	43.57	29.42	33	4.46	37x44x12	High-quality protein bar from Basic	2021-02-04
51	Basic Face Cream	6	Basic	54.55	26.12	174	0.52	46x8x25	High-quality face cream from Basic	2020-05-16
52	BrandC Smartphone	1	BrandC	1713.47	834.80	40	5.74	9x19x14	High-quality smartphone from BrandC	2021-08-04
53	Premium Coffee Beans	9	Premium	25.96	15.39	119	1.18	16x11x14	High-quality coffee beans from Premium	2021-06-06
54	Basic Vacuum Cleaner	3	Basic	177.79	88.04	154	4.91	49x35x5	High-quality vacuum cleaner from Basic	2020-07-24
55	BrandA Tire Gauge	8	BrandA	88.59	60.65	37	6.44	25x41x3	High-quality tire gauge from BrandA	2021-02-17
56	Premium Paint Set	10	Premium	60.90	42.24	54	0.64	6x48x15	High-quality paint set from Premium	2020-07-06
57	BrandC Bicycle	4	BrandC	47.99	20.19	103	0.91	50x33x15	High-quality bicycle from BrandC	2021-12-10
58	BrandE Air Freshener	8	BrandE	39.85	16.58	109	3.49	24x15x8	High-quality air freshener from BrandE	2020-12-16
59	Elite Plant Pot	3	Elite	248.24	150.59	41	9.66	32x27x24	High-quality plant pot from Elite	2021-03-07
60	Standard Smartphone	1	Standard	1576.99	913.30	19	7.25	42x44x6	High-quality smartphone from Standard	2020-10-25
61	BrandA Vitamins	6	BrandA	21.85	11.75	37	5.04	25x12x23	High-quality vitamins from BrandA	2021-04-12
62	Standard Chocolate	9	Standard	37.50	26.12	32	6.38	45x42x5	High-quality chocolate from Standard	2019-03-16
63	BrandD Shampoo	6	BrandD	46.66	26.31	42	6.05	18x27x8	High-quality shampoo from BrandD	2020-01-27
64	BrandA Doll	7	BrandA	37.18	18.93	77	8.98	37x12x24	High-quality doll from BrandA	2021-10-19
65	Basic Tire Gauge	8	Basic	70.40	35.60	138	4.32	26x12x7	High-quality tire gauge from Basic	2021-07-28
66	Premium Plant Pot	3	Premium	104.91	60.69	138	4.42	23x47x24	High-quality plant pot from Premium	2021-06-14
67	Deluxe Science Textbook	5	Deluxe	47.52	31.92	25	9.95	11x10x22	High-quality science textbook from Deluxe	2019-02-03
68	BrandB Boots	2	BrandB	106.83	66.82	139	1.09	33x37x20	High-quality boots from BrandB	2019-03-08
69	BrandE Tent	4	BrandE	259.22	120.16	198	4.60	29x12x8	High-quality tent from BrandE	2021-08-19
70	Premium Jeans	2	Premium	194.01	130.80	105	9.09	46x50x25	High-quality jeans from Premium	2021-03-21
71	Premium Fiction Novel	5	Premium	41.29	22.80	68	8.81	21x24x15	High-quality fiction novel from Premium	2020-05-09
72	Basic Coffee Beans	9	Basic	6.47	2.64	95	8.42	38x43x12	High-quality coffee beans from Basic	2020-11-17
73	Deluxe Vacuum Cleaner	3	Deluxe	496.56	234.65	100	2.01	46x30x3	High-quality vacuum cleaner from Deluxe	2021-05-28
74	Basic Yoga Mat	4	Basic	293.77	132.82	81	5.22	32x19x5	High-quality yoga mat from Basic	2019-09-16
75	BrandB Bedding Set	3	BrandB	323.09	205.25	195	6.31	21x40x7	High-quality bedding set from BrandB	2020-10-22
76	BrandB Tea Set	9	BrandB	9.20	4.89	160	7.72	14x6x21	High-quality tea set from BrandB	2019-06-11
77	BrandA Glue Set	10	BrandA	57.74	25.36	116	6.38	27x16x9	High-quality glue set from BrandA	2020-03-30
78	BrandD Smart Watch	1	BrandD	1094.06	518.12	199	8.09	29x21x23	High-quality smart watch from BrandD	2019-04-16
79	BrandB Puzzle	7	BrandB	75.58	44.46	163	9.85	11x12x16	High-quality puzzle from BrandB	2019-09-09
80	BrandC Face Cream	6	BrandC	33.99	22.72	23	0.87	28x18x14	High-quality face cream from BrandC	2019-07-26
81	BrandA Toy Car	7	BrandA	40.13	21.91	160	0.86	48x31x14	High-quality toy car from BrandA	2020-10-04
82	BrandC Hat	2	BrandC	48.26	19.45	45	6.63	45x43x3	High-quality hat from BrandC	2019-08-29
83	Premium Craft Paper	10	Premium	40.42	23.61	139	0.15	38x21x5	High-quality craft paper from Premium	2020-01-30
84	Standard Coffee Beans	9	Standard	6.04	3.34	39	2.24	28x12x8	High-quality coffee beans from Standard	2019-03-02
85	BrandC Speaker	1	BrandC	478.53	295.89	32	2.75	35x17x4	High-quality speaker from BrandC	2020-12-14
86	BrandE Makeup Kit	6	BrandE	50.97	32.76	111	5.18	30x17x10	High-quality makeup kit from BrandE	2019-12-21
87	BrandE Sweater	2	BrandE	192.95	83.14	196	5.92	15x18x25	High-quality sweater from BrandE	2021-09-26
88	Elite Protein Bar	9	Elite	24.07	15.02	81	6.27	43x29x15	High-quality protein bar from Elite	2020-02-14
89	Premium Water Bottle	4	Premium	127.84	75.40	16	4.55	7x37x10	High-quality water bottle from Premium	2021-04-19
90	Deluxe Phone Mount	8	Deluxe	126.60	75.14	135	3.59	6x12x7	High-quality phone mount from Deluxe	2020-10-22
91	BrandC Boots	2	BrandC	81.18	34.24	168	3.78	14x25x5	High-quality boots from BrandC	2019-01-20
92	BrandA Bicycle	4	BrandA	222.12	103.09	145	7.97	19x40x4	High-quality bicycle from BrandA	2021-02-28
93	Deluxe Jacket	2	Deluxe	54.25	25.24	143	2.85	43x47x4	High-quality jacket from Deluxe	2021-05-13
94	Premium Tire Gauge	8	Premium	124.81	57.34	12	8.05	36x7x10	High-quality tire gauge from Premium	2021-05-12
95	BrandB Car Mat	8	BrandB	76.13	44.19	151	3.89	41x6x11	High-quality car mat from BrandB	2019-02-06
96	Deluxe Lamp	3	Deluxe	494.22	332.85	72	1.40	30x7x19	High-quality lamp from Deluxe	2021-12-16
97	Premium Smartphone	1	Premium	1307.31	550.16	24	8.32	31x24x10	High-quality smartphone from Premium	2020-10-11
98	Basic Science Textbook	5	Basic	13.19	8.34	126	6.16	30x24x24	High-quality science textbook from Basic	2021-07-19
99	BrandB Protein Bar	9	BrandB	42.94	29.26	26	0.39	8x5x6	High-quality protein bar from BrandB	2019-08-04
100	Basic Garden Hose	3	Basic	128.64	54.85	185	9.03	28x39x2	High-quality garden hose from Basic	2019-04-18
101	BrandA Jacket	2	BrandA	35.50	24.29	19	2.71	49x44x14	High-quality jacket from BrandA	2020-07-06
102	BrandC Air Freshener	8	BrandC	93.77	40.88	81	8.63	42x31x22	High-quality air freshener from BrandC	2021-07-04
103	BrandB Tent	4	BrandB	168.49	79.55	122	6.65	22x25x25	High-quality tent from BrandB	2021-09-15
104	BrandB Air Freshener	8	BrandB	50.61	24.74	21	3.59	20x47x22	High-quality air freshener from BrandB	2020-02-26
105	BrandB Tent	4	BrandB	45.66	25.04	54	0.23	18x34x14	High-quality tent from BrandB	2020-01-20
106	BrandB Hat	2	BrandB	77.98	50.23	194	5.32	25x24x24	High-quality hat from BrandB	2021-07-18
107	Standard Sketchbook	10	Standard	15.08	6.62	93	3.92	33x44x18	High-quality sketchbook from Standard	2020-02-20
108	BrandD Backpack	4	BrandD	43.88	23.12	175	3.14	41x46x5	High-quality backpack from BrandD	2019-10-29
109	BrandB Toy Car	7	BrandB	62.66	29.59	117	1.95	6x35x23	High-quality toy car from BrandB	2021-12-23
110	Premium Tire Gauge	8	Premium	50.85	34.48	21	3.61	18x14x14	High-quality tire gauge from Premium	2021-10-25
111	Standard Perfume	6	Standard	38.70	20.60	94	1.07	46x29x25	High-quality perfume from Standard	2021-05-15
112	BrandE Cookbook	5	BrandE	17.58	7.96	70	5.34	36x38x15	High-quality cookbook from BrandE	2019-08-12
113	BrandD Coffee Beans	9	BrandD	48.15	22.43	13	8.96	41x22x9	High-quality coffee beans from BrandD	2019-05-15
114	BrandB Bedding Set	3	BrandB	152.22	101.19	179	7.19	30x30x5	High-quality bedding set from BrandB	2020-03-26
115	Elite Craft Paper	10	Elite	21.78	13.85	88	6.41	50x43x11	High-quality craft paper from Elite	2019-01-07
116	BrandC Laptop	1	BrandC	1031.32	629.25	122	7.42	49x20x7	High-quality laptop from BrandC	2020-10-07
117	BrandB Tent	4	BrandB	70.83	35.39	116	1.50	5x47x17	High-quality tent from BrandB	2021-05-26
118	BrandA Speaker	1	BrandA	396.15	189.82	19	1.79	5x43x13	High-quality speaker from BrandA	2021-08-28
119	BrandA Bedding Set	3	BrandA	254.39	120.65	28	0.55	6x41x23	High-quality bedding set from BrandA	2020-08-18
120	Standard Sketchbook	10	Standard	41.71	26.13	198	1.03	24x26x16	High-quality sketchbook from Standard	2021-10-01
121	Standard Chocolate	9	Standard	16.58	9.05	93	4.64	27x24x24	High-quality chocolate from Standard	2020-11-14
122	Deluxe Water Bottle	4	Deluxe	158.20	76.09	132	7.31	6x14x15	High-quality water bottle from Deluxe	2020-03-27
123	Premium Tea Set	9	Premium	27.40	12.97	189	6.99	32x28x8	High-quality tea set from Premium	2019-07-02
124	Basic Sweater	2	Basic	133.17	91.84	160	6.82	33x38x7	High-quality sweater from Basic	2020-06-27
125	Premium Speaker	1	Premium	812.50	426.72	70	3.16	7x42x18	High-quality speaker from Premium	2020-12-04
126	BrandB Makeup Kit	6	BrandB	47.88	25.69	88	2.96	5x36x23	High-quality makeup kit from BrandB	2019-10-29
127	BrandC Hat	2	BrandC	111.79	54.43	142	6.68	24x36x11	High-quality hat from BrandC	2019-05-13
128	BrandA Craft Paper	10	BrandA	38.41	17.87	151	1.32	36x24x2	High-quality craft paper from BrandA	2021-05-31
129	BrandA Chocolate	9	BrandA	7.25	3.20	72	7.87	37x47x19	High-quality chocolate from BrandA	2019-11-14
130	BrandE Jeans	2	BrandE	41.39	25.66	110	5.89	10x23x9	High-quality jeans from BrandE	2019-03-07
131	Premium Protein Bar	9	Premium	16.19	9.77	98	4.28	11x21x11	High-quality protein bar from Premium	2020-09-28
132	Deluxe Action Figure	7	Deluxe	41.64	27.60	148	1.48	17x21x6	High-quality action figure from Deluxe	2021-05-02
133	BrandD Self-Help Book	5	BrandD	22.04	9.38	145	9.28	34x39x7	High-quality self-help book from BrandD	2021-02-08
134	BrandB Biography	5	BrandB	15.54	8.28	80	5.09	48x50x13	High-quality biography from BrandB	2021-08-17
135	Basic Science Textbook	5	Basic	28.66	19.73	118	0.37	40x6x15	High-quality science textbook from Basic	2019-07-01
136	Deluxe Sketchbook	10	Deluxe	68.76	43.73	148	5.17	13x44x19	High-quality sketchbook from Deluxe	2020-08-23
137	Basic Running Shoes	4	Basic	59.63	35.84	118	8.09	38x34x3	High-quality running shoes from Basic	2019-06-23
138	BrandE Board Game	7	BrandE	68.43	40.71	85	5.98	23x41x17	High-quality board game from BrandE	2020-11-09
139	BrandB Coffee Beans	9	BrandB	38.32	23.08	189	7.20	49x18x18	High-quality coffee beans from BrandB	2019-10-23
140	BrandC Glue Set	10	BrandC	22.98	13.85	39	3.08	24x5x17	High-quality glue set from BrandC	2020-02-16
141	BrandB Running Shoes	4	BrandB	25.01	14.53	30	5.25	20x18x5	High-quality running shoes from BrandB	2021-08-28
142	Standard T-Shirt	2	Standard	97.11	40.47	31	3.07	35x16x9	High-quality t-shirt from Standard	2020-06-17
143	Elite Bedding Set	3	Elite	432.47	253.06	110	1.55	6x16x6	High-quality bedding set from Elite	2020-05-07
144	Standard Air Freshener	8	Standard	115.12	64.93	121	4.86	23x47x5	High-quality air freshener from Standard	2021-10-06
145	BrandE Sneakers	2	BrandE	87.37	53.23	27	4.69	32x14x2	High-quality sneakers from BrandE	2020-08-03
146	BrandB Toy Car	7	BrandB	50.37	20.31	77	0.44	46x47x21	High-quality toy car from BrandB	2021-06-29
147	Premium Running Shoes	4	Premium	289.77	156.58	185	4.64	5x15x13	High-quality running shoes from Premium	2021-10-22
148	Premium Tablet	1	Premium	1809.97	1009.09	131	0.72	46x14x13	High-quality tablet from Premium	2020-11-25
149	BrandC Perfume	6	BrandC	33.61	21.13	77	9.24	9x46x17	High-quality perfume from BrandC	2021-02-10
150	Deluxe Perfume	6	Deluxe	68.63	39.31	129	7.78	38x21x6	High-quality perfume from Deluxe	2020-10-25
151	Deluxe Doll	7	Deluxe	35.67	20.88	103	0.77	6x15x9	High-quality doll from Deluxe	2019-07-17
152	Elite Paint Set	10	Elite	70.59	38.32	194	2.39	20x11x7	High-quality paint set from Elite	2021-02-25
153	BrandB Tire Gauge	8	BrandB	23.36	11.10	9	8.48	9x33x13	High-quality tire gauge from BrandB	2019-03-02
154	Premium Shampoo	6	Premium	17.90	9.57	34	9.89	41x40x8	High-quality shampoo from Premium	2020-02-05
155	Elite Chocolate	9	Elite	24.69	12.00	51	7.45	32x38x8	High-quality chocolate from Elite	2019-06-26
156	BrandB Smartphone	1	BrandB	446.90	287.36	1	3.66	31x41x19	High-quality smartphone from BrandB	2019-05-28
157	BrandC Bicycle	4	BrandC	212.65	146.16	186	6.46	36x17x8	High-quality bicycle from BrandC	2021-08-28
158	Premium Bedding Set	3	Premium	191.11	128.03	35	8.04	33x32x22	High-quality bedding set from Premium	2021-02-09
159	Deluxe Face Cream	6	Deluxe	15.19	9.64	76	1.10	36x19x3	High-quality face cream from Deluxe	2020-11-08
160	BrandD Paint Set	10	BrandD	63.03	30.69	64	3.97	27x9x7	High-quality paint set from BrandD	2020-08-12
161	Standard Running Shoes	4	Standard	183.22	120.18	156	5.05	30x44x3	High-quality running shoes from Standard	2019-08-16
162	BrandE Glue Set	10	BrandE	51.77	21.21	107	2.68	26x8x6	High-quality glue set from BrandE	2020-02-23
163	Premium Bedding Set	3	Premium	463.60	277.70	15	2.43	9x41x21	High-quality bedding set from Premium	2019-03-14
164	BrandB Phone Mount	8	BrandB	143.24	83.00	156	9.30	40x35x6	High-quality phone mount from BrandB	2020-07-08
165	BrandB Paint Set	10	BrandB	10.39	5.74	166	3.57	35x24x9	High-quality paint set from BrandB	2019-02-13
166	BrandA Coffee Beans	9	BrandA	39.81	25.61	136	6.12	29x48x23	High-quality coffee beans from BrandA	2019-02-07
167	BrandA Tire Gauge	8	BrandA	67.26	34.52	32	4.35	32x40x6	High-quality tire gauge from BrandA	2019-08-25
168	BrandB Glue Set	10	BrandB	68.11	47.32	94	3.58	26x32x3	High-quality glue set from BrandB	2020-05-02
169	BrandB Yoga Mat	4	BrandB	186.87	87.48	191	7.55	39x41x3	High-quality yoga mat from BrandB	2019-01-31
170	BrandA Tea Set	9	BrandA	8.45	3.70	46	2.90	25x27x21	High-quality tea set from BrandA	2020-05-15
171	BrandC Jacket	2	BrandC	127.13	69.11	31	6.60	9x21x19	High-quality jacket from BrandC	2020-02-26
172	Premium Plant Pot	3	Premium	450.87	296.50	113	7.16	28x40x11	High-quality plant pot from Premium	2020-05-15
173	BrandE Water Bottle	4	BrandE	112.69	63.38	26	0.63	31x50x21	High-quality water bottle from BrandE	2021-09-22
174	BrandB Bicycle	4	BrandB	80.98	35.72	133	2.38	40x18x5	High-quality bicycle from BrandB	2021-02-01
175	BrandA Headphones	1	BrandA	1956.92	1192.75	166	7.67	12x6x17	High-quality headphones from BrandA	2019-03-11
176	BrandE Phone Mount	8	BrandE	94.41	46.27	21	0.69	44x29x17	High-quality phone mount from BrandE	2019-02-08
177	Basic Tire Gauge	8	Basic	74.94	35.02	97	1.93	32x39x3	High-quality tire gauge from Basic	2020-09-16
178	Standard Coffee Maker	3	Standard	386.24	263.09	155	7.57	26x21x20	High-quality coffee maker from Standard	2020-03-19
179	Premium Running Shoes	4	Premium	224.59	131.71	109	7.85	8x11x19	High-quality running shoes from Premium	2021-03-05
180	BrandE Lamp	3	BrandE	432.09	294.42	118	4.30	41x38x10	High-quality lamp from BrandE	2019-11-29
181	Elite Glue Set	10	Elite	57.96	39.26	33	9.09	22x48x10	High-quality glue set from Elite	2019-06-25
182	Standard Tea Set	9	Standard	18.31	10.46	9	6.19	28x22x23	High-quality tea set from Standard	2020-05-28
183	BrandA Doll	7	BrandA	20.45	11.67	82	8.38	16x33x16	High-quality doll from BrandA	2019-02-05
184	BrandA Perfume	6	BrandA	50.91	35.12	122	6.41	40x18x15	High-quality perfume from BrandA	2019-04-30
185	BrandE Paint Set	10	BrandE	68.10	38.51	16	4.46	21x22x10	High-quality paint set from BrandE	2021-10-10
186	BrandD Cookbook	5	BrandD	35.21	15.64	158	6.59	19x12x22	High-quality cookbook from BrandD	2019-03-20
187	Standard Air Freshener	8	Standard	131.18	75.29	10	5.58	19x8x24	High-quality air freshener from Standard	2020-06-14
188	BrandA Puzzle	7	BrandA	58.13	38.21	90	5.45	7x43x9	High-quality puzzle from BrandA	2020-12-17
189	BrandB Fiction Novel	5	BrandB	30.28	13.14	19	2.45	25x41x13	High-quality fiction novel from BrandB	2021-05-01
190	Basic Fiction Novel	5	Basic	45.03	19.94	83	6.11	28x26x15	High-quality fiction novel from Basic	2021-02-06
191	BrandE Glue Set	10	BrandE	49.67	22.26	11	2.98	14x42x2	High-quality glue set from BrandE	2019-08-06
192	Premium Sketchbook	10	Premium	42.22	26.78	130	7.86	50x27x8	High-quality sketchbook from Premium	2021-02-14
193	BrandA Doll	7	BrandA	56.68	25.22	195	9.98	10x9x9	High-quality doll from BrandA	2021-10-28
194	Standard Protein Bar	9	Standard	37.99	24.86	135	8.00	43x35x23	High-quality protein bar from Standard	2021-12-10
195	Elite Bedding Set	3	Elite	172.13	78.92	147	3.00	20x26x9	High-quality bedding set from Elite	2021-01-11
196	Elite Shampoo	6	Elite	36.96	25.57	177	2.49	31x28x4	High-quality shampoo from Elite	2020-12-21
197	Premium Jeans	2	Premium	135.87	79.02	114	7.88	19x41x6	High-quality jeans from Premium	2020-05-16
198	Deluxe Tire Gauge	8	Deluxe	104.90	61.02	73	3.48	12x10x15	High-quality tire gauge from Deluxe	2021-05-12
199	BrandC Self-Help Book	5	BrandC	33.04	19.49	197	2.06	16x34x2	High-quality self-help book from BrandC	2019-12-08
200	Basic Car Mat	8	Basic	50.56	28.64	120	7.45	13x7x15	High-quality car mat from Basic	2019-02-19
201	BrandB Shampoo	6	BrandB	20.18	13.32	99	9.05	27x13x14	High-quality shampoo from BrandB	2020-05-09
202	BrandB Chocolate	9	BrandB	20.16	13.05	86	5.96	44x11x25	High-quality chocolate from BrandB	2019-04-03
203	Premium Laptop	1	Premium	1902.34	1280.66	161	4.55	32x23x17	High-quality laptop from Premium	2019-10-03
204	Deluxe Cookbook	5	Deluxe	46.65	31.77	21	1.61	5x42x20	High-quality cookbook from Deluxe	2021-01-27
205	Basic Protein Bar	9	Basic	19.42	8.80	184	5.92	11x19x11	High-quality protein bar from Basic	2021-10-07
206	BrandA Craft Paper	10	BrandA	45.80	30.65	148	5.13	32x23x12	High-quality craft paper from BrandA	2021-02-25
207	BrandC Puzzle	7	BrandC	76.84	31.70	188	8.84	18x32x18	High-quality puzzle from BrandC	2020-07-23
208	Deluxe Water Bottle	4	Deluxe	111.45	56.19	42	1.27	22x36x16	High-quality water bottle from Deluxe	2020-04-03
209	BrandE Sketchbook	10	BrandE	70.93	33.89	155	7.56	19x47x10	High-quality sketchbook from BrandE	2019-10-16
210	BrandD Jeans	2	BrandD	117.15	64.74	43	0.37	7x39x19	High-quality jeans from BrandD	2020-02-04
211	Elite Car Mat	8	Elite	127.39	51.94	52	2.89	41x32x25	High-quality car mat from Elite	2021-06-30
212	BrandC Self-Help Book	5	BrandC	43.24	21.12	28	7.19	12x33x15	High-quality self-help book from BrandC	2021-10-07
213	BrandB Craft Paper	10	BrandB	65.92	46.01	187	6.72	27x10x25	High-quality craft paper from BrandB	2020-03-31
214	Premium Paint Set	10	Premium	18.50	9.26	116	6.34	37x48x4	High-quality paint set from Premium	2020-10-06
215	Basic Fiction Novel	5	Basic	14.02	8.57	133	3.24	40x47x22	High-quality fiction novel from Basic	2019-03-14
216	BrandD Smartphone	1	BrandD	316.91	162.53	56	6.77	21x35x6	High-quality smartphone from BrandD	2021-09-19
217	Elite Yoga Mat	4	Elite	102.71	47.20	22	9.51	18x5x15	High-quality yoga mat from Elite	2019-05-18
218	Standard Biography	5	Standard	34.45	21.12	9	4.24	21x44x14	High-quality biography from Standard	2020-04-25
219	Elite Science Textbook	5	Elite	31.22	21.43	76	8.42	23x47x17	High-quality science textbook from Elite	2021-09-30
220	Deluxe Protein Bar	9	Deluxe	21.07	11.47	24	2.27	23x31x16	High-quality protein bar from Deluxe	2020-10-28
221	Basic Yoga Mat	4	Basic	56.85	30.67	81	6.64	27x49x14	High-quality yoga mat from Basic	2019-09-20
222	Elite Monitor	1	Elite	1222.06	740.77	7	2.98	37x18x15	High-quality monitor from Elite	2019-05-05
223	BrandE Chocolate	9	BrandE	35.37	18.51	113	4.31	21x8x10	High-quality chocolate from BrandE	2021-09-21
224	Premium Sketchbook	10	Premium	50.63	20.95	114	4.16	41x15x19	High-quality sketchbook from Premium	2020-02-27
225	Deluxe Car Mat	8	Deluxe	97.45	42.76	138	0.30	6x29x4	High-quality car mat from Deluxe	2020-11-13
226	Standard Speaker	1	Standard	173.76	72.07	53	3.68	17x15x19	High-quality speaker from Standard	2021-03-21
227	BrandE Tablet	1	BrandE	1612.51	1085.54	84	4.19	40x20x2	High-quality tablet from BrandE	2019-03-15
228	Standard Smartphone	1	Standard	249.92	129.80	124	0.52	23x24x2	High-quality smartphone from Standard	2020-04-16
229	BrandA Air Freshener	8	BrandA	51.78	22.63	200	3.84	30x13x25	High-quality air freshener from BrandA	2020-07-06
230	BrandB Paint Set	10	BrandB	12.95	7.99	195	7.35	6x5x25	High-quality paint set from BrandB	2019-11-07
231	Deluxe Laptop	1	Deluxe	1595.61	731.24	155	8.61	25x32x18	High-quality laptop from Deluxe	2019-02-17
232	BrandE Puzzle	7	BrandE	43.21	18.58	167	5.80	29x23x15	High-quality puzzle from BrandE	2019-07-10
233	Basic Tablet	1	Basic	1143.94	623.45	179	5.38	20x29x2	High-quality tablet from Basic	2021-10-14
234	Premium Glue Set	10	Premium	59.10	36.31	115	2.32	6x30x9	High-quality glue set from Premium	2021-07-04
235	Elite Science Textbook	5	Elite	32.53	19.29	85	1.52	45x10x5	High-quality science textbook from Elite	2019-12-13
236	Elite Tablet	1	Elite	1207.15	513.24	103	6.20	35x38x25	High-quality tablet from Elite	2020-04-21
237	Elite Paint Set	10	Elite	24.89	12.28	86	8.36	7x25x24	High-quality paint set from Elite	2021-04-12
238	BrandE Paint Set	10	BrandE	54.26	33.99	125	5.50	25x46x9	High-quality paint set from BrandE	2020-10-21
239	Elite Protein Bar	9	Elite	28.15	18.51	187	0.91	11x32x24	High-quality protein bar from Elite	2019-06-08
240	BrandC Perfume	6	BrandC	77.63	34.83	191	1.30	17x33x5	High-quality perfume from BrandC	2019-03-21
241	Elite Plant Pot	3	Elite	101.95	65.34	124	1.48	40x31x14	High-quality plant pot from Elite	2019-01-19
242	BrandB Smart Watch	1	BrandB	899.18	439.04	173	2.78	25x44x13	High-quality smart watch from BrandB	2019-12-06
243	BrandE Shampoo	6	BrandE	56.14	25.90	157	9.52	28x38x21	High-quality shampoo from BrandE	2020-05-29
244	Elite Toy Car	7	Elite	26.32	13.14	191	7.23	13x15x18	High-quality toy car from Elite	2021-08-28
245	Premium Car Mat	8	Premium	71.20	31.69	17	9.93	5x24x24	High-quality car mat from Premium	2020-01-20
246	BrandB Tablet	1	BrandB	1098.58	548.53	15	6.29	43x15x4	High-quality tablet from BrandB	2020-12-18
247	BrandD Self-Help Book	5	BrandD	23.80	9.62	49	2.82	32x42x25	High-quality self-help book from BrandD	2020-09-18
248	Deluxe Bicycle	4	Deluxe	235.92	160.49	143	5.46	47x17x4	High-quality bicycle from Deluxe	2019-11-09
249	BrandD Coffee Beans	9	BrandD	17.60	8.43	26	1.35	38x42x22	High-quality coffee beans from BrandD	2021-02-23
250	Deluxe Science Textbook	5	Deluxe	40.88	23.61	70	9.67	44x47x17	High-quality science textbook from Deluxe	2020-03-04
251	BrandA Dress	2	BrandA	159.92	111.42	23	9.30	44x14x6	High-quality dress from BrandA	2019-12-04
252	BrandA Plant Pot	3	BrandA	175.20	117.17	13	1.46	33x32x23	High-quality plant pot from BrandA	2021-08-24
253	BrandE Phone Mount	8	BrandE	82.55	35.92	143	3.99	29x50x17	High-quality phone mount from BrandE	2020-12-28
254	Standard Chocolate	9	Standard	19.26	8.16	154	8.44	15x45x10	High-quality chocolate from Standard	2019-10-20
255	Standard Boots	2	Standard	96.70	58.84	64	6.89	40x32x22	High-quality boots from Standard	2020-12-14
256	BrandA Dress	2	BrandA	175.24	115.06	197	6.73	32x18x21	High-quality dress from BrandA	2020-01-27
257	Premium Protein Bar	9	Premium	13.06	8.15	2	2.04	28x38x8	High-quality protein bar from Premium	2019-01-12
258	BrandE Doll	7	BrandE	34.33	23.11	64	5.08	5x43x10	High-quality doll from BrandE	2019-03-10
259	Elite Vitamins	6	Elite	44.64	31.19	180	2.61	45x8x20	High-quality vitamins from Elite	2019-03-04
260	Deluxe Glue Set	10	Deluxe	50.36	27.55	121	7.52	46x39x5	High-quality glue set from Deluxe	2019-03-20
261	BrandA Vitamins	6	BrandA	64.39	39.54	180	7.39	13x10x15	High-quality vitamins from BrandA	2019-09-02
262	Elite Board Game	7	Elite	55.35	23.17	24	8.59	22x17x22	High-quality board game from Elite	2019-02-04
263	Premium Speaker	1	Premium	1800.59	811.64	150	7.25	28x38x2	High-quality speaker from Premium	2021-04-05
264	BrandA Plant Pot	3	BrandA	51.18	33.14	128	1.56	22x10x7	High-quality plant pot from BrandA	2021-06-27
265	BrandE Running Shoes	4	BrandE	192.35	116.68	104	1.81	5x24x10	High-quality running shoes from BrandE	2020-12-19
266	Premium Coffee Maker	3	Premium	243.80	158.67	22	5.71	34x10x5	High-quality coffee maker from Premium	2019-07-05
267	BrandB Vacuum Cleaner	3	BrandB	109.12	63.00	5	7.69	5x18x22	High-quality vacuum cleaner from BrandB	2021-02-06
268	BrandB Plant Pot	3	BrandB	441.06	301.23	78	8.39	46x17x25	High-quality plant pot from BrandB	2019-09-29
269	BrandA Craft Paper	10	BrandA	33.41	16.24	71	1.49	25x31x9	High-quality craft paper from BrandA	2020-01-21
270	BrandD Science Textbook	5	BrandD	17.08	8.34	178	4.45	10x36x13	High-quality science textbook from BrandD	2021-01-14
271	Standard Bicycle	4	Standard	148.66	87.61	43	0.46	42x29x6	High-quality bicycle from Standard	2020-03-07
272	Basic Tent	4	Basic	120.40	77.45	73	2.15	49x37x19	High-quality tent from Basic	2020-07-04
273	Standard Laptop	1	Standard	1558.15	743.96	119	2.68	12x38x23	High-quality laptop from Standard	2020-01-17
274	BrandC Tire Gauge	8	BrandC	78.08	38.80	144	3.84	42x7x12	High-quality tire gauge from BrandC	2019-08-03
275	BrandA Sneakers	2	BrandA	44.37	24.08	86	6.51	11x16x13	High-quality sneakers from BrandA	2020-09-19
276	Elite Sketchbook	10	Elite	44.63	27.92	112	8.11	34x42x20	High-quality sketchbook from Elite	2021-06-09
277	Elite Camera	1	Elite	1676.49	797.63	95	6.05	35x48x14	High-quality camera from Elite	2020-09-06
278	BrandD Coffee Beans	9	BrandD	39.34	26.37	129	1.17	32x22x20	High-quality coffee beans from BrandD	2021-03-31
279	BrandA Self-Help Book	5	BrandA	16.56	7.45	76	8.88	49x38x8	High-quality self-help book from BrandA	2019-10-13
280	Premium Yoga Mat	4	Premium	241.86	100.65	23	3.16	14x27x16	High-quality yoga mat from Premium	2021-03-21
281	Elite Action Figure	7	Elite	12.06	5.36	44	3.08	10x16x9	High-quality action figure from Elite	2020-02-21
282	BrandB Plant Pot	3	BrandB	367.58	164.03	142	8.47	28x5x17	High-quality plant pot from BrandB	2019-11-23
283	BrandB Chocolate	9	BrandB	26.19	15.87	178	2.20	35x47x14	High-quality chocolate from BrandB	2021-08-07
284	BrandB Tea Set	9	BrandB	22.44	11.12	34	4.06	25x23x23	High-quality tea set from BrandB	2021-05-19
285	Basic Self-Help Book	5	Basic	31.36	15.81	171	7.43	42x6x9	High-quality self-help book from Basic	2019-12-31
286	Premium Tea Set	9	Premium	21.30	11.72	0	6.14	30x9x22	High-quality tea set from Premium	2020-04-16
287	Elite Tea Set	9	Elite	13.46	6.24	111	1.02	29x46x7	High-quality tea set from Elite	2021-05-21
288	BrandE Headphones	1	BrandE	656.63	395.67	123	0.44	31x16x7	High-quality headphones from BrandE	2021-03-26
289	Elite Laptop	1	Elite	1622.15	817.38	187	1.10	30x5x7	High-quality laptop from Elite	2020-10-15
290	Deluxe Vacuum Cleaner	3	Deluxe	263.35	159.56	2	4.91	47x30x15	High-quality vacuum cleaner from Deluxe	2019-04-22
291	Basic Jacket	2	Basic	62.85	37.10	154	8.09	33x37x13	High-quality jacket from Basic	2021-08-27
292	Premium Lamp	3	Premium	425.20	294.04	28	7.88	32x39x14	High-quality lamp from Premium	2019-06-13
293	BrandA Dress	2	BrandA	77.37	52.63	151	2.65	37x44x25	High-quality dress from BrandA	2021-07-20
294	BrandA Camera	1	BrandA	956.29	393.95	125	4.66	8x43x23	High-quality camera from BrandA	2021-01-26
295	Basic Vitamins	6	Basic	39.05	19.09	6	5.47	16x23x13	High-quality vitamins from Basic	2021-05-04
296	Elite Coffee Beans	9	Elite	19.61	11.59	152	1.21	7x39x25	High-quality coffee beans from Elite	2021-03-22
297	BrandC Shampoo	6	BrandC	15.73	6.74	186	1.53	36x32x10	High-quality shampoo from BrandC	2020-12-08
298	Deluxe Plant Pot	3	Deluxe	137.17	88.84	187	8.22	41x34x3	High-quality plant pot from Deluxe	2019-06-06
299	Premium Craft Paper	10	Premium	10.57	6.16	185	6.41	11x29x18	High-quality craft paper from Premium	2019-06-11
300	BrandE Speaker	1	BrandE	873.93	355.44	191	2.64	46x10x15	High-quality speaker from BrandE	2019-08-27
301	Deluxe Tablet	1	Deluxe	558.90	274.40	131	5.44	20x49x3	High-quality tablet from Deluxe	2021-02-05
302	Elite Water Bottle	4	Elite	84.18	57.30	70	7.49	16x22x18	High-quality water bottle from Elite	2019-04-04
303	Basic Makeup Kit	6	Basic	91.70	55.34	69	0.15	18x6x15	High-quality makeup kit from Basic	2019-09-23
304	BrandE Smart Watch	1	BrandE	951.76	606.34	162	3.25	19x19x2	High-quality smart watch from BrandE	2020-10-26
305	BrandB Shampoo	6	BrandB	64.25	39.74	155	8.29	42x31x22	High-quality shampoo from BrandB	2020-11-04
306	Basic Water Bottle	4	Basic	155.79	88.38	87	3.47	27x33x6	High-quality water bottle from Basic	2021-08-04
307	BrandD Glue Set	10	BrandD	43.66	19.69	99	2.63	7x47x20	High-quality glue set from BrandD	2019-06-10
308	Standard Hat	2	Standard	197.22	83.80	191	9.85	28x24x11	High-quality hat from Standard	2020-10-07
309	Elite Hat	2	Elite	20.47	12.03	42	6.28	41x32x15	High-quality hat from Elite	2019-02-17
310	Standard Chocolate	9	Standard	38.48	26.82	96	9.22	13x29x21	High-quality chocolate from Standard	2019-09-10
311	Basic Laptop	1	Basic	475.70	331.87	146	2.96	15x30x19	High-quality laptop from Basic	2021-04-16
312	BrandD Chocolate	9	BrandD	23.82	13.81	81	7.73	45x11x23	High-quality chocolate from BrandD	2020-10-12
313	Standard Water Bottle	4	Standard	171.44	80.15	103	5.00	34x23x16	High-quality water bottle from Standard	2019-11-18
314	Basic Vacuum Cleaner	3	Basic	158.44	88.69	85	7.65	46x16x23	High-quality vacuum cleaner from Basic	2019-07-21
315	Deluxe Camera	1	Deluxe	1323.55	916.26	105	1.97	6x44x9	High-quality camera from Deluxe	2019-10-11
316	Deluxe Self-Help Book	5	Deluxe	30.13	12.78	146	7.35	6x25x21	High-quality self-help book from Deluxe	2020-05-26
317	Deluxe Cookbook	5	Deluxe	35.02	21.20	94	0.32	43x46x14	High-quality cookbook from Deluxe	2021-11-13
318	BrandC Shampoo	6	BrandC	50.11	30.91	61	1.83	50x17x12	High-quality shampoo from BrandC	2019-09-29
319	BrandB Smart Watch	1	BrandB	1794.17	829.09	118	4.65	48x43x16	High-quality smart watch from BrandB	2020-05-10
320	Elite Air Freshener	8	Elite	82.53	35.76	154	8.39	15x20x16	High-quality air freshener from Elite	2019-05-24
321	BrandA Coffee Beans	9	BrandA	35.69	18.63	133	9.96	29x9x15	High-quality coffee beans from BrandA	2020-06-16
322	Deluxe Jeans	2	Deluxe	134.71	75.47	6	4.44	8x23x14	High-quality jeans from Deluxe	2019-03-23
323	Basic Speaker	1	Basic	1447.42	801.10	166	4.46	12x11x6	High-quality speaker from Basic	2020-06-21
324	BrandB Makeup Kit	6	BrandB	74.42	37.95	168	3.46	20x35x8	High-quality makeup kit from BrandB	2020-06-25
325	Premium Coffee Beans	9	Premium	33.89	14.31	181	4.97	20x21x12	High-quality coffee beans from Premium	2020-08-27
326	Premium Perfume	6	Premium	80.44	49.06	145	2.83	7x13x6	High-quality perfume from Premium	2021-12-04
327	BrandA Garden Hose	3	BrandA	126.09	64.46	92	7.17	24x50x7	High-quality garden hose from BrandA	2020-09-16
328	Elite Glue Set	10	Elite	53.11	23.70	177	1.37	43x23x14	High-quality glue set from Elite	2020-06-10
329	BrandA Tea Set	9	BrandA	43.29	24.89	37	5.88	21x28x25	High-quality tea set from BrandA	2021-11-07
330	Basic Doll	7	Basic	44.43	29.77	88	6.47	42x37x12	High-quality doll from Basic	2021-12-07
331	Basic Craft Paper	10	Basic	65.98	36.00	43	8.72	35x16x17	High-quality craft paper from Basic	2021-02-16
332	BrandB Coffee Beans	9	BrandB	20.41	10.06	57	1.59	43x12x22	High-quality coffee beans from BrandB	2020-02-08
333	Elite Garden Hose	3	Elite	240.47	162.03	3	8.42	38x19x25	High-quality garden hose from Elite	2020-02-19
334	BrandA Chocolate	9	BrandA	22.93	9.85	84	5.12	22x40x19	High-quality chocolate from BrandA	2019-06-12
335	Elite Paint Set	10	Elite	45.97	21.81	65	7.99	16x49x22	High-quality paint set from Elite	2020-05-16
336	Elite Tea Set	9	Elite	12.98	9.01	68	5.56	10x17x25	High-quality tea set from Elite	2019-05-11
337	Standard Dress	2	Standard	71.01	32.83	62	5.90	42x35x16	High-quality dress from Standard	2019-07-21
338	BrandA Bedding Set	3	BrandA	173.05	102.13	50	4.84	33x10x17	High-quality bedding set from BrandA	2020-02-09
339	Standard Running Shoes	4	Standard	187.08	108.41	76	5.74	42x32x5	High-quality running shoes from Standard	2021-06-25
340	Deluxe Tea Set	9	Deluxe	41.26	24.11	116	9.92	21x31x21	High-quality tea set from Deluxe	2020-07-08
341	BrandC Tire Gauge	8	BrandC	59.37	32.36	72	9.52	24x21x19	High-quality tire gauge from BrandC	2020-05-24
342	BrandE Vitamins	6	BrandE	70.36	38.76	160	4.46	16x36x2	High-quality vitamins from BrandE	2020-10-15
343	Elite Hat	2	Elite	45.18	18.96	110	6.76	11x33x12	High-quality hat from Elite	2020-01-10
344	BrandB Tea Set	9	BrandB	39.33	18.25	128	3.12	38x35x5	High-quality tea set from BrandB	2020-09-06
345	Deluxe Tea Set	9	Deluxe	35.23	17.51	49	7.69	15x15x21	High-quality tea set from Deluxe	2019-11-18
346	Standard Puzzle	7	Standard	78.72	46.92	106	7.82	22x19x10	High-quality puzzle from Standard	2021-08-24
347	Premium Phone Mount	8	Premium	34.57	17.29	90	8.31	25x33x11	High-quality phone mount from Premium	2021-05-21
348	Basic Protein Bar	9	Basic	5.26	3.59	14	9.69	27x46x6	High-quality protein bar from Basic	2021-07-24
349	BrandA Puzzle	7	BrandA	67.66	31.17	169	7.20	23x28x2	High-quality puzzle from BrandA	2020-10-21
350	Basic Glue Set	10	Basic	29.82	16.94	51	7.99	44x37x16	High-quality glue set from Basic	2020-07-15
351	BrandB Car Mat	8	BrandB	47.82	23.80	122	9.42	42x35x3	High-quality car mat from BrandB	2021-03-09
352	BrandD Biography	5	BrandD	21.21	12.34	96	0.69	8x45x12	High-quality biography from BrandD	2020-07-19
353	Elite Phone Mount	8	Elite	139.69	60.53	34	8.82	9x25x25	High-quality phone mount from Elite	2021-04-27
354	BrandC Headphones	1	BrandC	1200.13	686.75	143	0.97	20x25x20	High-quality headphones from BrandC	2020-06-17
355	Standard Self-Help Book	5	Standard	42.69	25.91	35	7.74	9x49x24	High-quality self-help book from Standard	2020-10-04
356	Elite Garden Hose	3	Elite	378.69	175.88	82	4.74	34x28x12	High-quality garden hose from Elite	2020-02-12
357	BrandE Lamp	3	BrandE	142.57	89.01	5	1.49	46x31x15	High-quality lamp from BrandE	2021-03-22
358	BrandA Toy Car	7	BrandA	68.55	28.66	131	3.80	41x32x3	High-quality toy car from BrandA	2021-10-29
359	Standard Vitamins	6	Standard	53.26	30.49	162	0.76	9x41x4	High-quality vitamins from Standard	2019-08-19
360	BrandC Self-Help Book	5	BrandC	41.94	27.42	22	5.78	34x44x22	High-quality self-help book from BrandC	2020-01-26
361	Basic Board Game	7	Basic	67.61	36.49	189	1.61	26x9x7	High-quality board game from Basic	2020-11-26
362	Standard Glue Set	10	Standard	60.33	37.52	110	8.91	30x41x11	High-quality glue set from Standard	2019-01-14
363	Basic Water Bottle	4	Basic	30.19	14.12	109	1.59	19x42x23	High-quality water bottle from Basic	2020-10-30
364	BrandD Hat	2	BrandD	157.44	90.11	90	8.94	50x41x6	High-quality hat from BrandD	2020-01-22
365	BrandD Cookbook	5	BrandD	22.34	9.61	136	6.06	7x13x19	High-quality cookbook from BrandD	2020-12-14
366	Premium Coffee Maker	3	Premium	437.87	297.11	168	2.17	24x15x15	High-quality coffee maker from Premium	2020-07-09
367	BrandD Air Freshener	8	BrandD	119.27	48.68	112	1.32	29x6x16	High-quality air freshener from BrandD	2020-03-03
368	BrandA Plant Pot	3	BrandA	234.47	121.87	52	7.73	42x12x4	High-quality plant pot from BrandA	2019-12-25
369	Deluxe Doll	7	Deluxe	61.27	26.75	193	2.18	36x43x13	High-quality doll from Deluxe	2020-10-10
370	BrandD Camera	1	BrandD	460.14	196.59	129	3.66	21x37x5	High-quality camera from BrandD	2021-07-24
371	BrandA Running Shoes	4	BrandA	129.51	68.12	25	3.61	24x9x15	High-quality running shoes from BrandA	2020-09-07
372	BrandB Yoga Mat	4	BrandB	203.87	131.10	120	0.26	22x46x12	High-quality yoga mat from BrandB	2019-04-03
373	BrandD Action Figure	7	BrandD	24.06	9.69	132	1.64	49x35x3	High-quality action figure from BrandD	2019-05-06
374	BrandD Self-Help Book	5	BrandD	44.65	26.71	95	6.21	15x31x7	High-quality self-help book from BrandD	2019-12-24
375	BrandC Doll	7	BrandC	62.45	40.16	46	3.71	12x15x2	High-quality doll from BrandC	2021-10-15
376	BrandE Shampoo	6	BrandE	45.14	23.11	67	6.26	6x6x12	High-quality shampoo from BrandE	2019-02-28
377	BrandA Glue Set	10	BrandA	57.24	25.37	104	0.56	29x43x25	High-quality glue set from BrandA	2021-12-11
378	BrandC Headphones	1	BrandC	245.22	123.74	57	1.01	9x12x17	High-quality headphones from BrandC	2021-08-09
379	Standard Glue Set	10	Standard	37.51	24.65	163	0.11	35x35x10	High-quality glue set from Standard	2019-09-20
380	Standard Vitamins	6	Standard	41.63	24.32	183	1.05	36x41x8	High-quality vitamins from Standard	2019-09-15
381	Standard Shampoo	6	Standard	19.94	13.61	57	6.63	11x50x14	High-quality shampoo from Standard	2020-08-01
382	BrandB Bedding Set	3	BrandB	139.89	66.48	186	6.63	26x50x16	High-quality bedding set from BrandB	2021-11-30
383	BrandC Craft Paper	10	BrandC	29.97	15.36	37	5.84	7x29x22	High-quality craft paper from BrandC	2019-04-09
384	BrandC Tea Set	9	BrandC	5.64	3.33	60	1.70	25x5x20	High-quality tea set from BrandC	2021-09-11
385	Premium Protein Bar	9	Premium	13.45	8.89	147	4.12	18x34x21	High-quality protein bar from Premium	2020-06-22
386	BrandB Hat	2	BrandB	152.82	91.18	131	9.25	26x16x10	High-quality hat from BrandB	2020-11-29
387	Standard Toy Car	7	Standard	43.03	18.46	87	7.66	21x9x13	High-quality toy car from Standard	2021-05-23
388	Standard Fiction Novel	5	Standard	15.05	7.05	117	8.32	12x40x24	High-quality fiction novel from Standard	2020-08-28
389	Premium Dress	2	Premium	71.80	38.11	21	9.67	37x16x14	High-quality dress from Premium	2021-11-12
390	BrandC Cookbook	5	BrandC	43.60	20.34	4	2.07	27x38x21	High-quality cookbook from BrandC	2019-11-07
391	Standard Water Bottle	4	Standard	169.39	108.42	92	5.44	49x38x7	High-quality water bottle from Standard	2021-02-05
392	BrandB Tea Set	9	BrandB	35.62	21.03	158	2.34	50x14x19	High-quality tea set from BrandB	2021-05-18
393	BrandE Action Figure	7	BrandE	15.33	10.59	102	3.04	38x31x17	High-quality action figure from BrandE	2021-08-16
394	BrandC Sneakers	2	BrandC	148.49	72.76	19	2.59	40x47x11	High-quality sneakers from BrandC	2020-03-03
395	Deluxe Self-Help Book	5	Deluxe	48.37	20.21	105	1.49	35x15x9	High-quality self-help book from Deluxe	2021-03-12
396	Basic Sketchbook	10	Basic	34.20	15.66	89	0.80	22x13x14	High-quality sketchbook from Basic	2019-09-10
397	BrandD Dress	2	BrandD	97.03	58.38	194	3.34	45x12x18	High-quality dress from BrandD	2020-09-29
398	BrandB Water Bottle	4	BrandB	237.21	137.47	59	6.64	24x12x19	High-quality water bottle from BrandB	2021-07-19
399	BrandB Action Figure	7	BrandB	71.86	45.00	184	3.48	22x7x14	High-quality action figure from BrandB	2020-06-07
400	Elite Car Mat	8	Elite	72.50	32.66	181	6.95	36x23x9	High-quality car mat from Elite	2021-12-06
401	BrandB Coffee Maker	3	BrandB	498.85	289.83	153	8.66	20x47x17	High-quality coffee maker from BrandB	2021-06-04
402	BrandA Toy Car	7	BrandA	55.39	36.53	71	8.44	22x21x22	High-quality toy car from BrandA	2021-11-06
403	Basic Bicycle	4	Basic	208.42	99.08	91	0.92	11x50x17	High-quality bicycle from Basic	2020-05-12
404	Elite Self-Help Book	5	Elite	18.86	10.00	68	1.13	50x36x19	High-quality self-help book from Elite	2021-02-08
405	BrandA Camera	1	BrandA	1223.24	705.94	164	9.55	41x11x5	High-quality camera from BrandA	2020-05-03
406	Deluxe Craft Paper	10	Deluxe	53.06	35.61	107	8.17	50x7x13	High-quality craft paper from Deluxe	2021-06-20
407	Deluxe Backpack	4	Deluxe	262.44	107.91	102	8.15	45x32x23	High-quality backpack from Deluxe	2019-02-22
408	Deluxe Action Figure	7	Deluxe	24.29	14.31	84	1.08	31x6x25	High-quality action figure from Deluxe	2021-07-24
409	Premium Craft Paper	10	Premium	62.83	31.62	63	2.84	8x25x16	High-quality craft paper from Premium	2020-06-22
410	BrandD Yoga Mat	4	BrandD	178.58	117.69	165	3.29	30x27x7	High-quality yoga mat from BrandD	2021-10-20
411	Premium Face Cream	6	Premium	40.37	22.67	58	3.23	24x11x25	High-quality face cream from Premium	2019-07-05
412	Premium Protein Bar	9	Premium	32.98	19.52	193	3.89	21x50x17	High-quality protein bar from Premium	2020-12-19
413	Elite Craft Paper	10	Elite	68.02	42.61	43	3.30	12x17x20	High-quality craft paper from Elite	2020-09-27
414	Standard Doll	7	Standard	32.14	18.25	45	4.04	49x9x8	High-quality doll from Standard	2019-07-11
415	Deluxe Fiction Novel	5	Deluxe	46.59	27.91	67	1.54	26x39x13	High-quality fiction novel from Deluxe	2021-03-23
416	Basic Shampoo	6	Basic	17.53	12.04	75	6.17	10x25x9	High-quality shampoo from Basic	2021-06-25
417	BrandD Paint Set	10	BrandD	44.72	26.84	70	0.36	19x49x9	High-quality paint set from BrandD	2020-05-17
418	Elite Sweater	2	Elite	134.86	62.68	3	3.04	6x44x17	High-quality sweater from Elite	2021-06-17
419	Standard Camera	1	Standard	1124.89	641.67	105	1.94	38x42x14	High-quality camera from Standard	2021-03-03
420	Premium Jacket	2	Premium	163.63	78.39	94	3.71	20x25x19	High-quality jacket from Premium	2021-01-01
421	BrandC Board Game	7	BrandC	33.87	21.96	179	2.54	39x42x6	High-quality board game from BrandC	2019-07-17
422	Elite Makeup Kit	6	Elite	57.25	24.70	154	2.36	27x50x24	High-quality makeup kit from Elite	2020-04-03
423	BrandE Hat	2	BrandE	121.24	50.43	158	4.43	42x32x4	High-quality hat from BrandE	2019-12-17
424	Standard Smartphone	1	Standard	924.51	550.16	88	4.82	50x14x4	High-quality smartphone from Standard	2020-12-26
425	BrandE Board Game	7	BrandE	50.74	34.72	186	0.37	43x36x15	High-quality board game from BrandE	2019-10-01
426	BrandD Protein Bar	9	BrandD	34.78	17.14	178	6.78	26x19x20	High-quality protein bar from BrandD	2021-11-06
427	BrandC Boots	2	BrandC	156.77	108.81	150	3.21	5x44x3	High-quality boots from BrandC	2021-01-03
428	BrandB Water Bottle	4	BrandB	238.02	100.28	16	5.34	15x17x9	High-quality water bottle from BrandB	2020-01-03
429	BrandA Dress	2	BrandA	135.14	74.12	30	3.38	11x30x20	High-quality dress from BrandA	2021-03-04
430	Basic Boots	2	Basic	143.84	63.51	87	1.91	24x27x7	High-quality boots from Basic	2021-05-31
431	Elite Smart Watch	1	Elite	226.93	108.51	51	2.34	46x45x4	High-quality smart watch from Elite	2020-11-26
432	BrandB Protein Bar	9	BrandB	28.57	11.60	155	0.70	40x8x23	High-quality protein bar from BrandB	2021-02-03
433	BrandC Fiction Novel	5	BrandC	10.07	7.00	3	0.15	29x24x2	High-quality fiction novel from BrandC	2021-02-06
434	BrandC Jeans	2	BrandC	49.87	29.24	46	5.40	27x11x23	High-quality jeans from BrandC	2019-11-13
435	Deluxe Chocolate	9	Deluxe	12.96	6.90	197	1.86	14x33x2	High-quality chocolate from Deluxe	2019-03-21
436	BrandE Paint Set	10	BrandE	70.65	30.54	174	1.89	38x15x5	High-quality paint set from BrandE	2021-10-16
437	Deluxe Tea Set	9	Deluxe	11.99	7.00	86	9.38	47x40x14	High-quality tea set from Deluxe	2021-07-06
438	Standard Coffee Beans	9	Standard	7.95	3.77	36	2.47	36x17x14	High-quality coffee beans from Standard	2019-03-27
439	BrandA Speaker	1	BrandA	1837.39	1242.70	168	7.11	42x11x18	High-quality speaker from BrandA	2019-07-06
440	Standard Sneakers	2	Standard	119.15	72.76	133	4.00	39x46x8	High-quality sneakers from Standard	2020-08-01
441	BrandC Sneakers	2	BrandC	97.86	44.96	160	4.32	32x29x4	High-quality sneakers from BrandC	2021-10-01
442	Elite Board Game	7	Elite	19.09	10.85	156	3.95	36x23x23	High-quality board game from Elite	2019-04-23
443	BrandA Self-Help Book	5	BrandA	17.52	7.48	150	7.50	41x39x7	High-quality self-help book from BrandA	2020-10-04
444	BrandA Lamp	3	BrandA	276.46	114.50	77	3.91	27x39x3	High-quality lamp from BrandA	2021-06-07
445	Standard Tent	4	Standard	169.10	76.68	94	6.84	7x18x5	High-quality tent from Standard	2021-07-25
446	BrandD Vacuum Cleaner	3	BrandD	361.96	152.71	52	5.00	41x45x21	High-quality vacuum cleaner from BrandD	2019-02-01
447	Basic Fiction Novel	5	Basic	18.24	11.07	74	0.15	20x47x12	High-quality fiction novel from Basic	2019-12-29
448	BrandD Protein Bar	9	BrandD	21.73	14.15	11	1.64	43x20x21	High-quality protein bar from BrandD	2020-06-12
449	Deluxe Protein Bar	9	Deluxe	36.96	24.79	79	2.13	46x22x15	High-quality protein bar from Deluxe	2019-01-21
450	Basic Glue Set	10	Basic	33.27	21.72	48	8.19	36x21x21	High-quality glue set from Basic	2019-01-22
451	BrandA Biography	5	BrandA	37.84	20.23	169	6.93	9x45x5	High-quality biography from BrandA	2019-08-25
452	Elite Shampoo	6	Elite	14.12	7.92	42	9.44	21x48x24	High-quality shampoo from Elite	2021-03-26
453	Standard Craft Paper	10	Standard	27.19	17.85	66	1.17	12x30x8	High-quality craft paper from Standard	2019-06-27
454	BrandD Protein Bar	9	BrandD	10.72	7.49	120	4.84	12x19x3	High-quality protein bar from BrandD	2021-03-05
455	BrandB Cookbook	5	BrandB	40.50	26.00	61	4.42	28x33x25	High-quality cookbook from BrandB	2019-10-20
456	Deluxe Protein Bar	9	Deluxe	39.61	23.72	128	7.69	17x18x25	High-quality protein bar from Deluxe	2020-10-13
457	Deluxe Fiction Novel	5	Deluxe	10.57	4.71	64	9.23	27x34x8	High-quality fiction novel from Deluxe	2019-04-26
458	Basic Boots	2	Basic	43.32	21.12	16	2.33	45x17x12	High-quality boots from Basic	2021-06-17
459	Elite Coffee Maker	3	Elite	53.30	25.25	135	2.95	15x14x19	High-quality coffee maker from Elite	2020-10-12
460	BrandB Paint Set	10	BrandB	53.88	28.18	136	0.27	15x25x13	High-quality paint set from BrandB	2019-03-20
461	BrandB Cookbook	5	BrandB	37.37	15.01	0	5.67	29x41x5	High-quality cookbook from BrandB	2020-04-04
462	BrandA Lamp	3	BrandA	290.55	122.66	166	8.26	35x41x22	High-quality lamp from BrandA	2021-03-01
463	Deluxe Science Textbook	5	Deluxe	25.47	17.14	60	6.86	44x21x13	High-quality science textbook from Deluxe	2021-07-20
464	BrandC Tire Gauge	8	BrandC	76.32	50.66	57	1.53	45x16x14	High-quality tire gauge from BrandC	2020-06-10
465	Premium Dress	2	Premium	151.90	80.43	76	1.53	34x31x24	High-quality dress from Premium	2020-04-09
466	BrandC Biography	5	BrandC	43.61	22.06	103	4.27	31x34x25	High-quality biography from BrandC	2021-07-15
467	Basic Hat	2	Basic	100.75	50.51	170	4.05	38x18x9	High-quality hat from Basic	2020-03-20
468	Deluxe Tablet	1	Deluxe	429.47	284.34	168	7.86	28x34x19	High-quality tablet from Deluxe	2021-04-16
469	BrandE Vitamins	6	BrandE	27.64	12.23	27	5.47	33x24x21	High-quality vitamins from BrandE	2021-04-24
470	BrandD Fiction Novel	5	BrandD	18.69	10.57	40	6.63	38x32x7	High-quality fiction novel from BrandD	2021-06-26
471	BrandD Car Mat	8	BrandD	67.11	40.27	69	9.84	48x41x6	High-quality car mat from BrandD	2021-04-03
472	BrandC Sweater	2	BrandC	91.09	49.24	189	1.39	36x25x21	High-quality sweater from BrandC	2021-12-22
473	BrandB T-Shirt	2	BrandB	160.59	68.37	2	9.21	8x26x4	High-quality t-shirt from BrandB	2020-10-03
474	BrandD Puzzle	7	BrandD	62.56	43.00	78	8.42	28x44x12	High-quality puzzle from BrandD	2021-07-03
475	Premium Backpack	4	Premium	218.49	106.39	25	8.04	15x14x7	High-quality backpack from Premium	2021-04-30
476	Standard Laptop	1	Standard	1824.95	954.27	143	5.57	35x49x10	High-quality laptop from Standard	2020-05-25
477	BrandC Jeans	2	BrandC	183.20	78.61	10	1.44	29x35x14	High-quality jeans from BrandC	2021-09-03
478	BrandA Air Freshener	8	BrandA	94.13	65.55	92	9.32	42x41x7	High-quality air freshener from BrandA	2021-07-05
479	Elite Car Mat	8	Elite	142.79	81.40	86	9.88	28x9x7	High-quality car mat from Elite	2019-10-04
480	Basic Phone Mount	8	Basic	138.76	60.12	171	2.05	45x25x11	High-quality phone mount from Basic	2019-06-20
481	Deluxe Chocolate	9	Deluxe	49.26	27.02	159	8.92	31x15x13	High-quality chocolate from Deluxe	2020-06-01
482	Standard Sketchbook	10	Standard	26.78	14.89	6	4.95	15x8x22	High-quality sketchbook from Standard	2020-05-04
483	BrandE Phone Mount	8	BrandE	75.61	40.06	10	2.80	47x34x23	High-quality phone mount from BrandE	2019-06-14
484	Standard Chocolate	9	Standard	6.41	4.24	159	0.21	41x6x11	High-quality chocolate from Standard	2021-02-18
485	Elite Tea Set	9	Elite	22.10	9.08	172	2.78	29x26x13	High-quality tea set from Elite	2021-11-15
486	Basic Glue Set	10	Basic	55.39	24.36	88	7.22	40x17x17	High-quality glue set from Basic	2020-07-30
487	BrandB Phone Mount	8	BrandB	138.30	93.44	21	8.07	25x37x5	High-quality phone mount from BrandB	2019-02-17
488	BrandB Air Freshener	8	BrandB	47.80	21.66	16	1.62	20x10x4	High-quality air freshener from BrandB	2019-01-20
489	Premium Face Cream	6	Premium	88.05	51.53	39	5.87	34x45x12	High-quality face cream from Premium	2019-08-05
490	BrandB Bedding Set	3	BrandB	46.96	20.74	190	9.27	16x10x24	High-quality bedding set from BrandB	2019-07-07
491	Basic Board Game	7	Basic	65.83	30.94	12	7.20	29x25x22	High-quality board game from Basic	2021-12-20
492	Elite Tablet	1	Elite	1644.22	1007.04	126	6.09	16x35x11	High-quality tablet from Elite	2019-05-06
493	BrandC Perfume	6	BrandC	54.70	23.19	50	2.71	39x41x8	High-quality perfume from BrandC	2019-09-11
494	BrandD Face Cream	6	BrandD	25.21	12.51	58	1.71	45x42x11	High-quality face cream from BrandD	2021-04-24
495	BrandE Makeup Kit	6	BrandE	28.08	13.35	88	7.38	38x5x22	High-quality makeup kit from BrandE	2020-05-30
496	BrandC Chocolate	9	BrandC	7.91	3.31	88	9.04	8x44x15	High-quality chocolate from BrandC	2019-06-13
497	Elite Lamp	3	Elite	25.76	16.06	22	3.25	28x49x23	High-quality lamp from Elite	2019-05-15
498	BrandE Water Bottle	4	BrandE	224.97	111.52	91	7.45	35x28x17	High-quality water bottle from BrandE	2020-09-06
499	Premium Biography	5	Premium	31.84	19.85	58	5.91	7x49x13	High-quality biography from Premium	2021-04-19
500	Elite Plant Pot	3	Elite	175.70	112.25	103	4.69	34x33x6	High-quality plant pot from Elite	2019-10-18
\.


--
-- Data for Name: product_suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_suppliers (product_id, supplier_id, supply_price, lead_time_days, min_order_quantity) FROM stdin;
1	2	22.13	30	64
2	4	922.60	17	45
3	3	14.02	22	11
4	1	73.39	30	62
4	4	92.42	22	99
5	1	11.90	20	23
6	1	9.49	29	80
6	4	13.23	13	64
7	5	818.73	13	82
7	3	1012.21	5	61
7	4	708.15	26	52
8	2	22.32	9	98
8	4	32.30	13	53
8	5	26.31	24	81
9	5	277.36	25	79
10	5	23.80	6	72
10	2	20.90	24	45
11	3	26.59	26	89
12	4	16.50	24	55
12	5	20.09	25	66
12	3	23.80	10	50
13	1	95.33	25	78
14	2	80.30	29	59
14	3	85.23	24	54
15	3	16.48	17	46
16	1	11.53	25	61
16	5	11.45	14	96
17	2	14.48	21	50
17	4	15.74	5	27
17	3	18.08	26	59
18	3	97.98	19	59
19	1	13.68	17	59
20	2	188.92	22	61
21	5	18.23	11	49
21	3	23.58	9	44
22	2	73.74	24	90
22	3	76.87	26	62
23	5	20.54	8	60
23	3	18.36	10	73
24	3	12.63	26	47
24	2	10.37	7	56
24	1	14.31	20	26
25	3	23.84	9	51
26	1	86.26	11	53
27	4	17.55	28	59
28	2	36.83	15	76
29	4	4.99	17	18
29	1	5.30	8	56
29	3	6.38	6	53
30	3	34.89	16	39
31	3	6.47	7	34
31	5	7.99	21	44
32	3	20.84	5	52
32	1	18.65	24	39
33	5	25.51	12	29
33	3	20.37	27	25
34	2	25.69	9	84
35	4	26.55	28	38
35	3	24.81	30	45
36	5	13.38	7	45
36	2	14.51	30	78
36	1	14.83	20	75
37	4	68.44	30	35
38	5	23.90	19	71
38	3	21.79	22	29
38	2	22.61	14	15
39	4	15.81	8	64
40	3	14.87	7	37
40	2	17.26	23	97
40	4	20.09	21	20
41	2	222.83	5	15
41	5	296.26	23	59
41	3	227.22	14	30
42	1	46.74	19	76
42	3	55.29	29	65
43	3	38.75	16	74
44	5	949.95	14	54
44	1	1110.82	18	37
45	3	18.62	21	78
45	5	17.36	28	73
45	4	22.86	9	50
46	2	39.98	10	26
46	4	45.97	11	51
47	2	46.42	19	77
48	5	34.79	10	80
48	4	27.55	6	41
48	3	30.63	16	39
49	3	17.42	10	75
49	1	18.86	10	10
49	4	19.02	19	60
50	4	28.66	17	100
50	5	24.06	9	79
51	2	31.03	14	51
51	5	28.28	21	67
51	3	21.72	26	26
52	4	876.80	15	36
53	5	16.52	11	59
54	4	83.11	11	23
54	2	83.51	29	100
54	5	75.23	9	22
55	4	64.41	20	47
55	1	65.79	7	42
55	2	67.69	13	38
56	1	44.53	8	11
57	5	16.81	14	55
57	1	17.30	30	86
58	4	19.44	16	100
58	5	16.32	13	36
59	1	124.64	30	88
60	4	765.96	8	97
60	2	1041.63	12	39
61	5	13.57	30	84
62	5	22.62	18	88
62	2	25.78	7	13
63	1	28.90	30	91
64	4	16.86	14	86
64	1	19.68	16	79
65	1	33.55	22	62
65	5	37.41	28	77
65	3	35.93	7	70
66	5	58.35	27	26
66	4	51.36	23	85
66	2	52.28	24	42
67	1	31.36	12	75
68	4	66.58	14	84
69	2	141.91	11	37
70	4	113.02	10	39
71	1	21.17	22	15
71	5	26.72	19	11
71	3	20.88	11	97
72	2	3.15	28	77
73	1	262.58	22	69
74	3	130.69	28	73
74	1	119.85	19	12
75	4	197.26	18	55
76	2	3.94	26	67
76	4	4.65	27	27
77	4	28.96	22	29
78	1	593.86	10	97
79	1	45.15	8	84
79	4	50.31	11	74
79	3	42.95	22	31
80	4	23.23	13	66
80	1	19.39	13	100
81	2	22.77	11	11
82	2	21.18	16	92
82	4	20.12	18	82
83	5	25.14	6	61
84	3	3.55	17	14
84	5	3.86	22	55
85	4	247.90	11	42
86	5	38.19	11	53
86	4	33.04	28	45
86	3	33.79	22	21
87	5	98.66	26	49
88	4	14.13	9	43
88	1	13.11	5	59
89	3	67.41	22	97
89	2	62.98	29	100
89	1	60.89	22	100
90	5	88.30	30	58
90	3	67.70	21	22
90	1	62.61	18	53
91	2	32.18	16	80
91	4	38.44	27	57
91	3	35.24	13	31
92	4	108.15	20	83
93	2	29.49	11	62
94	5	66.73	17	53
95	4	44.13	20	61
95	3	43.50	21	73
95	1	43.77	16	82
96	2	314.33	22	64
97	2	486.04	29	49
98	4	8.29	24	19
99	2	27.46	29	81
99	5	23.68	22	93
99	4	29.78	14	32
100	5	61.14	9	34
100	3	48.28	24	11
101	3	27.32	17	24
101	4	22.96	5	14
101	2	20.35	7	38
102	1	34.44	14	77
102	5	48.52	14	46
102	4	35.70	11	62
103	4	79.53	10	19
103	2	71.96	23	87
104	5	20.65	28	77
105	4	21.01	17	42
105	3	28.30	27	87
106	5	46.45	25	94
107	3	6.81	7	53
107	5	7.89	20	38
107	4	6.70	5	58
108	1	24.17	23	58
108	3	22.77	12	59
109	4	25.82	6	84
109	2	31.67	8	15
110	1	38.09	19	33
111	2	19.00	26	32
111	3	16.95	21	59
112	4	8.17	10	44
112	5	9.27	24	70
112	1	6.70	29	92
113	2	21.19	26	66
113	4	23.49	10	72
114	2	81.24	8	97
114	4	94.54	26	89
115	1	15.70	19	96
116	1	555.15	30	33
116	2	687.18	18	10
117	5	34.31	15	62
117	1	35.51	27	78
117	2	40.59	26	80
118	5	209.13	6	77
118	4	177.90	24	70
119	2	141.97	21	58
120	1	29.91	23	47
120	5	29.57	27	34
121	4	8.23	20	16
121	5	7.85	11	29
122	2	72.91	20	94
122	3	73.79	30	54
123	2	12.42	30	43
123	4	14.19	21	66
123	1	13.78	17	59
124	1	83.00	23	91
124	5	83.21	19	20
124	3	86.29	25	40
125	3	487.09	13	50
125	1	451.94	27	91
126	1	23.15	29	56
127	3	53.18	10	86
128	4	14.34	28	44
128	5	19.15	28	77
128	3	18.66	15	39
129	4	3.36	15	13
129	3	2.86	30	54
129	1	2.92	6	71
130	5	20.60	12	78
130	3	22.74	28	78
130	1	24.34	17	84
131	3	8.54	24	25
132	3	26.57	17	48
133	4	9.47	27	45
133	1	10.55	5	70
133	3	8.33	11	17
134	1	6.91	5	59
134	2	7.35	30	100
135	1	22.40	15	23
135	5	16.15	28	28
136	2	41.30	12	78
136	1	42.89	23	65
137	2	31.57	14	60
138	3	37.15	18	44
138	4	43.83	30	60
139	2	25.35	12	37
139	3	26.32	9	72
140	4	15.64	23	89
141	2	13.16	15	86
141	4	12.48	6	100
142	5	36.97	7	16
142	1	46.57	5	32
142	4	42.55	18	15
143	4	283.85	8	97
143	3	290.90	15	24
144	3	59.71	21	43
144	4	67.32	19	70
145	4	56.08	11	76
145	2	46.76	12	12
145	5	51.68	13	42
146	5	23.47	19	93
147	1	142.15	20	77
147	4	162.22	15	12
148	5	1077.18	29	92
148	1	1084.27	18	14
149	4	23.33	5	61
150	1	38.84	18	70
150	3	32.40	7	91
150	2	44.75	27	79
151	5	24.57	10	86
151	3	18.23	28	61
151	1	24.41	11	82
152	2	32.61	20	69
153	5	10.50	25	85
153	3	11.19	14	96
154	2	10.34	11	41
155	3	11.57	21	67
155	4	9.64	27	74
156	5	286.13	7	15
157	3	163.85	17	92
157	1	138.17	5	64
157	2	132.56	20	14
158	1	129.45	29	78
158	2	137.29	14	66
159	4	10.53	21	35
159	2	10.82	12	42
159	1	9.71	29	54
160	3	27.17	15	94
160	4	28.05	26	10
161	4	138.33	24	26
161	5	119.18	21	17
162	1	17.05	8	67
162	5	21.67	21	41
162	3	23.69	30	59
163	5	249.45	7	64
163	1	276.86	21	51
164	1	87.12	13	43
164	4	99.40	6	80
164	2	85.06	23	50
165	1	5.94	5	35
165	3	6.88	25	14
165	5	5.65	16	65
166	5	29.14	15	29
167	2	36.17	29	16
167	1	29.33	16	30
168	5	53.63	25	14
169	1	91.23	24	94
170	3	3.56	11	38
170	2	2.99	24	31
170	4	4.31	16	61
171	1	62.61	5	41
171	3	56.10	24	92
172	1	251.12	16	45
172	5	332.68	6	33
172	4	318.16	11	30
173	1	53.68	25	87
174	5	31.65	22	51
174	3	28.64	14	26
175	4	991.60	22	27
176	5	37.74	27	59
176	2	54.29	9	17
176	4	42.59	8	98
177	1	35.95	6	54
178	5	266.32	27	67
178	4	233.36	21	55
179	1	145.22	20	86
179	4	128.92	11	85
180	4	346.38	9	44
180	1	333.40	15	91
180	5	315.61	12	77
181	4	37.29	7	78
182	4	10.40	26	34
183	1	13.40	18	45
183	5	13.31	23	55
183	3	13.39	8	74
184	1	30.69	16	56
184	4	37.18	26	63
185	5	42.88	26	20
185	4	35.99	15	85
185	1	31.44	6	75
186	5	16.11	28	89
187	2	85.68	13	74
187	5	73.89	8	96
188	3	30.80	27	47
188	4	38.40	14	84
189	1	11.12	27	51
189	5	14.39	21	83
189	3	11.23	13	46
190	1	21.63	6	40
190	4	23.27	5	66
191	3	23.11	16	54
191	5	24.79	24	99
192	2	25.37	15	75
193	1	20.96	6	74
193	2	27.81	9	94
193	3	21.71	19	52
194	1	24.33	19	90
194	3	24.83	20	44
195	5	81.27	10	57
195	3	72.10	27	25
196	2	22.67	19	28
197	2	86.50	30	41
197	4	78.47	20	88
198	4	49.23	6	100
199	4	22.41	16	86
199	3	23.26	22	49
200	3	30.79	18	69
200	5	33.18	28	23
200	2	27.91	9	35
201	5	13.66	30	63
201	4	14.17	20	25
201	3	11.48	16	85
202	2	12.23	5	31
203	3	1245.28	13	89
203	1	1400.65	5	58
204	1	26.99	9	29
204	2	31.65	26	71
205	1	8.31	30	18
205	2	10.36	16	24
206	3	32.21	13	23
206	1	30.61	25	16
206	5	25.21	14	56
207	2	32.41	30	47
207	4	29.84	24	53
208	4	65.71	30	33
208	1	66.49	18	81
209	3	30.02	16	94
209	5	33.67	29	63
209	2	32.73	6	81
210	2	61.01	5	48
210	1	77.39	28	84
210	3	54.17	21	63
211	1	42.61	11	20
211	4	51.39	16	52
211	3	55.69	22	51
212	5	17.69	27	84
213	3	47.54	12	60
213	5	47.04	6	88
214	3	10.98	7	95
214	2	9.93	6	77
214	4	9.54	21	74
215	4	8.06	26	13
215	5	10.21	6	57
215	2	8.13	29	80
216	4	168.85	7	23
217	2	53.64	10	15
217	3	40.81	14	16
218	3	22.06	11	97
219	1	23.43	27	37
219	3	25.21	18	41
219	4	21.43	6	33
220	5	12.23	12	79
221	4	32.34	21	31
221	2	36.11	7	81
221	5	31.07	11	77
222	3	676.57	19	76
222	5	622.05	29	62
223	5	18.01	12	44
223	3	21.33	30	27
224	5	16.83	12	48
224	3	21.05	7	33
224	4	19.22	28	61
225	3	39.20	13	29
225	4	46.66	18	49
226	2	82.11	13	69
226	1	76.34	11	97
227	4	1199.14	24	65
228	3	116.28	24	93
228	2	120.83	7	97
229	5	23.08	19	48
229	1	20.57	23	31
229	3	20.92	21	67
230	2	6.67	13	59
230	5	9.00	11	82
230	3	8.36	15	41
231	2	822.02	15	65
232	5	17.17	9	35
232	1	19.44	5	29
233	5	593.24	30	84
233	2	688.04	22	82
233	4	699.56	13	85
234	1	34.72	26	76
234	3	29.98	8	94
235	2	16.84	9	83
235	1	21.46	9	41
235	3	20.56	25	90
236	2	438.59	17	81
236	1	511.32	10	16
236	3	457.10	11	39
237	1	13.30	29	44
237	2	10.09	17	96
238	1	28.07	21	62
238	5	33.88	14	100
238	3	39.20	21	51
239	1	18.52	6	43
239	2	20.64	15	84
240	3	37.43	15	96
240	5	38.67	26	61
241	4	73.69	30	57
241	1	73.85	19	74
241	5	62.34	26	10
242	2	506.95	15	18
243	5	22.09	17	91
243	1	28.48	25	64
243	4	23.43	13	87
244	5	11.64	18	38
244	3	11.38	6	57
245	2	26.71	18	55
245	5	27.80	13	42
246	5	448.11	14	29
247	4	11.47	21	65
248	2	144.44	27	22
248	5	183.95	9	16
249	5	7.84	25	83
250	1	24.29	21	54
251	2	131.21	5	53
251	4	107.36	25	22
251	1	99.63	15	80
252	3	96.06	7	90
252	2	106.07	11	33
253	2	38.93	21	70
254	4	7.87	11	33
254	2	9.32	26	85
255	1	63.94	29	45
255	2	50.10	11	80
255	3	49.33	17	15
256	4	128.89	24	19
256	3	125.95	20	15
256	2	93.80	9	26
257	3	6.79	13	54
257	5	8.02	25	47
257	2	8.41	29	62
258	3	24.20	5	52
258	1	26.32	20	12
259	2	27.20	24	89
259	1	30.31	8	47
259	5	27.64	21	34
260	3	25.48	5	90
261	2	39.21	28	56
261	5	33.59	6	64
262	2	18.64	29	29
263	3	684.61	22	85
264	1	30.32	30	35
264	4	37.42	8	46
265	2	104.51	9	15
265	5	106.57	7	88
266	3	155.08	12	21
267	3	60.83	18	54
268	3	344.11	10	38
268	5	265.23	7	62
269	3	15.20	5	63
269	4	17.95	13	68
270	2	7.78	9	63
270	3	8.20	9	16
271	1	78.57	25	70
271	2	96.28	9	68
271	3	95.46	8	10
272	3	89.51	16	97
273	4	758.80	6	64
273	1	767.48	15	69
274	2	43.03	10	20
275	4	24.30	17	68
275	2	27.64	24	35
275	1	27.07	12	56
276	3	28.75	12	99
277	3	643.43	16	44
278	1	24.07	23	99
278	4	24.47	7	63
278	5	24.59	6	66
279	2	6.84	9	23
279	3	8.06	12	14
279	1	6.40	10	60
280	1	91.19	28	77
280	2	112.09	25	97
280	3	93.84	8	83
281	2	4.59	6	48
282	1	187.40	25	18
283	3	17.20	22	74
283	4	12.90	15	22
284	3	11.60	11	46
285	2	17.55	28	41
285	3	14.07	18	35
286	2	9.41	20	100
287	4	6.74	11	69
287	3	6.74	6	10
288	4	446.26	14	25
288	2	380.73	13	39
288	1	387.89	19	14
289	5	865.36	8	69
289	2	657.41	28	44
289	4	798.04	8	33
290	5	172.57	24	31
290	1	162.87	26	38
291	5	43.34	25	82
292	5	290.59	19	92
292	2	334.10	22	57
292	3	280.01	8	68
293	4	54.84	16	14
293	3	49.57	8	73
294	4	352.47	27	82
294	5	352.82	29	99
294	2	326.06	6	97
295	3	20.78	23	20
295	1	21.19	24	80
296	3	10.42	25	19
297	4	6.98	17	46
297	2	7.13	5	76
298	5	96.42	13	48
298	4	72.61	16	100
298	1	96.56	25	47
299	2	6.97	28	52
299	1	6.33	16	69
300	4	378.75	17	57
301	2	282.80	17	33
302	2	56.59	25	51
303	5	47.53	28	33
303	2	54.24	23	94
304	5	584.67	29	26
305	4	42.25	30	18
305	1	33.72	18	75
305	3	45.47	5	25
306	4	105.70	30	38
307	1	22.36	23	93
307	4	16.29	13	83
308	4	94.34	7	93
309	2	9.86	11	27
309	1	12.03	17	95
310	1	27.11	16	95
311	1	357.13	19	69
311	3	374.78	20	16
311	2	276.73	26	85
312	1	11.79	17	74
312	2	11.76	8	23
313	3	74.89	25	93
313	4	88.90	24	61
313	2	73.93	5	72
314	3	78.13	15	86
314	5	83.79	27	82
315	1	774.08	23	31
315	2	787.73	16	25
315	4	1088.86	16	61
316	1	14.60	28	82
317	3	22.58	30	46
317	1	23.16	30	95
317	2	22.13	16	15
318	4	30.86	8	64
319	1	911.01	30	77
319	3	801.25	20	34
320	3	36.35	22	26
320	2	39.06	20	73
321	1	18.70	14	73
321	2	18.27	12	57
322	1	88.41	26	96
322	3	88.91	25	80
322	2	69.64	22	40
323	3	764.77	23	85
323	2	791.38	8	32
324	5	32.55	6	20
324	3	39.64	6	99
325	5	16.55	18	91
325	3	14.76	9	58
326	4	41.44	7	82
326	1	47.49	23	83
327	2	57.00	12	96
328	5	20.98	7	41
329	4	24.67	11	15
329	2	23.11	17	77
329	1	21.23	30	71
330	1	26.58	15	52
330	4	25.93	27	31
331	5	30.75	26	45
332	1	11.90	13	71
332	3	10.08	8	33
332	5	10.30	17	85
333	4	167.81	14	57
333	5	137.55	12	83
333	2	192.72	30	26
334	4	10.16	7	66
335	3	21.46	18	52
335	2	25.35	5	41
335	5	22.40	13	97
336	2	10.13	19	57
336	5	10.22	25	92
336	4	7.41	15	71
337	2	34.93	28	71
337	4	36.52	23	20
337	5	32.29	11	19
338	1	109.05	11	48
339	3	100.57	16	41
339	2	108.54	27	19
339	4	89.71	15	73
340	3	19.59	23	28
340	2	27.97	19	30
341	2	33.90	21	14
342	1	43.21	17	85
342	2	41.89	16	67
342	3	40.99	18	33
343	2	17.11	11	83
343	4	15.93	22	58
343	1	21.92	30	68
344	4	20.49	22	50
345	4	14.12	23	44
345	3	15.60	23	92
346	2	42.53	8	17
346	5	52.28	7	12
347	5	14.84	20	85
347	3	17.11	24	34
348	4	3.27	23	29
348	5	3.04	5	23
349	3	34.91	21	79
349	5	35.87	24	63
349	1	32.56	24	92
350	1	15.00	9	90
351	3	21.38	19	51
351	1	21.04	14	74
351	2	27.49	7	22
352	5	11.48	20	14
353	5	55.68	16	60
354	5	726.04	18	46
355	4	22.40	10	48
355	2	29.35	15	51
355	1	23.67	10	10
356	4	208.35	12	53
357	4	80.13	17	89
357	2	96.46	10	28
357	5	94.84	23	46
358	1	28.55	7	66
359	3	32.52	12	45
360	5	26.14	6	89
360	1	32.09	13	70
361	3	29.92	26	16
361	5	35.28	30	41
361	4	42.71	21	19
362	1	36.64	29	55
363	5	13.51	15	27
364	4	81.45	29	20
365	1	8.37	10	31
365	5	8.81	8	72
365	2	8.99	7	59
366	1	242.63	24	53
366	4	289.52	26	20
366	5	300.53	15	44
367	5	42.68	26	35
368	3	116.61	28	11
368	1	104.34	15	86
369	4	24.92	18	99
370	4	200.67	19	92
370	3	205.45	26	57
371	3	67.40	10	82
371	1	56.12	15	32
371	5	74.60	14	85
372	3	113.80	23	24
373	5	10.41	25	46
373	4	8.37	23	87
373	2	8.80	8	47
374	5	24.40	29	20
375	1	45.23	16	98
376	5	22.16	23	84
376	2	20.24	8	46
376	4	26.39	18	51
377	4	20.35	8	30
378	4	100.50	19	48
378	2	143.04	9	16
378	5	129.64	21	92
379	2	26.64	18	89
379	3	29.38	21	76
380	2	23.38	24	48
380	5	24.75	27	79
381	4	13.41	30	86
382	1	59.76	17	68
383	4	14.30	24	23
383	1	17.90	14	44
383	5	16.55	23	25
384	4	2.92	9	24
384	5	3.41	5	22
385	1	7.79	21	50
386	5	80.88	16	61
387	5	20.44	12	47
387	2	16.12	13	11
387	1	20.14	9	42
388	4	6.13	17	71
388	3	7.99	25	41
389	3	30.64	9	50
390	2	23.90	29	42
391	2	97.22	18	66
392	3	23.67	20	59
393	2	9.79	9	89
394	4	63.97	25	94
394	5	77.44	29	78
394	2	72.57	27	64
395	5	19.36	20	48
395	2	16.59	22	99
395	4	23.25	20	72
396	1	13.00	19	93
397	5	50.87	14	98
397	3	47.91	12	37
398	3	111.94	30	57
398	2	156.96	5	98
398	1	146.99	30	86
399	5	51.53	9	46
399	1	50.37	30	27
399	2	42.20	10	65
400	3	29.91	7	65
400	1	35.86	26	78
401	1	309.64	23	32
401	3	288.14	18	100
401	5	314.56	23	80
402	2	39.44	12	81
402	1	38.83	30	80
403	5	110.77	21	83
404	3	11.63	25	34
405	5	741.68	29	68
405	3	719.86	18	76
405	4	570.78	28	15
406	1	31.06	12	55
406	4	41.36	19	93
407	1	89.74	24	87
408	4	14.76	7	20
408	2	15.60	26	84
409	2	27.66	7	93
409	4	27.71	12	49
409	3	34.24	28	17
410	3	94.47	20	93
410	1	94.31	20	57
411	5	24.69	22	48
412	2	17.82	23	88
412	1	20.39	17	35
412	4	21.72	19	58
413	3	41.18	18	26
413	2	47.19	12	79
413	4	50.01	30	51
414	3	17.22	24	42
414	1	18.63	28	55
414	2	16.63	10	30
415	3	28.83	15	22
415	5	24.52	11	100
416	5	13.21	24	18
417	4	24.63	23	62
417	2	23.71	27	55
418	3	73.23	27	22
419	2	666.48	20	49
420	5	66.08	12	64
420	3	69.90	29	55
421	5	22.89	15	13
421	4	19.78	20	40
421	1	21.93	9	28
422	1	22.34	18	99
423	5	57.35	30	69
423	1	57.86	6	100
424	3	634.56	26	32
425	3	36.57	22	24
426	4	17.25	19	18
427	1	122.56	25	82
427	4	119.70	16	49
427	2	116.42	28	97
428	1	93.07	9	25
428	5	83.06	10	66
428	2	110.28	23	64
429	5	81.75	20	37
430	2	53.04	24	36
431	3	129.80	8	12
432	4	11.62	10	40
432	3	9.53	18	52
432	1	12.91	23	43
433	2	7.93	5	40
433	3	7.88	22	22
433	4	7.03	5	41
434	1	28.27	22	57
434	4	31.76	26	14
434	5	34.13	9	18
435	3	5.94	7	100
435	5	6.22	22	21
435	1	6.76	9	76
436	1	36.31	7	64
436	3	32.18	20	78
437	2	7.40	25	34
437	1	6.11	7	46
438	4	3.93	20	11
438	3	3.33	9	12
438	1	3.44	25	49
439	2	1240.50	11	36
439	3	1146.66	9	23
439	5	1015.73	16	18
440	1	81.63	14	60
441	4	37.15	25	47
442	1	9.54	12	53
443	1	6.98	28	68
443	4	7.69	9	16
444	3	113.23	9	97
444	4	122.79	26	39
444	2	118.93	16	64
445	5	75.58	26	20
445	2	76.35	30	19
445	1	83.14	30	86
446	2	179.64	22	73
446	4	165.86	19	72
446	5	148.04	28	66
447	5	12.69	11	74
447	4	10.98	26	19
448	4	15.79	24	78
449	5	25.12	23	38
450	4	21.34	25	30
450	1	17.74	21	70
450	5	19.33	13	56
451	2	20.93	15	53
452	1	7.92	21	20
452	3	8.38	30	68
452	5	8.96	12	45
453	2	18.13	26	13
454	4	8.87	23	94
454	5	7.20	14	96
455	3	23.38	25	23
456	5	27.29	30	50
456	1	23.81	24	34
457	4	3.97	22	91
457	2	4.38	26	60
457	3	5.13	6	56
458	3	23.88	24	34
458	5	23.38	23	33
459	2	21.02	23	50
459	5	22.74	18	39
460	1	26.08	18	68
460	3	22.64	6	69
460	4	33.40	7	55
461	4	14.76	26	45
462	2	100.83	16	55
463	4	18.16	28	53
463	3	18.89	26	50
463	5	15.54	29	14
464	5	55.91	21	100
464	2	52.55	18	68
465	2	86.82	21	77
465	5	81.65	30	85
466	2	23.33	28	27
467	1	55.81	6	14
468	5	316.14	26	95
468	4	228.51	13	12
469	5	11.30	29	18
469	3	14.61	30	32
469	1	11.23	8	98
470	2	10.01	20	78
470	5	11.39	13	22
471	2	47.56	14	80
472	1	47.44	7	76
472	4	47.63	13	29
473	2	58.14	14	48
473	4	77.22	20	17
474	5	38.85	22	63
474	4	42.48	8	12
474	1	51.25	21	69
475	5	118.25	12	41
475	3	91.79	19	16
476	1	872.30	14	38
476	5	1063.37	5	69
476	2	856.66	14	58
477	5	76.19	21	82
477	4	94.08	20	94
477	1	90.94	24	96
478	1	72.23	25	17
479	2	91.11	12	75
479	4	97.11	30	69
480	2	63.11	28	74
480	4	70.54	23	28
481	4	25.98	23	30
481	3	24.68	5	46
482	5	12.63	26	34
482	2	12.26	21	64
482	1	16.49	14	41
483	5	36.01	13	55
484	3	4.03	16	22
484	4	4.26	8	31
484	2	4.18	24	20
485	3	7.47	12	44
485	1	8.14	29	68
486	2	21.42	9	55
486	5	28.14	30	97
487	4	85.82	30	98
487	1	87.11	17	27
488	5	18.12	25	95
488	2	18.67	8	19
489	1	46.54	25	18
489	3	43.56	5	91
490	4	16.82	5	72
491	3	27.82	17	93
492	4	887.77	30	14
492	3	950.84	9	32
492	2	836.00	26	49
493	3	20.07	18	66
493	5	24.62	12	56
494	5	12.81	26	27
495	2	14.82	8	25
495	5	15.13	8	97
496	5	3.53	24	83
496	3	3.60	14	44
497	5	13.76	30	99
497	1	13.40	13	52
497	3	14.87	19	50
498	5	132.54	17	77
498	4	94.89	25	89
498	3	105.66	22	23
499	4	22.64	23	94
499	2	18.35	6	33
500	3	95.80	16	81
\.


--
-- Data for Name: promotions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotions (promotion_id, promotion_name, description, discount_percentage, start_date, end_date, is_active) FROM stdin;
1	Summer Sale 2024	20% off on all summer items	20.00	2024-06-01	2024-08-31	t
2	Black Friday Deal	50% off electronics	50.00	2023-11-24	2023-11-26	f
3	New Year Special	15% off everything	15.00	2024-01-01	2024-01-15	f
4	Spring Cleaning	30% off home & garden	30.00	2024-03-01	2024-04-30	f
5	Back to School	25% off books and supplies	25.00	2024-08-01	2024-09-15	t
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.review (review_id, product_id, order_id, rating, review_text, review_date, helpful_votes) FROM stdin;
1	212	1999	4	Very good	1970-01-01	39
2	445	1075	3	Does the job	1970-01-01	11
4	191	1427	5	Excellent product!	1970-01-01	43
5	440	1367	5	Excellent product!	1970-01-01	9
6	1	2201	5	Amazing value	1970-01-01	1
7	57	291	5	Excellent product!	1970-01-01	35
8	349	364	1	Waste of money	1970-01-01	0
9	436	864	4	Good quality	1970-01-01	19
11	335	2144	4	Nice product	1970-01-01	2
13	197	606	5	Excellent product!	1970-01-01	5
15	329	2265	4	Nice product	1970-01-01	21
18	360	1623	4	Good quality	1970-01-01	2
19	207	1871	2	Below expectations	1970-01-01	40
20	488	2074	5	Highly recommend	1970-01-01	8
21	43	1576	3	Decent product	1970-01-01	33
22	487	1166	4	Nice product	1970-01-01	46
23	489	600	5	Perfect quality	1970-01-01	44
24	440	2300	5	Amazing value	1970-01-01	15
25	173	1442	2	Below expectations	1970-01-01	3
27	52	2355	5	Excellent product!	1970-01-01	5
28	452	975	5	Love it!	1970-01-01	24
29	414	440	1	Very poor quality	1970-01-01	37
30	41	404	3	Could be better	1970-01-01	5
32	350	2119	5	Amazing value	1970-01-01	13
33	376	395	4	Satisfied with purchase	1970-01-01	7
35	2	2445	4	Good quality	1970-01-01	15
36	412	380	4	Nice product	1970-01-01	19
37	316	2011	2	Not great	1970-01-01	29
38	447	480	5	Excellent product!	1970-01-01	14
39	85	1355	3	Average quality	1970-01-01	15
40	49	2245	4	Very good	1970-01-01	26
42	296	14	3	Average quality	1970-01-01	42
44	308	1098	5	Highly recommend	1970-01-01	35
45	120	1140	3	Decent product	1970-01-01	33
46	43	537	4	Nice product	1970-01-01	49
48	238	368	4	Good quality	1970-01-01	44
49	217	1644	4	Nice product	1970-01-01	10
54	130	741	2	Poor quality	1970-01-01	15
55	424	1609	4	Very good	1970-01-01	32
56	345	2459	4	Would buy again	1970-01-01	46
57	460	2422	3	Could be better	1970-01-01	26
58	7	2070	4	Nice product	1970-01-01	39
62	165	668	3	Does the job	1970-01-01	17
65	40	1698	2	Poor quality	1970-01-01	40
67	257	2286	3	Could be better	1970-01-01	22
68	322	1839	4	Good quality	1970-01-01	40
69	367	586	3	Decent product	1970-01-01	39
70	124	1893	4	Nice product	1970-01-01	29
71	452	302	5	Excellent product!	1970-01-01	4
72	190	1885	5	Perfect quality	1970-01-01	24
73	456	1112	4	Satisfied with purchase	1970-01-01	28
75	65	14	4	Nice product	1970-01-01	31
77	84	906	4	Good quality	1970-01-01	20
78	494	2433	2	Disappointing	1970-01-01	41
79	373	1675	4	Very good	1970-01-01	25
80	311	595	4	Nice product	1970-01-01	15
81	319	100	5	Excellent product!	1970-01-01	3
82	171	2388	4	Satisfied with purchase	1970-01-01	47
84	122	1749	4	Satisfied with purchase	1970-01-01	2
86	335	69	4	Satisfied with purchase	1970-01-01	17
87	485	2195	2	Issues with product	1970-01-01	48
88	401	1640	4	Satisfied with purchase	1970-01-01	49
89	287	2452	4	Satisfied with purchase	1970-01-01	24
90	381	1178	4	Very good	1970-01-01	40
91	130	1309	4	Good quality	1970-01-01	41
92	145	1550	4	Very good	1970-01-01	40
94	359	2006	5	Love it!	1970-01-01	19
95	184	1647	4	Very good	1970-01-01	21
96	38	409	5	Highly recommend	1970-01-01	15
97	355	742	4	Nice product	1970-01-01	25
98	328	970	5	Highly recommend	1970-01-01	22
99	387	226	3	Does the job	1970-01-01	1
100	417	1640	3	Decent product	1970-01-01	25
103	412	112	2	Poor quality	1970-01-01	40
104	149	917	3	Average quality	1970-01-01	44
105	457	44	5	Perfect quality	1970-01-01	36
110	401	2282	5	Love it!	1970-01-01	32
112	137	44	5	Perfect quality	1970-01-01	46
113	207	967	5	Love it!	1970-01-01	15
115	84	1279	5	Highly recommend	1970-01-01	21
116	17	636	5	Amazing value	1970-01-01	5
117	326	2053	5	Highly recommend	1970-01-01	26
118	54	338	3	Decent product	1970-01-01	25
119	71	434	4	Nice product	1970-01-01	18
120	450	924	5	Excellent product!	1970-01-01	35
121	180	872	4	Very good	1970-01-01	30
122	395	747	5	Excellent product!	1970-01-01	50
125	244	1829	4	Would buy again	1970-01-01	23
127	20	1333	4	Good quality	1970-01-01	50
128	340	1941	3	Average quality	1970-01-01	13
129	356	162	4	Would buy again	1970-01-01	17
130	111	1984	4	Satisfied with purchase	1970-01-01	48
133	70	420	4	Would buy again	1970-01-01	24
134	333	1727	5	Amazing value	1970-01-01	2
135	325	1387	4	Good quality	1970-01-01	19
137	448	80	5	Perfect quality	1970-01-01	49
138	421	289	4	Would buy again	1970-01-01	31
139	43	1461	2	Below expectations	1970-01-01	36
140	490	1761	3	Average quality	1970-01-01	0
141	308	1790	5	Perfect quality	1970-01-01	39
145	120	2017	5	Love it!	1970-01-01	7
148	128	522	3	Does the job	1970-01-01	29
149	350	463	4	Very good	1970-01-01	3
150	34	734	2	Disappointing	1970-01-01	16
152	276	241	4	Satisfied with purchase	1970-01-01	18
154	63	2023	4	Good quality	1970-01-01	42
155	85	1355	2	Disappointing	1970-01-01	34
156	62	1689	4	Satisfied with purchase	1970-01-01	23
157	211	456	4	Nice product	1970-01-01	25
159	190	1179	4	Would buy again	1970-01-01	6
162	46	91	3	Average quality	1970-01-01	9
163	445	1075	4	Good quality	1970-01-01	35
164	459	265	1	Completely unsatisfied	1970-01-01	22
165	222	220	4	Nice product	1970-01-01	31
166	246	841	4	Nice product	1970-01-01	41
168	119	1184	4	Very good	1970-01-01	50
170	76	1479	5	Amazing value	1970-01-01	16
171	187	1274	4	Very good	1970-01-01	12
172	387	1032	4	Satisfied with purchase	1970-01-01	47
173	245	679	5	Perfect quality	1970-01-01	0
174	299	692	3	Could be better	1970-01-01	16
175	63	2023	4	Nice product	1970-01-01	40
178	97	1431	4	Would buy again	1970-01-01	44
179	273	679	3	Does the job	1970-01-01	35
180	389	1744	3	Does the job	1970-01-01	21
181	25	1775	5	Amazing value	1970-01-01	13
182	456	2022	4	Good quality	1970-01-01	45
183	313	401	5	Excellent product!	1970-01-01	29
185	205	694	1	Completely unsatisfied	1970-01-01	24
187	394	2432	4	Very good	1970-01-01	2
188	101	2027	5	Highly recommend	1970-01-01	2
190	235	1186	5	Highly recommend	1970-01-01	50
191	145	1550	4	Nice product	1970-01-01	31
193	382	1737	3	It's okay	1970-01-01	45
196	300	2390	3	Decent product	1970-01-01	50
197	129	112	5	Highly recommend	1970-01-01	25
199	5	1278	4	Good quality	1970-01-01	50
200	419	892	4	Satisfied with purchase	1970-01-01	43
201	77	1522	5	Amazing value	1970-01-01	26
202	50	51	1	Terrible	1970-01-01	8
203	338	1880	2	Issues with product	1970-01-01	17
204	119	2315	5	Love it!	1970-01-01	22
205	65	1196	5	Love it!	1970-01-01	0
206	47	1194	2	Poor quality	1970-01-01	38
209	479	1306	4	Nice product	1970-01-01	27
210	152	2029	4	Satisfied with purchase	1970-01-01	30
211	316	1909	5	Amazing value	1970-01-01	28
212	404	1686	5	Excellent product!	1970-01-01	17
213	332	1913	4	Very good	1970-01-01	45
214	353	2274	5	Excellent product!	1970-01-01	3
215	142	2406	5	Love it!	1970-01-01	23
217	40	1851	4	Satisfied with purchase	1970-01-01	1
218	231	1790	4	Good quality	1970-01-01	42
219	158	699	4	Would buy again	1970-01-01	37
220	109	157	5	Excellent product!	1970-01-01	32
221	101	589	5	Amazing value	1970-01-01	27
222	342	1277	5	Excellent product!	1970-01-01	8
223	330	809	4	Satisfied with purchase	1970-01-01	10
224	201	2048	2	Poor quality	1970-01-01	10
225	36	1092	5	Excellent product!	1970-01-01	6
226	180	761	4	Nice product	1970-01-01	9
228	93	656	4	Good quality	1970-01-01	16
229	294	1499	4	Good quality	1970-01-01	23
231	228	1188	5	Love it!	1970-01-01	43
232	82	1749	5	Perfect quality	1970-01-01	4
234	319	2268	2	Not great	1970-01-01	49
235	246	841	4	Good quality	1970-01-01	13
237	102	336	5	Perfect quality	1970-01-01	3
238	76	1235	3	Decent product	1970-01-01	44
239	157	466	4	Would buy again	1970-01-01	46
240	157	1831	4	Good quality	1970-01-01	6
241	142	600	4	Good quality	1970-01-01	31
242	127	1707	5	Perfect quality	1970-01-01	42
243	342	2320	2	Not great	1970-01-01	16
244	325	2473	4	Satisfied with purchase	1970-01-01	15
246	78	1642	3	It's okay	1970-01-01	6
247	399	1737	2	Below expectations	1970-01-01	34
249	496	1794	1	Do not buy	1970-01-01	49
250	445	2302	4	Good quality	1970-01-01	30
251	138	2125	1	Completely unsatisfied	1970-01-01	26
252	300	972	4	Would buy again	1970-01-01	6
254	326	140	5	Love it!	1970-01-01	29
255	65	1196	4	Nice product	1970-01-01	0
256	331	507	4	Would buy again	1970-01-01	4
258	157	1629	4	Satisfied with purchase	1970-01-01	31
260	273	493	2	Disappointing	1970-01-01	33
261	457	211	5	Highly recommend	1970-01-01	3
263	252	2409	5	Love it!	1970-01-01	14
265	252	2409	4	Would buy again	1970-01-01	39
266	332	1913	4	Good quality	1970-01-01	37
267	75	866	4	Would buy again	1970-01-01	20
268	237	880	5	Love it!	1970-01-01	43
270	149	304	1	Very poor quality	1970-01-01	36
271	327	681	1	Completely unsatisfied	1970-01-01	45
272	380	1479	5	Excellent product!	1970-01-01	19
273	335	2055	2	Not great	1970-01-01	38
274	187	1274	4	Very good	1970-01-01	35
275	48	1600	2	Disappointing	1970-01-01	36
279	180	761	3	It's okay	1970-01-01	15
282	43	1576	5	Perfect quality	1970-01-01	25
283	460	2422	5	Love it!	1970-01-01	7
284	19	73	4	Very good	1970-01-01	45
285	407	372	4	Good quality	1970-01-01	17
286	12	2375	4	Satisfied with purchase	1970-01-01	38
287	140	2339	3	Does the job	1970-01-01	14
420	88	465	5	Love it!	1970-01-01	15
289	157	1831	5	Perfect quality	1970-01-01	43
290	273	2328	5	Excellent product!	1970-01-01	26
292	379	9	5	Highly recommend	1970-01-01	21
293	355	742	5	Highly recommend	1970-01-01	13
294	381	837	5	Perfect quality	1970-01-01	1
296	411	1598	5	Excellent product!	1970-01-01	34
297	380	1564	3	It's okay	1970-01-01	21
300	69	1866	4	Very good	1970-01-01	14
301	65	1348	3	Decent product	1970-01-01	6
302	70	1590	4	Would buy again	1970-01-01	31
303	140	2449	4	Satisfied with purchase	1970-01-01	22
305	68	39	5	Perfect quality	1970-01-01	8
306	178	2434	3	Could be better	1970-01-01	21
307	325	1387	2	Below expectations	1970-01-01	34
308	315	676	5	Amazing value	1970-01-01	20
309	40	946	3	Could be better	1970-01-01	35
310	361	846	3	Decent product	1970-01-01	48
311	303	1574	5	Highly recommend	1970-01-01	42
312	449	953	4	Very good	1970-01-01	24
313	120	490	3	Does the job	1970-01-01	41
315	258	144	5	Amazing value	1970-01-01	45
316	241	1656	4	Satisfied with purchase	1970-01-01	5
318	309	751	1	Waste of money	1970-01-01	16
319	49	285	4	Would buy again	1970-01-01	46
321	441	958	5	Perfect quality	1970-01-01	48
322	214	1738	5	Perfect quality	1970-01-01	21
324	407	713	3	Decent product	1970-01-01	2
325	106	2055	4	Would buy again	1970-01-01	13
326	168	850	5	Amazing value	1970-01-01	22
327	427	1687	4	Good quality	1970-01-01	18
328	353	96	3	It's okay	1970-01-01	38
329	296	4	5	Amazing value	1970-01-01	23
331	188	2361	4	Very good	1970-01-01	6
332	129	1682	2	Issues with product	1970-01-01	25
333	68	39	3	Could be better	1970-01-01	18
334	73	1502	4	Good quality	1970-01-01	21
337	133	598	4	Satisfied with purchase	1970-01-01	43
338	486	2211	4	Good quality	1970-01-01	21
340	438	886	4	Nice product	1970-01-01	16
342	491	1732	5	Excellent product!	1970-01-01	27
344	288	1971	3	Could be better	1970-01-01	13
345	314	1407	4	Would buy again	1970-01-01	35
348	465	655	5	Highly recommend	1970-01-01	38
349	399	1539	4	Very good	1970-01-01	41
352	171	120	2	Poor quality	1970-01-01	29
356	396	1689	5	Excellent product!	1970-01-01	48
359	243	29	4	Very good	1970-01-01	34
360	459	617	5	Love it!	1970-01-01	12
363	441	958	4	Satisfied with purchase	1970-01-01	17
364	268	219	4	Would buy again	1970-01-01	45
366	350	2119	5	Highly recommend	1970-01-01	16
367	417	300	5	Excellent product!	1970-01-01	39
368	152	612	3	Average quality	1970-01-01	21
370	281	1354	4	Would buy again	1970-01-01	49
372	282	1819	4	Satisfied with purchase	1970-01-01	45
373	10	9	5	Excellent product!	1970-01-01	24
374	78	1642	5	Perfect quality	1970-01-01	33
375	163	1119	5	Amazing value	1970-01-01	18
376	203	1492	4	Good quality	1970-01-01	6
377	202	1034	2	Issues with product	1970-01-01	48
381	29	624	5	Amazing value	1970-01-01	0
382	427	1687	3	Could be better	1970-01-01	48
383	187	289	5	Love it!	1970-01-01	21
384	312	108	5	Highly recommend	1970-01-01	27
385	264	399	4	Would buy again	1970-01-01	25
386	437	1619	1	Waste of money	1970-01-01	14
388	336	1718	3	It's okay	1970-01-01	30
390	20	2284	5	Amazing value	1970-01-01	26
392	228	1188	5	Amazing value	1970-01-01	36
393	421	506	4	Nice product	1970-01-01	30
396	353	346	4	Very good	1970-01-01	10
398	242	795	5	Amazing value	1970-01-01	26
400	389	1744	4	Good quality	1970-01-01	7
401	213	37	4	Satisfied with purchase	1970-01-01	48
403	69	1866	4	Very good	1970-01-01	5
404	407	307	5	Love it!	1970-01-01	31
405	157	1291	3	It's okay	1970-01-01	1
406	370	1380	2	Poor quality	1970-01-01	45
407	486	506	4	Very good	1970-01-01	46
408	320	1496	5	Perfect quality	1970-01-01	23
410	166	2078	4	Nice product	1970-01-01	42
411	434	548	5	Excellent product!	1970-01-01	17
412	484	257	4	Satisfied with purchase	1970-01-01	29
413	69	521	3	It's okay	1970-01-01	6
414	474	1504	4	Would buy again	1970-01-01	43
415	478	994	4	Good quality	1970-01-01	10
416	174	1945	5	Love it!	1970-01-01	46
417	147	527	4	Would buy again	1970-01-01	49
418	226	971	3	Decent product	1970-01-01	12
419	376	1830	3	Decent product	1970-01-01	32
421	288	1971	4	Satisfied with purchase	1970-01-01	34
422	126	2211	5	Excellent product!	1970-01-01	3
424	345	2459	5	Love it!	1970-01-01	8
425	365	512	4	Very good	1970-01-01	47
426	447	490	4	Good quality	1970-01-01	45
428	60	806	2	Below expectations	1970-01-01	6
429	406	1258	4	Very good	1970-01-01	27
430	406	1324	4	Would buy again	1970-01-01	8
431	70	1924	1	Waste of money	1970-01-01	4
433	37	390	3	Does the job	1970-01-01	15
434	406	1815	3	Average quality	1970-01-01	28
436	91	193	5	Highly recommend	1970-01-01	21
438	369	1025	4	Nice product	1970-01-01	6
439	150	2294	3	Does the job	1970-01-01	20
441	188	673	5	Highly recommend	1970-01-01	18
442	188	1466	4	Very good	1970-01-01	50
443	168	923	4	Would buy again	1970-01-01	44
444	273	679	5	Perfect quality	1970-01-01	11
445	356	162	3	Could be better	1970-01-01	15
446	220	478	4	Satisfied with purchase	1970-01-01	8
448	147	1218	3	It's okay	1970-01-01	34
451	327	494	3	It's okay	1970-01-01	19
452	92	2107	4	Would buy again	1970-01-01	28
453	330	809	3	Could be better	1970-01-01	50
454	258	1392	4	Satisfied with purchase	1970-01-01	48
457	350	2119	3	Does the job	1970-01-01	19
458	449	959	4	Would buy again	1970-01-01	31
459	243	740	3	Could be better	1970-01-01	30
464	463	1839	4	Nice product	1970-01-01	48
465	324	854	5	Perfect quality	1970-01-01	34
466	171	2388	4	Good quality	1970-01-01	18
467	311	1444	4	Would buy again	1970-01-01	40
469	88	465	1	Terrible	1970-01-01	44
475	12	1180	4	Satisfied with purchase	1970-01-01	23
477	342	2320	3	Decent product	1970-01-01	3
478	309	1665	4	Very good	1970-01-01	17
479	377	819	5	Excellent product!	1970-01-01	6
480	168	850	4	Satisfied with purchase	1970-01-01	15
481	78	1642	2	Not great	1970-01-01	29
482	122	2396	3	Average quality	1970-01-01	19
483	324	1055	5	Perfect quality	1970-01-01	21
484	386	2105	4	Very good	1970-01-01	0
486	462	2	5	Love it!	1970-01-01	21
487	45	605	4	Good quality	1970-01-01	19
488	132	23	3	Decent product	1970-01-01	40
489	225	1102	3	Does the job	1970-01-01	26
490	187	1274	4	Would buy again	1970-01-01	30
491	361	927	5	Excellent product!	1970-01-01	15
492	316	1734	5	Excellent product!	1970-01-01	10
493	315	1899	3	Average quality	1970-01-01	19
496	460	2422	4	Nice product	1970-01-01	45
500	1	701	4	Good quality	1970-01-01	16
501	130	741	4	Very good	1970-01-01	18
502	102	1609	3	Average quality	1970-01-01	25
503	268	2333	4	Nice product	1970-01-01	46
504	224	1057	5	Excellent product!	1970-01-01	27
505	71	1558	4	Good quality	1970-01-01	17
507	397	1116	3	Average quality	1970-01-01	36
508	161	311	4	Very good	1970-01-01	20
514	120	1140	3	Average quality	1970-01-01	11
516	405	1346	5	Highly recommend	1970-01-01	6
517	478	423	5	Love it!	1970-01-01	48
518	224	1057	4	Good quality	1970-01-01	40
519	76	1457	4	Good quality	1970-01-01	45
520	191	737	5	Love it!	1970-01-01	15
523	165	538	3	It's okay	1970-01-01	45
524	274	2198	2	Disappointing	1970-01-01	34
525	500	947	5	Excellent product!	1970-01-01	37
526	268	2333	5	Perfect quality	1970-01-01	44
527	331	2430	2	Poor quality	1970-01-01	41
529	12	2253	5	Perfect quality	1970-01-01	25
530	376	1830	3	It's okay	1970-01-01	39
531	128	1794	3	Does the job	1970-01-01	5
532	106	1338	2	Poor quality	1970-01-01	2
533	328	505	5	Amazing value	1970-01-01	37
534	367	614	2	Poor quality	1970-01-01	46
535	60	2286	5	Perfect quality	1970-01-01	1
536	406	1461	3	Average quality	1970-01-01	44
537	93	2032	3	Does the job	1970-01-01	48
539	97	1431	2	Below expectations	1970-01-01	48
540	1	701	3	Could be better	1970-01-01	25
541	167	945	4	Satisfied with purchase	1970-01-01	32
544	489	1151	3	Could be better	1970-01-01	47
545	47	2035	4	Very good	1970-01-01	42
546	27	1127	5	Perfect quality	1970-01-01	45
549	189	2399	5	Excellent product!	1970-01-01	27
550	143	2049	5	Perfect quality	1970-01-01	18
551	381	2023	3	Does the job	1970-01-01	35
552	51	184	4	Nice product	1970-01-01	22
553	102	613	4	Would buy again	1970-01-01	28
554	27	551	4	Very good	1970-01-01	12
556	45	475	1	Completely unsatisfied	1970-01-01	6
557	414	440	1	Very poor quality	1970-01-01	48
558	60	2286	4	Very good	1970-01-01	3
559	153	188	5	Amazing value	1970-01-01	31
562	103	231	3	Could be better	1970-01-01	7
564	128	1494	2	Issues with product	1970-01-01	45
565	27	1494	4	Good quality	1970-01-01	33
566	189	2399	5	Perfect quality	1970-01-01	26
567	498	710	5	Excellent product!	1970-01-01	40
568	140	937	1	Completely unsatisfied	1970-01-01	21
572	133	1044	1	Do not buy	1970-01-01	45
573	203	561	4	Very good	1970-01-01	40
574	237	1048	5	Excellent product!	1970-01-01	42
575	102	336	5	Perfect quality	1970-01-01	9
576	34	734	4	Would buy again	1970-01-01	22
577	65	1196	4	Very good	1970-01-01	33
578	328	290	3	It's okay	1970-01-01	14
579	376	395	1	Do not buy	1970-01-01	28
581	82	2363	4	Nice product	1970-01-01	6
584	158	1324	3	Could be better	1970-01-01	36
587	204	1668	2	Issues with product	1970-01-01	48
588	401	892	4	Very good	1970-01-01	27
589	422	1059	3	Could be better	1970-01-01	22
590	73	1860	4	Good quality	1970-01-01	25
591	228	2319	3	Does the job	1970-01-01	48
592	2	2445	2	Not great	1970-01-01	40
593	481	1038	4	Satisfied with purchase	1970-01-01	9
594	269	1638	1	Terrible	1970-01-01	22
595	15	653	4	Good quality	1970-01-01	21
597	69	646	4	Would buy again	1970-01-01	50
598	334	2171	3	Average quality	1970-01-01	24
599	1	1408	4	Nice product	1970-01-01	6
601	341	2141	4	Satisfied with purchase	1970-01-01	26
602	316	2011	2	Disappointing	1970-01-01	30
604	183	2293	2	Not great	1970-01-01	23
606	448	1041	5	Perfect quality	1970-01-01	20
607	290	2262	1	Terrible	1970-01-01	18
608	392	345	4	Very good	1970-01-01	47
609	324	854	5	Amazing value	1970-01-01	35
611	485	1887	4	Would buy again	1970-01-01	33
614	252	2409	2	Poor quality	1970-01-01	12
615	387	226	5	Perfect quality	1970-01-01	33
617	382	1737	3	It's okay	1970-01-01	1
618	40	1698	4	Good quality	1970-01-01	20
619	310	599	3	Does the job	1970-01-01	14
621	18	1659	3	Could be better	1970-01-01	36
623	204	1668	4	Would buy again	1970-01-01	32
624	69	646	4	Satisfied with purchase	1970-01-01	6
625	407	372	4	Would buy again	1970-01-01	9
626	493	2064	3	Could be better	1970-01-01	20
627	25	2244	4	Very good	1970-01-01	10
628	352	2163	2	Not great	1970-01-01	14
630	237	1048	5	Perfect quality	1970-01-01	23
631	446	73	4	Would buy again	1970-01-01	6
632	138	1081	3	It's okay	1970-01-01	23
633	365	1703	4	Very good	1970-01-01	16
634	138	2125	2	Issues with product	1970-01-01	40
636	336	1718	3	Could be better	1970-01-01	27
637	262	2488	1	Completely unsatisfied	1970-01-01	7
639	327	681	5	Love it!	1970-01-01	8
641	149	304	4	Nice product	1970-01-01	49
642	402	165	3	Decent product	1970-01-01	37
643	323	31	4	Satisfied with purchase	1970-01-01	5
647	178	976	3	Could be better	1970-01-01	39
648	369	237	3	Decent product	1970-01-01	18
649	19	1882	3	Average quality	1970-01-01	9
651	179	2389	3	Does the job	1970-01-01	35
652	257	1526	2	Issues with product	1970-01-01	25
653	314	1785	3	It's okay	1970-01-01	29
654	331	732	3	It's okay	1970-01-01	23
655	417	2469	1	Terrible	1970-01-01	7
656	366	802	5	Excellent product!	1970-01-01	9
657	70	281	4	Would buy again	1970-01-01	37
663	299	1502	5	Amazing value	1970-01-01	46
664	357	2433	3	Could be better	1970-01-01	43
665	411	469	4	Good quality	1970-01-01	31
667	166	576	3	It's okay	1970-01-01	14
671	324	1055	3	Does the job	1970-01-01	12
672	342	1277	5	Amazing value	1970-01-01	7
673	274	564	5	Amazing value	1970-01-01	6
675	239	842	3	Does the job	1970-01-01	5
676	102	980	4	Satisfied with purchase	1970-01-01	20
677	401	892	4	Would buy again	1970-01-01	37
678	297	2472	4	Good quality	1970-01-01	28
680	133	1600	4	Good quality	1970-01-01	3
681	58	423	5	Highly recommend	1970-01-01	6
686	299	1082	3	Does the job	1970-01-01	24
687	327	1703	3	Could be better	1970-01-01	48
691	198	2361	4	Very good	1970-01-01	46
692	406	1461	3	Average quality	1970-01-01	28
693	30	777	3	Decent product	1970-01-01	37
694	66	1133	4	Nice product	1970-01-01	0
695	254	1925	4	Satisfied with purchase	1970-01-01	38
698	70	281	3	Could be better	1970-01-01	4
699	133	2486	1	Do not buy	1970-01-01	14
700	152	1801	3	Could be better	1970-01-01	14
703	404	121	5	Amazing value	1970-01-01	22
706	124	422	4	Very good	1970-01-01	1
707	392	680	5	Amazing value	1970-01-01	41
708	25	1103	3	Could be better	1970-01-01	6
709	223	248	3	Average quality	1970-01-01	2
710	197	1655	4	Good quality	1970-01-01	3
711	196	1382	3	Does the job	1970-01-01	25
712	36	1879	4	Good quality	1970-01-01	35
713	260	1450	4	Nice product	1970-01-01	33
714	84	1279	4	Nice product	1970-01-01	33
717	363	13	3	It's okay	1970-01-01	3
718	184	1647	5	Highly recommend	1970-01-01	29
719	250	225	1	Terrible	1970-01-01	31
720	482	2272	5	Love it!	1970-01-01	30
721	166	1566	3	Does the job	1970-01-01	12
722	350	2119	5	Excellent product!	1970-01-01	33
724	478	1316	2	Not great	1970-01-01	6
729	75	1565	5	Perfect quality	1970-01-01	1
730	466	1049	3	It's okay	1970-01-01	18
731	287	2452	3	Does the job	1970-01-01	37
733	417	1271	4	Good quality	1970-01-01	14
734	331	2432	3	Decent product	1970-01-01	42
737	286	1771	4	Satisfied with purchase	1970-01-01	36
739	324	664	5	Highly recommend	1970-01-01	43
740	405	119	1	Waste of money	1970-01-01	14
741	265	903	4	Very good	1970-01-01	48
742	145	1550	2	Issues with product	1970-01-01	37
743	394	1348	4	Would buy again	1970-01-01	25
744	181	939	5	Love it!	1970-01-01	24
745	128	1794	5	Amazing value	1970-01-01	41
748	125	493	5	Love it!	1970-01-01	32
749	88	1800	4	Satisfied with purchase	1970-01-01	12
750	331	46	5	Amazing value	1970-01-01	22
752	470	503	5	Highly recommend	1970-01-01	21
753	417	1271	5	Love it!	1970-01-01	39
754	130	637	3	Could be better	1970-01-01	24
755	133	598	4	Very good	1970-01-01	44
756	2	374	2	Poor quality	1970-01-01	36
757	44	2472	3	It's okay	1970-01-01	48
758	285	712	4	Nice product	1970-01-01	28
759	488	1975	5	Highly recommend	1970-01-01	23
760	1	1408	4	Very good	1970-01-01	14
763	68	1324	2	Not great	1970-01-01	8
764	452	1483	3	Could be better	1970-01-01	37
765	430	2435	4	Satisfied with purchase	1970-01-01	23
766	34	1820	5	Highly recommend	1970-01-01	25
767	115	334	3	Decent product	1970-01-01	44
768	349	1464	4	Very good	1970-01-01	18
772	223	248	3	Average quality	1970-01-01	44
773	247	880	5	Excellent product!	1970-01-01	34
776	147	881	4	Very good	1970-01-01	1
778	375	1282	1	Terrible	1970-01-01	50
779	362	915	5	Excellent product!	1970-01-01	20
780	187	2391	4	Would buy again	1970-01-01	37
781	373	2471	4	Nice product	1970-01-01	50
782	247	2466	3	Decent product	1970-01-01	32
783	43	1576	2	Not great	1970-01-01	14
784	439	1144	1	Completely unsatisfied	1970-01-01	8
785	3	277	4	Satisfied with purchase	1970-01-01	19
786	313	401	4	Would buy again	1970-01-01	36
787	60	429	4	Nice product	1970-01-01	25
788	247	2466	4	Satisfied with purchase	1970-01-01	13
789	406	1258	2	Disappointing	1970-01-01	16
791	367	2210	5	Love it!	1970-01-01	26
793	195	344	4	Nice product	1970-01-01	8
794	448	1034	5	Amazing value	1970-01-01	8
796	352	2015	5	Amazing value	1970-01-01	25
797	213	37	5	Excellent product!	1970-01-01	24
799	254	727	3	Could be better	1970-01-01	48
800	236	876	2	Below expectations	1970-01-01	15
801	459	617	4	Satisfied with purchase	1970-01-01	40
802	385	2094	4	Very good	1970-01-01	29
804	178	225	4	Very good	1970-01-01	15
805	459	941	2	Issues with product	1970-01-01	4
808	466	1626	2	Below expectations	1970-01-01	29
809	227	1203	5	Love it!	1970-01-01	38
810	291	2400	3	Decent product	1970-01-01	38
812	268	2333	5	Amazing value	1970-01-01	10
813	426	2083	5	Perfect quality	1970-01-01	39
814	47	79	4	Good quality	1970-01-01	19
815	469	919	4	Good quality	1970-01-01	15
816	374	1518	5	Highly recommend	1970-01-01	45
817	91	2281	5	Highly recommend	1970-01-01	7
820	335	2144	4	Very good	1970-01-01	45
821	213	511	4	Good quality	1970-01-01	31
823	240	1611	3	It's okay	1970-01-01	40
824	334	633	5	Love it!	1970-01-01	30
825	497	865	4	Nice product	1970-01-01	10
826	54	338	5	Amazing value	1970-01-01	44
828	126	1286	3	Does the job	1970-01-01	15
829	92	2083	4	Very good	1970-01-01	11
830	331	507	5	Highly recommend	1970-01-01	46
831	252	1750	1	Waste of money	1970-01-01	20
832	74	1194	4	Very good	1970-01-01	50
833	457	2491	1	Completely unsatisfied	1970-01-01	22
834	460	1693	4	Nice product	1970-01-01	31
836	457	211	4	Satisfied with purchase	1970-01-01	29
837	319	1354	5	Amazing value	1970-01-01	38
838	406	1815	5	Highly recommend	1970-01-01	37
840	116	351	5	Love it!	1970-01-01	46
843	205	1870	4	Very good	1970-01-01	4
844	452	302	4	Satisfied with purchase	1970-01-01	29
845	252	2409	1	Completely unsatisfied	1970-01-01	9
847	421	1376	5	Excellent product!	1970-01-01	10
849	4	2223	5	Love it!	1970-01-01	1
850	111	1984	5	Amazing value	1970-01-01	23
851	222	220	4	Satisfied with purchase	1970-01-01	47
852	339	867	5	Love it!	1970-01-01	10
853	8	1484	4	Nice product	1970-01-01	32
854	173	1390	4	Satisfied with purchase	1970-01-01	7
856	119	976	1	Do not buy	1970-01-01	45
857	445	2408	4	Satisfied with purchase	1970-01-01	10
858	286	1296	4	Satisfied with purchase	1970-01-01	27
859	389	1178	5	Perfect quality	1970-01-01	22
860	270	1284	2	Not great	1970-01-01	8
861	352	1967	1	Completely unsatisfied	1970-01-01	1
862	193	2174	4	Satisfied with purchase	1970-01-01	30
863	414	183	3	It's okay	1970-01-01	43
864	273	1332	5	Highly recommend	1970-01-01	44
865	215	2184	4	Satisfied with purchase	1970-01-01	25
866	145	1455	3	Average quality	1970-01-01	46
867	165	2461	5	Perfect quality	1970-01-01	5
868	94	1905	4	Very good	1970-01-01	23
871	4	2223	4	Nice product	1970-01-01	16
872	215	2184	5	Love it!	1970-01-01	11
874	411	2082	4	Would buy again	1970-01-01	8
876	369	1598	4	Satisfied with purchase	1970-01-01	45
880	310	599	5	Perfect quality	1970-01-01	29
881	427	2063	3	Average quality	1970-01-01	7
882	480	2253	5	Amazing value	1970-01-01	35
883	184	1647	1	Completely unsatisfied	1970-01-01	26
884	17	636	5	Love it!	1970-01-01	27
885	271	759	5	Highly recommend	1970-01-01	24
886	40	1851	5	Highly recommend	1970-01-01	43
887	203	543	3	Average quality	1970-01-01	0
888	386	1627	3	Does the job	1970-01-01	16
889	449	1809	2	Not great	1970-01-01	6
890	246	841	4	Good quality	1970-01-01	29
891	456	1112	1	Completely unsatisfied	1970-01-01	18
893	116	351	2	Not great	1970-01-01	26
894	43	537	3	Decent product	1970-01-01	44
896	30	777	3	It's okay	1970-01-01	8
897	34	1122	3	It's okay	1970-01-01	0
898	287	17	3	It's okay	1970-01-01	39
900	98	40	5	Highly recommend	1970-01-01	46
901	145	496	5	Love it!	1970-01-01	21
903	284	1564	5	Perfect quality	1970-01-01	10
904	104	501	4	Satisfied with purchase	1970-01-01	42
906	136	1720	3	Decent product	1970-01-01	29
907	174	1094	4	Good quality	1970-01-01	22
908	300	2209	5	Excellent product!	1970-01-01	45
910	215	1318	5	Love it!	1970-01-01	23
911	357	1069	1	Terrible	1970-01-01	7
912	366	824	5	Love it!	1970-01-01	20
913	194	910	3	Could be better	1970-01-01	11
914	325	1387	4	Nice product	1970-01-01	34
915	414	440	3	It's okay	1970-01-01	5
916	230	1532	5	Perfect quality	1970-01-01	37
917	64	949	1	Waste of money	1970-01-01	16
918	193	2174	5	Perfect quality	1970-01-01	34
919	242	1087	5	Amazing value	1970-01-01	45
920	299	1082	5	Highly recommend	1970-01-01	34
921	445	1663	4	Good quality	1970-01-01	8
923	42	796	3	Average quality	1970-01-01	44
924	78	1461	3	Does the job	1970-01-01	46
928	461	1600	4	Would buy again	1970-01-01	38
929	64	2335	4	Very good	1970-01-01	43
930	264	1457	3	Could be better	1970-01-01	35
932	152	1323	3	Does the job	1970-01-01	21
933	104	1678	4	Satisfied with purchase	1970-01-01	16
934	225	2117	3	It's okay	1970-01-01	24
935	491	1981	1	Completely unsatisfied	1970-01-01	22
937	178	2434	5	Excellent product!	1970-01-01	22
939	195	1074	5	Love it!	1970-01-01	45
941	180	761	5	Love it!	1970-01-01	29
942	47	1822	4	Very good	1970-01-01	42
943	362	75	4	Nice product	1970-01-01	33
944	215	778	4	Satisfied with purchase	1970-01-01	43
946	500	1062	5	Excellent product!	1970-01-01	15
947	179	2389	5	Amazing value	1970-01-01	48
948	380	839	4	Nice product	1970-01-01	38
949	362	915	2	Not great	1970-01-01	21
951	132	78	5	Love it!	1970-01-01	33
953	268	1672	4	Nice product	1970-01-01	33
954	308	209	4	Satisfied with purchase	1970-01-01	23
955	131	2186	5	Amazing value	1970-01-01	39
956	454	2101	4	Nice product	1970-01-01	6
960	363	938	3	Decent product	1970-01-01	41
961	493	2091	1	Waste of money	1970-01-01	37
962	258	1392	3	Decent product	1970-01-01	50
963	477	750	5	Perfect quality	1970-01-01	17
964	270	1306	3	Does the job	1970-01-01	19
965	423	690	3	It's okay	1970-01-01	25
967	228	1188	2	Disappointing	1970-01-01	41
970	60	322	5	Excellent product!	1970-01-01	25
971	209	150	1	Very poor quality	1970-01-01	21
972	60	2286	4	Nice product	1970-01-01	39
973	219	2028	4	Nice product	1970-01-01	3
974	276	1014	4	Nice product	1970-01-01	50
975	250	179	4	Would buy again	1970-01-01	32
976	336	1718	5	Highly recommend	1970-01-01	48
978	442	1895	3	Could be better	1970-01-01	26
980	221	1693	4	Nice product	1970-01-01	24
981	417	2469	4	Good quality	1970-01-01	13
982	364	2351	5	Excellent product!	1970-01-01	44
984	65	1196	2	Below expectations	1970-01-01	24
985	452	302	2	Poor quality	1970-01-01	42
989	287	17	4	Good quality	1970-01-01	15
990	377	1016	5	Highly recommend	1970-01-01	37
993	310	1091	4	Very good	1970-01-01	11
994	365	641	3	Average quality	1970-01-01	43
996	224	592	5	Perfect quality	1970-01-01	10
999	63	866	4	Good quality	1970-01-01	44
1001	404	748	3	Could be better	1970-01-01	18
1002	160	744	4	Nice product	1970-01-01	2
1003	68	2203	4	Good quality	1970-01-01	23
1005	224	2424	3	Could be better	1970-01-01	9
1007	487	949	3	Average quality	1970-01-01	19
1009	425	359	3	Does the job	1970-01-01	17
1010	370	2302	5	Highly recommend	1970-01-01	49
1012	43	537	3	Decent product	1970-01-01	15
1013	1	2201	5	Amazing value	1970-01-01	40
1014	383	1615	2	Not great	1970-01-01	26
1015	149	2049	3	Could be better	1970-01-01	25
1017	473	1286	5	Amazing value	1970-01-01	15
1018	252	2342	4	Very good	1970-01-01	24
1019	268	1215	3	Could be better	1970-01-01	44
1021	190	1885	4	Good quality	1970-01-01	21
1022	212	1063	4	Very good	1970-01-01	26
1023	91	193	3	Does the job	1970-01-01	0
1024	421	1376	4	Would buy again	1970-01-01	34
1025	409	1203	4	Good quality	1970-01-01	50
1027	95	766	3	Average quality	1970-01-01	26
1029	252	2342	4	Good quality	1970-01-01	26
1031	293	1720	1	Completely unsatisfied	1970-01-01	44
1033	299	1605	5	Love it!	1970-01-01	36
1035	436	1022	4	Satisfied with purchase	1970-01-01	36
1036	313	401	1	Waste of money	1970-01-01	3
1037	252	889	4	Good quality	1970-01-01	43
1038	91	1234	1	Terrible	1970-01-01	49
1039	240	889	4	Would buy again	1970-01-01	29
1044	324	1055	1	Terrible	1970-01-01	43
1046	476	737	4	Satisfied with purchase	1970-01-01	19
1047	335	656	4	Would buy again	1970-01-01	38
1048	50	51	4	Satisfied with purchase	1970-01-01	7
1049	2	374	4	Very good	1970-01-01	41
1050	398	648	3	Average quality	1970-01-01	43
1051	357	1118	5	Amazing value	1970-01-01	40
1053	97	1431	5	Excellent product!	1970-01-01	38
1054	381	2023	3	Could be better	1970-01-01	41
1056	171	1188	3	Could be better	1970-01-01	10
1057	437	1261	3	Could be better	1970-01-01	3
1058	127	1044	5	Love it!	1970-01-01	9
1059	404	1686	4	Would buy again	1970-01-01	47
1061	58	1984	3	Decent product	1970-01-01	20
1062	49	285	4	Nice product	1970-01-01	28
1063	470	132	5	Amazing value	1970-01-01	9
1065	99	1104	2	Poor quality	1970-01-01	10
1066	210	1063	4	Nice product	1970-01-01	44
1067	487	330	5	Excellent product!	1970-01-01	10
1068	458	1656	4	Nice product	1970-01-01	3
1070	33	265	5	Perfect quality	1970-01-01	45
1071	85	1775	4	Nice product	1970-01-01	20
1072	187	1274	2	Disappointing	1970-01-01	26
1073	261	1161	1	Completely unsatisfied	1970-01-01	44
1074	352	950	5	Highly recommend	1970-01-01	16
1075	43	537	4	Good quality	1970-01-01	21
1076	336	1718	3	Could be better	1970-01-01	28
1078	38	409	4	Good quality	1970-01-01	31
1082	35	1988	4	Nice product	1970-01-01	26
1084	128	759	5	Highly recommend	1970-01-01	9
1085	254	1925	5	Amazing value	1970-01-01	38
1086	181	1016	4	Satisfied with purchase	1970-01-01	19
1087	90	62	3	Decent product	1970-01-01	50
1088	414	1390	4	Nice product	1970-01-01	9
1089	202	1121	5	Excellent product!	1970-01-01	41
1090	470	132	5	Perfect quality	1970-01-01	28
1091	415	1615	1	Very poor quality	1970-01-01	31
1092	387	860	2	Issues with product	1970-01-01	2
1093	168	826	3	Could be better	1970-01-01	32
1095	422	420	1	Waste of money	1970-01-01	44
1096	133	2486	5	Highly recommend	1970-01-01	19
1097	360	665	5	Amazing value	1970-01-01	23
1098	214	1526	4	Satisfied with purchase	1970-01-01	37
1099	73	1571	4	Very good	1970-01-01	11
1101	105	1126	5	Perfect quality	1970-01-01	35
1103	399	1737	4	Satisfied with purchase	1970-01-01	43
1105	286	330	5	Excellent product!	1970-01-01	38
1106	88	1800	2	Issues with product	1970-01-01	43
1107	158	426	3	It's okay	1970-01-01	28
1108	406	1258	1	Terrible	1970-01-01	0
1109	350	463	4	Would buy again	1970-01-01	6
1111	248	499	4	Very good	1970-01-01	18
1114	175	899	5	Amazing value	1970-01-01	46
1115	369	1025	4	Would buy again	1970-01-01	44
1116	65	657	3	Does the job	1970-01-01	5
1117	294	280	4	Good quality	1970-01-01	5
1118	178	225	1	Completely unsatisfied	1970-01-01	0
1119	323	86	2	Below expectations	1970-01-01	6
1120	228	1998	4	Good quality	1970-01-01	46
1123	224	592	3	Does the job	1970-01-01	30
1124	230	570	3	Average quality	1970-01-01	43
1125	100	930	4	Very good	1970-01-01	0
1126	328	1220	5	Love it!	1970-01-01	30
1128	365	1109	4	Nice product	1970-01-01	38
1130	467	852	4	Would buy again	1970-01-01	44
1131	70	2322	4	Good quality	1970-01-01	14
1133	453	1180	5	Highly recommend	1970-01-01	38
1136	184	1647	4	Nice product	1970-01-01	47
1137	146	1492	3	Average quality	1970-01-01	18
1138	395	799	2	Disappointing	1970-01-01	22
1140	364	2351	5	Love it!	1970-01-01	18
1143	269	1569	3	Decent product	1970-01-01	14
1144	17	636	5	Highly recommend	1970-01-01	48
1147	71	906	2	Below expectations	1970-01-01	0
1148	3	277	5	Perfect quality	1970-01-01	31
1150	159	81	4	Good quality	1970-01-01	19
1152	47	1341	2	Disappointing	1970-01-01	39
1154	73	2132	1	Terrible	1970-01-01	21
1155	56	2154	4	Satisfied with purchase	1970-01-01	47
1156	177	1967	1	Very poor quality	1970-01-01	16
1158	92	634	4	Would buy again	1970-01-01	11
1159	182	2208	3	Average quality	1970-01-01	9
1161	459	549	5	Amazing value	1970-01-01	6
1162	233	21	5	Excellent product!	1970-01-01	3
1163	266	1482	5	Amazing value	1970-01-01	44
1164	197	1655	5	Amazing value	1970-01-01	26
1166	98	12	4	Good quality	1970-01-01	14
1167	21	450	5	Excellent product!	1970-01-01	22
1168	473	1326	5	Highly recommend	1970-01-01	32
1169	85	1169	4	Very good	1970-01-01	42
1171	73	404	4	Nice product	1970-01-01	48
1172	58	784	1	Waste of money	1970-01-01	42
1173	348	712	5	Perfect quality	1970-01-01	22
1174	364	2430	4	Would buy again	1970-01-01	8
1175	149	304	1	Very poor quality	1970-01-01	34
1177	380	1794	5	Amazing value	1970-01-01	6
1178	312	158	5	Love it!	1970-01-01	48
1180	290	1599	4	Nice product	1970-01-01	28
1181	324	854	3	It's okay	1970-01-01	11
1182	141	1850	4	Would buy again	1970-01-01	30
1183	44	2472	5	Perfect quality	1970-01-01	30
1184	198	606	5	Love it!	1970-01-01	16
1185	138	1035	4	Would buy again	1970-01-01	31
1186	85	1169	3	It's okay	1970-01-01	17
1188	331	2432	4	Would buy again	1970-01-01	32
1189	20	1046	4	Nice product	1970-01-01	37
1190	36	1761	5	Amazing value	1970-01-01	30
1192	147	1218	3	Does the job	1970-01-01	32
1193	168	923	3	Could be better	1970-01-01	18
1194	120	1140	5	Love it!	1970-01-01	0
1195	427	2063	2	Issues with product	1970-01-01	8
1196	462	2	5	Amazing value	1970-01-01	13
1197	105	2334	4	Very good	1970-01-01	21
1198	324	1055	5	Highly recommend	1970-01-01	44
1199	355	1687	4	Very good	1970-01-01	37
1201	341	2141	3	Could be better	1970-01-01	15
1203	73	998	5	Amazing value	1970-01-01	50
1204	462	2	3	Decent product	1970-01-01	27
1205	140	919	5	Perfect quality	1970-01-01	7
1206	487	949	5	Excellent product!	1970-01-01	26
1207	303	597	4	Would buy again	1970-01-01	45
1208	43	1461	2	Poor quality	1970-01-01	3
1209	80	729	5	Highly recommend	1970-01-01	42
1210	346	2075	4	Nice product	1970-01-01	33
1214	47	719	4	Satisfied with purchase	1970-01-01	8
1215	313	2283	4	Good quality	1970-01-01	15
1216	188	2361	2	Below expectations	1970-01-01	11
1217	155	2411	5	Highly recommend	1970-01-01	34
1218	441	289	4	Satisfied with purchase	1970-01-01	19
1220	207	2170	5	Excellent product!	1970-01-01	40
1222	100	930	2	Issues with product	1970-01-01	0
1223	104	501	4	Satisfied with purchase	1970-01-01	31
1225	412	1132	4	Good quality	1970-01-01	19
1226	232	1071	3	Decent product	1970-01-01	32
1228	427	125	3	Does the job	1970-01-01	33
1229	241	188	5	Love it!	1970-01-01	35
1230	325	1387	4	Satisfied with purchase	1970-01-01	8
1234	106	889	2	Poor quality	1970-01-01	42
1237	418	1578	4	Good quality	1970-01-01	39
1239	427	2044	4	Good quality	1970-01-01	34
1241	407	307	5	Highly recommend	1970-01-01	2
1245	354	724	3	It's okay	1970-01-01	5
1246	42	962	4	Satisfied with purchase	1970-01-01	39
1247	460	1011	4	Would buy again	1970-01-01	50
1248	472	44	5	Love it!	1970-01-01	47
1249	52	2355	3	It's okay	1970-01-01	27
1253	203	561	4	Would buy again	1970-01-01	27
1254	158	1324	5	Perfect quality	1970-01-01	30
1255	187	1302	2	Below expectations	1970-01-01	24
1256	460	2422	5	Love it!	1970-01-01	0
1258	8	2041	3	Does the job	1970-01-01	5
1260	185	1332	5	Excellent product!	1970-01-01	11
1262	290	999	4	Satisfied with purchase	1970-01-01	14
1263	310	1091	3	Does the job	1970-01-01	48
1264	87	11	5	Perfect quality	1970-01-01	15
1265	417	1271	3	Could be better	1970-01-01	12
1267	353	346	4	Very good	1970-01-01	16
1271	475	1502	3	Does the job	1970-01-01	22
1273	179	641	5	Highly recommend	1970-01-01	3
1274	209	150	5	Highly recommend	1970-01-01	47
1275	355	831	4	Satisfied with purchase	1970-01-01	35
1276	17	636	3	Could be better	1970-01-01	1
1277	363	1478	3	Average quality	1970-01-01	16
1278	8	1751	1	Waste of money	1970-01-01	21
1279	444	178	3	Could be better	1970-01-01	38
1281	358	1035	4	Would buy again	1970-01-01	2
1282	129	1475	3	It's okay	1970-01-01	30
1283	312	1781	5	Amazing value	1970-01-01	4
1285	264	1665	4	Nice product	1970-01-01	40
1286	63	2079	5	Perfect quality	1970-01-01	41
1288	488	728	4	Nice product	1970-01-01	50
1289	150	2294	5	Perfect quality	1970-01-01	38
1290	101	1401	1	Very poor quality	1970-01-01	42
1291	229	83	5	Perfect quality	1970-01-01	42
1295	343	2218	5	Amazing value	1970-01-01	4
1297	122	2324	5	Love it!	1970-01-01	34
1298	472	2058	4	Good quality	1970-01-01	29
1300	36	596	5	Highly recommend	1970-01-01	0
1301	223	1498	4	Would buy again	1970-01-01	10
1304	340	2208	3	Decent product	1970-01-01	20
1305	413	2424	4	Nice product	1970-01-01	17
1306	36	1092	5	Highly recommend	1970-01-01	2
1307	331	9	4	Very good	1970-01-01	35
1309	131	1279	2	Not great	1970-01-01	15
1310	195	344	4	Very good	1970-01-01	7
1311	173	1390	3	Decent product	1970-01-01	5
1312	441	1669	5	Highly recommend	1970-01-01	34
1314	194	1434	3	Does the job	1970-01-01	35
1315	408	430	4	Good quality	1970-01-01	35
1316	60	429	5	Excellent product!	1970-01-01	34
1317	218	1715	4	Very good	1970-01-01	13
1318	223	1498	3	Does the job	1970-01-01	12
1319	351	941	3	Could be better	1970-01-01	8
1320	273	366	4	Would buy again	1970-01-01	10
1323	94	1905	5	Perfect quality	1970-01-01	27
1324	491	1046	4	Good quality	1970-01-01	44
1325	336	916	5	Perfect quality	1970-01-01	31
1326	239	1043	3	Does the job	1970-01-01	36
1327	93	656	4	Good quality	1970-01-01	21
1328	224	2424	3	Average quality	1970-01-01	40
1330	343	1822	4	Nice product	1970-01-01	40
1331	479	1186	2	Not great	1970-01-01	32
1333	399	1539	4	Good quality	1970-01-01	4
1334	69	646	4	Nice product	1970-01-01	10
1336	427	110	4	Satisfied with purchase	1970-01-01	42
1337	164	886	5	Love it!	1970-01-01	3
1338	186	1601	5	Amazing value	1970-01-01	32
1339	299	2089	3	It's okay	1970-01-01	41
1340	159	466	3	It's okay	1970-01-01	40
1341	369	1685	5	Excellent product!	1970-01-01	23
1342	467	2048	4	Good quality	1970-01-01	9
1344	331	9	5	Love it!	1970-01-01	40
1345	185	1410	4	Nice product	1970-01-01	16
1346	101	1661	4	Very good	1970-01-01	46
1347	239	1043	5	Love it!	1970-01-01	3
1349	322	2463	3	Does the job	1970-01-01	15
1350	289	1283	3	It's okay	1970-01-01	10
1351	97	12	5	Perfect quality	1970-01-01	18
1352	250	225	1	Waste of money	1970-01-01	12
1353	445	2408	5	Highly recommend	1970-01-01	18
1354	467	1634	4	Very good	1970-01-01	16
1357	252	1726	5	Perfect quality	1970-01-01	42
1359	250	887	4	Very good	1970-01-01	1
1360	241	1534	3	Could be better	1970-01-01	16
1363	248	499	3	Could be better	1970-01-01	5
1365	397	237	4	Nice product	1970-01-01	50
1366	44	1548	2	Disappointing	1970-01-01	46
1368	429	1557	5	Perfect quality	1970-01-01	32
1369	181	2435	5	Highly recommend	1970-01-01	12
1370	215	2184	3	Decent product	1970-01-01	44
1371	183	2158	3	Could be better	1970-01-01	34
1372	133	355	4	Satisfied with purchase	1970-01-01	15
1373	57	1492	3	Average quality	1970-01-01	49
1377	69	1716	4	Good quality	1970-01-01	2
1378	338	2016	3	Decent product	1970-01-01	3
1379	306	752	4	Nice product	1970-01-01	4
1380	60	1354	4	Would buy again	1970-01-01	23
1381	336	916	3	It's okay	1970-01-01	36
1382	273	1417	2	Issues with product	1970-01-01	37
1383	212	203	1	Waste of money	1970-01-01	42
1384	320	1496	3	Does the job	1970-01-01	35
1385	180	1449	5	Love it!	1970-01-01	28
1388	232	1499	5	Highly recommend	1970-01-01	3
1389	440	566	5	Excellent product!	1970-01-01	30
1390	94	1129	2	Poor quality	1970-01-01	35
1394	445	1663	3	It's okay	1970-01-01	15
1396	450	924	5	Love it!	1970-01-01	16
1397	458	1656	4	Would buy again	1970-01-01	31
1398	128	836	2	Issues with product	1970-01-01	49
1399	13	754	4	Very good	1970-01-01	45
1400	190	2342	4	Good quality	1970-01-01	45
1401	421	378	3	Could be better	1970-01-01	14
1402	117	1824	2	Below expectations	1970-01-01	47
1403	44	2472	3	Could be better	1970-01-01	12
1405	412	744	4	Nice product	1970-01-01	4
1407	159	466	5	Highly recommend	1970-01-01	1
1408	252	96	5	Amazing value	1970-01-01	24
1409	39	1902	5	Love it!	1970-01-01	27
1410	198	2361	4	Would buy again	1970-01-01	0
1411	40	889	3	Decent product	1970-01-01	25
1412	230	773	5	Highly recommend	1970-01-01	43
1413	31	1653	4	Satisfied with purchase	1970-01-01	15
1416	455	237	5	Amazing value	1970-01-01	4
1417	265	1895	3	It's okay	1970-01-01	26
1418	187	536	3	Average quality	1970-01-01	19
1420	230	773	4	Nice product	1970-01-01	31
1421	278	1766	3	Decent product	1970-01-01	33
1422	119	976	4	Nice product	1970-01-01	41
1425	251	1234	5	Amazing value	1970-01-01	11
1426	448	1041	2	Disappointing	1970-01-01	34
1427	192	946	5	Love it!	1970-01-01	23
1428	187	1302	4	Good quality	1970-01-01	17
1429	198	2445	4	Very good	1970-01-01	39
1430	99	675	5	Amazing value	1970-01-01	50
1431	33	1761	1	Waste of money	1970-01-01	19
1434	152	1323	4	Satisfied with purchase	1970-01-01	48
1435	322	1653	3	Could be better	1970-01-01	35
1436	488	728	5	Amazing value	1970-01-01	31
1437	326	1740	3	Decent product	1970-01-01	40
1440	18	677	3	Average quality	1970-01-01	1
1441	175	1138	1	Waste of money	1970-01-01	16
1442	468	1418	4	Nice product	1970-01-01	26
1443	47	2035	4	Good quality	1970-01-01	27
1445	78	1461	3	It's okay	1970-01-01	2
1447	147	1218	4	Very good	1970-01-01	21
1448	425	336	3	Average quality	1970-01-01	28
1450	203	543	4	Very good	1970-01-01	16
1451	181	2355	4	Good quality	1970-01-01	32
1452	452	975	2	Disappointing	1970-01-01	5
1453	145	1455	4	Satisfied with purchase	1970-01-01	7
1455	491	2029	5	Excellent product!	1970-01-01	34
1456	493	2064	4	Very good	1970-01-01	24
1457	65	14	5	Love it!	1970-01-01	24
1459	387	860	4	Very good	1970-01-01	21
1460	336	1718	3	Does the job	1970-01-01	22
1461	183	2293	5	Love it!	1970-01-01	25
1462	386	1627	4	Satisfied with purchase	1970-01-01	32
1465	247	1102	2	Disappointing	1970-01-01	1
1468	345	2459	3	Does the job	1970-01-01	43
1469	191	737	3	Does the job	1970-01-01	36
1470	92	1646	4	Would buy again	1970-01-01	27
1471	362	915	1	Waste of money	1970-01-01	5
1473	463	638	3	Average quality	1970-01-01	33
1474	412	744	4	Nice product	1970-01-01	17
1475	52	2316	4	Very good	1970-01-01	46
1476	244	1829	5	Highly recommend	1970-01-01	13
1477	325	2215	4	Nice product	1970-01-01	34
1480	167	88	4	Good quality	1970-01-01	49
1482	437	43	4	Good quality	1970-01-01	34
1483	54	1560	2	Poor quality	1970-01-01	44
1484	341	89	5	Excellent product!	1970-01-01	17
1486	362	1148	5	Perfect quality	1970-01-01	17
1487	179	2482	3	Could be better	1970-01-01	29
1488	269	1804	1	Do not buy	1970-01-01	31
1489	35	1857	5	Perfect quality	1970-01-01	42
1490	327	749	4	Very good	1970-01-01	11
1492	147	554	4	Would buy again	1970-01-01	36
1494	411	493	5	Highly recommend	1970-01-01	44
1496	96	736	4	Good quality	1970-01-01	27
1497	431	1498	2	Disappointing	1970-01-01	32
1500	459	549	5	Excellent product!	1970-01-01	28
1501	41	404	3	Does the job	1970-01-01	37
1502	30	777	4	Good quality	1970-01-01	48
1503	412	380	3	Average quality	1970-01-01	20
1504	247	2466	4	Would buy again	1970-01-01	13
1505	133	355	4	Satisfied with purchase	1970-01-01	17
1506	467	899	5	Amazing value	1970-01-01	31
1507	180	305	5	Excellent product!	1970-01-01	5
1508	97	1431	4	Would buy again	1970-01-01	6
1509	310	2394	2	Issues with product	1970-01-01	40
1510	234	1823	4	Would buy again	1970-01-01	4
1511	94	1905	5	Love it!	1970-01-01	17
1513	345	2459	5	Amazing value	1970-01-01	35
1514	88	1800	3	Does the job	1970-01-01	40
1516	277	580	4	Satisfied with purchase	1970-01-01	34
1517	446	1151	3	Average quality	1970-01-01	10
1518	56	797	4	Would buy again	1970-01-01	22
1519	454	937	5	Highly recommend	1970-01-01	35
1520	392	1891	2	Poor quality	1970-01-01	8
1521	454	1427	4	Good quality	1970-01-01	17
1522	181	939	4	Would buy again	1970-01-01	5
1527	183	1641	5	Highly recommend	1970-01-01	43
1529	250	179	5	Amazing value	1970-01-01	4
1531	331	2432	4	Very good	1970-01-01	7
1532	165	1478	2	Below expectations	1970-01-01	16
1533	34	1820	4	Very good	1970-01-01	37
1535	414	440	5	Love it!	1970-01-01	48
1536	301	506	4	Good quality	1970-01-01	19
1538	140	2449	3	Does the job	1970-01-01	31
1539	2	374	3	Decent product	1970-01-01	34
1541	467	1634	3	Could be better	1970-01-01	35
1542	80	1273	4	Would buy again	1970-01-01	0
1544	226	1097	4	Good quality	1970-01-01	11
1546	98	141	5	Amazing value	1970-01-01	1
1547	104	1346	4	Satisfied with purchase	1970-01-01	10
1548	168	1377	4	Nice product	1970-01-01	3
1549	128	759	4	Would buy again	1970-01-01	46
1551	309	806	1	Completely unsatisfied	1970-01-01	23
1552	177	1318	5	Love it!	1970-01-01	13
1553	191	2186	5	Perfect quality	1970-01-01	4
1554	33	1091	4	Would buy again	1970-01-01	42
1555	142	2406	4	Very good	1970-01-01	45
1559	456	1669	5	Highly recommend	1970-01-01	48
1562	129	606	5	Excellent product!	1970-01-01	2
1564	11	2121	5	Highly recommend	1970-01-01	49
1567	354	724	3	It's okay	1970-01-01	50
1568	462	468	5	Excellent product!	1970-01-01	32
1569	358	1035	3	Decent product	1970-01-01	38
1571	189	1611	3	Could be better	1970-01-01	46
1572	124	1893	3	Could be better	1970-01-01	26
1573	101	1661	5	Love it!	1970-01-01	26
1574	473	1326	3	Could be better	1970-01-01	18
1576	484	1422	4	Would buy again	1970-01-01	27
1578	439	881	2	Issues with product	1970-01-01	10
1580	274	2198	4	Would buy again	1970-01-01	17
1581	308	1790	4	Nice product	1970-01-01	0
1585	104	21	5	Excellent product!	1970-01-01	19
1586	43	1042	3	Average quality	1970-01-01	9
1588	90	65	2	Below expectations	1970-01-01	25
1589	456	840	4	Satisfied with purchase	1970-01-01	13
1591	463	2156	3	Does the job	1970-01-01	14
1592	327	1780	3	Decent product	1970-01-01	45
1593	336	2471	5	Highly recommend	1970-01-01	49
1594	92	1779	5	Excellent product!	1970-01-01	24
1595	174	1945	3	It's okay	1970-01-01	32
1596	299	2089	3	Average quality	1970-01-01	29
1597	288	2075	4	Would buy again	1970-01-01	7
1598	17	1621	2	Issues with product	1970-01-01	30
1599	392	1891	5	Amazing value	1970-01-01	1
1600	230	1564	2	Disappointing	1970-01-01	13
1601	44	1548	4	Would buy again	1970-01-01	13
1602	130	741	3	Could be better	1970-01-01	14
1603	431	494	3	Does the job	1970-01-01	9
1605	436	864	3	Decent product	1970-01-01	29
1606	466	1422	2	Poor quality	1970-01-01	43
1607	493	2091	3	Does the job	1970-01-01	37
1608	389	1744	3	It's okay	1970-01-01	14
1609	335	69	5	Excellent product!	1970-01-01	34
1610	473	1992	4	Good quality	1970-01-01	41
1611	366	824	3	It's okay	1970-01-01	47
1612	40	525	4	Good quality	1970-01-01	12
1613	231	727	3	Average quality	1970-01-01	7
1615	386	2013	4	Nice product	1970-01-01	32
1617	144	158	3	Does the job	1970-01-01	25
1618	363	2473	4	Very good	1970-01-01	23
1620	1	701	4	Nice product	1970-01-01	0
1621	463	246	3	Average quality	1970-01-01	6
1623	24	570	4	Would buy again	1970-01-01	36
1624	443	889	4	Nice product	1970-01-01	41
1625	428	1214	4	Good quality	1970-01-01	45
1627	34	1091	4	Good quality	1970-01-01	44
1628	382	260	2	Disappointing	1970-01-01	42
1629	377	819	4	Satisfied with purchase	1970-01-01	39
1630	346	1123	4	Would buy again	1970-01-01	1
1631	418	551	3	Average quality	1970-01-01	28
1633	40	1851	4	Nice product	1970-01-01	16
1634	30	1078	5	Love it!	1970-01-01	35
1636	35	1857	3	Decent product	1970-01-01	14
1638	85	153	4	Nice product	1970-01-01	38
1639	313	2283	4	Nice product	1970-01-01	13
1640	491	1745	4	Very good	1970-01-01	23
1641	40	1698	1	Waste of money	1970-01-01	38
1642	76	188	4	Nice product	1970-01-01	43
1646	87	11	1	Do not buy	1970-01-01	47
1648	360	1353	4	Would buy again	1970-01-01	42
1649	500	947	5	Highly recommend	1970-01-01	29
1650	356	468	3	Does the job	1970-01-01	26
1651	462	1821	4	Good quality	1970-01-01	36
1652	245	1546	4	Nice product	1970-01-01	15
1653	76	1909	2	Issues with product	1970-01-01	46
1654	35	1857	4	Very good	1970-01-01	33
1655	120	1140	3	Does the job	1970-01-01	30
1656	37	390	4	Satisfied with purchase	1970-01-01	20
1657	373	1126	4	Would buy again	1970-01-01	43
1658	80	729	4	Satisfied with purchase	1970-01-01	43
1659	130	1309	5	Love it!	1970-01-01	38
1660	305	567	3	Does the job	1970-01-01	38
1662	319	1927	3	Average quality	1970-01-01	36
1663	137	1151	3	Does the job	1970-01-01	23
1664	260	1450	4	Good quality	1970-01-01	4
1665	173	655	4	Nice product	1970-01-01	13
1666	319	100	1	Waste of money	1970-01-01	5
1667	269	2107	1	Waste of money	1970-01-01	29
1668	488	1975	5	Highly recommend	1970-01-01	24
1673	66	667	5	Love it!	1970-01-01	46
1675	381	252	3	Decent product	1970-01-01	17
1676	9	1736	4	Nice product	1970-01-01	27
1677	119	1184	4	Very good	1970-01-01	6
1678	116	508	4	Very good	1970-01-01	0
1682	477	750	3	Could be better	1970-01-01	49
1683	243	740	4	Nice product	1970-01-01	44
1688	461	246	4	Nice product	1970-01-01	31
1690	94	1563	2	Below expectations	1970-01-01	49
1692	174	1094	2	Disappointing	1970-01-01	48
1693	356	759	4	Satisfied with purchase	1970-01-01	17
1696	173	655	4	Satisfied with purchase	1970-01-01	28
1697	9	1267	5	Excellent product!	1970-01-01	49
1700	488	930	5	Excellent product!	1970-01-01	21
1701	262	626	4	Good quality	1970-01-01	5
1703	380	842	4	Would buy again	1970-01-01	19
1705	101	1661	5	Highly recommend	1970-01-01	37
1707	13	78	5	Perfect quality	1970-01-01	16
1708	10	9	4	Nice product	1970-01-01	25
1710	264	2054	1	Waste of money	1970-01-01	20
1712	62	2321	2	Poor quality	1970-01-01	32
1714	489	319	5	Amazing value	1970-01-01	43
1715	436	864	4	Would buy again	1970-01-01	38
1717	71	1558	5	Love it!	1970-01-01	14
1718	455	1614	3	Average quality	1970-01-01	16
1721	315	1561	5	Love it!	1970-01-01	6
1722	84	1226	4	Would buy again	1970-01-01	15
1725	118	456	4	Good quality	1970-01-01	27
1726	135	1591	1	Very poor quality	1970-01-01	3
1729	493	2091	3	Could be better	1970-01-01	37
1730	84	1463	2	Not great	1970-01-01	5
1731	333	810	3	It's okay	1970-01-01	21
1734	157	599	5	Amazing value	1970-01-01	26
1736	21	1689	5	Excellent product!	1970-01-01	36
1737	366	623	5	Excellent product!	1970-01-01	50
1739	138	1035	5	Excellent product!	1970-01-01	33
1740	337	1420	4	Satisfied with purchase	1970-01-01	23
1741	115	334	2	Issues with product	1970-01-01	45
1742	427	2063	5	Highly recommend	1970-01-01	6
1743	455	1334	5	Amazing value	1970-01-01	20
1747	304	1213	3	Could be better	1970-01-01	50
1748	338	709	4	Very good	1970-01-01	1
1749	274	320	2	Disappointing	1970-01-01	22
1751	313	401	5	Amazing value	1970-01-01	24
1753	448	111	4	Nice product	1970-01-01	12
1754	272	2497	5	Perfect quality	1970-01-01	22
1756	367	1998	3	Decent product	1970-01-01	42
1757	337	1397	5	Amazing value	1970-01-01	36
1759	119	1184	4	Would buy again	1970-01-01	32
1760	39	972	4	Would buy again	1970-01-01	30
1761	8	1751	1	Terrible	1970-01-01	19
1762	457	938	4	Satisfied with purchase	1970-01-01	13
1763	115	1676	5	Amazing value	1970-01-01	45
1764	282	1575	5	Perfect quality	1970-01-01	31
1765	222	375	5	Excellent product!	1970-01-01	27
1766	242	795	2	Issues with product	1970-01-01	13
1767	457	850	5	Excellent product!	1970-01-01	12
1769	456	1669	1	Very poor quality	1970-01-01	42
1770	397	867	2	Poor quality	1970-01-01	43
1771	326	1740	2	Below expectations	1970-01-01	23
1772	489	600	4	Good quality	1970-01-01	9
1773	28	1970	5	Perfect quality	1970-01-01	0
1775	240	1768	4	Very good	1970-01-01	44
1776	331	46	5	Love it!	1970-01-01	26
1777	378	837	5	Love it!	1970-01-01	2
1779	491	1745	5	Perfect quality	1970-01-01	27
1780	355	742	3	It's okay	1970-01-01	7
1781	312	158	2	Below expectations	1970-01-01	41
1782	234	8	2	Not great	1970-01-01	7
1783	8	1751	4	Satisfied with purchase	1970-01-01	42
1785	269	1804	5	Love it!	1970-01-01	43
1786	241	814	4	Nice product	1970-01-01	14
1791	251	1234	5	Love it!	1970-01-01	50
1792	482	905	3	Does the job	1970-01-01	27
1793	462	917	4	Nice product	1970-01-01	38
1796	242	590	4	Would buy again	1970-01-01	35
1797	389	1895	1	Very poor quality	1970-01-01	1
1799	297	1915	3	It's okay	1970-01-01	9
\.


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (supplier_id, supplier_name, contact_person_id, rating, address, city) FROM stdin;
1	TechSource Inc	1	4.5	123 Tech Ave	San Francisco
2	Fashion Forward Ltd	2	4.2	456 Style St	New York
3	Home Essentials Co	3	4.7	789 Garden Rd	Chicago
4	Sports Gear Direct	4	4.3	321 Athletic Way	Denver
5	Global Books Publishing	5	4.6	654 Literature Lane	Boston
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);


--
-- Name: contact_person_contact_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_person_contact_person_id_seq', 5, true);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, false);


--
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 1, false);


--
-- Name: inventory_movements_movement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventory_movements_movement_id_seq', 1, false);


--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 1, false);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_product_id_seq', 1, false);


--
-- Name: promotions_promotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promotions_promotion_id_seq', 1, false);


--
-- Name: review_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.review_review_id_seq', 1, false);


--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_supplier_id_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city);


--
-- Name: contact_person contact_person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_person
    ADD CONSTRAINT contact_person_pkey PRIMARY KEY (contact_person_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: inventory_movements inventory_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_movements
    ADD CONSTRAINT inventory_movements_pkey PRIMARY KEY (movement_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: product_suppliers product_suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_suppliers
    ADD CONSTRAINT product_suppliers_pkey PRIMARY KEY (product_id, supplier_id);


--
-- Name: promotions promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_pkey PRIMARY KEY (promotion_id);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supplier_id);


--
-- Name: customer customer_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_city_fkey FOREIGN KEY (city) REFERENCES public.city(city);


--
-- Name: supplier fk_contact_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT fk_contact_person FOREIGN KEY (contact_person_id) REFERENCES public.contact_person(contact_person_id) ON DELETE CASCADE;


--
-- Name: employee fk_employee_manager; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES public.employee(employee_id) ON DELETE SET NULL;


--
-- Name: inventory_movements fk_inventory_movements_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_movements
    ADD CONSTRAINT fk_inventory_movements_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: order_items fk_order_items_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: orders fk_orders_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON DELETE CASCADE;


--
-- Name: product fk_product_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE SET NULL;


--
-- Name: product_suppliers fk_product_suppliers_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_suppliers
    ADD CONSTRAINT fk_product_suppliers_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: product_suppliers fk_product_suppliers_supplier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_suppliers
    ADD CONSTRAINT fk_product_suppliers_supplier FOREIGN KEY (supplier_id) REFERENCES public.supplier(supplier_id) ON DELETE CASCADE;


--
-- Name: review fk_review_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_order FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: review fk_review_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_product FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON DELETE CASCADE;


--
-- Name: orders orders_promotion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_promotion_id_fkey FOREIGN KEY (promotion_id) REFERENCES public.promotions(promotion_id);


--
-- Name: orders orders_ship_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_ship_city_fkey FOREIGN KEY (ship_city) REFERENCES public.city(city);


--
-- Name: supplier supplier_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_city_fkey FOREIGN KEY (city) REFERENCES public.city(city);


--
-- PostgreSQL database dump complete
--

