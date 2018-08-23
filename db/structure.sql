SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: ensure_letters_formatted(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ensure_letters_formatted() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 begin
   if new.letters is not null and new.letters <> '' then
     new.letters := letters_format(new.letters);
   end if;
   return new;
 end$$;


--
-- Name: letter_jumbles_letters_format(anyarray); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.letter_jumbles_letters_format(anyarray) RETURNS TABLE(sorted_letters text)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY select array_to_string(array_agg(letters_array.letter), '') as sorted_letters
	from (
		select unnest(string_to_array(lower(regexp_replace(unsorted_letters, '[[:space:]]', '')), NULL)) as letter 
		order by letter asc
	) as letters_array; 
END;
$$;


--
-- Name: letters_format(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.letters_format(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
select
  array_to_string(array_agg(letters_array.letter), '') as letters
from (
  select
    unnest(string_to_array(lower(regexp_replace($1, '[[:space:]]', '')), null)) as letter
  order by
    letter asc) as letters_array;
$_$;


--
-- Name: letters_formatx(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.letters_formatx(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
select
    array_to_string(array_agg(letters_array.letter), '') as letters
  from (
    select
      unnest(string_to_array(lower(regexp_replace($1, '[[:space:]]', '')), null)) as letter
    order by
      letter asc) as letters_array;
$_$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: letter_jumbles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.letter_jumbles (
    id bigint NOT NULL,
    letters character varying NOT NULL,
    words character varying[] DEFAULT '{}'::character varying[],
    version integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: letter_jumbles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.letter_jumbles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: letter_jumbles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.letter_jumbles_id_seq OWNED BY public.letter_jumbles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: letter_jumbles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.letter_jumbles ALTER COLUMN id SET DEFAULT nextval('public.letter_jumbles_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: letter_jumbles letter_jumbles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.letter_jumbles
    ADD CONSTRAINT letter_jumbles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_letter_jumbles_letters_formatted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_letter_jumbles_letters_formatted ON public.letter_jumbles USING btree (public.letters_format((letters)::text));


--
-- Name: letter_jumbles trigger_ensure_letters_formatted; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_ensure_letters_formatted BEFORE INSERT ON public.letter_jumbles FOR EACH ROW EXECUTE PROCEDURE public.ensure_letters_formatted();


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180812224250'),
('20180822235640'),
('20180823020710'),
('20180823023140');


