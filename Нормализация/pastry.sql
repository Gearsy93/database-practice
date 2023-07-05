--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

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

ALTER TABLE IF EXISTS ONLY public.supplier DROP CONSTRAINT IF EXISTS supplier_sex_sex_id_fk;
ALTER TABLE IF EXISTS ONLY public.procurement DROP CONSTRAINT IF EXISTS procurement_supplier_supplier_id_fk;
ALTER TABLE IF EXISTS ONLY public."order" DROP CONSTRAINT IF EXISTS order_procurement_procurement_id_fk;
ALTER TABLE IF EXISTS ONLY public."order" DROP CONSTRAINT IF EXISTS order_meal_meal_id_fk;
ALTER TABLE IF EXISTS ONLY public."order" DROP CONSTRAINT IF EXISTS order_ingredient_ingredient_id_fk;
ALTER TABLE IF EXISTS ONLY public.meal_price DROP CONSTRAINT IF EXISTS meal_price_meal_meal_id_fk;
ALTER TABLE IF EXISTS ONLY public.meal_count DROP CONSTRAINT IF EXISTS meal_count_order_order_id_fk;
ALTER TABLE IF EXISTS ONLY public.meal_count DROP CONSTRAINT IF EXISTS meal_count_meal_meal_id_fk;
ALTER TABLE IF EXISTS ONLY public.ingredient_meal_count DROP CONSTRAINT IF EXISTS ingredient_meal_count_meal_meal_id_fk;
ALTER TABLE IF EXISTS ONLY public.ingredient_meal_count DROP CONSTRAINT IF EXISTS ingredient_meal_count_ingredient_ingredient_id_fk;
ALTER TABLE IF EXISTS ONLY public.cheque DROP CONSTRAINT IF EXISTS cheque_manager_manager_id_fk;
ALTER TABLE IF EXISTS ONLY public.cheque DROP CONSTRAINT IF EXISTS cheque_delivery_address_delivery_address_id_fk;
ALTER TABLE IF EXISTS ONLY public.cheque DROP CONSTRAINT IF EXISTS cheque_customer_customer_id_fk;
DROP INDEX IF EXISTS public.supplier_supplier_id_uindex;
DROP INDEX IF EXISTS public."sex_sex id_uindex";
DROP INDEX IF EXISTS public.procurement_procurement_id_uindex;
DROP INDEX IF EXISTS public.order_order_id_uindex;
DROP INDEX IF EXISTS public.meal_meal_id_uindex;
DROP INDEX IF EXISTS public.manager_manager_id_uindex;
DROP INDEX IF EXISTS public.ingredient_ingredient_id_uindex;
DROP INDEX IF EXISTS public.delivery_address_delivery_address_id_uindex;
DROP INDEX IF EXISTS public.customer_customer_id_uindex;
ALTER TABLE IF EXISTS ONLY public.supplier DROP CONSTRAINT IF EXISTS supplier_pk;
ALTER TABLE IF EXISTS ONLY public.sex DROP CONSTRAINT IF EXISTS sex_pk;
ALTER TABLE IF EXISTS ONLY public.procurement DROP CONSTRAINT IF EXISTS procurement_pk;
ALTER TABLE IF EXISTS ONLY public."order" DROP CONSTRAINT IF EXISTS order_pk;
ALTER TABLE IF EXISTS ONLY public.meal DROP CONSTRAINT IF EXISTS meal_pk;
ALTER TABLE IF EXISTS ONLY public.manager DROP CONSTRAINT IF EXISTS manager_pk;
ALTER TABLE IF EXISTS ONLY public.ingredient DROP CONSTRAINT IF EXISTS ingredient_pk;
ALTER TABLE IF EXISTS ONLY public.delivery_address DROP CONSTRAINT IF EXISTS delivery_address_pk;
ALTER TABLE IF EXISTS ONLY public.customer DROP CONSTRAINT IF EXISTS customer_pk;
ALTER TABLE IF EXISTS public.supplier ALTER COLUMN supplier_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sex ALTER COLUMN sex_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.procurement ALTER COLUMN procurement_id DROP DEFAULT;
ALTER TABLE IF EXISTS public."order" ALTER COLUMN order_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.meal ALTER COLUMN meal_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.manager ALTER COLUMN manager_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ingredient ALTER COLUMN ingredient_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.delivery_address ALTER COLUMN delivery_address_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customer ALTER COLUMN customer_id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.supplier_supplier_id_seq;
DROP TABLE IF EXISTS public.supplier;
DROP SEQUENCE IF EXISTS public.sex_sex_id_seq;
DROP TABLE IF EXISTS public.sex;
DROP SEQUENCE IF EXISTS public.procurement_procurement_id_seq;
DROP TABLE IF EXISTS public.procurement;
DROP SEQUENCE IF EXISTS public.order_order_id_seq;
DROP TABLE IF EXISTS public."order";
DROP TABLE IF EXISTS public.meal_price;
DROP SEQUENCE IF EXISTS public.meal_meal_id_seq;
DROP TABLE IF EXISTS public.meal_count;
DROP TABLE IF EXISTS public.meal;
DROP SEQUENCE IF EXISTS public.manager_manager_id_seq;
DROP TABLE IF EXISTS public.manager;
DROP TABLE IF EXISTS public.ingredient_meal_count;
DROP SEQUENCE IF EXISTS public.ingredient_ingredient_id_seq;
DROP TABLE IF EXISTS public.ingredient;
DROP SEQUENCE IF EXISTS public.delivery_address_delivery_address_id_seq;
DROP TABLE IF EXISTS public.delivery_address;
DROP SEQUENCE IF EXISTS public.customer_customer_id_seq;
DROP TABLE IF EXISTS public.customer;
DROP SEQUENCE IF EXISTS public.cheque_order_id_seq;
DROP TABLE IF EXISTS public.cheque;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cheque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cheque (
    order_id integer NOT NULL,
    order_number integer NOT NULL,
    manager_id integer NOT NULL,
    customer_id integer NOT NULL,
    delivery_address_id integer NOT NULL
);


ALTER TABLE public.cheque OWNER TO postgres;

--
-- Name: cheque_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cheque_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cheque_order_id_seq OWNER TO postgres;

--
-- Name: cheque_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cheque_order_id_seq OWNED BY public.cheque.order_id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    phone bigint NOT NULL,
    sex_id smallint NOT NULL,
    customer character varying(50)
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customer_id_seq OWNER TO postgres;

--
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- Name: delivery_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_address (
    delivery_address_id integer NOT NULL,
    city character varying(20) NOT NULL,
    address character varying(50) NOT NULL,
    index integer NOT NULL
);


ALTER TABLE public.delivery_address OWNER TO postgres;

--
-- Name: delivery_address_delivery_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delivery_address_delivery_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delivery_address_delivery_address_id_seq OWNER TO postgres;

--
-- Name: delivery_address_delivery_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delivery_address_delivery_address_id_seq OWNED BY public.delivery_address.delivery_address_id;


--
-- Name: ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient (
    ingredient_id integer NOT NULL,
    ingredient character varying(20) NOT NULL,
    country_origin character varying(20) NOT NULL,
    measurement character varying(20) NOT NULL,
    weight real NOT NULL
);


ALTER TABLE public.ingredient OWNER TO postgres;

--
-- Name: ingredient_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingredient_ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredient_ingredient_id_seq OWNER TO postgres;

--
-- Name: ingredient_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingredient_ingredient_id_seq OWNED BY public.ingredient.ingredient_id;


--
-- Name: ingredient_meal_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient_meal_count (
    meal_id integer NOT NULL,
    ingredient_id integer NOT NULL,
    ingredient_meal_count integer NOT NULL
);


ALTER TABLE public.ingredient_meal_count OWNER TO postgres;

--
-- Name: manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager (
    manager_id integer NOT NULL,
    manager character varying(50) NOT NULL,
    phone bigint NOT NULL,
    sex_id smallint NOT NULL
);


ALTER TABLE public.manager OWNER TO postgres;

--
-- Name: manager_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manager_manager_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manager_manager_id_seq OWNER TO postgres;

--
-- Name: manager_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manager_manager_id_seq OWNED BY public.manager.manager_id;


--
-- Name: meal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meal (
    meal_id integer NOT NULL,
    meal character varying(20) NOT NULL,
    weight real NOT NULL,
    calories real NOT NULL
);


ALTER TABLE public.meal OWNER TO postgres;

--
-- Name: meal_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meal_count (
    order_id integer NOT NULL,
    meal_id integer NOT NULL,
    meal_count integer NOT NULL
);


ALTER TABLE public.meal_count OWNER TO postgres;

--
-- Name: meal_meal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meal_meal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meal_meal_id_seq OWNER TO postgres;

--
-- Name: meal_meal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meal_meal_id_seq OWNED BY public.meal.meal_id;


--
-- Name: meal_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meal_price (
    meal_id integer NOT NULL,
    order_date date NOT NULL,
    meal_price real NOT NULL
);


ALTER TABLE public.meal_price OWNER TO postgres;

--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    order_id integer NOT NULL,
    procurement_id integer NOT NULL,
    meal_id integer NOT NULL,
    ingredient_id integer NOT NULL,
    order_date date DEFAULT now() NOT NULL
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_order_id_seq OWNER TO postgres;

--
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_order_id_seq OWNED BY public."order".order_id;


--
-- Name: procurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procurement (
    procurement_id integer NOT NULL,
    date date DEFAULT now() NOT NULL,
    supplier_id integer NOT NULL
);


ALTER TABLE public.procurement OWNER TO postgres;

--
-- Name: procurement_procurement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procurement_procurement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procurement_procurement_id_seq OWNER TO postgres;

--
-- Name: procurement_procurement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procurement_procurement_id_seq OWNED BY public.procurement.procurement_id;


--
-- Name: sex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sex (
    sex_id smallint NOT NULL,
    sex character varying(1) NOT NULL
);


ALTER TABLE public.sex OWNER TO postgres;

--
-- Name: sex_sex_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sex_sex_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sex_sex_id_seq OWNER TO postgres;

--
-- Name: sex_sex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sex_sex_id_seq OWNED BY public.sex.sex_id;


--
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    supplier_id integer NOT NULL,
    supplier character varying(50) NOT NULL,
    phone bigint NOT NULL,
    sex_id smallint NOT NULL
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supplier_supplier_id_seq OWNER TO postgres;

--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_supplier_id_seq OWNED BY public.supplier.supplier_id;


--
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- Name: delivery_address delivery_address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_address ALTER COLUMN delivery_address_id SET DEFAULT nextval('public.delivery_address_delivery_address_id_seq'::regclass);


--
-- Name: ingredient ingredient_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient ALTER COLUMN ingredient_id SET DEFAULT nextval('public.ingredient_ingredient_id_seq'::regclass);


--
-- Name: manager manager_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager ALTER COLUMN manager_id SET DEFAULT nextval('public.manager_manager_id_seq'::regclass);


--
-- Name: meal meal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal ALTER COLUMN meal_id SET DEFAULT nextval('public.meal_meal_id_seq'::regclass);


--
-- Name: order order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN order_id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- Name: procurement procurement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurement ALTER COLUMN procurement_id SET DEFAULT nextval('public.procurement_procurement_id_seq'::regclass);


--
-- Name: sex sex_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sex ALTER COLUMN sex_id SET DEFAULT nextval('public.sex_sex_id_seq'::regclass);


--
-- Name: supplier supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN supplier_id SET DEFAULT nextval('public.supplier_supplier_id_seq'::regclass);


--
-- Data for Name: cheque; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (1, 1, 5, 9, 9);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (2, 2, 8, 5, 5);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (3, 3, 3, 7, 8);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (4, 4, 8, 1, 2);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (5, 5, 10, 4, 5);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (6, 6, 6, 10, 9);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (7, 7, 2, 4, 9);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (8, 8, 2, 8, 4);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (9, 9, 4, 2, 1);
INSERT INTO public.cheque (order_id, order_number, manager_id, customer_id, delivery_address_id) VALUES (10, 10, 9, 6, 2);


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (1, 85733304197, 2, 'Быков Владимир Георгиевич');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (2, 85791148371, 1, 'Осипова Сафия Романовна');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (3, 80746006551, 1, 'Морозова Надежда Андреевна');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (4, 87571813573, 2, 'Федосеев Григорий Максимович');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (5, 80558668406, 2, 'Никифоров Кирилл Иванович');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (6, 81967095703, 2, 'Кузьмин Кирилл Иванович');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (7, 84971952738, 2, 'Шаповалов Герман Михайлович');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (8, 80180807023, 2, 'Шаповалов Герман Михайлович');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (9, 84971952738, 2, 'Гусев Лев Максимович');
INSERT INTO public.customer (customer_id, phone, sex_id, customer) VALUES (10, 86607554636, 2, 'Никулин Артём Родионович');


--
-- Data for Name: delivery_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (1, 'Стерлитамак', 'Минская ул., д. 7 кв.208', 170325);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (2, 'Якутск', 'Мичурина ул., д. 15 кв.141', 801009);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (3, 'Курск', 'Гагарина ул., д. 14 кв.97', 408402);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (4, 'Ростов-на-Дону', 'Луговой пер., д. 15 кв.20', 582099);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (5, 'Камышин', 'Интернациональная ул., д. 13 кв.209', 736603);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (6, 'Ульяновск', 'Южная ул., д. 6 кв.152', 548967);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (7, 'Нальчик', 'Луговой пер., д. 18 кв.61', 248736);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (8, 'Магнитогорск', 'Строителей ул., д. 16 кв.75', 809277);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (9, 'Чита', 'Советский пер., д. 12 кв.207', 467343);
INSERT INTO public.delivery_address (delivery_address_id, city, address, index) VALUES (10, 'Электросталь', 'Космонавтов ул., д. 7 кв.162', 231734);


--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (1, 'Молоко', 'Россия', 'гр', 1000);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (2, 'Яйца', 'Россия', 'гр', 70);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (3, 'Мука', 'Россия', 'гр', 2000);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (4, 'Сливочное_масло', 'Россия', 'гр', 180);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (5, 'Ваниль', 'Мексика', 'гр', 6);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (6, 'Шоколад', 'Швейцария', 'гр', 100);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (7, 'Сахар', 'Россия', 'гр', 2000);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (8, 'Сливки', 'Россия', 'гр', 1000);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (9, 'Какао-порошок', 'Нигерия', 'гр', 100);
INSERT INTO public.ingredient (ingredient_id, ingredient, country_origin, measurement, weight) VALUES (10, 'Соль', 'Россия', 'гр', 500);


--
-- Data for Name: ingredient_meal_count; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (1, 1, 2);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (1, 6, 1);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (1, 7, 2);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (2, 2, 2);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (3, 3, 3);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (3, 7, 1);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (4, 9, 5);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (4, 5, 2);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (5, 4, 3);
INSERT INTO public.ingredient_meal_count (meal_id, ingredient_id, ingredient_meal_count) VALUES (7, 3, 1);


--
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (1, 'Смирнова Элина Ивановна', 89921407640, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (2, 'Гаврилова Ева Петровна', 81156063448, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (3, 'Пирогова Маргарита Дмитриевна', 88177634696, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (4, 'Иванова Елизавета Александровна', 88014685647, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (5, 'Сухова Анна Степановна', 86613901336, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (6, 'Шевелева Дарья Данииловна', 83443999171, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (7, 'Зуева Анна Андреевна', 83967638220, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (8, 'Григорьев Кирилл Денисович', 89557903853, 2);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (9, 'Иванова Елизавета Александровна', 88930192674, 1);
INSERT INTO public.manager (manager_id, manager, phone, sex_id) VALUES (10, 'Шевелева Дарья Данииловна', 89989687753, 1);


--
-- Data for Name: meal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (6, 'Корзиночка', 60, 372);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (9, 'Красный_бархат', 2000, 358.3);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (3, 'Макаруны', 18, 126);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (5, 'Печенье', 150, 385.6);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (10, 'Трубочка', 50, 273);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (7, 'Картошка', 140, 441);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (4, 'Швейцарский_ролл', 350, 81);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (1, 'Раф', 300, 3);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (2, 'Прага', 380, 408);
INSERT INTO public.meal (meal_id, meal, weight, calories) VALUES (8, 'Буше', 70, 534);


--
-- Data for Name: meal_count; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (1, 3, 2);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (2, 2, 3);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (3, 6, 5);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (4, 3, 2);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (5, 7, 1);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (6, 8, 1);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (7, 9, 1);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (8, 9, 3);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (9, 3, 4);
INSERT INTO public.meal_count (order_id, meal_id, meal_count) VALUES (10, 10, 2);


--
-- Data for Name: meal_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (1, '2021-12-07', 300);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (1, '2021-12-07', 400);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (3, '2021-12-07', 700);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (4, '2021-12-07', 200);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (5, '2021-12-07', 500);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (6, '2021-12-07', 1000);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (7, '2021-12-07', 1500);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (8, '2021-12-07', 660);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (9, '2021-12-07', 320);
INSERT INTO public.meal_price (meal_id, order_date, meal_price) VALUES (10, '2021-12-07', 900);


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (1, 1, 2, 7, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (2, 1, 1, 2, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (3, 1, 4, 5, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (4, 2, 4, 7, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (5, 3, 5, 10, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (6, 4, 6, 2, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (7, 4, 4, 7, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (8, 7, 7, 7, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (9, 9, 7, 5, '2021-12-07');
INSERT INTO public."order" (order_id, procurement_id, meal_id, ingredient_id, order_date) VALUES (10, 9, 10, 2, '2021-12-07');


--
-- Data for Name: procurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (1, '2021-12-07', 4);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (2, '2021-12-07', 5);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (3, '2021-12-07', 8);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (4, '2021-12-07', 1);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (5, '2021-12-07', 2);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (6, '2021-12-07', 2);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (7, '2021-12-07', 3);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (8, '2021-12-07', 10);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (9, '2021-12-07', 9);
INSERT INTO public.procurement (procurement_id, date, supplier_id) VALUES (10, '2021-12-07', 2);


--
-- Data for Name: sex; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sex (sex_id, sex) VALUES (1, 'Ж');
INSERT INTO public.sex (sex_id, sex) VALUES (2, 'М');


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (1, 'Кузнецов Никита Дмит', 89247715165, 2);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (2, 'Анисимов Марк Герман', 85395028239, 2);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (3, 'Кириллова Нина Влади', 81027626872, 1);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (4, 'Макарова Ева Георгие', 89572214026, 2);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (5, 'Харитонова Варвара Даниловна', 89588391789, 2);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (6, 'Попов Андрей Леонидович', 84908126328, 1);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (7, 'Сафонов Богдан Макарович', 80958026431, 2);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (8, 'Егорова Арина Кирилловна', 82468279049, 1);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (9, 'Антонова Мария Глебовна', 82886140397, 1);
INSERT INTO public.supplier (supplier_id, supplier, phone, sex_id) VALUES (10, 'Федосеева Екатерина Сергеевна', 88982814271, 1);


--
-- Name: cheque_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cheque_order_id_seq', 1, false);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, false);


--
-- Name: delivery_address_delivery_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.delivery_address_delivery_address_id_seq', 1, false);


--
-- Name: ingredient_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredient_ingredient_id_seq', 1, false);


--
-- Name: manager_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manager_manager_id_seq', 1, false);


--
-- Name: meal_meal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meal_meal_id_seq', 1, false);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_order_id_seq', 1, false);


--
-- Name: procurement_procurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.procurement_procurement_id_seq', 1, false);


--
-- Name: sex_sex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sex_sex_id_seq', 1, false);


--
-- Name: supplier_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_supplier_id_seq', 1, false);


--
-- Name: customer customer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pk PRIMARY KEY (customer_id);


--
-- Name: delivery_address delivery_address_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_address
    ADD CONSTRAINT delivery_address_pk PRIMARY KEY (delivery_address_id);


--
-- Name: ingredient ingredient_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pk PRIMARY KEY (ingredient_id);


--
-- Name: manager manager_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pk PRIMARY KEY (manager_id);


--
-- Name: meal meal_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal
    ADD CONSTRAINT meal_pk PRIMARY KEY (meal_id);


--
-- Name: order order_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pk PRIMARY KEY (order_id);


--
-- Name: procurement procurement_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurement
    ADD CONSTRAINT procurement_pk PRIMARY KEY (procurement_id);


--
-- Name: sex sex_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sex
    ADD CONSTRAINT sex_pk PRIMARY KEY (sex_id);


--
-- Name: supplier supplier_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pk PRIMARY KEY (supplier_id);


--
-- Name: customer_customer_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_customer_id_uindex ON public.customer USING btree (customer_id);


--
-- Name: delivery_address_delivery_address_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX delivery_address_delivery_address_id_uindex ON public.delivery_address USING btree (delivery_address_id);


--
-- Name: ingredient_ingredient_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ingredient_ingredient_id_uindex ON public.ingredient USING btree (ingredient_id);


--
-- Name: manager_manager_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX manager_manager_id_uindex ON public.manager USING btree (manager_id);


--
-- Name: meal_meal_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX meal_meal_id_uindex ON public.meal USING btree (meal_id);


--
-- Name: order_order_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX order_order_id_uindex ON public."order" USING btree (order_id);


--
-- Name: procurement_procurement_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX procurement_procurement_id_uindex ON public.procurement USING btree (procurement_id);


--
-- Name: sex_sex id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "sex_sex id_uindex" ON public.sex USING btree (sex_id);


--
-- Name: supplier_supplier_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX supplier_supplier_id_uindex ON public.supplier USING btree (supplier_id);


--
-- Name: cheque cheque_customer_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cheque
    ADD CONSTRAINT cheque_customer_customer_id_fk FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: cheque cheque_delivery_address_delivery_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cheque
    ADD CONSTRAINT cheque_delivery_address_delivery_address_id_fk FOREIGN KEY (delivery_address_id) REFERENCES public.delivery_address(delivery_address_id);


--
-- Name: cheque cheque_manager_manager_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cheque
    ADD CONSTRAINT cheque_manager_manager_id_fk FOREIGN KEY (manager_id) REFERENCES public.manager(manager_id);


--
-- Name: ingredient_meal_count ingredient_meal_count_ingredient_ingredient_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_meal_count
    ADD CONSTRAINT ingredient_meal_count_ingredient_ingredient_id_fk FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(ingredient_id);


--
-- Name: ingredient_meal_count ingredient_meal_count_meal_meal_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient_meal_count
    ADD CONSTRAINT ingredient_meal_count_meal_meal_id_fk FOREIGN KEY (meal_id) REFERENCES public.meal(meal_id);


--
-- Name: meal_count meal_count_meal_meal_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal_count
    ADD CONSTRAINT meal_count_meal_meal_id_fk FOREIGN KEY (meal_id) REFERENCES public.meal(meal_id);


--
-- Name: meal_count meal_count_order_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal_count
    ADD CONSTRAINT meal_count_order_order_id_fk FOREIGN KEY (order_id) REFERENCES public."order"(order_id);


--
-- Name: meal_price meal_price_meal_meal_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal_price
    ADD CONSTRAINT meal_price_meal_meal_id_fk FOREIGN KEY (meal_id) REFERENCES public.meal(meal_id);


--
-- Name: order order_ingredient_ingredient_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_ingredient_ingredient_id_fk FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(ingredient_id);


--
-- Name: order order_meal_meal_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_meal_meal_id_fk FOREIGN KEY (meal_id) REFERENCES public.meal(meal_id);


--
-- Name: order order_procurement_procurement_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_procurement_procurement_id_fk FOREIGN KEY (procurement_id) REFERENCES public.procurement(procurement_id);


--
-- Name: procurement procurement_supplier_supplier_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procurement
    ADD CONSTRAINT procurement_supplier_supplier_id_fk FOREIGN KEY (supplier_id) REFERENCES public.supplier(supplier_id);


--
-- Name: supplier supplier_sex_sex_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_sex_sex_id_fk FOREIGN KEY (sex_id) REFERENCES public.sex(sex_id);


--
-- PostgreSQL database dump complete
--

