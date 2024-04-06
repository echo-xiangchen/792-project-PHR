--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

SET default_table_access_method = heap;

--
-- Name: bt2_job_instance; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.bt2_job_instance (
    id character varying(100) NOT NULL,
    job_cancelled boolean NOT NULL,
    cmb_recs_processed integer,
    cmb_recs_per_sec double precision,
    create_time timestamp(6) without time zone NOT NULL,
    cur_gated_step_id character varying(100),
    definition_id character varying(100) NOT NULL,
    definition_ver integer NOT NULL,
    end_time timestamp(6) without time zone,
    error_count integer,
    error_msg character varying(500),
    est_remaining character varying(100),
    fast_tracking boolean,
    params_json character varying(2000),
    params_json_lob oid,
    progress_pct double precision,
    report oid,
    start_time timestamp(6) without time zone,
    stat character varying(20) NOT NULL,
    tot_elapsed_millis integer,
    client_id character varying(200),
    user_name character varying(200),
    update_time timestamp(6) without time zone,
    warning_msg character varying(4000),
    work_chunks_purged boolean NOT NULL,
    CONSTRAINT bt2_job_instance_stat_check CHECK (((stat)::text = ANY (ARRAY[('QUEUED'::character varying)::text, ('IN_PROGRESS'::character varying)::text, ('FINALIZE'::character varying)::text, ('COMPLETED'::character varying)::text, ('ERRORED'::character varying)::text, ('FAILED'::character varying)::text, ('CANCELLED'::character varying)::text])))
);


ALTER TABLE public.bt2_job_instance OWNER TO admin;

--
-- Name: bt2_work_chunk; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.bt2_work_chunk (
    id character varying(100) NOT NULL,
    create_time timestamp(6) without time zone NOT NULL,
    end_time timestamp(6) without time zone,
    error_count integer NOT NULL,
    error_msg character varying(500),
    instance_id character varying(100) NOT NULL,
    definition_id character varying(100) NOT NULL,
    definition_ver integer NOT NULL,
    records_processed integer,
    seq integer NOT NULL,
    chunk_data oid,
    start_time timestamp(6) without time zone,
    stat character varying(20) NOT NULL,
    tgt_step_id character varying(100) NOT NULL,
    update_time timestamp(6) without time zone,
    warning_msg character varying(4000),
    CONSTRAINT bt2_work_chunk_stat_check CHECK (((stat)::text = ANY (ARRAY[('QUEUED'::character varying)::text, ('IN_PROGRESS'::character varying)::text, ('ERRORED'::character varying)::text, ('FAILED'::character varying)::text, ('COMPLETED'::character varying)::text])))
);


ALTER TABLE public.bt2_work_chunk OWNER TO admin;

--
-- Name: hfj_binary_storage_blob; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_binary_storage_blob (
    blob_id character varying(200) NOT NULL,
    blob_data oid NOT NULL,
    content_type character varying(100) NOT NULL,
    blob_hash character varying(128),
    published_date timestamp(6) without time zone NOT NULL,
    resource_id character varying(100) NOT NULL,
    blob_size bigint
);


ALTER TABLE public.hfj_binary_storage_blob OWNER TO admin;

--
-- Name: hfj_blk_export_colfile; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_blk_export_colfile (
    pid bigint NOT NULL,
    res_id character varying(100) NOT NULL,
    collection_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_export_colfile OWNER TO admin;

--
-- Name: hfj_blk_export_collection; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_blk_export_collection (
    pid bigint NOT NULL,
    type_filter character varying(1000),
    res_type character varying(40) NOT NULL,
    optlock integer NOT NULL,
    job_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_export_collection OWNER TO admin;

--
-- Name: hfj_blk_export_job; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_blk_export_job (
    pid bigint NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    exp_time timestamp(6) without time zone,
    job_id character varying(36) NOT NULL,
    request character varying(1024) NOT NULL,
    exp_since timestamp(6) without time zone,
    job_status character varying(10) NOT NULL,
    status_message character varying(500),
    status_time timestamp(6) without time zone NOT NULL,
    optlock integer NOT NULL
);


ALTER TABLE public.hfj_blk_export_job OWNER TO admin;

--
-- Name: hfj_blk_import_job; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_blk_import_job (
    pid bigint NOT NULL,
    batch_size integer NOT NULL,
    file_count integer NOT NULL,
    job_desc character varying(500),
    job_id character varying(36) NOT NULL,
    row_processing_mode character varying(20) NOT NULL,
    job_status character varying(10) NOT NULL,
    status_message character varying(500),
    status_time timestamp(6) without time zone NOT NULL,
    optlock integer NOT NULL,
    CONSTRAINT hfj_blk_import_job_job_status_check CHECK (((job_status)::text = ANY (ARRAY[('STAGING'::character varying)::text, ('READY'::character varying)::text, ('RUNNING'::character varying)::text, ('COMPLETE'::character varying)::text, ('ERROR'::character varying)::text]))),
    CONSTRAINT hfj_blk_import_job_row_processing_mode_check CHECK (((row_processing_mode)::text = 'FHIR_TRANSACTION'::text))
);


ALTER TABLE public.hfj_blk_import_job OWNER TO admin;

--
-- Name: hfj_blk_import_jobfile; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_blk_import_jobfile (
    pid bigint NOT NULL,
    job_contents oid NOT NULL,
    file_description character varying(500),
    file_seq integer NOT NULL,
    tenant_name character varying(200),
    job_pid bigint NOT NULL
);


ALTER TABLE public.hfj_blk_import_jobfile OWNER TO admin;

--
-- Name: hfj_forced_id; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_forced_id (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    forced_id character varying(100) NOT NULL,
    resource_pid bigint NOT NULL,
    resource_type character varying(100) DEFAULT ''::character varying
);


ALTER TABLE public.hfj_forced_id OWNER TO admin;

--
-- Name: hfj_history_tag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_history_tag (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    tag_id bigint,
    res_ver_pid bigint NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(40) NOT NULL
);


ALTER TABLE public.hfj_history_tag OWNER TO admin;

--
-- Name: hfj_idx_cmb_tok_nu; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_idx_cmb_tok_nu (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    hash_complete bigint NOT NULL,
    idx_string character varying(500) NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_idx_cmb_tok_nu OWNER TO admin;

--
-- Name: hfj_idx_cmp_string_uniq; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_idx_cmp_string_uniq (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    idx_string character varying(500) NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_idx_cmp_string_uniq OWNER TO admin;

--
-- Name: hfj_partition; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_partition (
    part_id integer NOT NULL,
    part_desc character varying(200),
    part_name character varying(200) NOT NULL
);


ALTER TABLE public.hfj_partition OWNER TO admin;

--
-- Name: hfj_res_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_link (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    src_path character varying(500) NOT NULL,
    src_resource_id bigint NOT NULL,
    source_resource_type character varying(40) NOT NULL,
    target_resource_id bigint,
    target_resource_type character varying(40) NOT NULL,
    target_resource_url character varying(200),
    target_resource_version bigint,
    sp_updated timestamp(6) without time zone
);


ALTER TABLE public.hfj_res_link OWNER TO admin;

--
-- Name: hfj_res_param_present; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_param_present (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    hash_presence bigint,
    sp_present boolean NOT NULL,
    res_id bigint NOT NULL
);


ALTER TABLE public.hfj_res_param_present OWNER TO admin;

--
-- Name: hfj_res_reindex_job; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_reindex_job (
    pid bigint NOT NULL,
    job_deleted boolean NOT NULL,
    reindex_count integer,
    res_type character varying(100),
    suspended_until timestamp(6) without time zone,
    update_threshold_high timestamp(6) without time zone NOT NULL,
    update_threshold_low timestamp(6) without time zone
);


ALTER TABLE public.hfj_res_reindex_job OWNER TO admin;

--
-- Name: hfj_res_search_url; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_search_url (
    res_search_url character varying(768) NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    res_id bigint NOT NULL
);


ALTER TABLE public.hfj_res_search_url OWNER TO admin;

--
-- Name: hfj_res_tag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_tag (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    tag_id bigint,
    res_id bigint,
    res_type character varying(40) NOT NULL
);


ALTER TABLE public.hfj_res_tag OWNER TO admin;

--
-- Name: hfj_res_ver; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_ver (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    res_deleted_at timestamp(6) without time zone,
    res_version character varying(7),
    has_tags boolean NOT NULL,
    res_published timestamp(6) without time zone NOT NULL,
    res_updated timestamp(6) without time zone NOT NULL,
    res_encoding character varying(5) NOT NULL,
    request_id character varying(16),
    res_text oid,
    res_id bigint NOT NULL,
    res_text_vc text,
    res_type character varying(40) NOT NULL,
    res_ver bigint NOT NULL,
    source_uri character varying(100),
    CONSTRAINT hfj_res_ver_res_encoding_check CHECK (((res_encoding)::text = ANY (ARRAY[('JSON'::character varying)::text, ('JSONC'::character varying)::text, ('DEL'::character varying)::text, ('ESR'::character varying)::text]))),
    CONSTRAINT hfj_res_ver_res_version_check CHECK (((res_version)::text = ANY (ARRAY[('DSTU2'::character varying)::text, ('DSTU2_HL7ORG'::character varying)::text, ('DSTU2_1'::character varying)::text, ('DSTU3'::character varying)::text, ('R4'::character varying)::text, ('R4B'::character varying)::text, ('R5'::character varying)::text])))
);


ALTER TABLE public.hfj_res_ver OWNER TO admin;

--
-- Name: hfj_res_ver_prov; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_res_ver_prov (
    res_ver_pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    request_id character varying(16),
    source_uri character varying(100),
    res_pid bigint NOT NULL
);


ALTER TABLE public.hfj_res_ver_prov OWNER TO admin;

--
-- Name: hfj_resource; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_resource (
    res_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    res_deleted_at timestamp(6) without time zone,
    res_version character varying(7),
    has_tags boolean NOT NULL,
    res_published timestamp(6) without time zone NOT NULL,
    res_updated timestamp(6) without time zone NOT NULL,
    fhir_id character varying(64),
    sp_has_links boolean,
    hash_sha256 character varying(64),
    sp_index_status bigint,
    res_language character varying(20),
    sp_cmpstr_uniq_present boolean,
    sp_cmptoks_present boolean,
    sp_coords_present boolean,
    sp_date_present boolean,
    sp_number_present boolean,
    sp_quantity_nrml_present boolean,
    sp_quantity_present boolean,
    sp_string_present boolean,
    sp_token_present boolean,
    sp_uri_present boolean,
    res_type character varying(40) NOT NULL,
    search_url_present boolean,
    res_ver bigint,
    CONSTRAINT hfj_resource_res_version_check CHECK (((res_version)::text = ANY (ARRAY[('DSTU2'::character varying)::text, ('DSTU2_HL7ORG'::character varying)::text, ('DSTU2_1'::character varying)::text, ('DSTU3'::character varying)::text, ('R4'::character varying)::text, ('R4B'::character varying)::text, ('R5'::character varying)::text])))
);


ALTER TABLE public.hfj_resource OWNER TO admin;

--
-- Name: hfj_resource_modified; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_resource_modified (
    res_id character varying(256) NOT NULL,
    res_ver character varying(8) NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    resource_type character varying(40) NOT NULL,
    summary_message character varying(4000) NOT NULL
);


ALTER TABLE public.hfj_resource_modified OWNER TO admin;

--
-- Name: hfj_revinfo; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_revinfo (
    rev bigint NOT NULL,
    revtstmp timestamp(6) without time zone
);


ALTER TABLE public.hfj_revinfo OWNER TO admin;

--
-- Name: hfj_search; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_search (
    pid bigint NOT NULL,
    created timestamp(6) without time zone NOT NULL,
    search_deleted boolean,
    expiry_or_null timestamp(6) without time zone,
    failure_code integer,
    failure_message character varying(500),
    last_updated_high timestamp(6) without time zone,
    last_updated_low timestamp(6) without time zone,
    num_blocked integer,
    num_found integer NOT NULL,
    preferred_page_size integer,
    resource_id bigint,
    resource_type character varying(200),
    search_param_map oid,
    search_query_string oid,
    search_query_string_hash integer,
    search_type integer NOT NULL,
    search_status character varying(10) NOT NULL,
    total_count integer,
    search_uuid character varying(48) NOT NULL,
    optlock_version integer,
    CONSTRAINT hfj_search_search_status_check CHECK (((search_status)::text = ANY (ARRAY[('LOADING'::character varying)::text, ('PASSCMPLET'::character varying)::text, ('FINISHED'::character varying)::text, ('FAILED'::character varying)::text, ('GONE'::character varying)::text]))),
    CONSTRAINT hfj_search_search_type_check CHECK (((search_type >= 0) AND (search_type <= 2)))
);


ALTER TABLE public.hfj_search OWNER TO admin;

--
-- Name: hfj_search_include; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_search_include (
    pid bigint NOT NULL,
    search_include character varying(200) NOT NULL,
    inc_recurse boolean NOT NULL,
    revinclude boolean NOT NULL,
    search_pid bigint NOT NULL
);


ALTER TABLE public.hfj_search_include OWNER TO admin;

--
-- Name: hfj_search_result; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_search_result (
    pid bigint NOT NULL,
    search_order integer NOT NULL,
    resource_pid bigint NOT NULL,
    search_pid bigint NOT NULL
);


ALTER TABLE public.hfj_search_result OWNER TO admin;

--
-- Name: hfj_spidx_coords; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_coords (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    sp_latitude double precision,
    sp_longitude double precision
);


ALTER TABLE public.hfj_spidx_coords OWNER TO admin;

--
-- Name: hfj_spidx_date; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_date (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    sp_value_high timestamp(6) without time zone,
    sp_value_high_date_ordinal integer,
    sp_value_low timestamp(6) without time zone,
    sp_value_low_date_ordinal integer
);


ALTER TABLE public.hfj_spidx_date OWNER TO admin;

--
-- Name: hfj_spidx_number; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_number (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    sp_value numeric(19,2)
);


ALTER TABLE public.hfj_spidx_number OWNER TO admin;

--
-- Name: hfj_spidx_quantity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_quantity (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    hash_identity_and_units bigint,
    hash_identity_sys_units bigint,
    sp_system character varying(200),
    sp_units character varying(200),
    sp_value double precision
);


ALTER TABLE public.hfj_spidx_quantity OWNER TO admin;

--
-- Name: hfj_spidx_quantity_nrml; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_quantity_nrml (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    hash_identity_and_units bigint,
    hash_identity_sys_units bigint,
    sp_system character varying(200),
    sp_units character varying(200),
    sp_value double precision
);


ALTER TABLE public.hfj_spidx_quantity_nrml OWNER TO admin;

--
-- Name: hfj_spidx_string; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_string (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_exact bigint,
    hash_identity bigint,
    hash_norm_prefix bigint,
    sp_value_exact character varying(200),
    sp_value_normalized character varying(200)
);


ALTER TABLE public.hfj_spidx_string OWNER TO admin;

--
-- Name: hfj_spidx_token; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_token (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    hash_sys bigint,
    hash_sys_and_value bigint,
    hash_value bigint,
    sp_system character varying(200),
    sp_value character varying(200)
);


ALTER TABLE public.hfj_spidx_token OWNER TO admin;

--
-- Name: hfj_spidx_uri; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_spidx_uri (
    sp_id bigint NOT NULL,
    partition_date date,
    partition_id integer,
    sp_missing boolean NOT NULL,
    sp_name character varying(100) NOT NULL,
    res_id bigint NOT NULL,
    res_type character varying(100) NOT NULL,
    sp_updated timestamp(6) without time zone,
    hash_identity bigint,
    hash_uri bigint,
    sp_uri character varying(500)
);


ALTER TABLE public.hfj_spidx_uri OWNER TO admin;

--
-- Name: hfj_subscription_stats; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_subscription_stats (
    pid bigint NOT NULL,
    created_time timestamp(6) without time zone NOT NULL,
    res_id bigint
);


ALTER TABLE public.hfj_subscription_stats OWNER TO admin;

--
-- Name: hfj_tag_def; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hfj_tag_def (
    tag_id bigint NOT NULL,
    tag_code character varying(200),
    tag_display character varying(200),
    tag_system character varying(200),
    tag_type integer NOT NULL,
    tag_user_selected boolean,
    tag_version character varying(30),
    CONSTRAINT hfj_tag_def_tag_type_check CHECK (((tag_type >= 0) AND (tag_type <= 2)))
);


ALTER TABLE public.hfj_tag_def OWNER TO admin;

--
-- Name: mpi_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.mpi_link (
    pid bigint NOT NULL,
    partition_date date,
    partition_id integer,
    created timestamp(6) without time zone NOT NULL,
    eid_match boolean,
    golden_resource_pid bigint NOT NULL,
    new_person boolean,
    link_source integer NOT NULL,
    match_result integer NOT NULL,
    target_type character varying(40),
    person_pid bigint NOT NULL,
    rule_count bigint,
    score double precision,
    target_pid bigint NOT NULL,
    updated timestamp(6) without time zone NOT NULL,
    vector bigint,
    version character varying(16) NOT NULL,
    CONSTRAINT mpi_link_link_source_check CHECK (((link_source >= 0) AND (link_source <= 1))),
    CONSTRAINT mpi_link_match_result_check CHECK (((match_result >= 0) AND (match_result <= 5)))
);


ALTER TABLE public.mpi_link OWNER TO admin;

--
-- Name: mpi_link_aud; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.mpi_link_aud (
    pid bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    partition_date date,
    partition_id integer,
    created timestamp(6) without time zone,
    eid_match boolean,
    golden_resource_pid bigint,
    new_person boolean,
    link_source integer,
    match_result integer,
    target_type character varying(40),
    person_pid bigint,
    rule_count bigint,
    score double precision,
    target_pid bigint,
    updated timestamp(6) without time zone,
    vector bigint,
    version character varying(16),
    CONSTRAINT mpi_link_aud_link_source_check CHECK (((link_source >= 0) AND (link_source <= 1))),
    CONSTRAINT mpi_link_aud_match_result_check CHECK (((match_result >= 0) AND (match_result <= 5)))
);


ALTER TABLE public.mpi_link_aud OWNER TO admin;

--
-- Name: npm_package; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.npm_package (
    pid bigint NOT NULL,
    cur_version_id character varying(200),
    package_desc character varying(200),
    package_id character varying(200) NOT NULL,
    updated_time timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.npm_package OWNER TO admin;

--
-- Name: npm_package_ver; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.npm_package_ver (
    pid bigint NOT NULL,
    current_version boolean NOT NULL,
    pkg_desc character varying(200),
    desc_upper character varying(200),
    fhir_version character varying(10) NOT NULL,
    fhir_version_id character varying(20) NOT NULL,
    package_id character varying(200) NOT NULL,
    package_size_bytes bigint NOT NULL,
    saved_time timestamp(6) without time zone NOT NULL,
    updated_time timestamp(6) without time zone NOT NULL,
    version_id character varying(200) NOT NULL,
    package_pid bigint NOT NULL,
    binary_res_id bigint NOT NULL,
    CONSTRAINT npm_package_ver_fhir_version_check CHECK (((fhir_version)::text = ANY (ARRAY[('DSTU2'::character varying)::text, ('DSTU2_HL7ORG'::character varying)::text, ('DSTU2_1'::character varying)::text, ('DSTU3'::character varying)::text, ('R4'::character varying)::text, ('R4B'::character varying)::text, ('R5'::character varying)::text])))
);


ALTER TABLE public.npm_package_ver OWNER TO admin;

--
-- Name: npm_package_ver_res; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.npm_package_ver_res (
    pid bigint NOT NULL,
    canonical_url character varying(200),
    canonical_version character varying(200),
    file_dir character varying(200),
    fhir_version character varying(10) NOT NULL,
    fhir_version_id character varying(20) NOT NULL,
    file_name character varying(200),
    res_size_bytes bigint NOT NULL,
    res_type character varying(40) NOT NULL,
    updated_time timestamp(6) without time zone NOT NULL,
    packver_pid bigint NOT NULL,
    binary_res_id bigint NOT NULL,
    CONSTRAINT npm_package_ver_res_fhir_version_check CHECK (((fhir_version)::text = ANY (ARRAY[('DSTU2'::character varying)::text, ('DSTU2_HL7ORG'::character varying)::text, ('DSTU2_1'::character varying)::text, ('DSTU3'::character varying)::text, ('R4'::character varying)::text, ('R4B'::character varying)::text, ('R5'::character varying)::text])))
);


ALTER TABLE public.npm_package_ver_res OWNER TO admin;

--
-- Name: seq_blkexcol_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_blkexcol_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkexcol_pid OWNER TO admin;

--
-- Name: seq_blkexcolfile_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_blkexcolfile_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkexcolfile_pid OWNER TO admin;

--
-- Name: seq_blkexjob_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_blkexjob_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkexjob_pid OWNER TO admin;

--
-- Name: seq_blkimjob_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_blkimjob_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkimjob_pid OWNER TO admin;

--
-- Name: seq_blkimjobfile_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_blkimjobfile_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_blkimjobfile_pid OWNER TO admin;

--
-- Name: seq_cncpt_map_grp_elm_tgt_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_cncpt_map_grp_elm_tgt_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cncpt_map_grp_elm_tgt_pid OWNER TO admin;

--
-- Name: seq_codesystem_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_codesystem_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_codesystem_pid OWNER TO admin;

--
-- Name: seq_codesystemver_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_codesystemver_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_codesystemver_pid OWNER TO admin;

--
-- Name: seq_concept_desig_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_desig_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_desig_pid OWNER TO admin;

--
-- Name: seq_concept_map_group_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_map_group_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_map_group_pid OWNER TO admin;

--
-- Name: seq_concept_map_grp_elm_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_map_grp_elm_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_map_grp_elm_pid OWNER TO admin;

--
-- Name: seq_concept_map_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_map_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_map_pid OWNER TO admin;

--
-- Name: seq_concept_pc_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_pc_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_pc_pid OWNER TO admin;

--
-- Name: seq_concept_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_pid OWNER TO admin;

--
-- Name: seq_concept_prop_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_concept_prop_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_concept_prop_pid OWNER TO admin;

--
-- Name: seq_empi_link_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_empi_link_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_empi_link_id OWNER TO admin;

--
-- Name: seq_forcedid_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_forcedid_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forcedid_id OWNER TO admin;

--
-- Name: seq_hfj_revinfo; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_hfj_revinfo
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_hfj_revinfo OWNER TO admin;

--
-- Name: seq_historytag_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_historytag_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_historytag_id OWNER TO admin;

--
-- Name: seq_idxcmbtoknu_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_idxcmbtoknu_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_idxcmbtoknu_id OWNER TO admin;

--
-- Name: seq_idxcmpstruniq_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_idxcmpstruniq_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_idxcmpstruniq_id OWNER TO admin;

--
-- Name: seq_npm_pack; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_npm_pack
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_npm_pack OWNER TO admin;

--
-- Name: seq_npm_packver; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_npm_packver
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_npm_packver OWNER TO admin;

--
-- Name: seq_npm_packverres; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_npm_packverres
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_npm_packverres OWNER TO admin;

--
-- Name: seq_res_reindex_job; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_res_reindex_job
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_res_reindex_job OWNER TO admin;

--
-- Name: seq_reslink_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_reslink_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_reslink_id OWNER TO admin;

--
-- Name: seq_resource_history_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_resource_history_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resource_history_id OWNER TO admin;

--
-- Name: seq_resource_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_resource_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resource_id OWNER TO admin;

--
-- Name: seq_resparmpresent_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_resparmpresent_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resparmpresent_id OWNER TO admin;

--
-- Name: seq_restag_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_restag_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_restag_id OWNER TO admin;

--
-- Name: seq_search; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_search
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_search OWNER TO admin;

--
-- Name: seq_search_inc; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_search_inc
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_search_inc OWNER TO admin;

--
-- Name: seq_search_res; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_search_res
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_search_res OWNER TO admin;

--
-- Name: seq_spidx_coords; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_coords
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_coords OWNER TO admin;

--
-- Name: seq_spidx_date; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_date
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_date OWNER TO admin;

--
-- Name: seq_spidx_number; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_number
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_number OWNER TO admin;

--
-- Name: seq_spidx_quantity; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_quantity
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_quantity OWNER TO admin;

--
-- Name: seq_spidx_quantity_nrml; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_quantity_nrml
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_quantity_nrml OWNER TO admin;

--
-- Name: seq_spidx_string; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_string
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_string OWNER TO admin;

--
-- Name: seq_spidx_token; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_token
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_token OWNER TO admin;

--
-- Name: seq_spidx_uri; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_spidx_uri
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_spidx_uri OWNER TO admin;

--
-- Name: seq_subscription_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_subscription_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_subscription_id OWNER TO admin;

--
-- Name: seq_tagdef_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_tagdef_id
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tagdef_id OWNER TO admin;

--
-- Name: seq_valueset_c_dsgntn_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_valueset_c_dsgntn_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_valueset_c_dsgntn_pid OWNER TO admin;

--
-- Name: seq_valueset_concept_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_valueset_concept_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_valueset_concept_pid OWNER TO admin;

--
-- Name: seq_valueset_pid; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.seq_valueset_pid
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_valueset_pid OWNER TO admin;

--
-- Name: trm_codesystem; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_codesystem (
    pid bigint NOT NULL,
    code_system_uri character varying(200) NOT NULL,
    current_version_pid bigint,
    cs_name character varying(200),
    res_id bigint
);


ALTER TABLE public.trm_codesystem OWNER TO admin;

--
-- Name: trm_codesystem_ver; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_codesystem_ver (
    pid bigint NOT NULL,
    cs_display character varying(200),
    codesystem_pid bigint,
    cs_version_id character varying(200),
    res_id bigint NOT NULL
);


ALTER TABLE public.trm_codesystem_ver OWNER TO admin;

--
-- Name: trm_concept; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept (
    pid bigint NOT NULL,
    codeval character varying(500) NOT NULL,
    codesystem_pid bigint,
    display character varying(400),
    index_status bigint,
    parent_pids oid,
    code_sequence integer,
    concept_updated timestamp(6) without time zone
);


ALTER TABLE public.trm_concept OWNER TO admin;

--
-- Name: trm_concept_desig; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_desig (
    pid bigint NOT NULL,
    lang character varying(500),
    use_code character varying(500),
    use_display character varying(500),
    use_system character varying(500),
    val character varying(2000) NOT NULL,
    cs_ver_pid bigint,
    concept_pid bigint
);


ALTER TABLE public.trm_concept_desig OWNER TO admin;

--
-- Name: trm_concept_map; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_map (
    pid bigint NOT NULL,
    res_id bigint,
    source_url character varying(200),
    target_url character varying(200),
    url character varying(200) NOT NULL,
    ver character varying(200)
);


ALTER TABLE public.trm_concept_map OWNER TO admin;

--
-- Name: trm_concept_map_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_map_group (
    pid bigint NOT NULL,
    concept_map_url character varying(200),
    source_url character varying(200) NOT NULL,
    source_vs character varying(200),
    source_version character varying(200),
    target_url character varying(200) NOT NULL,
    target_vs character varying(200),
    target_version character varying(200),
    concept_map_pid bigint NOT NULL
);


ALTER TABLE public.trm_concept_map_group OWNER TO admin;

--
-- Name: trm_concept_map_grp_element; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_map_grp_element (
    pid bigint NOT NULL,
    source_code character varying(500) NOT NULL,
    concept_map_url character varying(200),
    source_display character varying(500),
    system_url character varying(200),
    system_version character varying(200),
    valueset_url character varying(200),
    concept_map_group_pid bigint NOT NULL
);


ALTER TABLE public.trm_concept_map_grp_element OWNER TO admin;

--
-- Name: trm_concept_map_grp_elm_tgt; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_map_grp_elm_tgt (
    pid bigint NOT NULL,
    target_code character varying(500) NOT NULL,
    concept_map_url character varying(200),
    target_display character varying(500),
    target_equivalence character varying(50),
    system_url character varying(200),
    system_version character varying(200),
    valueset_url character varying(200),
    concept_map_grp_elm_pid bigint NOT NULL,
    CONSTRAINT trm_concept_map_grp_elm_tgt_target_equivalence_check CHECK (((target_equivalence)::text = ANY (ARRAY[('RELATEDTO'::character varying)::text, ('EQUIVALENT'::character varying)::text, ('EQUAL'::character varying)::text, ('WIDER'::character varying)::text, ('SUBSUMES'::character varying)::text, ('NARROWER'::character varying)::text, ('SPECIALIZES'::character varying)::text, ('INEXACT'::character varying)::text, ('UNMATCHED'::character varying)::text, ('DISJOINT'::character varying)::text, ('NULL'::character varying)::text])))
);


ALTER TABLE public.trm_concept_map_grp_elm_tgt OWNER TO admin;

--
-- Name: trm_concept_pc_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_pc_link (
    pid bigint NOT NULL,
    child_pid bigint,
    codesystem_pid bigint NOT NULL,
    parent_pid bigint,
    rel_type integer,
    CONSTRAINT trm_concept_pc_link_rel_type_check CHECK (((rel_type >= 0) AND (rel_type <= 0)))
);


ALTER TABLE public.trm_concept_pc_link OWNER TO admin;

--
-- Name: trm_concept_property; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_concept_property (
    pid bigint NOT NULL,
    prop_codesystem character varying(500),
    prop_display character varying(500),
    prop_key character varying(500) NOT NULL,
    prop_type integer NOT NULL,
    prop_val character varying(500),
    prop_val_lob oid,
    cs_ver_pid bigint,
    concept_pid bigint,
    CONSTRAINT trm_concept_property_prop_type_check CHECK (((prop_type >= 0) AND (prop_type <= 1)))
);


ALTER TABLE public.trm_concept_property OWNER TO admin;

--
-- Name: trm_valueset; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_valueset (
    pid bigint NOT NULL,
    expansion_status character varying(50) NOT NULL,
    expanded_at timestamp(6) without time zone,
    vsname character varying(200),
    res_id bigint,
    total_concept_designations bigint DEFAULT 0 NOT NULL,
    total_concepts bigint DEFAULT 0 NOT NULL,
    url character varying(200) NOT NULL,
    ver character varying(200),
    CONSTRAINT trm_valueset_expansion_status_check CHECK (((expansion_status)::text = ANY (ARRAY[('NOT_EXPANDED'::character varying)::text, ('EXPANSION_IN_PROGRESS'::character varying)::text, ('EXPANDED'::character varying)::text, ('FAILED_TO_EXPAND'::character varying)::text])))
);


ALTER TABLE public.trm_valueset OWNER TO admin;

--
-- Name: trm_valueset_c_designation; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_valueset_c_designation (
    pid bigint NOT NULL,
    valueset_concept_pid bigint NOT NULL,
    lang character varying(500),
    use_code character varying(500),
    use_display character varying(500),
    use_system character varying(500),
    val character varying(2000) NOT NULL,
    valueset_pid bigint NOT NULL
);


ALTER TABLE public.trm_valueset_c_designation OWNER TO admin;

--
-- Name: trm_valueset_concept; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trm_valueset_concept (
    pid bigint NOT NULL,
    codeval character varying(500) NOT NULL,
    display character varying(400),
    index_status bigint,
    valueset_order integer NOT NULL,
    source_direct_parent_pids oid,
    source_pid bigint,
    system_url character varying(200) NOT NULL,
    system_ver character varying(200),
    valueset_pid bigint NOT NULL
);


ALTER TABLE public.trm_valueset_concept OWNER TO admin;

--
-- Name: 17210; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17210');


ALTER LARGE OBJECT 17210 OWNER TO admin;

--
-- Name: 17211; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17211');


ALTER LARGE OBJECT 17211 OWNER TO admin;

--
-- Name: 17212; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17212');


ALTER LARGE OBJECT 17212 OWNER TO admin;

--
-- Name: 17213; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17213');


ALTER LARGE OBJECT 17213 OWNER TO admin;

--
-- Name: 17214; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17214');


ALTER LARGE OBJECT 17214 OWNER TO admin;

--
-- Name: 17215; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17215');


ALTER LARGE OBJECT 17215 OWNER TO admin;

--
-- Name: 17216; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17216');


ALTER LARGE OBJECT 17216 OWNER TO admin;

--
-- Name: 17217; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17217');


ALTER LARGE OBJECT 17217 OWNER TO admin;

--
-- Name: 17218; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17218');


ALTER LARGE OBJECT 17218 OWNER TO admin;

--
-- Name: 25398; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('25398');


ALTER LARGE OBJECT 25398 OWNER TO admin;

--
-- Name: 25409; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('25409');


ALTER LARGE OBJECT 25409 OWNER TO admin;

--
-- Name: 25410; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('25410');


ALTER LARGE OBJECT 25410 OWNER TO admin;

--
-- Name: 25411; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('25411');


ALTER LARGE OBJECT 25411 OWNER TO admin;

--
-- Name: 25412; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('25412');


ALTER LARGE OBJECT 25412 OWNER TO admin;

--
-- Name: 33590; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33590');


ALTER LARGE OBJECT 33590 OWNER TO admin;

--
-- Name: 33601; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33601');


ALTER LARGE OBJECT 33601 OWNER TO admin;

--
-- Name: 33602; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33602');


ALTER LARGE OBJECT 33602 OWNER TO admin;

--
-- Name: 33603; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33603');


ALTER LARGE OBJECT 33603 OWNER TO admin;

--
-- Data for Name: bt2_job_instance; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.bt2_job_instance (id, job_cancelled, cmb_recs_processed, cmb_recs_per_sec, create_time, cur_gated_step_id, definition_id, definition_ver, end_time, error_count, error_msg, est_remaining, fast_tracking, params_json, params_json_lob, progress_pct, report, start_time, stat, tot_elapsed_millis, client_id, user_name, update_time, warning_msg, work_chunks_purged) FROM stdin;
\.


--
-- Data for Name: bt2_work_chunk; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.bt2_work_chunk (id, create_time, end_time, error_count, error_msg, instance_id, definition_id, definition_ver, records_processed, seq, chunk_data, start_time, stat, tgt_step_id, update_time, warning_msg) FROM stdin;
\.


--
-- Data for Name: hfj_binary_storage_blob; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_binary_storage_blob (blob_id, blob_data, content_type, blob_hash, published_date, resource_id, blob_size) FROM stdin;
\.


--
-- Data for Name: hfj_blk_export_colfile; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_blk_export_colfile (pid, res_id, collection_pid) FROM stdin;
\.


--
-- Data for Name: hfj_blk_export_collection; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_blk_export_collection (pid, type_filter, res_type, optlock, job_pid) FROM stdin;
\.


--
-- Data for Name: hfj_blk_export_job; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_blk_export_job (pid, created_time, exp_time, job_id, request, exp_since, job_status, status_message, status_time, optlock) FROM stdin;
\.


--
-- Data for Name: hfj_blk_import_job; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_blk_import_job (pid, batch_size, file_count, job_desc, job_id, row_processing_mode, job_status, status_message, status_time, optlock) FROM stdin;
\.


--
-- Data for Name: hfj_blk_import_jobfile; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_blk_import_jobfile (pid, job_contents, file_description, file_seq, tenant_name, job_pid) FROM stdin;
\.


--
-- Data for Name: hfj_forced_id; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_forced_id (pid, partition_date, partition_id, forced_id, resource_pid, resource_type) FROM stdin;
\.


--
-- Data for Name: hfj_history_tag; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_history_tag (pid, partition_date, partition_id, tag_id, res_ver_pid, res_id, res_type) FROM stdin;
1	\N	\N	2	1	1	Patient
2	\N	\N	1	1	1	Patient
52	\N	\N	52	52	52	Encounter
53	\N	\N	52	53	53	Encounter
54	\N	\N	52	54	54	Encounter
55	\N	\N	52	55	55	Encounter
102	\N	\N	52	102	52	Encounter
103	\N	\N	52	103	53	Encounter
104	\N	\N	52	104	54	Encounter
105	\N	\N	52	105	55	Encounter
\.


--
-- Data for Name: hfj_idx_cmb_tok_nu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_idx_cmb_tok_nu (pid, partition_date, partition_id, hash_complete, idx_string, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_idx_cmp_string_uniq; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_idx_cmp_string_uniq (pid, partition_date, partition_id, idx_string, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_partition; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_partition (part_id, part_desc, part_name) FROM stdin;
\.


--
-- Data for Name: hfj_res_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_link (pid, partition_date, partition_id, src_path, src_resource_id, source_resource_type, target_resource_id, target_resource_type, target_resource_url, target_resource_version, sp_updated) FROM stdin;
1	\N	\N	Observation.performer	2	Observation	1	Patient	\N	\N	2024-03-29 23:55:08.917
2	\N	\N	Observation.subject	2	Observation	1	Patient	\N	\N	2024-03-29 23:55:08.917
3	\N	\N	Observation.subject.where(resolve() is Patient)	2	Observation	1	Patient	\N	\N	2024-03-29 23:55:08.917
4	\N	\N	Observation.subject	3	Observation	1	Patient	\N	\N	2024-03-29 23:55:12.906
5	\N	\N	Observation.performer	3	Observation	1	Patient	\N	\N	2024-03-29 23:55:12.906
6	\N	\N	Observation.subject.where(resolve() is Patient)	3	Observation	1	Patient	\N	\N	2024-03-29 23:55:12.906
7	\N	\N	Observation.performer	4	Observation	1	Patient	\N	\N	2024-03-29 23:56:23.176
8	\N	\N	Observation.subject.where(resolve() is Patient)	4	Observation	1	Patient	\N	\N	2024-03-29 23:56:23.176
9	\N	\N	Observation.subject	4	Observation	1	Patient	\N	\N	2024-03-29 23:56:23.176
10	\N	\N	Observation.subject.where(resolve() is Patient)	5	Observation	1	Patient	\N	\N	2024-03-29 23:56:27.008
11	\N	\N	Observation.performer	5	Observation	1	Patient	\N	\N	2024-03-29 23:56:27.008
12	\N	\N	Observation.subject	5	Observation	1	Patient	\N	\N	2024-03-29 23:56:27.008
13	\N	\N	Observation.subject.where(resolve() is Patient)	6	Observation	1	Patient	\N	\N	2024-03-29 23:56:31.035
14	\N	\N	Observation.subject	6	Observation	1	Patient	\N	\N	2024-03-29 23:56:31.035
15	\N	\N	Observation.performer	6	Observation	1	Patient	\N	\N	2024-03-29 23:56:31.035
16	\N	\N	Observation.performer	7	Observation	1	Patient	\N	\N	2024-03-29 23:56:34.972
17	\N	\N	Observation.subject.where(resolve() is Patient)	7	Observation	1	Patient	\N	\N	2024-03-29 23:56:34.972
18	\N	\N	Observation.subject	7	Observation	1	Patient	\N	\N	2024-03-29 23:56:34.972
19	\N	\N	Observation.subject	8	Observation	1	Patient	\N	\N	2024-03-29 23:56:39.613
20	\N	\N	Observation.subject.where(resolve() is Patient)	8	Observation	1	Patient	\N	\N	2024-03-29 23:56:39.613
21	\N	\N	Observation.performer	8	Observation	1	Patient	\N	\N	2024-03-29 23:56:39.613
\.


--
-- Data for Name: hfj_res_param_present; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_param_present (pid, partition_date, partition_id, hash_presence, sp_present, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_res_reindex_job; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_reindex_job (pid, job_deleted, reindex_count, res_type, suspended_until, update_threshold_high, update_threshold_low) FROM stdin;
\.


--
-- Data for Name: hfj_res_search_url; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_search_url (res_search_url, created_time, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_res_tag; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_tag (pid, partition_date, partition_id, tag_id, res_id, res_type) FROM stdin;
1	\N	\N	2	1	Patient
2	\N	\N	1	1	Patient
52	\N	\N	52	52	Encounter
53	\N	\N	52	53	Encounter
54	\N	\N	52	54	Encounter
55	\N	\N	52	55	Encounter
\.


--
-- Data for Name: hfj_res_ver; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_ver (pid, partition_date, partition_id, res_deleted_at, res_version, has_tags, res_published, res_updated, res_encoding, request_id, res_text, res_id, res_text_vc, res_type, res_ver, source_uri) FROM stdin;
1	\N	\N	\N	R4	t	2024-03-29 23:54:58.86	2024-03-29 23:54:58.86	JSON	b0u23gsQL8OW3g1a	\N	1	{"resourceType":"Patient","identifier":[{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"RRI"}],"text":"eHealth Ontario Enterprise Identifier"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid","value":"2923"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"MR"}],"text":"Wait Time Information System"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-example-uri","value":"FULL_PROFILE_LEN3"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"JHN"}],"text":"Ontario, Canada Personal Health Number"},"system":"https://fhir.infoway-inforoute.ca/NamingSystem/ca-on-patient-hcn","value":"6132001124"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"MR"}],"text":"Brantford General"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-example1-uri","value":"WSD00038992"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"JHN"}],"text":"British Columbia, Personal Health Number"},"system":"https://fhir.infoway-inforoute.ca/NamingSystem/ca-bc-patient-healthcare-id","value":"1806194839"}],"name":[{"use":"official","family":"Ma","given":["Yun"]}],"telecom":[{"system":"phone","value":"+1-222-22-22","use":"home"},{"system":"email","value":"test2@uwaterloo.ca","use":"home"}],"gender":"male","birthDate":"1951-01-02","address":[{"use":"home","type":"physical","line":["HomeAd HomeAddress.stName 2"],"city":"Waterloo","state":"ON","postalCode":"K4A0K6","country":"CAN"}],"contact":[{"relationship":[{"coding":[{"system":"http://hl7.org/fhir/v2/0131","code":"C","display":"Emergency Contact"}]}],"telecom":[{"system":"phone","value":"+1-222-22-23"}]}],"communication":[{"language":{"coding":[{"system":"urn:ietf:bcp:47","code":"en","display":"English"}]},"preferred":true}]}	Patient	1	\N
2	\N	\N	\N	R4	f	2024-03-29 23:55:08.917	2024-03-29 23:55:08.917	JSON	g9BAKwJUF3grLwlD	\N	2	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-02-29T06:51:00+00:00","issued":"2024-02-29T06:51:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":5.1,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
3	\N	\N	\N	R4	f	2024-03-29 23:55:12.906	2024-03-29 23:55:12.906	JSON	DIyzEXeMcuTWoL9W	\N	3	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-06T06:30:00+00:00","issued":"2024-03-06T06:30:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":5.1,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
4	\N	\N	\N	R4	f	2024-03-29 23:56:23.176	2024-03-29 23:56:23.176	JSON	PRF31JGUIf8tudK1	\N	4	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"After meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-05T12:03:00+00:00","issued":"2024-03-05T12:03:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":10.3,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"H","display":"High"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":10.0,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal postprandial glucose range"}}]}	Observation	1	\N
5	\N	\N	\N	R4	f	2024-03-29 23:56:27.008	2024-03-29 23:56:27.008	JSON	wWdYs9Ee59Oi6FWM	\N	5	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-05T18:35:00+00:00","issued":"2024-03-05T18:35:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":5.1,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
6	\N	\N	\N	R4	f	2024-03-29 23:56:31.035	2024-03-29 23:56:31.035	JSON	xk6fkXK9NMXgbd1A	\N	6	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-05T06:35:00+00:00","issued":"2024-03-05T06:35:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":3.5,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"L","display":"Low"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
7	\N	\N	\N	R4	f	2024-03-29 23:56:34.972	2024-03-29 23:56:34.972	JSON	qHeGPSmxG0cwPYZG	\N	7	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-06T12:30:00+00:00","issued":"2024-03-06T12:30:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":5.6,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
8	\N	\N	\N	R4	f	2024-03-29 23:56:39.613	2024-03-29 23:56:39.613	JSON	vP0gI08NoS6Oe0NI	\N	8	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-06T18:40:00+00:00","issued":"2024-03-06T18:40:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":6.4,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
52	\N	\N	\N	R4	t	2024-03-30 03:59:58.193	2024-03-30 03:59:58.193	JSON	dUF0ncWgG2KwxaAK	\N	52	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
53	\N	\N	\N	R4	t	2024-03-30 04:01:12.601	2024-03-30 04:01:12.601	JSON	SRpAvzbHaBGeBlqv	\N	53	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
54	\N	\N	\N	R4	t	2024-03-30 04:02:01.224	2024-03-30 04:02:01.224	JSON	l4OXukzBRWavs0tF	\N	54	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
55	\N	\N	\N	R4	t	2024-03-30 04:03:25.669	2024-03-30 04:03:25.669	JSON	9GLQYhXDrXTYr0bB	\N	55	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
102	\N	\N	2024-03-30 04:24:23.043	R4	t	2024-03-30 03:59:58.193	2024-03-30 04:24:23.043	DEL	MxXC4qW1S2xx2o2C	\N	52	\N	Encounter	2	\N
103	\N	\N	2024-03-30 04:24:27.377	R4	t	2024-03-30 04:01:12.601	2024-03-30 04:24:27.377	DEL	rQaFHotQsyCtM6Cs	\N	53	\N	Encounter	2	\N
104	\N	\N	2024-03-30 04:24:32.494	R4	t	2024-03-30 04:02:01.224	2024-03-30 04:24:32.494	DEL	tFUsUKp6EgOsGW8v	\N	54	\N	Encounter	2	\N
105	\N	\N	2024-03-30 04:24:37.28	R4	t	2024-03-30 04:03:25.669	2024-03-30 04:24:37.28	DEL	T0OjeCRnSxgXM6cf	\N	55	\N	Encounter	2	\N
152	\N	\N	\N	R4	f	2024-03-30 05:33:49.536	2024-03-30 05:33:49.536	JSON	tqcqgVvaoGJSN0Kh	\N	102	{"resourceType":"Observation","identifier":[{"use":"official","system":"http://www.bmc.nl/zorgportal/identifiers/observations","value":"6323"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"14743-9","display":"Glucose [Moles/volume] in Capillary blood by Glucometer"}],"text":"Before meal"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-03-06T18:40:00+00:00","issued":"2024-03-06T18:40:00+00:00","performer":[{"reference":"Patient/1"}],"valueQuantity":{"value":6.4,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.2,"unit":"mmol/l","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal preprandial glucose range"}}]}	Observation	1	\N
153	\N	\N	2024-03-30 05:34:24.798	R4	f	2024-03-30 05:33:49.536	2024-03-30 05:34:24.798	DEL	2o0cocOgoPxDchPh	\N	102	\N	Observation	2	\N
\.


--
-- Data for Name: hfj_res_ver_prov; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_ver_prov (res_ver_pid, partition_date, partition_id, request_id, source_uri, res_pid) FROM stdin;
1	\N	\N	b0u23gsQL8OW3g1a	\N	1
2	\N	\N	g9BAKwJUF3grLwlD	\N	2
3	\N	\N	DIyzEXeMcuTWoL9W	\N	3
4	\N	\N	PRF31JGUIf8tudK1	\N	4
5	\N	\N	wWdYs9Ee59Oi6FWM	\N	5
6	\N	\N	xk6fkXK9NMXgbd1A	\N	6
7	\N	\N	qHeGPSmxG0cwPYZG	\N	7
8	\N	\N	vP0gI08NoS6Oe0NI	\N	8
52	\N	\N	dUF0ncWgG2KwxaAK	\N	52
53	\N	\N	SRpAvzbHaBGeBlqv	\N	53
54	\N	\N	l4OXukzBRWavs0tF	\N	54
55	\N	\N	9GLQYhXDrXTYr0bB	\N	55
102	\N	\N	MxXC4qW1S2xx2o2C	\N	52
103	\N	\N	rQaFHotQsyCtM6Cs	\N	53
104	\N	\N	tFUsUKp6EgOsGW8v	\N	54
105	\N	\N	T0OjeCRnSxgXM6cf	\N	55
152	\N	\N	tqcqgVvaoGJSN0Kh	\N	102
153	\N	\N	2o0cocOgoPxDchPh	\N	102
\.


--
-- Data for Name: hfj_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_resource (res_id, partition_date, partition_id, res_deleted_at, res_version, has_tags, res_published, res_updated, fhir_id, sp_has_links, hash_sha256, sp_index_status, res_language, sp_cmpstr_uniq_present, sp_cmptoks_present, sp_coords_present, sp_date_present, sp_number_present, sp_quantity_nrml_present, sp_quantity_present, sp_string_present, sp_token_present, sp_uri_present, res_type, search_url_present, res_ver) FROM stdin;
1	\N	\N	\N	R4	t	2024-03-29 23:54:58.86	2024-03-29 23:54:58.86	1	f	85b0976c7c22bf0348e72ea5a71140454e6e99566c3e94f9b4d71d93ce439352	1	\N	f	f	f	t	f	f	f	t	t	f	Patient	f	1
2	\N	\N	\N	R4	f	2024-03-29 23:55:08.917	2024-03-29 23:55:08.917	2	t	de5bc224cbc584121c5c7250e77f49c03e232d014322d6af567834a65bba4ebf	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
3	\N	\N	\N	R4	f	2024-03-29 23:55:12.906	2024-03-29 23:55:12.906	3	t	22990e792f483ae7fb46f0ac4fc6814c50b3f4dc44c47696efc82256f6349b23	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
4	\N	\N	\N	R4	f	2024-03-29 23:56:23.176	2024-03-29 23:56:23.176	4	t	121598a7b852df5f199d18aae7c5d5ab2bfb4a403246caf72c4b7e20d748cdef	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
5	\N	\N	\N	R4	f	2024-03-29 23:56:27.008	2024-03-29 23:56:27.008	5	t	49b694c8692674534ed9262a376331522ffa59b6d6cbdc8704a0c47cc9278231	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
6	\N	\N	\N	R4	f	2024-03-29 23:56:31.035	2024-03-29 23:56:31.035	6	t	e1ed6282cf4f3e09db78afcc498f1ae1f74b19b1088b9bf80322567eb2b7e262	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
7	\N	\N	\N	R4	f	2024-03-29 23:56:34.972	2024-03-29 23:56:34.972	7	t	9281e0d797e8fd3c679b4af67e7e0cdbbe5b882d6e7bebbcd12fa77435e50bbc	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
8	\N	\N	\N	R4	f	2024-03-29 23:56:39.613	2024-03-29 23:56:39.613	8	t	726089d7fd1e99024412ebde37a9607159b1d13604728dbcb4d794300169f58d	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
52	\N	\N	2024-03-30 04:24:23.043	R4	t	2024-03-30 03:59:58.193	2024-03-30 04:24:23.043	52	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	Encounter	f	2
53	\N	\N	2024-03-30 04:24:27.377	R4	t	2024-03-30 04:01:12.601	2024-03-30 04:24:27.377	53	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	Encounter	f	2
54	\N	\N	2024-03-30 04:24:32.494	R4	t	2024-03-30 04:02:01.224	2024-03-30 04:24:32.494	54	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	Encounter	f	2
55	\N	\N	2024-03-30 04:24:37.28	R4	t	2024-03-30 04:03:25.669	2024-03-30 04:24:37.28	55	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	Encounter	f	2
102	\N	\N	2024-03-30 05:34:24.798	R4	f	2024-03-30 05:33:49.536	2024-03-30 05:34:24.798	102	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	Observation	f	2
\.


--
-- Data for Name: hfj_resource_modified; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_resource_modified (res_id, res_ver, created_time, resource_type, summary_message) FROM stdin;
\.


--
-- Data for Name: hfj_revinfo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_revinfo (rev, revtstmp) FROM stdin;
\.


--
-- Data for Name: hfj_search; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_search (pid, created, search_deleted, expiry_or_null, failure_code, failure_message, last_updated_high, last_updated_low, num_blocked, num_found, preferred_page_size, resource_id, resource_type, search_param_map, search_query_string, search_query_string_hash, search_type, search_status, total_count, search_uuid, optlock_version) FROM stdin;
\.


--
-- Data for Name: hfj_search_include; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_search_include (pid, search_include, inc_recurse, revinclude, search_pid) FROM stdin;
\.


--
-- Data for Name: hfj_search_result; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_search_result (pid, search_order, resource_pid, search_pid) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_coords; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_coords (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, sp_latitude, sp_longitude) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_date; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_date (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, sp_value_high, sp_value_high_date_ordinal, sp_value_low, sp_value_low_date_ordinal) FROM stdin;
1	\N	\N	f	birthdate	1	Patient	2024-03-29 23:54:58.86	5247847184787287691	1951-01-02 23:59:59.999	19510102	1951-01-02 00:00:00	19510102
2	\N	\N	f	date	2	Observation	2024-03-29 23:55:08.917	123682819940570799	2024-02-29 06:51:00	20240229	2024-02-29 06:51:00	20240229
3	\N	\N	f	date	3	Observation	2024-03-29 23:55:12.906	123682819940570799	2024-03-06 06:30:00	20240306	2024-03-06 06:30:00	20240306
4	\N	\N	f	date	4	Observation	2024-03-29 23:56:23.176	123682819940570799	2024-03-05 12:03:00	20240305	2024-03-05 12:03:00	20240305
5	\N	\N	f	date	5	Observation	2024-03-29 23:56:27.008	123682819940570799	2024-03-05 18:35:00	20240305	2024-03-05 18:35:00	20240305
6	\N	\N	f	date	6	Observation	2024-03-29 23:56:31.035	123682819940570799	2024-03-05 06:35:00	20240305	2024-03-05 06:35:00	20240305
7	\N	\N	f	date	7	Observation	2024-03-29 23:56:34.972	123682819940570799	2024-03-06 12:30:00	20240306	2024-03-06 12:30:00	20240306
8	\N	\N	f	date	8	Observation	2024-03-29 23:56:39.613	123682819940570799	2024-03-06 18:40:00	20240306	2024-03-06 18:40:00	20240306
\.


--
-- Data for Name: hfj_spidx_number; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_number (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, sp_value) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_quantity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_quantity (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_identity_and_units, hash_identity_sys_units, sp_system, sp_units, sp_value) FROM stdin;
1	\N	\N	f	value-quantity	2	Observation	2024-03-29 23:55:08.917	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	5.1
2	\N	\N	f	combo-value-quantity	2	Observation	2024-03-29 23:55:08.917	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	5.1
3	\N	\N	f	value-quantity	3	Observation	2024-03-29 23:55:12.906	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	5.1
4	\N	\N	f	combo-value-quantity	3	Observation	2024-03-29 23:55:12.906	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	5.1
5	\N	\N	f	value-quantity	4	Observation	2024-03-29 23:56:23.176	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	10.3
6	\N	\N	f	combo-value-quantity	4	Observation	2024-03-29 23:56:23.176	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	10.3
7	\N	\N	f	value-quantity	5	Observation	2024-03-29 23:56:27.008	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	5.1
8	\N	\N	f	combo-value-quantity	5	Observation	2024-03-29 23:56:27.008	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	5.1
9	\N	\N	f	value-quantity	6	Observation	2024-03-29 23:56:31.035	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	3.5
10	\N	\N	f	combo-value-quantity	6	Observation	2024-03-29 23:56:31.035	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	3.5
11	\N	\N	f	value-quantity	7	Observation	2024-03-29 23:56:34.972	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	5.6
12	\N	\N	f	combo-value-quantity	7	Observation	2024-03-29 23:56:34.972	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	5.6
13	\N	\N	f	value-quantity	8	Observation	2024-03-29 23:56:39.613	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	6.4
14	\N	\N	f	combo-value-quantity	8	Observation	2024-03-29 23:56:39.613	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	6.4
\.


--
-- Data for Name: hfj_spidx_quantity_nrml; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_quantity_nrml (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_identity_and_units, hash_identity_sys_units, sp_system, sp_units, sp_value) FROM stdin;
\.


--
-- Data for Name: hfj_spidx_string; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_string (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_exact, hash_identity, hash_norm_prefix, sp_value_exact, sp_value_normalized) FROM stdin;
1	\N	\N	f	name	1	Patient	2024-03-29 23:54:58.86	2374967257783229968	-1575415002568401616	-1463252090913723117	Yun	YUN
2	\N	\N	f	phonetic	1	Patient	2024-03-29 23:54:58.86	4748149162531866042	7732772475369838403	8317716575692629438	Ma	MA
3	\N	\N	f	address	1	Patient	2024-03-29 23:54:58.86	-3245261296918131802	-9161155455489687346	6193891337602857657	K4A0K6	K4A0K6
4	\N	\N	f	address-city	1	Patient	2024-03-29 23:54:58.86	3728378764232781438	4606538046458125917	-2007342453513273382	Waterloo	WATERLOO
5	\N	\N	f	family	1	Patient	2024-03-29 23:54:58.86	6230551898613947727	-9208284524139093953	8785853102554743158	Ma	MA
6	\N	\N	f	address-postalcode	1	Patient	2024-03-29 23:54:58.86	6441953884142218794	1142610086203790987	6783823457865320082	K4A0K6	K4A0K6
7	\N	\N	f	address	1	Patient	2024-03-29 23:54:58.86	1895554620606153389	-9161155455489687346	6193891337602857657	Waterloo	WATERLOO
8	\N	\N	f	language	1	Patient	2024-03-29 23:54:58.86	4995740588116258854	-6338030716006204643	8668447586533091895	English	ENGLISH
9	\N	\N	f	address	1	Patient	2024-03-29 23:54:58.86	3948778197267779573	-9161155455489687346	6193891337602857657	HomeAd HomeAddress.stName 2	HOMEAD HOMEADDRESS.STNAME 2
10	\N	\N	f	name	1	Patient	2024-03-29 23:54:58.86	-4898293605585357492	-1575415002568401616	-1463252090913723117	Ma	MA
11	\N	\N	f	given	1	Patient	2024-03-29 23:54:58.86	-8765631125341099714	-7533943853970611242	2239503174397326353	Yun	YUN
12	\N	\N	f	phonetic	1	Patient	2024-03-29 23:54:58.86	2172835642610956947	7732772475369838403	8317716575692629438	Yun	YUN
13	\N	\N	f	address	1	Patient	2024-03-29 23:54:58.86	-6949423222572959759	-9161155455489687346	6193891337602857657	ON	ON
14	\N	\N	f	address-country	1	Patient	2024-03-29 23:54:58.86	-6483138198484899228	8394007005180337668	4199164108628295473	CAN	CAN
15	\N	\N	f	address	1	Patient	2024-03-29 23:54:58.86	3220726170287243136	-9161155455489687346	6193891337602857657	CAN	CAN
16	\N	\N	f	address-state	1	Patient	2024-03-29 23:54:58.86	-8058086075220455848	6163711124349647528	-6233579723713934864	ON	ON
17	\N	\N	f	code	2	Observation	2024-03-29 23:55:08.917	1406456452800120149	2255293283549704696	7952934451955757422	Before meal	BEFORE MEAL
18	\N	\N	f	combo-code	2	Observation	2024-03-29 23:55:08.917	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
19	\N	\N	f	code	2	Observation	2024-03-29 23:55:08.917	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
20	\N	\N	f	combo-code	2	Observation	2024-03-29 23:55:08.917	2182465808393806126	-1575406001252496924	3219723693549490985	Before meal	BEFORE MEAL
21	\N	\N	f	code	3	Observation	2024-03-29 23:55:12.906	1406456452800120149	2255293283549704696	7952934451955757422	Before meal	BEFORE MEAL
22	\N	\N	f	combo-code	3	Observation	2024-03-29 23:55:12.906	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
23	\N	\N	f	code	3	Observation	2024-03-29 23:55:12.906	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
24	\N	\N	f	combo-code	3	Observation	2024-03-29 23:55:12.906	2182465808393806126	-1575406001252496924	3219723693549490985	Before meal	BEFORE MEAL
25	\N	\N	f	code	4	Observation	2024-03-29 23:56:23.176	-3028126907684642268	2255293283549704696	7952934451955757422	After meal	AFTER MEAL
26	\N	\N	f	combo-code	4	Observation	2024-03-29 23:56:23.176	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
27	\N	\N	f	code	4	Observation	2024-03-29 23:56:23.176	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
28	\N	\N	f	combo-code	4	Observation	2024-03-29 23:56:23.176	-6870427733514421258	-1575406001252496924	3219723693549490985	After meal	AFTER MEAL
29	\N	\N	f	code	5	Observation	2024-03-29 23:56:27.008	1406456452800120149	2255293283549704696	7952934451955757422	Before meal	BEFORE MEAL
30	\N	\N	f	combo-code	5	Observation	2024-03-29 23:56:27.008	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
31	\N	\N	f	code	5	Observation	2024-03-29 23:56:27.008	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
32	\N	\N	f	combo-code	5	Observation	2024-03-29 23:56:27.008	2182465808393806126	-1575406001252496924	3219723693549490985	Before meal	BEFORE MEAL
33	\N	\N	f	code	6	Observation	2024-03-29 23:56:31.035	1406456452800120149	2255293283549704696	7952934451955757422	Before meal	BEFORE MEAL
34	\N	\N	f	combo-code	6	Observation	2024-03-29 23:56:31.035	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
35	\N	\N	f	code	6	Observation	2024-03-29 23:56:31.035	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
36	\N	\N	f	combo-code	6	Observation	2024-03-29 23:56:31.035	2182465808393806126	-1575406001252496924	3219723693549490985	Before meal	BEFORE MEAL
37	\N	\N	f	code	7	Observation	2024-03-29 23:56:34.972	1406456452800120149	2255293283549704696	7952934451955757422	Before meal	BEFORE MEAL
38	\N	\N	f	combo-code	7	Observation	2024-03-29 23:56:34.972	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
39	\N	\N	f	code	7	Observation	2024-03-29 23:56:34.972	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
40	\N	\N	f	combo-code	7	Observation	2024-03-29 23:56:34.972	2182465808393806126	-1575406001252496924	3219723693549490985	Before meal	BEFORE MEAL
41	\N	\N	f	code	8	Observation	2024-03-29 23:56:39.613	1406456452800120149	2255293283549704696	7952934451955757422	Before meal	BEFORE MEAL
42	\N	\N	f	combo-code	8	Observation	2024-03-29 23:56:39.613	297844630521605603	-1575406001252496924	3219723693549490985	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
43	\N	\N	f	code	8	Observation	2024-03-29 23:56:39.613	681864957878196906	2255293283549704696	7952934451955757422	Glucose [Moles/volume] in Capillary blood by Glucometer	GLUCOSE [MOLES/VOLUME] IN CAPILLARY BLOOD BY GLUCOMETER
44	\N	\N	f	combo-code	8	Observation	2024-03-29 23:56:39.613	2182465808393806126	-1575406001252496924	3219723693549490985	Before meal	BEFORE MEAL
\.


--
-- Data for Name: hfj_spidx_token; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_token (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_sys, hash_sys_and_value, hash_value, sp_system, sp_value) FROM stdin;
1	\N	\N	f	deceased	1	Patient	2024-03-29 23:54:58.86	-2830809394128781005	7353680702239462393	-5327334097351605748	3407954849507134049	\N	false
2	\N	\N	f	phone	1	Patient	2024-03-29 23:54:58.86	-6551284011736109816	3676693649649869469	2217014884160737748	-4072635845336352155	phone	+1-222-22-22
3	\N	\N	f	identifier	1	Patient	2024-03-29 23:54:58.86	7001889285610424179	4763316194923162749	-2870423601700616926	-3301897089165252159	http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid	2923
4	\N	\N	f	identifier	1	Patient	2024-03-29 23:54:58.86	7001889285610424179	1715342199149986150	2488130311416695625	759552698550387343	https://fhir.infoway-inforoute.ca/NamingSystem/ca-on-patient-hcn	6132001124
5	\N	\N	f	telecom	1	Patient	2024-03-29 23:54:58.86	-2077596379165548657	8516278519576469875	8590648028235324968	-3343275632807121655	email	test2@uwaterloo.ca
6	\N	\N	f	language	1	Patient	2024-03-29 23:54:58.86	-6338030716006204643	-1940310015748265732	4810204165161749264	6299247892550696020	urn:ietf:bcp:47	en
7	\N	\N	f	telecom	1	Patient	2024-03-29 23:54:58.86	-2077596379165548657	-6891370790566514502	-7066425611039986254	8704819228189717495	phone	+1-222-22-22
8	\N	\N	f	identifier	1	Patient	2024-03-29 23:54:58.86	7001889285610424179	4257320668095098482	-8651841328355220569	-7081826293240340558	http://ehealthontario.ca/fhir/NamingSystem/id-example-uri	FULL_PROFILE_LEN3
9	\N	\N	f	identifier	1	Patient	2024-03-29 23:54:58.86	7001889285610424179	9021741681284811582	1234501713321297036	-3918135224496054290	https://fhir.infoway-inforoute.ca/NamingSystem/ca-bc-patient-healthcare-id	1806194839
10	\N	\N	f	email	1	Patient	2024-03-29 23:54:58.86	8843210077643414697	8013842278858588266	-8293275544597234423	-5572307882528425927	email	test2@uwaterloo.ca
11	\N	\N	f	gender	1	Patient	2024-03-29 23:54:58.86	2817066266609047850	-3105809197943607223	-394015888313699303	-5305902187566578701	http://hl7.org/fhir/administrative-gender	male
12	\N	\N	f	identifier	1	Patient	2024-03-29 23:54:58.86	7001889285610424179	9206385278132055722	2357603312228963506	-450861936932088867	http://ehealthontario.ca/fhir/NamingSystem/id-example1-uri	WSD00038992
13	\N	\N	f	address-use	1	Patient	2024-03-29 23:54:58.86	-5709780511353405485	2861726891246574650	-1860926926013048045	-8022872449579766223	http://hl7.org/fhir/address-use	home
14	\N	\N	f	identifier	2	Observation	2024-03-29 23:55:08.917	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
15	\N	\N	f	status	2	Observation	2024-03-29 23:55:08.917	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
16	\N	\N	f	combo-code	2	Observation	2024-03-29 23:55:08.917	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
17	\N	\N	f	code	2	Observation	2024-03-29 23:55:08.917	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
18	\N	\N	f	identifier	3	Observation	2024-03-29 23:55:12.906	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
19	\N	\N	f	status	3	Observation	2024-03-29 23:55:12.906	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
20	\N	\N	f	combo-code	3	Observation	2024-03-29 23:55:12.906	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
21	\N	\N	f	code	3	Observation	2024-03-29 23:55:12.906	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
22	\N	\N	f	identifier	4	Observation	2024-03-29 23:56:23.176	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
23	\N	\N	f	status	4	Observation	2024-03-29 23:56:23.176	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
24	\N	\N	f	combo-code	4	Observation	2024-03-29 23:56:23.176	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
25	\N	\N	f	code	4	Observation	2024-03-29 23:56:23.176	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
26	\N	\N	f	identifier	5	Observation	2024-03-29 23:56:27.008	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
27	\N	\N	f	status	5	Observation	2024-03-29 23:56:27.008	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
28	\N	\N	f	combo-code	5	Observation	2024-03-29 23:56:27.008	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
29	\N	\N	f	code	5	Observation	2024-03-29 23:56:27.008	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
30	\N	\N	f	identifier	6	Observation	2024-03-29 23:56:31.035	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
31	\N	\N	f	status	6	Observation	2024-03-29 23:56:31.035	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
32	\N	\N	f	combo-code	6	Observation	2024-03-29 23:56:31.035	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
33	\N	\N	f	code	6	Observation	2024-03-29 23:56:31.035	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
34	\N	\N	f	identifier	7	Observation	2024-03-29 23:56:34.972	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
35	\N	\N	f	status	7	Observation	2024-03-29 23:56:34.972	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
36	\N	\N	f	combo-code	7	Observation	2024-03-29 23:56:34.972	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
37	\N	\N	f	code	7	Observation	2024-03-29 23:56:34.972	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
38	\N	\N	f	identifier	8	Observation	2024-03-29 23:56:39.613	2064005440999524592	8486052549134125507	6910574240506826812	-6405715515536664669	http://www.bmc.nl/zorgportal/identifiers/observations	6323
39	\N	\N	f	status	8	Observation	2024-03-29 23:56:39.613	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
40	\N	\N	f	combo-code	8	Observation	2024-03-29 23:56:39.613	-1575406001252496924	-7445927209719109166	-3900890839679549405	3499849369436993651	http://loinc.org	14743-9
41	\N	\N	f	code	8	Observation	2024-03-29 23:56:39.613	2255293283549704696	3544617184093811114	3244284253357845986	5471039945402279935	http://loinc.org	14743-9
\.


--
-- Data for Name: hfj_spidx_uri; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_uri (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_uri, sp_uri) FROM stdin;
\.


--
-- Data for Name: hfj_subscription_stats; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_subscription_stats (pid, created_time, res_id) FROM stdin;
\.


--
-- Data for Name: hfj_tag_def; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_tag_def (tag_id, tag_code, tag_display, tag_system, tag_type, tag_user_selected, tag_version) FROM stdin;
1	N	normal	http://hl7.org/fhir/v3/Confidentiality	2	\N	\N
2	http://ehealthontario.ca/fhir/StructureDefinition/pcr-patient-response|2.0.0	\N	https://github.com/hapifhir/hapi-fhir/ns/jpa/profile	1	\N	\N
52	http://ehealthontario.ca/fhir/StructureDefinition/ca-on-lab-profile-Encounter|2.0.0	\N	https://github.com/hapifhir/hapi-fhir/ns/jpa/profile	1	\N	\N
\.


--
-- Data for Name: mpi_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.mpi_link (pid, partition_date, partition_id, created, eid_match, golden_resource_pid, new_person, link_source, match_result, target_type, person_pid, rule_count, score, target_pid, updated, vector, version) FROM stdin;
\.


--
-- Data for Name: mpi_link_aud; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.mpi_link_aud (pid, rev, revtype, partition_date, partition_id, created, eid_match, golden_resource_pid, new_person, link_source, match_result, target_type, person_pid, rule_count, score, target_pid, updated, vector, version) FROM stdin;
\.


--
-- Data for Name: npm_package; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.npm_package (pid, cur_version_id, package_desc, package_id, updated_time) FROM stdin;
\.


--
-- Data for Name: npm_package_ver; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.npm_package_ver (pid, current_version, pkg_desc, desc_upper, fhir_version, fhir_version_id, package_id, package_size_bytes, saved_time, updated_time, version_id, package_pid, binary_res_id) FROM stdin;
\.


--
-- Data for Name: npm_package_ver_res; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.npm_package_ver_res (pid, canonical_url, canonical_version, file_dir, fhir_version, fhir_version_id, file_name, res_size_bytes, res_type, updated_time, packver_pid, binary_res_id) FROM stdin;
\.


--
-- Data for Name: trm_codesystem; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_codesystem (pid, code_system_uri, current_version_pid, cs_name, res_id) FROM stdin;
\.


--
-- Data for Name: trm_codesystem_ver; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_codesystem_ver (pid, cs_display, codesystem_pid, cs_version_id, res_id) FROM stdin;
\.


--
-- Data for Name: trm_concept; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept (pid, codeval, codesystem_pid, display, index_status, parent_pids, code_sequence, concept_updated) FROM stdin;
\.


--
-- Data for Name: trm_concept_desig; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_desig (pid, lang, use_code, use_display, use_system, val, cs_ver_pid, concept_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_map; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_map (pid, res_id, source_url, target_url, url, ver) FROM stdin;
\.


--
-- Data for Name: trm_concept_map_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_map_group (pid, concept_map_url, source_url, source_vs, source_version, target_url, target_vs, target_version, concept_map_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_map_grp_element; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_map_grp_element (pid, source_code, concept_map_url, source_display, system_url, system_version, valueset_url, concept_map_group_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_map_grp_elm_tgt; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_map_grp_elm_tgt (pid, target_code, concept_map_url, target_display, target_equivalence, system_url, system_version, valueset_url, concept_map_grp_elm_pid) FROM stdin;
\.


--
-- Data for Name: trm_concept_pc_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_pc_link (pid, child_pid, codesystem_pid, parent_pid, rel_type) FROM stdin;
\.


--
-- Data for Name: trm_concept_property; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_concept_property (pid, prop_codesystem, prop_display, prop_key, prop_type, prop_val, prop_val_lob, cs_ver_pid, concept_pid) FROM stdin;
\.


--
-- Data for Name: trm_valueset; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_valueset (pid, expansion_status, expanded_at, vsname, res_id, total_concept_designations, total_concepts, url, ver) FROM stdin;
\.


--
-- Data for Name: trm_valueset_c_designation; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_valueset_c_designation (pid, valueset_concept_pid, lang, use_code, use_display, use_system, val, valueset_pid) FROM stdin;
\.


--
-- Data for Name: trm_valueset_concept; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trm_valueset_concept (pid, codeval, display, index_status, valueset_order, source_direct_parent_pids, source_pid, system_url, system_ver, valueset_pid) FROM stdin;
\.


--
-- Name: seq_blkexcol_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_blkexcol_pid', 1, false);


--
-- Name: seq_blkexcolfile_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_blkexcolfile_pid', 1, false);


--
-- Name: seq_blkexjob_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_blkexjob_pid', 1, false);


--
-- Name: seq_blkimjob_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_blkimjob_pid', 1, false);


--
-- Name: seq_blkimjobfile_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_blkimjobfile_pid', 1, false);


--
-- Name: seq_cncpt_map_grp_elm_tgt_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_cncpt_map_grp_elm_tgt_pid', 1, false);


--
-- Name: seq_codesystem_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_codesystem_pid', 1, false);


--
-- Name: seq_codesystemver_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_codesystemver_pid', 1, false);


--
-- Name: seq_concept_desig_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_desig_pid', 1, false);


--
-- Name: seq_concept_map_group_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_map_group_pid', 1, false);


--
-- Name: seq_concept_map_grp_elm_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_map_grp_elm_pid', 1, false);


--
-- Name: seq_concept_map_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_map_pid', 1, false);


--
-- Name: seq_concept_pc_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_pc_pid', 1, false);


--
-- Name: seq_concept_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_pid', 1, false);


--
-- Name: seq_concept_prop_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_concept_prop_pid', 1, false);


--
-- Name: seq_empi_link_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_empi_link_id', 1, false);


--
-- Name: seq_forcedid_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_forcedid_id', 1, false);


--
-- Name: seq_hfj_revinfo; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_hfj_revinfo', 1, false);


--
-- Name: seq_historytag_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_historytag_id', 151, true);


--
-- Name: seq_idxcmbtoknu_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_idxcmbtoknu_id', 1, false);


--
-- Name: seq_idxcmpstruniq_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_idxcmpstruniq_id', 1, false);


--
-- Name: seq_npm_pack; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_npm_pack', 1, false);


--
-- Name: seq_npm_packver; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_npm_packver', 1, false);


--
-- Name: seq_npm_packverres; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_npm_packverres', 1, false);


--
-- Name: seq_res_reindex_job; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_res_reindex_job', 1, false);


--
-- Name: seq_reslink_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_reslink_id', 151, true);


--
-- Name: seq_resource_history_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_resource_history_id', 201, true);


--
-- Name: seq_resource_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_resource_id', 151, true);


--
-- Name: seq_resparmpresent_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_resparmpresent_id', 1, false);


--
-- Name: seq_restag_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_restag_id', 101, true);


--
-- Name: seq_search; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_search', 351, true);


--
-- Name: seq_search_inc; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_search_inc', 1, false);


--
-- Name: seq_search_res; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_search_res', 251, true);


--
-- Name: seq_spidx_coords; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_coords', 1, false);


--
-- Name: seq_spidx_date; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_date', 101, true);


--
-- Name: seq_spidx_number; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_number', 1, false);


--
-- Name: seq_spidx_quantity; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_quantity', 101, true);


--
-- Name: seq_spidx_quantity_nrml; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_quantity_nrml', 1, false);


--
-- Name: seq_spidx_string; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_string', 151, true);


--
-- Name: seq_spidx_token; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_token', 151, true);


--
-- Name: seq_spidx_uri; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_uri', 1, false);


--
-- Name: seq_subscription_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_subscription_id', 1, false);


--
-- Name: seq_tagdef_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_tagdef_id', 101, true);


--
-- Name: seq_valueset_c_dsgntn_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_valueset_c_dsgntn_pid', 1, false);


--
-- Name: seq_valueset_concept_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_valueset_concept_pid', 1, false);


--
-- Name: seq_valueset_pid; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_valueset_pid', 1, false);


--
-- Data for Name: BLOBS; Type: BLOBS; Schema: -; Owner: -
--

BEGIN;

SELECT pg_catalog.lo_open('17210', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17211', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17212', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17213', 131072);
SELECT pg_catalog.lowrite(0, '\x3f636f64653d687474702533412532462532466c6f696e632e6f726725374331343734332d3926646174653d6765323032342d30322d323926646174653d6c65323032342d30332d32392670617469656e743d31265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17214', 131072);
SELECT pg_catalog.lowrite(0, '\x3f636f64653d687474702533412532462532466c6f696e632e6f726725374331343734332d3926646174653d6765323032342d30322d323926646174653d6c65323032342d30332d3239267375626a6563743d50617469656e7425324631265f736f72743d2d64617465265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17215', 131072);
SELECT pg_catalog.lowrite(0, '\x3f636f64653d687474702533412532462532466c6f696e632e6f726725374331343734332d3926646174653d6765323032342d30322d323926646174653d6c65323032342d30332d32392670617469656e743d31265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17216', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17217', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17218', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('25398', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('25409', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('25410', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('25411', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('25412', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33590', 131072);
SELECT pg_catalog.lowrite(0, '\x3f636f64653d687474702533412532462532466c6f696e632e6f726725374331343734332d3926646174653d6765323032342d30322d323926646174653d6c65323032342d30332d3239267375626a6563743d50617469656e7425324631265f736f72743d2d64617465265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33601', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33602', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33603', 131072);
SELECT pg_catalog.lowrite(0, '\x3f636f64653d687474702533412532462532466c6f696e632e6f726725374331343734332d3926646174653d6765323032342d30322d323926646174653d6c65323032342d30332d3239267375626a6563743d50617469656e7425324631265f736f72743d2d64617465265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

COMMIT;

--
-- Name: bt2_job_instance bt2_job_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bt2_job_instance
    ADD CONSTRAINT bt2_job_instance_pkey PRIMARY KEY (id);


--
-- Name: bt2_work_chunk bt2_work_chunk_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bt2_work_chunk
    ADD CONSTRAINT bt2_work_chunk_pkey PRIMARY KEY (id);


--
-- Name: hfj_binary_storage_blob hfj_binary_storage_blob_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_binary_storage_blob
    ADD CONSTRAINT hfj_binary_storage_blob_pkey PRIMARY KEY (blob_id);


--
-- Name: hfj_blk_export_colfile hfj_blk_export_colfile_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_export_colfile
    ADD CONSTRAINT hfj_blk_export_colfile_pkey PRIMARY KEY (pid);


--
-- Name: hfj_blk_export_collection hfj_blk_export_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_export_collection
    ADD CONSTRAINT hfj_blk_export_collection_pkey PRIMARY KEY (pid);


--
-- Name: hfj_blk_export_job hfj_blk_export_job_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_export_job
    ADD CONSTRAINT hfj_blk_export_job_pkey PRIMARY KEY (pid);


--
-- Name: hfj_blk_import_job hfj_blk_import_job_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_import_job
    ADD CONSTRAINT hfj_blk_import_job_pkey PRIMARY KEY (pid);


--
-- Name: hfj_blk_import_jobfile hfj_blk_import_jobfile_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_import_jobfile
    ADD CONSTRAINT hfj_blk_import_jobfile_pkey PRIMARY KEY (pid);


--
-- Name: hfj_forced_id hfj_forced_id_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT hfj_forced_id_pkey PRIMARY KEY (pid);


--
-- Name: hfj_history_tag hfj_history_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT hfj_history_tag_pkey PRIMARY KEY (pid);


--
-- Name: hfj_idx_cmb_tok_nu hfj_idx_cmb_tok_nu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_idx_cmb_tok_nu
    ADD CONSTRAINT hfj_idx_cmb_tok_nu_pkey PRIMARY KEY (pid);


--
-- Name: hfj_idx_cmp_string_uniq hfj_idx_cmp_string_uniq_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT hfj_idx_cmp_string_uniq_pkey PRIMARY KEY (pid);


--
-- Name: hfj_partition hfj_partition_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_partition
    ADD CONSTRAINT hfj_partition_pkey PRIMARY KEY (part_id);


--
-- Name: hfj_res_link hfj_res_link_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT hfj_res_link_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_param_present hfj_res_param_present_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_param_present
    ADD CONSTRAINT hfj_res_param_present_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_reindex_job hfj_res_reindex_job_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_reindex_job
    ADD CONSTRAINT hfj_res_reindex_job_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_search_url hfj_res_search_url_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_search_url
    ADD CONSTRAINT hfj_res_search_url_pkey PRIMARY KEY (res_search_url);


--
-- Name: hfj_res_tag hfj_res_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT hfj_res_tag_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_ver hfj_res_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT hfj_res_ver_pkey PRIMARY KEY (pid);


--
-- Name: hfj_res_ver_prov hfj_res_ver_prov_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT hfj_res_ver_prov_pkey PRIMARY KEY (res_ver_pid);


--
-- Name: hfj_resource_modified hfj_resource_modified_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_resource_modified
    ADD CONSTRAINT hfj_resource_modified_pkey PRIMARY KEY (res_id, res_ver);


--
-- Name: hfj_resource hfj_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_resource
    ADD CONSTRAINT hfj_resource_pkey PRIMARY KEY (res_id);


--
-- Name: hfj_revinfo hfj_revinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_revinfo
    ADD CONSTRAINT hfj_revinfo_pkey PRIMARY KEY (rev);


--
-- Name: hfj_search_include hfj_search_include_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_search_include
    ADD CONSTRAINT hfj_search_include_pkey PRIMARY KEY (pid);


--
-- Name: hfj_search hfj_search_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_search
    ADD CONSTRAINT hfj_search_pkey PRIMARY KEY (pid);


--
-- Name: hfj_search_result hfj_search_result_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_search_result
    ADD CONSTRAINT hfj_search_result_pkey PRIMARY KEY (pid);


--
-- Name: hfj_spidx_coords hfj_spidx_coords_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_coords
    ADD CONSTRAINT hfj_spidx_coords_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_date hfj_spidx_date_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_date
    ADD CONSTRAINT hfj_spidx_date_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_number hfj_spidx_number_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_number
    ADD CONSTRAINT hfj_spidx_number_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_quantity_nrml hfj_spidx_quantity_nrml_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_quantity_nrml
    ADD CONSTRAINT hfj_spidx_quantity_nrml_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_quantity hfj_spidx_quantity_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_quantity
    ADD CONSTRAINT hfj_spidx_quantity_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_string hfj_spidx_string_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_string
    ADD CONSTRAINT hfj_spidx_string_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_token hfj_spidx_token_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_token
    ADD CONSTRAINT hfj_spidx_token_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_spidx_uri hfj_spidx_uri_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT hfj_spidx_uri_pkey PRIMARY KEY (sp_id);


--
-- Name: hfj_subscription_stats hfj_subscription_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT hfj_subscription_stats_pkey PRIMARY KEY (pid);


--
-- Name: hfj_tag_def hfj_tag_def_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_tag_def
    ADD CONSTRAINT hfj_tag_def_pkey PRIMARY KEY (tag_id);


--
-- Name: hfj_blk_export_job idx_blkex_job_id; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_export_job
    ADD CONSTRAINT idx_blkex_job_id UNIQUE (job_id);


--
-- Name: hfj_blk_import_job idx_blkim_job_id; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_import_job
    ADD CONSTRAINT idx_blkim_job_id UNIQUE (job_id);


--
-- Name: trm_codesystem_ver idx_codesystem_and_ver; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT idx_codesystem_and_ver UNIQUE (codesystem_pid, cs_version_id);


--
-- Name: trm_concept idx_concept_cs_code; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT idx_concept_cs_code UNIQUE (codesystem_pid, codeval);


--
-- Name: trm_concept_map idx_concept_map_url; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT idx_concept_map_url UNIQUE (url, ver);


--
-- Name: trm_codesystem idx_cs_codesystem; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT idx_cs_codesystem UNIQUE (code_system_uri);


--
-- Name: mpi_link idx_empi_person_tgt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT idx_empi_person_tgt UNIQUE (person_pid, target_pid);


--
-- Name: hfj_forced_id idx_forcedid_resid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT idx_forcedid_resid UNIQUE (resource_pid);


--
-- Name: hfj_forced_id idx_forcedid_type_fid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT idx_forcedid_type_fid UNIQUE (resource_type, forced_id);


--
-- Name: hfj_idx_cmp_string_uniq idx_idxcmpstruniq_string; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT idx_idxcmpstruniq_string UNIQUE (idx_string);


--
-- Name: npm_package idx_pack_id; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package
    ADD CONSTRAINT idx_pack_id UNIQUE (package_id);


--
-- Name: npm_package_ver idx_packver; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT idx_packver UNIQUE (package_id, version_id);


--
-- Name: hfj_partition idx_part_name; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_partition
    ADD CONSTRAINT idx_part_name UNIQUE (part_name);


--
-- Name: hfj_resource idx_res_type_fhir_id; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_resource
    ADD CONSTRAINT idx_res_type_fhir_id UNIQUE (res_type, fhir_id);


--
-- Name: hfj_history_tag idx_reshisttag_tagid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT idx_reshisttag_tagid UNIQUE (res_ver_pid, tag_id);


--
-- Name: hfj_res_tag idx_restag_tagid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT idx_restag_tagid UNIQUE (res_id, tag_id);


--
-- Name: hfj_res_ver idx_resver_id_ver; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT idx_resver_id_ver UNIQUE (res_id, res_ver);


--
-- Name: hfj_search idx_search_uuid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_search
    ADD CONSTRAINT idx_search_uuid UNIQUE (search_uuid);


--
-- Name: hfj_search_result idx_searchres_order; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_search_result
    ADD CONSTRAINT idx_searchres_order UNIQUE (search_pid, search_order);


--
-- Name: hfj_spidx_uri idx_sp_uri_hash_identity_v2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT idx_sp_uri_hash_identity_v2 UNIQUE (hash_identity, sp_uri, res_id, partition_id);


--
-- Name: hfj_spidx_uri idx_sp_uri_hash_uri_v2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT idx_sp_uri_hash_uri_v2 UNIQUE (hash_uri, res_id, partition_id);


--
-- Name: hfj_subscription_stats idx_subsc_resid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT idx_subsc_resid UNIQUE (res_id);


--
-- Name: trm_valueset idx_valueset_url; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT idx_valueset_url UNIQUE (url, ver);


--
-- Name: trm_valueset_concept idx_vs_concept_cscd; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT idx_vs_concept_cscd UNIQUE (valueset_pid, system_url, codeval);


--
-- Name: trm_valueset_concept idx_vs_concept_order; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT idx_vs_concept_order UNIQUE (valueset_pid, valueset_order);


--
-- Name: mpi_link_aud mpi_link_aud_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link_aud
    ADD CONSTRAINT mpi_link_aud_pkey PRIMARY KEY (rev, pid);


--
-- Name: mpi_link mpi_link_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT mpi_link_pkey PRIMARY KEY (pid);


--
-- Name: npm_package npm_package_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package
    ADD CONSTRAINT npm_package_pkey PRIMARY KEY (pid);


--
-- Name: npm_package_ver npm_package_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT npm_package_ver_pkey PRIMARY KEY (pid);


--
-- Name: npm_package_ver_res npm_package_ver_res_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT npm_package_ver_res_pkey PRIMARY KEY (pid);


--
-- Name: trm_codesystem trm_codesystem_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT trm_codesystem_pkey PRIMARY KEY (pid);


--
-- Name: trm_codesystem_ver trm_codesystem_ver_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT trm_codesystem_ver_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_desig trm_concept_desig_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT trm_concept_desig_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map_group trm_concept_map_group_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map_group
    ADD CONSTRAINT trm_concept_map_group_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map_grp_element trm_concept_map_grp_element_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map_grp_element
    ADD CONSTRAINT trm_concept_map_grp_element_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map_grp_elm_tgt trm_concept_map_grp_elm_tgt_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map_grp_elm_tgt
    ADD CONSTRAINT trm_concept_map_grp_elm_tgt_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_map trm_concept_map_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT trm_concept_map_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_pc_link trm_concept_pc_link_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT trm_concept_pc_link_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept trm_concept_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT trm_concept_pkey PRIMARY KEY (pid);


--
-- Name: trm_concept_property trm_concept_property_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT trm_concept_property_pkey PRIMARY KEY (pid);


--
-- Name: trm_valueset_c_designation trm_valueset_c_designation_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT trm_valueset_c_designation_pkey PRIMARY KEY (pid);


--
-- Name: trm_valueset_concept trm_valueset_concept_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT trm_valueset_concept_pkey PRIMARY KEY (pid);


--
-- Name: trm_valueset trm_valueset_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT trm_valueset_pkey PRIMARY KEY (pid);


--
-- Name: fk_codesysver_cs_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_codesysver_cs_id ON public.trm_codesystem_ver USING btree (codesystem_pid);


--
-- Name: fk_codesysver_res_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_codesysver_res_id ON public.trm_codesystem_ver USING btree (res_id);


--
-- Name: fk_conceptdesig_concept; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_conceptdesig_concept ON public.trm_concept_desig USING btree (concept_pid);


--
-- Name: fk_conceptdesig_csv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_conceptdesig_csv ON public.trm_concept_desig USING btree (cs_ver_pid);


--
-- Name: fk_conceptprop_concept; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_conceptprop_concept ON public.trm_concept_property USING btree (concept_pid);


--
-- Name: fk_conceptprop_csv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_conceptprop_csv ON public.trm_concept_property USING btree (cs_ver_pid);


--
-- Name: fk_empi_link_target; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_empi_link_target ON public.mpi_link USING btree (target_pid);


--
-- Name: fk_npm_packverres_packver; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_npm_packverres_packver ON public.npm_package_ver_res USING btree (packver_pid);


--
-- Name: fk_npm_pkv_pkg; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_npm_pkv_pkg ON public.npm_package_ver USING btree (package_pid);


--
-- Name: fk_npm_pkv_resid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_npm_pkv_resid ON public.npm_package_ver USING btree (binary_res_id);


--
-- Name: fk_npm_pkvr_resid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_npm_pkvr_resid ON public.npm_package_ver_res USING btree (binary_res_id);


--
-- Name: fk_searchinc_search; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_searchinc_search ON public.hfj_search_include USING btree (search_pid);


--
-- Name: fk_tcmgelement_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_tcmgelement_group ON public.trm_concept_map_grp_element USING btree (concept_map_group_pid);


--
-- Name: fk_tcmgetarget_element; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_tcmgetarget_element ON public.trm_concept_map_grp_elm_tgt USING btree (concept_map_grp_elm_pid);


--
-- Name: fk_tcmgroup_conceptmap; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_tcmgroup_conceptmap ON public.trm_concept_map_group USING btree (concept_map_pid);


--
-- Name: fk_term_conceptpc_child; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_term_conceptpc_child ON public.trm_concept_pc_link USING btree (child_pid);


--
-- Name: fk_term_conceptpc_cs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_term_conceptpc_cs ON public.trm_concept_pc_link USING btree (codesystem_pid);


--
-- Name: fk_term_conceptpc_parent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_term_conceptpc_parent ON public.trm_concept_pc_link USING btree (parent_pid);


--
-- Name: fk_trm_valueset_concept_pid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_trm_valueset_concept_pid ON public.trm_valueset_c_designation USING btree (valueset_concept_pid);


--
-- Name: fk_trm_vscd_vs_pid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_trm_vscd_vs_pid ON public.trm_valueset_c_designation USING btree (valueset_pid);


--
-- Name: fk_trmcodesystem_curver; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_trmcodesystem_curver ON public.trm_codesystem USING btree (current_version_pid);


--
-- Name: fk_trmcodesystem_res; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_trmcodesystem_res ON public.trm_codesystem USING btree (res_id);


--
-- Name: fk_trmconceptmap_res; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_trmconceptmap_res ON public.trm_concept_map USING btree (res_id);


--
-- Name: fk_trmvalueset_res; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fk_trmvalueset_res ON public.trm_valueset USING btree (res_id);


--
-- Name: idx_blkex_exptime; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_blkex_exptime ON public.hfj_blk_export_job USING btree (exp_time);


--
-- Name: idx_blkim_jobfile_jobid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_blkim_jobfile_jobid ON public.hfj_blk_import_jobfile USING btree (job_pid);


--
-- Name: idx_bt2ji_ct; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_bt2ji_ct ON public.bt2_job_instance USING btree (create_time);


--
-- Name: idx_bt2wc_ii_seq; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_bt2wc_ii_seq ON public.bt2_work_chunk USING btree (instance_id, seq);


--
-- Name: idx_cncpt_map_grp_cd; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cncpt_map_grp_cd ON public.trm_concept_map_grp_element USING btree (source_code);


--
-- Name: idx_cncpt_mp_grp_elm_tgt_cd; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cncpt_mp_grp_elm_tgt_cd ON public.trm_concept_map_grp_elm_tgt USING btree (target_code);


--
-- Name: idx_concept_indexstatus; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_concept_indexstatus ON public.trm_concept USING btree (index_status);


--
-- Name: idx_concept_updated; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_concept_updated ON public.trm_concept USING btree (concept_updated);


--
-- Name: idx_empi_gr_tgt; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_empi_gr_tgt ON public.mpi_link USING btree (golden_resource_pid, target_pid);


--
-- Name: idx_empi_match_tgt_ver; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_empi_match_tgt_ver ON public.mpi_link USING btree (match_result, target_pid, version);


--
-- Name: idx_empi_tgt_mr_ls; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_empi_tgt_mr_ls ON public.mpi_link USING btree (target_type, match_result, link_source);


--
-- Name: idx_empi_tgt_mr_score; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_empi_tgt_mr_score ON public.mpi_link USING btree (target_type, match_result, score);


--
-- Name: idx_forceid_fid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_forceid_fid ON public.hfj_forced_id USING btree (forced_id);


--
-- Name: idx_idxcmbtoknu_res; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idxcmbtoknu_res ON public.hfj_idx_cmb_tok_nu USING btree (res_id);


--
-- Name: idx_idxcmbtoknu_str; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idxcmbtoknu_str ON public.hfj_idx_cmb_tok_nu USING btree (idx_string);


--
-- Name: idx_idxcmpstruniq_resource; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idxcmpstruniq_resource ON public.hfj_idx_cmp_string_uniq USING btree (res_id);


--
-- Name: idx_packverres_url; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_packverres_url ON public.npm_package_ver_res USING btree (canonical_url);


--
-- Name: idx_res_date; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_date ON public.hfj_resource USING btree (res_updated);


--
-- Name: idx_res_fhir_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_fhir_id ON public.hfj_resource USING btree (fhir_id);


--
-- Name: idx_res_resid_updated; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_resid_updated ON public.hfj_resource USING btree (res_id, res_updated, partition_id);


--
-- Name: idx_res_tag_res_tag; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_tag_res_tag ON public.hfj_res_tag USING btree (res_id, tag_id, partition_id);


--
-- Name: idx_res_tag_tag_res; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_tag_tag_res ON public.hfj_res_tag USING btree (tag_id, res_id, partition_id);


--
-- Name: idx_res_type_del_updated; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_type_del_updated ON public.hfj_resource USING btree (res_type, res_deleted_at, res_updated, partition_id, res_id);


--
-- Name: idx_reshisttag_resid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_reshisttag_resid ON public.hfj_history_tag USING btree (res_id);


--
-- Name: idx_resparmpresent_hashpres; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resparmpresent_hashpres ON public.hfj_res_param_present USING btree (hash_presence);


--
-- Name: idx_resparmpresent_resid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resparmpresent_resid ON public.hfj_res_param_present USING btree (res_id);


--
-- Name: idx_ressearchurl_res; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ressearchurl_res ON public.hfj_res_search_url USING btree (res_id);


--
-- Name: idx_ressearchurl_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ressearchurl_time ON public.hfj_res_search_url USING btree (created_time);


--
-- Name: idx_resver_date; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resver_date ON public.hfj_res_ver USING btree (res_updated);


--
-- Name: idx_resver_id_date; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resver_id_date ON public.hfj_res_ver USING btree (res_id, res_updated);


--
-- Name: idx_resver_type_date; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resver_type_date ON public.hfj_res_ver USING btree (res_type, res_updated);


--
-- Name: idx_resverprov_requestid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resverprov_requestid ON public.hfj_res_ver_prov USING btree (request_id);


--
-- Name: idx_resverprov_res_pid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resverprov_res_pid ON public.hfj_res_ver_prov USING btree (res_pid);


--
-- Name: idx_resverprov_sourceuri; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_resverprov_sourceuri ON public.hfj_res_ver_prov USING btree (source_uri);


--
-- Name: idx_rl_src; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_rl_src ON public.hfj_res_link USING btree (src_resource_id);


--
-- Name: idx_rl_tgt_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_rl_tgt_v2 ON public.hfj_res_link USING btree (target_resource_id, src_path, src_resource_id, target_resource_type, partition_id);


--
-- Name: idx_search_created; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_search_created ON public.hfj_search USING btree (created);


--
-- Name: idx_search_restype_hashs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_search_restype_hashs ON public.hfj_search USING btree (resource_type, search_query_string_hash, created);


--
-- Name: idx_sp_coords_hash_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_coords_hash_v2 ON public.hfj_spidx_coords USING btree (hash_identity, sp_latitude, sp_longitude, res_id, partition_id);


--
-- Name: idx_sp_coords_resid; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_coords_resid ON public.hfj_spidx_coords USING btree (res_id);


--
-- Name: idx_sp_coords_updated; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_coords_updated ON public.hfj_spidx_coords USING btree (sp_updated);


--
-- Name: idx_sp_date_hash_high_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_date_hash_high_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_high, res_id, partition_id);


--
-- Name: idx_sp_date_hash_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_date_hash_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low, sp_value_high, res_id, partition_id);


--
-- Name: idx_sp_date_ord_hash_high_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_date_ord_hash_high_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_high_date_ordinal, res_id, partition_id);


--
-- Name: idx_sp_date_ord_hash_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_date_ord_hash_v2 ON public.hfj_spidx_date USING btree (hash_identity, sp_value_low_date_ordinal, sp_value_high_date_ordinal, res_id, partition_id);


--
-- Name: idx_sp_date_resid_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_date_resid_v2 ON public.hfj_spidx_date USING btree (res_id, hash_identity, sp_value_low, sp_value_high, sp_value_low_date_ordinal, sp_value_high_date_ordinal, partition_id);


--
-- Name: idx_sp_number_hash_val_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_number_hash_val_v2 ON public.hfj_spidx_number USING btree (hash_identity, sp_value, res_id, partition_id);


--
-- Name: idx_sp_number_resid_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_number_resid_v2 ON public.hfj_spidx_number USING btree (res_id, hash_identity, sp_value, partition_id);


--
-- Name: idx_sp_qnty_nrml_hash_sysun_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_qnty_nrml_hash_sysun_v2 ON public.hfj_spidx_quantity_nrml USING btree (hash_identity_sys_units, sp_value, res_id, partition_id);


--
-- Name: idx_sp_qnty_nrml_hash_un_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_qnty_nrml_hash_un_v2 ON public.hfj_spidx_quantity_nrml USING btree (hash_identity_and_units, sp_value, res_id, partition_id);


--
-- Name: idx_sp_qnty_nrml_hash_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_qnty_nrml_hash_v2 ON public.hfj_spidx_quantity_nrml USING btree (hash_identity, sp_value, res_id, partition_id);


--
-- Name: idx_sp_qnty_nrml_resid_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_qnty_nrml_resid_v2 ON public.hfj_spidx_quantity_nrml USING btree (res_id, hash_identity, hash_identity_sys_units, hash_identity_and_units, sp_value, partition_id);


--
-- Name: idx_sp_quantity_hash_sysun_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_quantity_hash_sysun_v2 ON public.hfj_spidx_quantity USING btree (hash_identity_sys_units, sp_value, res_id, partition_id);


--
-- Name: idx_sp_quantity_hash_un_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_quantity_hash_un_v2 ON public.hfj_spidx_quantity USING btree (hash_identity_and_units, sp_value, res_id, partition_id);


--
-- Name: idx_sp_quantity_hash_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_quantity_hash_v2 ON public.hfj_spidx_quantity USING btree (hash_identity, sp_value, res_id, partition_id);


--
-- Name: idx_sp_quantity_resid_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_quantity_resid_v2 ON public.hfj_spidx_quantity USING btree (res_id, hash_identity, hash_identity_sys_units, hash_identity_and_units, sp_value, partition_id);


--
-- Name: idx_sp_string_hash_exct_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_string_hash_exct_v2 ON public.hfj_spidx_string USING btree (hash_exact, res_id, partition_id);


--
-- Name: idx_sp_string_hash_ident_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_string_hash_ident_v2 ON public.hfj_spidx_string USING btree (hash_identity, res_id, partition_id);


--
-- Name: idx_sp_string_hash_nrm_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_string_hash_nrm_v2 ON public.hfj_spidx_string USING btree (hash_norm_prefix, sp_value_normalized, res_id, partition_id);


--
-- Name: idx_sp_string_resid_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_string_resid_v2 ON public.hfj_spidx_string USING btree (res_id, hash_norm_prefix, partition_id);


--
-- Name: idx_sp_token_hash_s_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_token_hash_s_v2 ON public.hfj_spidx_token USING btree (hash_sys, res_id, partition_id);


--
-- Name: idx_sp_token_hash_sv_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_token_hash_sv_v2 ON public.hfj_spidx_token USING btree (hash_sys_and_value, res_id, partition_id);


--
-- Name: idx_sp_token_hash_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_token_hash_v2 ON public.hfj_spidx_token USING btree (hash_identity, sp_system, sp_value, res_id, partition_id);


--
-- Name: idx_sp_token_hash_v_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_token_hash_v_v2 ON public.hfj_spidx_token USING btree (hash_value, res_id, partition_id);


--
-- Name: idx_sp_token_resid_v2; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_token_resid_v2 ON public.hfj_spidx_token USING btree (res_id, hash_sys_and_value, hash_value, hash_sys, hash_identity, partition_id);


--
-- Name: idx_sp_uri_coords; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_sp_uri_coords ON public.hfj_spidx_uri USING btree (res_id);


--
-- Name: idx_tag_def_tp_cd_sys; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_tag_def_tp_cd_sys ON public.hfj_tag_def USING btree (tag_type, tag_code, tag_system, tag_id, tag_version, tag_user_selected);


--
-- Name: hfj_history_tag fk3gc37g8b2c9qcrrccw7s50inw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT fk3gc37g8b2c9qcrrccw7s50inw FOREIGN KEY (tag_id) REFERENCES public.hfj_tag_def(tag_id);


--
-- Name: hfj_res_tag fk4kiphkwif9illrg0jtooom2w1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT fk4kiphkwif9illrg0jtooom2w1 FOREIGN KEY (tag_id) REFERENCES public.hfj_tag_def(tag_id);


--
-- Name: hfj_blk_export_collection fk_blkexcol_job; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_export_collection
    ADD CONSTRAINT fk_blkexcol_job FOREIGN KEY (job_pid) REFERENCES public.hfj_blk_export_job(pid);


--
-- Name: hfj_blk_export_colfile fk_blkexcolfile_collect; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_export_colfile
    ADD CONSTRAINT fk_blkexcolfile_collect FOREIGN KEY (collection_pid) REFERENCES public.hfj_blk_export_collection(pid);


--
-- Name: hfj_blk_import_jobfile fk_blkimjobfile_job; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_blk_import_jobfile
    ADD CONSTRAINT fk_blkimjobfile_job FOREIGN KEY (job_pid) REFERENCES public.hfj_blk_import_job(pid);


--
-- Name: bt2_work_chunk fk_bt2wc_instance; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bt2_work_chunk
    ADD CONSTRAINT fk_bt2wc_instance FOREIGN KEY (instance_id) REFERENCES public.bt2_job_instance(id);


--
-- Name: trm_codesystem_ver fk_codesysver_cs_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT fk_codesysver_cs_id FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem(pid);


--
-- Name: trm_codesystem_ver fk_codesysver_res_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem_ver
    ADD CONSTRAINT fk_codesysver_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_concept fk_concept_pid_cs_pid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept
    ADD CONSTRAINT fk_concept_pid_cs_pid FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_concept_desig fk_conceptdesig_concept; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT fk_conceptdesig_concept FOREIGN KEY (concept_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_concept_desig fk_conceptdesig_csv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_desig
    ADD CONSTRAINT fk_conceptdesig_csv FOREIGN KEY (cs_ver_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_concept_property fk_conceptprop_concept; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT fk_conceptprop_concept FOREIGN KEY (concept_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_concept_property fk_conceptprop_csv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_property
    ADD CONSTRAINT fk_conceptprop_csv FOREIGN KEY (cs_ver_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: mpi_link fk_empi_link_golden_resource; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_golden_resource FOREIGN KEY (golden_resource_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: mpi_link fk_empi_link_person; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_person FOREIGN KEY (person_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: mpi_link fk_empi_link_target; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link
    ADD CONSTRAINT fk_empi_link_target FOREIGN KEY (target_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_forced_id fk_forcedid_resource; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_forced_id
    ADD CONSTRAINT fk_forcedid_resource FOREIGN KEY (resource_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_history_tag fk_historytag_history; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_history_tag
    ADD CONSTRAINT fk_historytag_history FOREIGN KEY (res_ver_pid) REFERENCES public.hfj_res_ver(pid);


--
-- Name: hfj_idx_cmb_tok_nu fk_idxcmbtoknu_res_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_idx_cmb_tok_nu
    ADD CONSTRAINT fk_idxcmbtoknu_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_idx_cmp_string_uniq fk_idxcmpstruniq_res_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_idx_cmp_string_uniq
    ADD CONSTRAINT fk_idxcmpstruniq_res_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: npm_package_ver_res fk_npm_packverres_packver; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT fk_npm_packverres_packver FOREIGN KEY (packver_pid) REFERENCES public.npm_package_ver(pid);


--
-- Name: npm_package_ver fk_npm_pkv_pkg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT fk_npm_pkv_pkg FOREIGN KEY (package_pid) REFERENCES public.npm_package(pid);


--
-- Name: npm_package_ver fk_npm_pkv_resid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver
    ADD CONSTRAINT fk_npm_pkv_resid FOREIGN KEY (binary_res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: npm_package_ver_res fk_npm_pkvr_resid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.npm_package_ver_res
    ADD CONSTRAINT fk_npm_pkvr_resid FOREIGN KEY (binary_res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_link fk_reslink_source; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT fk_reslink_source FOREIGN KEY (src_resource_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_link fk_reslink_target; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_link
    ADD CONSTRAINT fk_reslink_target FOREIGN KEY (target_resource_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_ver fk_resource_history_resource; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_ver
    ADD CONSTRAINT fk_resource_history_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_param_present fk_resparmpres_resid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_param_present
    ADD CONSTRAINT fk_resparmpres_resid FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_tag fk_restag_resource; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_tag
    ADD CONSTRAINT fk_restag_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_ver_prov fk_resverprov_res_pid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT fk_resverprov_res_pid FOREIGN KEY (res_pid) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_res_ver_prov fk_resverprov_resver_pid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_res_ver_prov
    ADD CONSTRAINT fk_resverprov_resver_pid FOREIGN KEY (res_ver_pid) REFERENCES public.hfj_res_ver(pid);


--
-- Name: hfj_search_include fk_searchinc_search; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_search_include
    ADD CONSTRAINT fk_searchinc_search FOREIGN KEY (search_pid) REFERENCES public.hfj_search(pid);


--
-- Name: hfj_spidx_date fk_sp_date_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_date
    ADD CONSTRAINT fk_sp_date_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_number fk_sp_number_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_number
    ADD CONSTRAINT fk_sp_number_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_quantity fk_sp_quantity_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_quantity
    ADD CONSTRAINT fk_sp_quantity_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_quantity_nrml fk_sp_quantitynm_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_quantity_nrml
    ADD CONSTRAINT fk_sp_quantitynm_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_token fk_sp_token_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_token
    ADD CONSTRAINT fk_sp_token_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_string fk_spidxstr_resource; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_string
    ADD CONSTRAINT fk_spidxstr_resource FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_subscription_stats fk_subsc_resource_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_subscription_stats
    ADD CONSTRAINT fk_subsc_resource_id FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_concept_map_grp_element fk_tcmgelement_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map_grp_element
    ADD CONSTRAINT fk_tcmgelement_group FOREIGN KEY (concept_map_group_pid) REFERENCES public.trm_concept_map_group(pid);


--
-- Name: trm_concept_map_grp_elm_tgt fk_tcmgetarget_element; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map_grp_elm_tgt
    ADD CONSTRAINT fk_tcmgetarget_element FOREIGN KEY (concept_map_grp_elm_pid) REFERENCES public.trm_concept_map_grp_element(pid);


--
-- Name: trm_concept_map_group fk_tcmgroup_conceptmap; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map_group
    ADD CONSTRAINT fk_tcmgroup_conceptmap FOREIGN KEY (concept_map_pid) REFERENCES public.trm_concept_map(pid);


--
-- Name: trm_concept_pc_link fk_term_conceptpc_child; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_child FOREIGN KEY (child_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_concept_pc_link fk_term_conceptpc_cs; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_cs FOREIGN KEY (codesystem_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_concept_pc_link fk_term_conceptpc_parent; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_pc_link
    ADD CONSTRAINT fk_term_conceptpc_parent FOREIGN KEY (parent_pid) REFERENCES public.trm_concept(pid);


--
-- Name: trm_valueset_c_designation fk_trm_valueset_concept_pid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT fk_trm_valueset_concept_pid FOREIGN KEY (valueset_concept_pid) REFERENCES public.trm_valueset_concept(pid);


--
-- Name: trm_valueset_concept fk_trm_valueset_pid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_concept
    ADD CONSTRAINT fk_trm_valueset_pid FOREIGN KEY (valueset_pid) REFERENCES public.trm_valueset(pid);


--
-- Name: trm_valueset_c_designation fk_trm_vscd_vs_pid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset_c_designation
    ADD CONSTRAINT fk_trm_vscd_vs_pid FOREIGN KEY (valueset_pid) REFERENCES public.trm_valueset(pid);


--
-- Name: trm_codesystem fk_trmcodesystem_curver; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT fk_trmcodesystem_curver FOREIGN KEY (current_version_pid) REFERENCES public.trm_codesystem_ver(pid);


--
-- Name: trm_codesystem fk_trmcodesystem_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_codesystem
    ADD CONSTRAINT fk_trmcodesystem_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_concept_map fk_trmconceptmap_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_concept_map
    ADD CONSTRAINT fk_trmconceptmap_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: trm_valueset fk_trmvalueset_res; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trm_valueset
    ADD CONSTRAINT fk_trmvalueset_res FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_coords fkc97mpk37okwu8qvtceg2nh9vn; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_coords
    ADD CONSTRAINT fkc97mpk37okwu8qvtceg2nh9vn FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: hfj_spidx_uri fkgxsreutymmfjuwdswv3y887do; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.hfj_spidx_uri
    ADD CONSTRAINT fkgxsreutymmfjuwdswv3y887do FOREIGN KEY (res_id) REFERENCES public.hfj_resource(res_id);


--
-- Name: mpi_link_aud fkkbqi6ie5cmr64rl4a1qbeury1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.mpi_link_aud
    ADD CONSTRAINT fkkbqi6ie5cmr64rl4a1qbeury1 FOREIGN KEY (rev) REFERENCES public.hfj_revinfo(rev);


--
-- PostgreSQL database dump complete
--

