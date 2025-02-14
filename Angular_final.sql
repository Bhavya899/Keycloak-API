toc.dat                                                                                             0000600 0004000 0002000 00000072700 14632771343 0014457 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                       |            postgres    16.2    16.2 Y    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    5    postgres    DATABASE     j   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE postgres;
                postgres    false         �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3718                     2615    16404 	   demo_test    SCHEMA        CREATE SCHEMA demo_test;
    DROP SCHEMA demo_test;
                postgres    false                     3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false         �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2                    1255    16448 r   log_detail(character varying, integer, integer, character varying, timestamp without time zone, character varying)    FUNCTION     �  CREATE FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO demo_test.log_detail_tbl(v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name)
    SELECT _proc_name, _row_deleted, _row_inserted, _tbl_name, _load_tms, _scm_name;
END;
$$;
 �   DROP FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying);
    	   demo_test          postgres    false    7                    1255    16449 {   log_detail(character varying, integer, integer, character varying, timestamp without time zone, character varying, integer)    FUNCTION        CREATE FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying, _ins_time integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO demo_test.log_detail_tbl(v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name,ins_time)
    SELECT _proc_name, _row_deleted, _row_inserted, _tbl_name, _load_tms, _scm_name,_ins_time;
END;
$$;
 �   DROP FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying, _ins_time integer);
    	   demo_test          postgres    false    7                    1255    16430    pr_movie_rating() 	   PROCEDURE     }  CREATE PROCEDURE demo_test.pr_movie_rating()
    LANGUAGE plpgsql
    AS $$
DECLARE

row_deleted int default 0;
row_inserted INT default 0;
v_load_tms TIMESTAMP;


BEGIN
 SELECT CURRENT_TIMESTAMP INTO v_load_tms;
DELETE FROM demo_test.fact_movies_rating;
GET DIAGNOSTICS row_deleted=ROW_COUNT;
RAISE NOTICE 'NO OF ROW Deleted %',row_deleted;


INSERT INTO demo_test.fact_movies_rating(movie_id, title, movie_type, user_id, rating, rating_date)

SELECT mov.movie_id,mov.title,mov.movie_type,
rat.user_id,rat.rating,rat.rating_date
FROM demo_test.movies mov
LEFT JOIN demo_test.ratings rat
ON mov.movie_id=rat.movie_id;





GET DIAGNOSTICS row_inserted =ROW_COUNT;
RAISE NOTICE 'NO OF ROW INSERTED %',row_inserted;


PERFORM demo_test.log_detail('pr_movie_rating',
							row_deleted,
							  row_inserted,
							  'Movie|Rating',
							  v_load_tms,
							  'demo_test'
							);
END;
$$;
 ,   DROP PROCEDURE demo_test.pr_movie_rating();
    	   demo_test          postgres    false    7                    1255    16576 W   add_employee(character varying, character varying, integer, integer, character varying)    FUNCTION     t  CREATE FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.employee_list (first_name, last_name, age, salary,email_id)
    VALUES (p_first_name, p_last_name, p_age, p_salary,p_email_id);
END;
$$;
 �   DROP FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying);
       public          postgres    false                    1255    16626 }   add_employee(character varying, character varying, integer, integer, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying, p_role_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.employee_list (first_name, last_name, age, salary,email_id,password,role_name)
    VALUES (p_first_name, p_last_name, p_age, p_salary,p_email_id,p_password,p_role_name);
END;
$$;
 �   DROP FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying, p_role_name character varying);
       public          postgres    false         �            1255    16581    add_role(character varying)    FUNCTION     �   CREATE FUNCTION public.add_role(p_role_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.rolemaster (role_name)
    VALUES (p_role_name);
END;
$$;
 >   DROP FUNCTION public.add_role(p_role_name character varying);
       public          postgres    false                    1255    16565    delete_employee(integer)    FUNCTION     �   CREATE FUNCTION public.delete_employee(p_employee_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM public.employee_list
    WHERE employee_id = p_employee_id;
END;
$$;
 =   DROP FUNCTION public.delete_employee(p_employee_id integer);
       public          postgres    false         �            1255    16583    delete_role(integer)    FUNCTION     �   CREATE FUNCTION public.delete_role(p_role_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM public.rolemaster
    WHERE role_id = p_role_id;
END;
$$;
 5   DROP FUNCTION public.delete_role(p_role_id integer);
       public          postgres    false         	           1255    16573    read_all_employees()    FUNCTION     �  CREATE FUNCTION public.read_all_employees() RETURNS TABLE(employee_id integer, first_name character varying, last_name character varying, age integer, salary integer, email_id character varying, password character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT el.employee_id, el.first_name, el.last_name,el.age, el.salary,el.email_id,el.password
    FROM public.employee_list el;
END;
$$;
 +   DROP FUNCTION public.read_all_employees();
       public          postgres    false                    1255    16571    read_employee(integer)    FUNCTION     �  CREATE FUNCTION public.read_employee(p_employee_id integer) RETURNS TABLE(employee_id integer, first_name character varying, last_name character varying, age integer, salary integer, email_id character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT el.employee_id, el.first_name, el.last_name,el.email_id,el.age, el.salary
    FROM public.employee_list el
    WHERE el.employee_id = p_employee_id;
END;
$$;
 ;   DROP FUNCTION public.read_employee(p_employee_id integer);
       public          postgres    false         �            1255    16580    read_role()    FUNCTION     �   CREATE FUNCTION public.read_role() RETURNS TABLE(role_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT r.role_name
    FROM public.rolemaster r;
END;
$$;
 "   DROP FUNCTION public.read_role();
       public          postgres    false         �            1255    16459    retrieve_data_from_table()    FUNCTION     �   CREATE FUNCTION public.retrieve_data_from_table() RETURNS TABLE(brand character varying, model character varying, year integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM public.cars;
END;
$$;
 1   DROP FUNCTION public.retrieve_data_from_table();
       public          postgres    false         �            1255    16455    retrivedata() 	   PROCEDURE     t   CREATE PROCEDURE public.retrivedata()
    LANGUAGE plpgsql
    AS $$
begin
select * from demo_test.movies;
end;
$$;
 %   DROP PROCEDURE public.retrivedata();
       public          postgres    false         �            1255    16456    retrivedata1() 	   PROCEDURE     u   CREATE PROCEDURE public.retrivedata1()
    LANGUAGE plpgsql
    AS $$
begin
select * from demo_test.movies;
end;
$$;
 &   DROP PROCEDURE public.retrivedata1();
       public          postgres    false         �            1255    16457    retrivedata2() 	   PROCEDURE     v   CREATE PROCEDURE public.retrivedata2()
    LANGUAGE plpgsql
    AS $$
begin
perform * from demo_test.movies;
end;
$$;
 &   DROP PROCEDURE public.retrivedata2();
       public          postgres    false         �            1255    16458    retrivedata3() 	   PROCEDURE     u   CREATE PROCEDURE public.retrivedata3()
    LANGUAGE plpgsql
    AS $$
begin
Select * from demo_test.movies;
end;
$$;
 &   DROP PROCEDURE public.retrivedata3();
       public          postgres    false         
           1255    16575 m   signup_employee(character varying, character varying, integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.signup_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.employee_list (first_name, last_name, age, salary,email_id,password)
    VALUES (p_first_name, p_last_name, p_age, p_salary,p_email_id,p_password);
END;
$$;
 �   DROP FUNCTION public.signup_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying);
       public          postgres    false                    1255    16572 c   update_employee(integer, character varying, character varying, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.update_employee(p_employee_id integer, p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE public.employee_list
    SET first_name = p_first_name,
        last_name = p_last_name,
        age = p_age,
        salary = p_salary,
		email_id=P_email_id 
    WHERE employee_id = p_employee_id;
END;
$$;
 �   DROP FUNCTION public.update_employee(p_employee_id integer, p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying);
       public          postgres    false         �            1259    16525    employee    TABLE     �   CREATE TABLE demo_test.employee (
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    id integer NOT NULL
);
    DROP TABLE demo_test.employee;
    	   demo_test         heap    postgres    false    7         �            1259    16546 	   employee1    TABLE     �   CREATE TABLE demo_test.employee1 (
    username character varying(100),
    email character varying(100),
    emailconfirmed boolean,
    id integer NOT NULL
);
     DROP TABLE demo_test.employee1;
    	   demo_test         heap    postgres    false    7         �            1259    16549    employee1_id_seq    SEQUENCE     �   ALTER TABLE demo_test.employee1 ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME demo_test.employee1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000000
    CACHE 1
);
         	   demo_test          postgres    false    234    7         �            1259    16545    employee_id_seq    SEQUENCE     �   ALTER TABLE demo_test.employee ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME demo_test.employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000
    CACHE 1
);
         	   demo_test          postgres    false    232    7         �            1259    16421    fact_movies_rating    TABLE     �   CREATE TABLE demo_test.fact_movies_rating (
    movie_id integer,
    title character varying(500),
    movie_type character varying(500),
    user_id integer,
    rating numeric(2,1),
    rating_date character varying(20)
);
 )   DROP TABLE demo_test.fact_movies_rating;
    	   demo_test         heap    postgres    false    7         �            1259    16431    log_detail_tbl    TABLE     �   CREATE TABLE demo_test.log_detail_tbl (
    v_proc_name character varying,
    n_row_deleted integer,
    n_row_inserted integer,
    v_tbl_name character varying,
    t_load_tms timestamp without time zone,
    v_scm_name character varying
);
 %   DROP TABLE demo_test.log_detail_tbl;
    	   demo_test         heap    postgres    false    7         �            1259    16410    movies    TABLE     �   CREATE TABLE demo_test.movies (
    movie_id integer,
    title character varying(500),
    movie_type character varying(500)
);
    DROP TABLE demo_test.movies;
    	   demo_test         heap    postgres    false    7         �            1259    16418    ratings    TABLE     �   CREATE TABLE demo_test.ratings (
    user_id integer,
    movie_id integer,
    rating numeric(2,1),
    rating_date character varying(20)
);
    DROP TABLE demo_test.ratings;
    	   demo_test         heap    postgres    false    7         �            1259    16398    cars    TABLE     �   CREATE TABLE public.cars (
    brand character varying(100),
    model character varying(100),
    year character varying(100),
    car_id integer NOT NULL
);
    DROP TABLE public.cars;
       public         heap    postgres    false         �            1259    16462    cars_car_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.cars_car_id_seq;
       public          postgres    false    217         �           0    0    cars_car_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;
          public          postgres    false    224         �            1259    16495    emp    TABLE     �   CREATE TABLE public.emp (
    employeeid integer,
    name character varying(100),
    age integer,
    state character varying(100),
    country character varying(100),
    action character varying(100)
);
    DROP TABLE public.emp;
       public         heap    postgres    false         �            1259    16481    employee    TABLE     �   CREATE TABLE public.employee (
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    id integer NOT NULL
);
    DROP TABLE public.employee;
       public         heap    postgres    false         �            1259    16487    employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.employee_id_seq;
       public          postgres    false    225         �           0    0    employee_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;
          public          postgres    false    226         �            1259    16616    employee_list    TABLE     .  CREATE TABLE public.employee_list (
    employee_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(20),
    age integer,
    salary integer,
    email_id character varying(50),
    password character varying(50),
    role_name character varying(20) NOT NULL
);
 !   DROP TABLE public.employee_list;
       public         heap    postgres    false         �            1259    16615    employee_list_employee_id_seq    SEQUENCE     �   ALTER TABLE public.employee_list ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_list_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000
    CACHE 1
);
            public          postgres    false    239         �            1259    16405    movies    TABLE     ~   CREATE TABLE public.movies (
    movie_id integer,
    title character varying(500),
    movie_type character varying(500)
);
    DROP TABLE public.movies;
       public         heap    postgres    false         �            1259    16608 
   rolemaster    TABLE     o   CREATE TABLE public.rolemaster (
    role_name character varying(20) NOT NULL,
    role_id integer NOT NULL
);
    DROP TABLE public.rolemaster;
       public         heap    postgres    false         �            1259    16607    rolemaster_role_id_seq    SEQUENCE     �   ALTER TABLE public.rolemaster ALTER COLUMN role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rolemaster_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000
    CACHE 1
);
            public          postgres    false    237         �            1259    16501    student    TABLE     �   CREATE TABLE public.student (
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    id integer NOT NULL
);
    DROP TABLE public.student;
       public         heap    postgres    false         �            1259    16516    student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.student_id_seq;
       public          postgres    false    228         �           0    0    student_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;
          public          postgres    false    231         �            1259    16450    tb_smart_crud    TABLE     �   CREATE TABLE public.tb_smart_crud (
    autoid integer NOT NULL,
    firstname character varying(20),
    lastname character varying(20),
    gender character varying(10)
);
 !   DROP TABLE public.tb_smart_crud;
       public         heap    postgres    false         �            1259    16504    user    TABLE     �   CREATE TABLE public."user" (
    email character varying(100),
    password character varying(100),
    id integer NOT NULL,
    otp integer
);
    DROP TABLE public."user";
       public         heap    postgres    false         �            1259    16508    user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          postgres    false    229         �           0    0    user_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
          public          postgres    false    230         �           2604    16463    cars car_id    DEFAULT     j   ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);
 :   ALTER TABLE public.cars ALTER COLUMN car_id DROP DEFAULT;
       public          postgres    false    224    217         �           2604    16488    employee id    DEFAULT     j   ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);
 :   ALTER TABLE public.employee ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225         �           2604    16517 
   student id    DEFAULT     h   ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);
 9   ALTER TABLE public.student ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    228         �           2604    16509    user id    DEFAULT     d   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229         y          0    16525    employee 
   TABLE DATA           G   COPY demo_test.employee (first_name, last_name, email, id) FROM stdin;
 	   demo_test          postgres    false    232       3705.dat {          0    16546 	   employee1 
   TABLE DATA           K   COPY demo_test.employee1 (username, email, emailconfirmed, id) FROM stdin;
 	   demo_test          postgres    false    234       3707.dat n          0    16421    fact_movies_rating 
   TABLE DATA           j   COPY demo_test.fact_movies_rating (movie_id, title, movie_type, user_id, rating, rating_date) FROM stdin;
 	   demo_test          postgres    false    221       3694.dat o          0    16431    log_detail_tbl 
   TABLE DATA           {   COPY demo_test.log_detail_tbl (v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name) FROM stdin;
 	   demo_test          postgres    false    222       3695.dat l          0    16410    movies 
   TABLE DATA           @   COPY demo_test.movies (movie_id, title, movie_type) FROM stdin;
 	   demo_test          postgres    false    219       3692.dat m          0    16418    ratings 
   TABLE DATA           L   COPY demo_test.ratings (user_id, movie_id, rating, rating_date) FROM stdin;
 	   demo_test          postgres    false    220       3693.dat j          0    16398    cars 
   TABLE DATA           :   COPY public.cars (brand, model, year, car_id) FROM stdin;
    public          postgres    false    217       3690.dat t          0    16495    emp 
   TABLE DATA           L   COPY public.emp (employeeid, name, age, state, country, action) FROM stdin;
    public          postgres    false    227       3700.dat r          0    16481    employee 
   TABLE DATA           D   COPY public.employee (first_name, last_name, email, id) FROM stdin;
    public          postgres    false    225       3698.dat �          0    16616    employee_list 
   TABLE DATA           w   COPY public.employee_list (employee_id, first_name, last_name, age, salary, email_id, password, role_name) FROM stdin;
    public          postgres    false    239       3712.dat k          0    16405    movies 
   TABLE DATA           =   COPY public.movies (movie_id, title, movie_type) FROM stdin;
    public          postgres    false    218       3691.dat ~          0    16608 
   rolemaster 
   TABLE DATA           8   COPY public.rolemaster (role_name, role_id) FROM stdin;
    public          postgres    false    237       3710.dat u          0    16501    student 
   TABLE DATA           C   COPY public.student (first_name, last_name, email, id) FROM stdin;
    public          postgres    false    228       3701.dat p          0    16450    tb_smart_crud 
   TABLE DATA           L   COPY public.tb_smart_crud (autoid, firstname, lastname, gender) FROM stdin;
    public          postgres    false    223       3696.dat v          0    16504    user 
   TABLE DATA           :   COPY public."user" (email, password, id, otp) FROM stdin;
    public          postgres    false    229       3702.dat �           0    0    employee1_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('demo_test.employee1_id_seq', 1, false);
       	   demo_test          postgres    false    235         �           0    0    employee_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('demo_test.employee_id_seq', 3, true);
       	   demo_test          postgres    false    233         �           0    0    cars_car_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.cars_car_id_seq', 30, true);
          public          postgres    false    224         �           0    0    employee_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.employee_id_seq', 10, true);
          public          postgres    false    226         �           0    0    employee_list_employee_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.employee_list_employee_id_seq', 1, false);
          public          postgres    false    238         �           0    0    rolemaster_role_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.rolemaster_role_id_seq', 1, false);
          public          postgres    false    236         �           0    0    student_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.student_id_seq', 5, true);
          public          postgres    false    231         �           0    0    user_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.user_id_seq', 20, true);
          public          postgres    false    230         �           2606    16465    cars cars_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);
 8   ALTER TABLE ONLY public.cars DROP CONSTRAINT cars_pkey;
       public            postgres    false    217         �           2606    16620     employee_list employee_list_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.employee_list
    ADD CONSTRAINT employee_list_pkey PRIMARY KEY (employee_id);
 J   ALTER TABLE ONLY public.employee_list DROP CONSTRAINT employee_list_pkey;
       public            postgres    false    239         �           2606    16490    employee employee_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    225         �           2606    16612    rolemaster rolemaster_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.rolemaster
    ADD CONSTRAINT rolemaster_pkey PRIMARY KEY (role_id);
 D   ALTER TABLE ONLY public.rolemaster DROP CONSTRAINT rolemaster_pkey;
       public            postgres    false    237         �           2606    16614 #   rolemaster rolemaster_role_name_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.rolemaster
    ADD CONSTRAINT rolemaster_role_name_key UNIQUE (role_name);
 M   ALTER TABLE ONLY public.rolemaster DROP CONSTRAINT rolemaster_role_name_key;
       public            postgres    false    237         �           2606    16519    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    228         �           2606    16454     tb_smart_crud tb_smart_crud_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.tb_smart_crud
    ADD CONSTRAINT tb_smart_crud_pkey PRIMARY KEY (autoid);
 J   ALTER TABLE ONLY public.tb_smart_crud DROP CONSTRAINT tb_smart_crud_pkey;
       public            postgres    false    223         �           2606    16511    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            postgres    false    229         �           2606    16621    employee_list fk_role_name    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee_list
    ADD CONSTRAINT fk_role_name FOREIGN KEY (role_name) REFERENCES public.rolemaster(role_name);
 D   ALTER TABLE ONLY public.employee_list DROP CONSTRAINT fk_role_name;
       public          postgres    false    3543    239    237                                                                        3705.dat                                                                                            0000600 0004000 0002000 00000000113 14632771343 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        ADO	DOTNET	ADO@gmail.com	2
Bhavy	Munjani	bhavymunjani1418@gmail.com	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                     3707.dat                                                                                            0000600 0004000 0002000 00000000005 14632771343 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3694.dat                                                                                            0000600 0004000 0002000 00000001215 14632771343 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	XYZ	thriller	1001	4.0	1-2-23
3	QWE	Drama	1002	4.5	10-2-22
1	ABC	Action	1003	3.0	11-12-23
1	ABC	Action	1003	3.0	11-12-23
4	WER	Romance	1004	5.0	1-12-22
5	ERT	Action	1005	3.5	2-10-22
6	RTY	DRAMA	1006	2.0	14-2-23
7	TYU	Romance	1007	4.5	13-3-23
8	IOP	Comedy	1008	3.0	14-4-23
9	DEF	Fantacy	1009	5.0	15-5-23
10	OPQ	Animation	10010	4.0	16-6-23
11	LMN	Children	10011	4.5	17-7-23
12	KLM	Action	10012	4.2	18-8-23
4	WER	Romance	10013	5.0	10-2-23
5	ERT	Action	10014	4.5	13-3-23
6	RTY	DRAMA	10015	5.0	15-6-23
1	ABC	Action	10016	3.0	17-8-23
1	ABC	Action	10016	3.0	17-8-23
7	TYU	Romance	10017	4.0	21-9-23
5	ERT	Action	10018	4.0	23-10-23
13	MNB	Romance	\N	\N	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                   3695.dat                                                                                            0000600 0004000 0002000 00000000224 14632771343 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        pr_movie_rating	21	21	Movie|Rating	2024-02-16 15:50:12.82451	demo_test
pr_movie_rating	21	21	Movie|Rating	2024-02-16 16:09:37.441086	demo_test
\.


                                                                                                                                                                                                                                                                                                                                                                            3692.dat                                                                                            0000600 0004000 0002000 00000000276 14632771343 0014274 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        4	WER	Romance
5	ERT	Action
6	RTY	DRAMA
7	TYU	Romance
8	IOP	Comedy
9	DEF	Fantacy
10	OPQ	Animation
11	LMN	Children
12	KLM	Action
13	MNB	Romance
15	DOTNET	Boring
3	ABC	Action
2	ABC	Action
\.


                                                                                                                                                                                                                                                                                                                                  3693.dat                                                                                            0000600 0004000 0002000 00000000550 14632771343 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1001	2	4.0	1-2-23
1002	3	4.5	10-2-22
1003	1	3.0	11-12-23
1004	4	5.0	1-12-22
1005	5	3.5	2-10-22
1006	6	2.0	14-2-23
1007	7	4.5	13-3-23
1008	8	3.0	14-4-23
1009	9	5.0	15-5-23
10010	10	4.0	16-6-23
10011	11	4.5	17-7-23
10012	12	4.2	18-8-23
10013	4	5.0	10-2-23
10014	5	4.5	13-3-23
10015	6	5.0	15-6-23
10016	1	3.0	17-8-23
10017	7	4.0	21-9-23
10018	5	4.0	23-10-23
\.


                                                                                                                                                        3690.dat                                                                                            0000600 0004000 0002000 00000000451 14632771343 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        Toyota	Supra	2024	2
Ford	Mustang	2024	3
Lamborghini	Avantador	2019	18
KML	OPQ	2008	20
Audi	Q7	2022	6
QWE	ASD	2019	21
FGH	VBN	2010	22
ABC	XYZ	2014	17
gbdb	hgmghn	2019	23
VSFVDFV	FDFSDF	2023	14
Maruti	Fanti	1950	25
Austin	Martin	2019	28
Austin	Martin	2019	29
Nissan	GTR	2017	19
BMW	wqr	2004	30
\.


                                                                                                                                                                                                                       3700.dat                                                                                            0000600 0004000 0002000 00000000041 14632771343 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Bhavy	21	Gujarat	India	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3698.dat                                                                                            0000600 0004000 0002000 00000000406 14632771343 0014275 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        bhavy	Munjani	bhavymunjani1418@gmail.com	2
bhavy	Munjani	bhavymunjani@gmail.com	4
Bhavy	Munjani	bhavymunjani@gmail.com	1
ABC	XYZ	ABCXYZ0102@gmail.com	5
dotnet	Core	dotnetcore@gmail.com	6
Visual	Studio	visualstudio@gmail.com	7
hello	world	helloworld@gmail	9
\.


                                                                                                                                                                                                                                                          3712.dat                                                                                            0000600 0004000 0002000 00000000005 14632771343 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3691.dat                                                                                            0000600 0004000 0002000 00000000174 14632771343 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	ABC	Drama
2	XYZABC	Drama
3	QWERTYUISDFGH	Action
3	QWERTYUISDFGH	Action
3	QWERTYUISDFGH	Action
3	QWERTYUISDFGH	Action
\.


                                                                                                                                                                                                                                                                                                                                                                                                    3710.dat                                                                                            0000600 0004000 0002000 00000000005 14632771343 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3701.dat                                                                                            0000600 0004000 0002000 00000000113 14632771343 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        ADO	DOT	adodotnet@gmail.com	1
Bhavy	Munjani	bhavymunjani@gmail.com 	3
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                     3696.dat                                                                                            0000600 0004000 0002000 00000000005 14632771343 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3702.dat                                                                                            0000600 0004000 0002000 00000001225 14632771343 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        ABCXYZ1418@gmail.com	ABC@123	5	\N
bhavymunjani0102@gmail.com	bhavy@123	6	\N
bhavymunjani1418@gmail.com	bhavy@1418	7	\N
bhavymunjani1418@gmail.com	bhavy@1418	8	\N
bhavymunjani1418@gmail.com	bhavy@1418	9	\N
bhavymunjani1418@gmail.com	bhavy@1418	10	\N
bhavymunjani1418@gmail.com	bhavy@1418	11	\N
bhavymunjani1418@gmail.com	bhavy@1418	12	\N
bhavymunjani1418@gmail.com	bhavy@1418	13	\N
bhavymunjani1418@gmail.com	bhavy@1418	14	\N
bhavymunjani1418@gmail.com	bhavy@1418	15	\N
bhavymunjani1418@gmail.com	bhavy@1418	16	\N
bhavymunjani1418@gmail.com	bhavy@1418	17	\N
hencybhalani@gmail.com	aaa	18	\N
hencybhalani@gmail.com	aaa	19	\N
hencybhalani@gmail.com	qqq	20	\N
\.


                                                                                                                                                                                                                                                                                                                                                                           restore.sql                                                                                         0000600 0004000 0002000 00000064662 14632771343 0015414 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: demo_test; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA demo_test;


ALTER SCHEMA demo_test OWNER TO postgres;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: log_detail(character varying, integer, integer, character varying, timestamp without time zone, character varying); Type: FUNCTION; Schema: demo_test; Owner: postgres
--

CREATE FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO demo_test.log_detail_tbl(v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name)
    SELECT _proc_name, _row_deleted, _row_inserted, _tbl_name, _load_tms, _scm_name;
END;
$$;


ALTER FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying) OWNER TO postgres;

--
-- Name: log_detail(character varying, integer, integer, character varying, timestamp without time zone, character varying, integer); Type: FUNCTION; Schema: demo_test; Owner: postgres
--

CREATE FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying, _ins_time integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO demo_test.log_detail_tbl(v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name,ins_time)
    SELECT _proc_name, _row_deleted, _row_inserted, _tbl_name, _load_tms, _scm_name,_ins_time;
END;
$$;


ALTER FUNCTION demo_test.log_detail(_proc_name character varying, _row_deleted integer, _row_inserted integer, _tbl_name character varying, _load_tms timestamp without time zone, _scm_name character varying, _ins_time integer) OWNER TO postgres;

--
-- Name: pr_movie_rating(); Type: PROCEDURE; Schema: demo_test; Owner: postgres
--

CREATE PROCEDURE demo_test.pr_movie_rating()
    LANGUAGE plpgsql
    AS $$
DECLARE

row_deleted int default 0;
row_inserted INT default 0;
v_load_tms TIMESTAMP;


BEGIN
 SELECT CURRENT_TIMESTAMP INTO v_load_tms;
DELETE FROM demo_test.fact_movies_rating;
GET DIAGNOSTICS row_deleted=ROW_COUNT;
RAISE NOTICE 'NO OF ROW Deleted %',row_deleted;


INSERT INTO demo_test.fact_movies_rating(movie_id, title, movie_type, user_id, rating, rating_date)

SELECT mov.movie_id,mov.title,mov.movie_type,
rat.user_id,rat.rating,rat.rating_date
FROM demo_test.movies mov
LEFT JOIN demo_test.ratings rat
ON mov.movie_id=rat.movie_id;





GET DIAGNOSTICS row_inserted =ROW_COUNT;
RAISE NOTICE 'NO OF ROW INSERTED %',row_inserted;


PERFORM demo_test.log_detail('pr_movie_rating',
							row_deleted,
							  row_inserted,
							  'Movie|Rating',
							  v_load_tms,
							  'demo_test'
							);
END;
$$;


ALTER PROCEDURE demo_test.pr_movie_rating() OWNER TO postgres;

--
-- Name: add_employee(character varying, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.employee_list (first_name, last_name, age, salary,email_id)
    VALUES (p_first_name, p_last_name, p_age, p_salary,p_email_id);
END;
$$;


ALTER FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying) OWNER TO postgres;

--
-- Name: add_employee(character varying, character varying, integer, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying, p_role_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.employee_list (first_name, last_name, age, salary,email_id,password,role_name)
    VALUES (p_first_name, p_last_name, p_age, p_salary,p_email_id,p_password,p_role_name);
END;
$$;


ALTER FUNCTION public.add_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying, p_role_name character varying) OWNER TO postgres;

--
-- Name: add_role(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_role(p_role_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.rolemaster (role_name)
    VALUES (p_role_name);
END;
$$;


ALTER FUNCTION public.add_role(p_role_name character varying) OWNER TO postgres;

--
-- Name: delete_employee(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_employee(p_employee_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM public.employee_list
    WHERE employee_id = p_employee_id;
END;
$$;


ALTER FUNCTION public.delete_employee(p_employee_id integer) OWNER TO postgres;

--
-- Name: delete_role(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_role(p_role_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM public.rolemaster
    WHERE role_id = p_role_id;
END;
$$;


ALTER FUNCTION public.delete_role(p_role_id integer) OWNER TO postgres;

--
-- Name: read_all_employees(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.read_all_employees() RETURNS TABLE(employee_id integer, first_name character varying, last_name character varying, age integer, salary integer, email_id character varying, password character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT el.employee_id, el.first_name, el.last_name,el.age, el.salary,el.email_id,el.password
    FROM public.employee_list el;
END;
$$;


ALTER FUNCTION public.read_all_employees() OWNER TO postgres;

--
-- Name: read_employee(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.read_employee(p_employee_id integer) RETURNS TABLE(employee_id integer, first_name character varying, last_name character varying, age integer, salary integer, email_id character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT el.employee_id, el.first_name, el.last_name,el.email_id,el.age, el.salary
    FROM public.employee_list el
    WHERE el.employee_id = p_employee_id;
END;
$$;


ALTER FUNCTION public.read_employee(p_employee_id integer) OWNER TO postgres;

--
-- Name: read_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.read_role() RETURNS TABLE(role_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT r.role_name
    FROM public.rolemaster r;
END;
$$;


ALTER FUNCTION public.read_role() OWNER TO postgres;

--
-- Name: retrieve_data_from_table(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.retrieve_data_from_table() RETURNS TABLE(brand character varying, model character varying, year integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM public.cars;
END;
$$;


ALTER FUNCTION public.retrieve_data_from_table() OWNER TO postgres;

--
-- Name: retrivedata(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.retrivedata()
    LANGUAGE plpgsql
    AS $$
begin
select * from demo_test.movies;
end;
$$;


ALTER PROCEDURE public.retrivedata() OWNER TO postgres;

--
-- Name: retrivedata1(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.retrivedata1()
    LANGUAGE plpgsql
    AS $$
begin
select * from demo_test.movies;
end;
$$;


ALTER PROCEDURE public.retrivedata1() OWNER TO postgres;

--
-- Name: retrivedata2(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.retrivedata2()
    LANGUAGE plpgsql
    AS $$
begin
perform * from demo_test.movies;
end;
$$;


ALTER PROCEDURE public.retrivedata2() OWNER TO postgres;

--
-- Name: retrivedata3(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.retrivedata3()
    LANGUAGE plpgsql
    AS $$
begin
Select * from demo_test.movies;
end;
$$;


ALTER PROCEDURE public.retrivedata3() OWNER TO postgres;

--
-- Name: signup_employee(character varying, character varying, integer, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.signup_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO public.employee_list (first_name, last_name, age, salary,email_id,password)
    VALUES (p_first_name, p_last_name, p_age, p_salary,p_email_id,p_password);
END;
$$;


ALTER FUNCTION public.signup_employee(p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying, p_password character varying) OWNER TO postgres;

--
-- Name: update_employee(integer, character varying, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_employee(p_employee_id integer, p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE public.employee_list
    SET first_name = p_first_name,
        last_name = p_last_name,
        age = p_age,
        salary = p_salary,
		email_id=P_email_id 
    WHERE employee_id = p_employee_id;
END;
$$;


ALTER FUNCTION public.update_employee(p_employee_id integer, p_first_name character varying, p_last_name character varying, p_age integer, p_salary integer, p_email_id character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: employee; Type: TABLE; Schema: demo_test; Owner: postgres
--

CREATE TABLE demo_test.employee (
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    id integer NOT NULL
);


ALTER TABLE demo_test.employee OWNER TO postgres;

--
-- Name: employee1; Type: TABLE; Schema: demo_test; Owner: postgres
--

CREATE TABLE demo_test.employee1 (
    username character varying(100),
    email character varying(100),
    emailconfirmed boolean,
    id integer NOT NULL
);


ALTER TABLE demo_test.employee1 OWNER TO postgres;

--
-- Name: employee1_id_seq; Type: SEQUENCE; Schema: demo_test; Owner: postgres
--

ALTER TABLE demo_test.employee1 ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME demo_test.employee1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000000
    CACHE 1
);


--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: demo_test; Owner: postgres
--

ALTER TABLE demo_test.employee ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME demo_test.employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000
    CACHE 1
);


--
-- Name: fact_movies_rating; Type: TABLE; Schema: demo_test; Owner: postgres
--

CREATE TABLE demo_test.fact_movies_rating (
    movie_id integer,
    title character varying(500),
    movie_type character varying(500),
    user_id integer,
    rating numeric(2,1),
    rating_date character varying(20)
);


ALTER TABLE demo_test.fact_movies_rating OWNER TO postgres;

--
-- Name: log_detail_tbl; Type: TABLE; Schema: demo_test; Owner: postgres
--

CREATE TABLE demo_test.log_detail_tbl (
    v_proc_name character varying,
    n_row_deleted integer,
    n_row_inserted integer,
    v_tbl_name character varying,
    t_load_tms timestamp without time zone,
    v_scm_name character varying
);


ALTER TABLE demo_test.log_detail_tbl OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: demo_test; Owner: postgres
--

CREATE TABLE demo_test.movies (
    movie_id integer,
    title character varying(500),
    movie_type character varying(500)
);


ALTER TABLE demo_test.movies OWNER TO postgres;

--
-- Name: ratings; Type: TABLE; Schema: demo_test; Owner: postgres
--

CREATE TABLE demo_test.ratings (
    user_id integer,
    movie_id integer,
    rating numeric(2,1),
    rating_date character varying(20)
);


ALTER TABLE demo_test.ratings OWNER TO postgres;

--
-- Name: cars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cars (
    brand character varying(100),
    model character varying(100),
    year character varying(100),
    car_id integer NOT NULL
);


ALTER TABLE public.cars OWNER TO postgres;

--
-- Name: cars_car_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cars_car_id_seq OWNER TO postgres;

--
-- Name: cars_car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;


--
-- Name: emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emp (
    employeeid integer,
    name character varying(100),
    age integer,
    state character varying(100),
    country character varying(100),
    action character varying(100)
);


ALTER TABLE public.emp OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    id integer NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_id_seq OWNER TO postgres;

--
-- Name: employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_id_seq OWNED BY public.employee.id;


--
-- Name: employee_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_list (
    employee_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(20),
    age integer,
    salary integer,
    email_id character varying(50),
    password character varying(50),
    role_name character varying(20) NOT NULL
);


ALTER TABLE public.employee_list OWNER TO postgres;

--
-- Name: employee_list_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee_list ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_list_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000
    CACHE 1
);


--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movie_id integer,
    title character varying(500),
    movie_type character varying(500)
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: rolemaster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rolemaster (
    role_name character varying(20) NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.rolemaster OWNER TO postgres;

--
-- Name: rolemaster_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rolemaster ALTER COLUMN role_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rolemaster_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000
    CACHE 1
);


--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    first_name character varying(100),
    last_name character varying(100),
    email character varying(100),
    id integer NOT NULL
);


ALTER TABLE public.student OWNER TO postgres;

--
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_id_seq OWNER TO postgres;

--
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;


--
-- Name: tb_smart_crud; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_smart_crud (
    autoid integer NOT NULL,
    firstname character varying(20),
    lastname character varying(20),
    gender character varying(10)
);


ALTER TABLE public.tb_smart_crud OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    email character varying(100),
    password character varying(100),
    id integer NOT NULL,
    otp integer
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: cars car_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);


--
-- Name: employee id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public.employee_id_seq'::regclass);


--
-- Name: student id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: employee; Type: TABLE DATA; Schema: demo_test; Owner: postgres
--

COPY demo_test.employee (first_name, last_name, email, id) FROM stdin;
\.
COPY demo_test.employee (first_name, last_name, email, id) FROM '$$PATH$$/3705.dat';

--
-- Data for Name: employee1; Type: TABLE DATA; Schema: demo_test; Owner: postgres
--

COPY demo_test.employee1 (username, email, emailconfirmed, id) FROM stdin;
\.
COPY demo_test.employee1 (username, email, emailconfirmed, id) FROM '$$PATH$$/3707.dat';

--
-- Data for Name: fact_movies_rating; Type: TABLE DATA; Schema: demo_test; Owner: postgres
--

COPY demo_test.fact_movies_rating (movie_id, title, movie_type, user_id, rating, rating_date) FROM stdin;
\.
COPY demo_test.fact_movies_rating (movie_id, title, movie_type, user_id, rating, rating_date) FROM '$$PATH$$/3694.dat';

--
-- Data for Name: log_detail_tbl; Type: TABLE DATA; Schema: demo_test; Owner: postgres
--

COPY demo_test.log_detail_tbl (v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name) FROM stdin;
\.
COPY demo_test.log_detail_tbl (v_proc_name, n_row_deleted, n_row_inserted, v_tbl_name, t_load_tms, v_scm_name) FROM '$$PATH$$/3695.dat';

--
-- Data for Name: movies; Type: TABLE DATA; Schema: demo_test; Owner: postgres
--

COPY demo_test.movies (movie_id, title, movie_type) FROM stdin;
\.
COPY demo_test.movies (movie_id, title, movie_type) FROM '$$PATH$$/3692.dat';

--
-- Data for Name: ratings; Type: TABLE DATA; Schema: demo_test; Owner: postgres
--

COPY demo_test.ratings (user_id, movie_id, rating, rating_date) FROM stdin;
\.
COPY demo_test.ratings (user_id, movie_id, rating, rating_date) FROM '$$PATH$$/3693.dat';

--
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cars (brand, model, year, car_id) FROM stdin;
\.
COPY public.cars (brand, model, year, car_id) FROM '$$PATH$$/3690.dat';

--
-- Data for Name: emp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emp (employeeid, name, age, state, country, action) FROM stdin;
\.
COPY public.emp (employeeid, name, age, state, country, action) FROM '$$PATH$$/3700.dat';

--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (first_name, last_name, email, id) FROM stdin;
\.
COPY public.employee (first_name, last_name, email, id) FROM '$$PATH$$/3698.dat';

--
-- Data for Name: employee_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_list (employee_id, first_name, last_name, age, salary, email_id, password, role_name) FROM stdin;
\.
COPY public.employee_list (employee_id, first_name, last_name, age, salary, email_id, password, role_name) FROM '$$PATH$$/3712.dat';

--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movie_id, title, movie_type) FROM stdin;
\.
COPY public.movies (movie_id, title, movie_type) FROM '$$PATH$$/3691.dat';

--
-- Data for Name: rolemaster; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rolemaster (role_name, role_id) FROM stdin;
\.
COPY public.rolemaster (role_name, role_id) FROM '$$PATH$$/3710.dat';

--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (first_name, last_name, email, id) FROM stdin;
\.
COPY public.student (first_name, last_name, email, id) FROM '$$PATH$$/3701.dat';

--
-- Data for Name: tb_smart_crud; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_smart_crud (autoid, firstname, lastname, gender) FROM stdin;
\.
COPY public.tb_smart_crud (autoid, firstname, lastname, gender) FROM '$$PATH$$/3696.dat';

--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (email, password, id, otp) FROM stdin;
\.
COPY public."user" (email, password, id, otp) FROM '$$PATH$$/3702.dat';

--
-- Name: employee1_id_seq; Type: SEQUENCE SET; Schema: demo_test; Owner: postgres
--

SELECT pg_catalog.setval('demo_test.employee1_id_seq', 1, false);


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: demo_test; Owner: postgres
--

SELECT pg_catalog.setval('demo_test.employee_id_seq', 3, true);


--
-- Name: cars_car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cars_car_id_seq', 30, true);


--
-- Name: employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_id_seq', 10, true);


--
-- Name: employee_list_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_list_employee_id_seq', 1, false);


--
-- Name: rolemaster_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rolemaster_role_id_seq', 1, false);


--
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 5, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 20, true);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);


--
-- Name: employee_list employee_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_list
    ADD CONSTRAINT employee_list_pkey PRIMARY KEY (employee_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- Name: rolemaster rolemaster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rolemaster
    ADD CONSTRAINT rolemaster_pkey PRIMARY KEY (role_id);


--
-- Name: rolemaster rolemaster_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rolemaster
    ADD CONSTRAINT rolemaster_role_name_key UNIQUE (role_name);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);


--
-- Name: tb_smart_crud tb_smart_crud_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_smart_crud
    ADD CONSTRAINT tb_smart_crud_pkey PRIMARY KEY (autoid);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: employee_list fk_role_name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_list
    ADD CONSTRAINT fk_role_name FOREIGN KEY (role_name) REFERENCES public.rolemaster(role_name);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              