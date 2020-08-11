--
-- PostgreSQL database dump
--  pg_dump -U postgres -s baseball_alltime_stats > ~/baseball_alltime_stats.sql
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 12.3

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

--
-- Name: player_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_info (
    playerid text NOT NULL,
    birthyear integer,
    birthmonth integer,
    birthday integer,
    birthcountry text,
    birthstate text,
    birthcity text,
    deathyear integer,
    deathmonth integer,
    deathday integer,
    deathcountry text,
    deathstate text,
    deathcity text,
    namefirst text,
    namelast text,
    namegiven text,
    weight numeric,
    height text,
    bats text,
    throws text,
    debut date,
    finalgame date,
    retroid text,
    bbrefid text
);

ALTER TABLE public.player_info OWNER TO postgres;

--
-- Name: player_info player_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_info
    ADD CONSTRAINT player_info_pkey PRIMARY KEY (playerid);


CREATE TABLE public.player_batting_by_year (
    playerid text NOT NULL,
    yearid integer NOT NULL,
    ab integer,
    batting_avg decimal,
    bb integer,
    cs integer,
    doubles integer,
    games integer,
    gidp integer,
    hbp integer,
    hits integer,
    hr integer,
    ibb integer,
    lgid text,
    obp decimal,
    ops decimal,
    ops_plus decimal,
    rbi integer,
    runs integer,
    sb integer,
    sf integer,
    sh integer,
    slg decimal,
    so integer,
    stint integer,
    teamid text,
    triples integer
);
	
ALTER TABLE public.player_batting_by_year OWNER TO postgres;

--
-- Name: player_batting_by_year player_batting_by_year_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_batting_by_year
	ADD CONSTRAINT player_batting_by_year_pkey PRIMARY KEY (playerid, yearid);
	
	
CREATE TABLE IF NOT EXISTS public.player_batting_post_season_by_year (
    playerid text NOT NULL,
    yearid integer NOT NULL,
    round text NOT NULL,
    ab integer,
    bb integer,
    cs integer,
    doubles integer,
    games integer,
    gidp integer,
    hbp integer,
    hits integer,
    hr integer,
    batting_avg decimal,
    ibb integer,
    lgid text,
    rbi integer,
    runs integer,
    sb integer,
    sf integer,
    sh integer,
    so integer,
    teamid text,
    triples integer,
    obp decimal, 
    slg decimal,
    ops decimal,
    ops_plus decimal
);

ALTER TABLE public.player_batting_post_season_by_year OWNER TO postgres;

--
-- Name: player_batting_by_year player_batting_by_year_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_batting_post_season_by_year
	ADD CONSTRAINT player_batting_post_season_by_year_pkey PRIMARY KEY (playerid, yearid, round);


CREATE TABLE IF NOT EXISTS public.parks (
	parkid text NOT NULL,
	parkname text,
	city text,
	state text,
	country text
);

ALTER TABLE public.parks OWNER TO postgres;

--
-- Name: parks parks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parks
	ADD CONSTRAINT parks_pkey PRIMARY KEY (parkid);

	
