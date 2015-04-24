--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE account (
    acctno integer NOT NULL,
    type integer,
    balance numeric,
    branchno integer,
    code integer
);


ALTER TABLE account OWNER TO brianc;

--
-- Name: acct_cust; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE acct_cust (
    acctno integer NOT NULL,
    ssn character varying NOT NULL
);


ALTER TABLE acct_cust OWNER TO brianc;

--
-- Name: bank; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE bank (
    code integer NOT NULL,
    name character varying,
    address character varying
);


ALTER TABLE bank OWNER TO brianc;

--
-- Name: bank_branch; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE bank_branch (
    branchno integer NOT NULL,
    code integer NOT NULL,
    address character varying
);


ALTER TABLE bank_branch OWNER TO brianc;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE customer (
    ssn character varying NOT NULL,
    name character varying,
    addr character varying,
    phone character varying
);


ALTER TABLE customer OWNER TO brianc;

--
-- Name: loan; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE loan (
    loanno integer NOT NULL,
    type integer,
    amount numeric,
    branchno integer,
    code integer
);


ALTER TABLE loan OWNER TO brianc;

--
-- Name: loan_cust; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE loan_cust (
    loanno integer NOT NULL,
    ssn character varying NOT NULL
);


ALTER TABLE loan_cust OWNER TO brianc;

--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY account (acctno, type, balance, branchno, code) FROM stdin;
\.


--
-- Data for Name: acct_cust; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY acct_cust (acctno, ssn) FROM stdin;
\.


--
-- Data for Name: bank; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY bank (code, name, address) FROM stdin;
\.


--
-- Data for Name: bank_branch; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY bank_branch (branchno, code, address) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY customer (ssn, name, addr, phone) FROM stdin;
\.


--
-- Data for Name: loan; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY loan (loanno, type, amount, branchno, code) FROM stdin;
\.


--
-- Data for Name: loan_cust; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY loan_cust (loanno, ssn) FROM stdin;
\.


--
-- Name: account_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (acctno);


--
-- Name: acct_cust_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY acct_cust
    ADD CONSTRAINT acct_cust_pkey PRIMARY KEY (acctno, ssn);


--
-- Name: bank_branch_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY bank_branch
    ADD CONSTRAINT bank_branch_pkey PRIMARY KEY (branchno, code);


--
-- Name: bank_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT bank_pkey PRIMARY KEY (code);


--
-- Name: customer_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (ssn);


--
-- Name: loan_cust_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY loan_cust
    ADD CONSTRAINT loan_cust_pkey PRIMARY KEY (loanno, ssn);


--
-- Name: loan_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY loan
    ADD CONSTRAINT loan_pkey PRIMARY KEY (loanno);


--
-- Name: ac_constraint; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY acct_cust
    ADD CONSTRAINT ac_constraint FOREIGN KEY (acctno) REFERENCES account(acctno);


--
-- Name: ac_constraint; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY loan_cust
    ADD CONSTRAINT ac_constraint FOREIGN KEY (loanno) REFERENCES loan(loanno);


--
-- Name: branch_key; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY loan
    ADD CONSTRAINT branch_key FOREIGN KEY (branchno, code) REFERENCES bank_branch(branchno, code);


--
-- Name: branch_key; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY account
    ADD CONSTRAINT branch_key FOREIGN KEY (branchno, code) REFERENCES bank_branch(branchno, code);


--
-- Name: fk_bankno; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY bank_branch
    ADD CONSTRAINT fk_bankno FOREIGN KEY (code) REFERENCES bank(code);


--
-- Name: ss_constraint; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY acct_cust
    ADD CONSTRAINT ss_constraint FOREIGN KEY (ssn) REFERENCES customer(ssn);


--
-- Name: ss_constraint; Type: FK CONSTRAINT; Schema: public; Owner: brianc
--

ALTER TABLE ONLY loan_cust
    ADD CONSTRAINT ss_constraint FOREIGN KEY (ssn) REFERENCES customer(ssn);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

