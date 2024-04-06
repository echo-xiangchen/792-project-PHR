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
-- Name: 17209; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17209');


ALTER LARGE OBJECT 17209 OWNER TO admin;

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
-- Name: 17213; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('17213');


ALTER LARGE OBJECT 17213 OWNER TO admin;

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
-- Name: 33590; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33590');


ALTER LARGE OBJECT 33590 OWNER TO admin;

--
-- Name: 33591; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33591');


ALTER LARGE OBJECT 33591 OWNER TO admin;

--
-- Name: 33592; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33592');


ALTER LARGE OBJECT 33592 OWNER TO admin;

--
-- Name: 33593; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33593');


ALTER LARGE OBJECT 33593 OWNER TO admin;

--
-- Name: 33594; Type: BLOB; Schema: -; Owner: admin
--

SELECT pg_catalog.lo_create('33594');


ALTER LARGE OBJECT 33594 OWNER TO admin;

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
1	\N	\N	1	1	1	Patient
2	\N	\N	2	1	1	Patient
3	\N	\N	3	3	3	Encounter
4	\N	\N	3	4	4	Encounter
52	\N	\N	3	52	52	Encounter
53	\N	\N	3	53	53	Encounter
54	\N	\N	3	54	54	Encounter
55	\N	\N	3	55	55	Encounter
102	\N	\N	1	102	102	Patient
103	\N	\N	2	102	102	Patient
104	\N	\N	2	103	102	Patient
105	\N	\N	1	103	102	Patient
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
1	\N	\N	Encounter.subject.where(resolve() is Patient)	3	Encounter	1	Patient	\N	\N	2024-03-29 23:51:19.362
2	\N	\N	Encounter.subject	3	Encounter	1	Patient	\N	\N	2024-03-29 23:51:19.362
3	\N	\N	Encounter.subject.where(resolve() is Patient)	4	Encounter	1	Patient	\N	\N	2024-03-29 23:51:24.703
4	\N	\N	Encounter.subject	4	Encounter	1	Patient	\N	\N	2024-03-29 23:51:24.703
5	\N	\N	ServiceRequest.subject	5	ServiceRequest	1	Patient	\N	\N	2024-03-29 23:51:30.453
6	\N	\N	ServiceRequest.subject.where(resolve() is Patient)	5	ServiceRequest	1	Patient	\N	\N	2024-03-29 23:51:30.453
7	\N	\N	ServiceRequest.requester	5	ServiceRequest	2	Practitioner	\N	\N	2024-03-29 23:51:30.453
8	\N	\N	ServiceRequest.encounter	5	ServiceRequest	3	Encounter	\N	\N	2024-03-29 23:51:30.453
9	\N	\N	ServiceRequest.subject	6	ServiceRequest	1	Patient	\N	\N	2024-03-29 23:51:34.845
10	\N	\N	ServiceRequest.requester	6	ServiceRequest	2	Practitioner	\N	\N	2024-03-29 23:51:34.845
11	\N	\N	ServiceRequest.encounter	6	ServiceRequest	4	Encounter	\N	\N	2024-03-29 23:51:34.845
12	\N	\N	ServiceRequest.subject.where(resolve() is Patient)	6	ServiceRequest	1	Patient	\N	\N	2024-03-29 23:51:34.845
13	\N	\N	Observation.subject	7	Observation	1	Patient	\N	\N	2024-03-29 23:51:41.609
14	\N	\N	Observation.subject.where(resolve() is Patient)	7	Observation	1	Patient	\N	\N	2024-03-29 23:51:41.609
15	\N	\N	Observation.subject.where(resolve() is Patient)	8	Observation	1	Patient	\N	\N	2024-03-29 23:51:44.748
16	\N	\N	Observation.subject	8	Observation	1	Patient	\N	\N	2024-03-29 23:51:44.748
17	\N	\N	Observation.subject	9	Observation	1	Patient	\N	\N	2024-03-29 23:51:47.861
18	\N	\N	Observation.subject.where(resolve() is Patient)	9	Observation	1	Patient	\N	\N	2024-03-29 23:51:47.861
19	\N	\N	Observation.subject.where(resolve() is Patient)	10	Observation	1	Patient	\N	\N	2024-03-29 23:51:58.9
20	\N	\N	Observation.subject	10	Observation	1	Patient	\N	\N	2024-03-29 23:51:58.9
21	\N	\N	Observation.subject.where(resolve() is Patient)	11	Observation	1	Patient	\N	\N	2024-03-29 23:52:06.229
22	\N	\N	Observation.subject	11	Observation	1	Patient	\N	\N	2024-03-29 23:52:06.229
23	\N	\N	Observation.subject	12	Observation	1	Patient	\N	\N	2024-03-29 23:52:13.102
24	\N	\N	Observation.subject.where(resolve() is Patient)	12	Observation	1	Patient	\N	\N	2024-03-29 23:52:13.102
25	\N	\N	Observation.subject.where(resolve() is Patient)	13	Observation	1	Patient	\N	\N	2024-03-29 23:52:18.104
26	\N	\N	Observation.subject	13	Observation	1	Patient	\N	\N	2024-03-29 23:52:18.104
27	\N	\N	Observation.subject.where(resolve() is Patient)	14	Observation	1	Patient	\N	\N	2024-03-29 23:52:30.942
28	\N	\N	Observation.subject	14	Observation	1	Patient	\N	\N	2024-03-29 23:52:30.942
29	\N	\N	Observation.subject.where(resolve() is Patient)	15	Observation	1	Patient	\N	\N	2024-03-29 23:52:36.874
30	\N	\N	Observation.subject	15	Observation	1	Patient	\N	\N	2024-03-29 23:52:36.874
31	\N	\N	Observation.subject	16	Observation	1	Patient	\N	\N	2024-03-29 23:52:41.933
32	\N	\N	Observation.subject.where(resolve() is Patient)	16	Observation	1	Patient	\N	\N	2024-03-29 23:52:41.933
33	\N	\N	Observation.subject.where(resolve() is Patient)	17	Observation	1	Patient	\N	\N	2024-03-29 23:52:45.811
34	\N	\N	Observation.subject	17	Observation	1	Patient	\N	\N	2024-03-29 23:52:45.811
35	\N	\N	Observation.subject.where(resolve() is Patient)	18	Observation	1	Patient	\N	\N	2024-03-29 23:52:50.645
36	\N	\N	Observation.subject	18	Observation	1	Patient	\N	\N	2024-03-29 23:52:50.645
37	\N	\N	DiagnosticReport.result	19	DiagnosticReport	9	Observation	\N	\N	2024-03-29 23:53:08.206
38	\N	\N	DiagnosticReport.result	19	DiagnosticReport	8	Observation	\N	\N	2024-03-29 23:53:08.206
39	\N	\N	DiagnosticReport.subject.where(resolve() is Patient)	19	DiagnosticReport	1	Patient	\N	\N	2024-03-29 23:53:08.206
40	\N	\N	DiagnosticReport.result	19	DiagnosticReport	7	Observation	\N	\N	2024-03-29 23:53:08.206
41	\N	\N	DiagnosticReport.basedOn	19	DiagnosticReport	5	ServiceRequest	\N	\N	2024-03-29 23:53:08.206
42	\N	\N	DiagnosticReport.subject	19	DiagnosticReport	1	Patient	\N	\N	2024-03-29 23:53:08.206
43	\N	\N	DiagnosticReport.result	19	DiagnosticReport	10	Observation	\N	\N	2024-03-29 23:53:08.206
44	\N	\N	DiagnosticReport.result	20	DiagnosticReport	15	Observation	\N	\N	2024-03-29 23:53:37.276
45	\N	\N	DiagnosticReport.result	20	DiagnosticReport	14	Observation	\N	\N	2024-03-29 23:53:37.276
46	\N	\N	DiagnosticReport.result	20	DiagnosticReport	13	Observation	\N	\N	2024-03-29 23:53:37.276
47	\N	\N	DiagnosticReport.result	20	DiagnosticReport	12	Observation	\N	\N	2024-03-29 23:53:37.276
48	\N	\N	DiagnosticReport.result	20	DiagnosticReport	11	Observation	\N	\N	2024-03-29 23:53:37.276
49	\N	\N	DiagnosticReport.subject.where(resolve() is Patient)	20	DiagnosticReport	1	Patient	\N	\N	2024-03-29 23:53:37.276
50	\N	\N	DiagnosticReport.subject	20	DiagnosticReport	1	Patient	\N	\N	2024-03-29 23:53:37.276
51	\N	\N	DiagnosticReport.basedOn	20	DiagnosticReport	6	ServiceRequest	\N	\N	2024-03-29 23:53:37.276
52	\N	\N	DiagnosticReport.result	20	DiagnosticReport	18	Observation	\N	\N	2024-03-29 23:53:37.276
53	\N	\N	DiagnosticReport.result	20	DiagnosticReport	17	Observation	\N	\N	2024-03-29 23:53:37.276
54	\N	\N	DiagnosticReport.result	20	DiagnosticReport	16	Observation	\N	\N	2024-03-29 23:53:37.276
102	\N	\N	Encounter.subject.where(resolve() is Patient)	52	Encounter	1	Patient	\N	\N	2024-03-30 04:26:05.517
103	\N	\N	Encounter.subject	52	Encounter	1	Patient	\N	\N	2024-03-30 04:26:05.517
104	\N	\N	Encounter.subject	53	Encounter	1	Patient	\N	\N	2024-03-30 04:26:09.137
105	\N	\N	Encounter.subject.where(resolve() is Patient)	53	Encounter	1	Patient	\N	\N	2024-03-30 04:26:09.137
106	\N	\N	Encounter.subject	54	Encounter	1	Patient	\N	\N	2024-03-30 04:26:12.997
107	\N	\N	Encounter.subject.where(resolve() is Patient)	54	Encounter	1	Patient	\N	\N	2024-03-30 04:26:12.997
108	\N	\N	Encounter.subject.where(resolve() is Patient)	55	Encounter	1	Patient	\N	\N	2024-03-30 04:26:15.97
109	\N	\N	Encounter.subject	55	Encounter	1	Patient	\N	\N	2024-03-30 04:26:15.97
110	\N	\N	ServiceRequest.subject.where(resolve() is Patient)	56	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:26:35.106
111	\N	\N	ServiceRequest.requester	56	ServiceRequest	2	Practitioner	\N	\N	2024-03-30 04:26:35.106
112	\N	\N	ServiceRequest.subject	56	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:26:35.106
113	\N	\N	ServiceRequest.encounter	56	ServiceRequest	52	Encounter	\N	\N	2024-03-30 04:26:35.106
114	\N	\N	ServiceRequest.subject.where(resolve() is Patient)	57	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:27:28.171
115	\N	\N	ServiceRequest.encounter	57	ServiceRequest	53	Encounter	\N	\N	2024-03-30 04:27:28.171
116	\N	\N	ServiceRequest.subject	57	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:27:28.171
117	\N	\N	ServiceRequest.requester	57	ServiceRequest	2	Practitioner	\N	\N	2024-03-30 04:27:28.171
118	\N	\N	ServiceRequest.requester	58	ServiceRequest	2	Practitioner	\N	\N	2024-03-30 04:29:25.948
119	\N	\N	ServiceRequest.encounter	58	ServiceRequest	54	Encounter	\N	\N	2024-03-30 04:29:25.948
120	\N	\N	ServiceRequest.subject	58	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:29:25.948
121	\N	\N	ServiceRequest.subject.where(resolve() is Patient)	58	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:29:25.948
122	\N	\N	ServiceRequest.requester	59	ServiceRequest	2	Practitioner	\N	\N	2024-03-30 04:29:42.34
123	\N	\N	ServiceRequest.subject	59	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:29:42.34
124	\N	\N	ServiceRequest.encounter	59	ServiceRequest	55	Encounter	\N	\N	2024-03-30 04:29:42.34
125	\N	\N	ServiceRequest.subject.where(resolve() is Patient)	59	ServiceRequest	1	Patient	\N	\N	2024-03-30 04:29:42.34
126	\N	\N	Observation.subject.where(resolve() is Patient)	60	Observation	1	Patient	\N	\N	2024-03-30 04:31:56.282
127	\N	\N	Observation.subject	60	Observation	1	Patient	\N	\N	2024-03-30 04:31:56.282
128	\N	\N	Observation.subject	61	Observation	1	Patient	\N	\N	2024-03-30 04:33:07.05
129	\N	\N	Observation.subject.where(resolve() is Patient)	61	Observation	1	Patient	\N	\N	2024-03-30 04:33:07.05
130	\N	\N	Observation.subject.where(resolve() is Patient)	62	Observation	1	Patient	\N	\N	2024-03-30 04:33:53.184
131	\N	\N	Observation.subject	62	Observation	1	Patient	\N	\N	2024-03-30 04:33:53.184
132	\N	\N	Observation.subject	63	Observation	1	Patient	\N	\N	2024-03-30 04:34:37.247
133	\N	\N	Observation.subject.where(resolve() is Patient)	63	Observation	1	Patient	\N	\N	2024-03-30 04:34:37.247
134	\N	\N	DiagnosticReport.result	64	DiagnosticReport	62	Observation	\N	\N	2024-03-30 04:36:58.287
135	\N	\N	DiagnosticReport.result	64	DiagnosticReport	63	Observation	\N	\N	2024-03-30 04:36:58.287
136	\N	\N	DiagnosticReport.basedOn	64	DiagnosticReport	56	ServiceRequest	\N	\N	2024-03-30 04:36:58.287
137	\N	\N	DiagnosticReport.subject	64	DiagnosticReport	1	Patient	\N	\N	2024-03-30 04:36:58.287
138	\N	\N	DiagnosticReport.result	64	DiagnosticReport	60	Observation	\N	\N	2024-03-30 04:36:58.287
139	\N	\N	DiagnosticReport.subject.where(resolve() is Patient)	64	DiagnosticReport	1	Patient	\N	\N	2024-03-30 04:36:58.287
140	\N	\N	DiagnosticReport.result	64	DiagnosticReport	61	Observation	\N	\N	2024-03-30 04:36:58.287
141	\N	\N	Observation.subject.where(resolve() is Patient)	65	Observation	1	Patient	\N	\N	2024-03-30 04:38:52.576
142	\N	\N	Observation.subject	65	Observation	1	Patient	\N	\N	2024-03-30 04:38:52.576
143	\N	\N	Observation.subject.where(resolve() is Patient)	66	Observation	1	Patient	\N	\N	2024-03-30 04:39:45.262
144	\N	\N	Observation.subject	66	Observation	1	Patient	\N	\N	2024-03-30 04:39:45.262
145	\N	\N	Observation.subject	67	Observation	1	Patient	\N	\N	2024-03-30 04:40:32.538
146	\N	\N	Observation.subject.where(resolve() is Patient)	67	Observation	1	Patient	\N	\N	2024-03-30 04:40:32.538
147	\N	\N	Observation.subject	68	Observation	1	Patient	\N	\N	2024-03-30 04:41:13.966
148	\N	\N	Observation.subject.where(resolve() is Patient)	68	Observation	1	Patient	\N	\N	2024-03-30 04:41:13.966
149	\N	\N	DiagnosticReport.subject	69	DiagnosticReport	1	Patient	\N	\N	2024-03-30 04:43:14.94
150	\N	\N	DiagnosticReport.result	69	DiagnosticReport	66	Observation	\N	\N	2024-03-30 04:43:14.94
151	\N	\N	DiagnosticReport.result	69	DiagnosticReport	65	Observation	\N	\N	2024-03-30 04:43:14.94
152	\N	\N	DiagnosticReport.result	69	DiagnosticReport	68	Observation	\N	\N	2024-03-30 04:43:14.94
153	\N	\N	DiagnosticReport.result	69	DiagnosticReport	67	Observation	\N	\N	2024-03-30 04:43:14.94
154	\N	\N	DiagnosticReport.basedOn	69	DiagnosticReport	57	ServiceRequest	\N	\N	2024-03-30 04:43:14.94
155	\N	\N	DiagnosticReport.subject.where(resolve() is Patient)	69	DiagnosticReport	1	Patient	\N	\N	2024-03-30 04:43:14.94
156	\N	\N	Observation.subject	70	Observation	1	Patient	\N	\N	2024-03-30 04:44:53.418
157	\N	\N	Observation.subject.where(resolve() is Patient)	70	Observation	1	Patient	\N	\N	2024-03-30 04:44:53.418
158	\N	\N	Observation.subject.where(resolve() is Patient)	71	Observation	1	Patient	\N	\N	2024-03-30 04:45:48.146
159	\N	\N	Observation.subject	71	Observation	1	Patient	\N	\N	2024-03-30 04:45:48.146
160	\N	\N	Observation.subject	72	Observation	1	Patient	\N	\N	2024-03-30 04:46:26.864
161	\N	\N	Observation.subject.where(resolve() is Patient)	72	Observation	1	Patient	\N	\N	2024-03-30 04:46:26.864
162	\N	\N	Observation.subject	73	Observation	1	Patient	\N	\N	2024-03-30 04:47:11.586
163	\N	\N	Observation.subject.where(resolve() is Patient)	73	Observation	1	Patient	\N	\N	2024-03-30 04:47:11.586
164	\N	\N	Observation.subject.where(resolve() is Patient)	74	Observation	1	Patient	\N	\N	2024-03-30 04:47:58.496
165	\N	\N	Observation.subject	74	Observation	1	Patient	\N	\N	2024-03-30 04:47:58.496
166	\N	\N	Observation.subject.where(resolve() is Patient)	75	Observation	1	Patient	\N	\N	2024-03-30 04:48:37.308
167	\N	\N	Observation.subject	75	Observation	1	Patient	\N	\N	2024-03-30 04:48:37.308
168	\N	\N	Observation.subject	76	Observation	1	Patient	\N	\N	2024-03-30 04:49:29.535
169	\N	\N	Observation.subject.where(resolve() is Patient)	76	Observation	1	Patient	\N	\N	2024-03-30 04:49:29.535
170	\N	\N	Observation.subject.where(resolve() is Patient)	77	Observation	1	Patient	\N	\N	2024-03-30 04:50:10.779
171	\N	\N	Observation.subject	77	Observation	1	Patient	\N	\N	2024-03-30 04:50:10.779
172	\N	\N	DiagnosticReport.result	78	DiagnosticReport	77	Observation	\N	\N	2024-03-30 04:52:21.763
173	\N	\N	DiagnosticReport.basedOn	78	DiagnosticReport	58	ServiceRequest	\N	\N	2024-03-30 04:52:21.763
174	\N	\N	DiagnosticReport.result	78	DiagnosticReport	70	Observation	\N	\N	2024-03-30 04:52:21.763
175	\N	\N	DiagnosticReport.subject.where(resolve() is Patient)	78	DiagnosticReport	1	Patient	\N	\N	2024-03-30 04:52:21.763
176	\N	\N	DiagnosticReport.result	78	DiagnosticReport	72	Observation	\N	\N	2024-03-30 04:52:21.763
177	\N	\N	DiagnosticReport.result	78	DiagnosticReport	71	Observation	\N	\N	2024-03-30 04:52:21.763
178	\N	\N	DiagnosticReport.subject	78	DiagnosticReport	1	Patient	\N	\N	2024-03-30 04:52:21.763
179	\N	\N	DiagnosticReport.result	78	DiagnosticReport	74	Observation	\N	\N	2024-03-30 04:52:21.763
180	\N	\N	DiagnosticReport.result	78	DiagnosticReport	73	Observation	\N	\N	2024-03-30 04:52:21.763
181	\N	\N	DiagnosticReport.result	78	DiagnosticReport	76	Observation	\N	\N	2024-03-30 04:52:21.763
182	\N	\N	DiagnosticReport.result	78	DiagnosticReport	75	Observation	\N	\N	2024-03-30 04:52:21.763
183	\N	\N	Observation.subject	79	Observation	1	Patient	\N	\N	2024-03-30 04:53:53.703
184	\N	\N	Observation.subject.where(resolve() is Patient)	79	Observation	1	Patient	\N	\N	2024-03-30 04:53:53.703
185	\N	\N	Observation.subject	80	Observation	1	Patient	\N	\N	2024-03-30 04:54:42.536
186	\N	\N	Observation.subject.where(resolve() is Patient)	80	Observation	1	Patient	\N	\N	2024-03-30 04:54:42.536
187	\N	\N	Observation.subject	81	Observation	1	Patient	\N	\N	2024-03-30 04:55:23.364
188	\N	\N	Observation.subject.where(resolve() is Patient)	81	Observation	1	Patient	\N	\N	2024-03-30 04:55:23.364
189	\N	\N	Observation.subject.where(resolve() is Patient)	82	Observation	1	Patient	\N	\N	2024-03-30 04:56:04.597
190	\N	\N	Observation.subject	82	Observation	1	Patient	\N	\N	2024-03-30 04:56:04.597
191	\N	\N	Observation.subject.where(resolve() is Patient)	83	Observation	1	Patient	\N	\N	2024-03-30 04:56:47.414
192	\N	\N	Observation.subject	83	Observation	1	Patient	\N	\N	2024-03-30 04:56:47.414
193	\N	\N	Observation.subject	84	Observation	1	Patient	\N	\N	2024-03-30 04:57:28.702
194	\N	\N	Observation.subject.where(resolve() is Patient)	84	Observation	1	Patient	\N	\N	2024-03-30 04:57:28.702
195	\N	\N	Observation.subject	85	Observation	1	Patient	\N	\N	2024-03-30 04:58:13.109
196	\N	\N	Observation.subject.where(resolve() is Patient)	85	Observation	1	Patient	\N	\N	2024-03-30 04:58:13.109
197	\N	\N	Observation.subject.where(resolve() is Patient)	86	Observation	1	Patient	\N	\N	2024-03-30 04:58:53.964
198	\N	\N	Observation.subject	86	Observation	1	Patient	\N	\N	2024-03-30 04:58:53.964
199	\N	\N	DiagnosticReport.subject	87	DiagnosticReport	1	Patient	\N	\N	2024-03-30 05:00:46.183
200	\N	\N	DiagnosticReport.subject.where(resolve() is Patient)	87	DiagnosticReport	1	Patient	\N	\N	2024-03-30 05:00:46.183
201	\N	\N	DiagnosticReport.result	87	DiagnosticReport	86	Observation	\N	\N	2024-03-30 05:00:46.183
202	\N	\N	DiagnosticReport.result	87	DiagnosticReport	82	Observation	\N	\N	2024-03-30 05:00:46.183
203	\N	\N	DiagnosticReport.result	87	DiagnosticReport	83	Observation	\N	\N	2024-03-30 05:00:46.183
204	\N	\N	DiagnosticReport.basedOn	87	DiagnosticReport	59	ServiceRequest	\N	\N	2024-03-30 05:00:46.183
205	\N	\N	DiagnosticReport.result	87	DiagnosticReport	84	Observation	\N	\N	2024-03-30 05:00:46.183
206	\N	\N	DiagnosticReport.result	87	DiagnosticReport	85	Observation	\N	\N	2024-03-30 05:00:46.183
207	\N	\N	DiagnosticReport.result	87	DiagnosticReport	79	Observation	\N	\N	2024-03-30 05:00:46.183
208	\N	\N	DiagnosticReport.result	87	DiagnosticReport	80	Observation	\N	\N	2024-03-30 05:00:46.183
209	\N	\N	DiagnosticReport.result	87	DiagnosticReport	81	Observation	\N	\N	2024-03-30 05:00:46.183
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
1	\N	\N	1	1	Patient
2	\N	\N	2	1	Patient
3	\N	\N	3	3	Encounter
4	\N	\N	3	4	Encounter
52	\N	\N	3	52	Encounter
53	\N	\N	3	53	Encounter
54	\N	\N	3	54	Encounter
55	\N	\N	3	55	Encounter
102	\N	\N	1	102	Patient
103	\N	\N	2	102	Patient
\.


--
-- Data for Name: hfj_res_ver; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_ver (pid, partition_date, partition_id, res_deleted_at, res_version, has_tags, res_published, res_updated, res_encoding, request_id, res_text, res_id, res_text_vc, res_type, res_ver, source_uri) FROM stdin;
1	\N	\N	\N	R4	t	2024-03-29 23:51:02.473	2024-03-29 23:51:02.473	JSON	tbAAa35HWA6bpO0X	\N	1	{"resourceType":"Patient","identifier":[{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"RRI"}],"text":"eHealth Ontario Enterprise Identifier"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid","value":"2923"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"MR"}],"text":"Wait Time Information System"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-example-uri","value":"FULL_PROFILE_LEN3"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"JHN"}],"text":"Ontario, Canada Personal Health Number"},"system":"https://fhir.infoway-inforoute.ca/NamingSystem/ca-on-patient-hcn","value":"6132001124"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"MR"}],"text":"Brantford General"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-example1-uri","value":"WSD00038992"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"JHN"}],"text":"British Columbia, Personal Health Number"},"system":"https://fhir.infoway-inforoute.ca/NamingSystem/ca-bc-patient-healthcare-id","value":"1806194839"}],"name":[{"use":"official","family":"Ma","given":["Yun"]}],"telecom":[{"system":"phone","value":"+1-222-22-22","use":"home"},{"system":"email","value":"test2@uwaterloo.ca","use":"home"}],"gender":"male","birthDate":"1951-01-02","address":[{"use":"home","type":"physical","line":["HomeAd HomeAddress.stName 2"],"city":"Waterloo","state":"ON","postalCode":"K4A0K6","country":"CAN"}],"contact":[{"relationship":[{"coding":[{"system":"http://hl7.org/fhir/v2/0131","code":"C","display":"Emergency Contact"}]}],"telecom":[{"system":"phone","value":"+1-222-22-23"}]}],"communication":[{"language":{"coding":[{"system":"urn:ietf:bcp:47","code":"en","display":"English"}]},"preferred":true}]}	Patient	1	\N
2	\N	\N	\N	R4	f	2024-03-29 23:51:10.897	2024-03-29 23:51:10.897	JSON	EzG4zz0BdUsKcXAz	\N	2	{"resourceType":"Practitioner","identifier":[{"system":"http://www.acme.org/practitioners","value":"23"}],"name":[{"family":"Smith","given":["Anne"],"prefix":["DR"]}],"telecom":[{"system":"phone","value":"555-555-5555","use":"work"}],"address":[{"use":"home","type":"physical","line":["13 ABC St"],"city":"Toronto","state":"ON","postalCode":"M1M M2M","country":"Canada"}]}	Practitioner	1	\N
3	\N	\N	\N	R4	t	2024-03-29 23:51:19.362	2024-03-29 23:51:19.362	JSON	o9pzBU6VsOjZm5HZ	\N	3	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
4	\N	\N	\N	R4	t	2024-03-29 23:51:24.703	2024-03-29 23:51:24.703	JSON	gpTnVsc6aeHicOZe	\N	4	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
5	\N	\N	\N	R4	f	2024-03-29 23:51:30.453	2024-03-29 23:51:30.453	JSON	m5ZumuJiuUqkcVej	\N	5	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/3"},"occurrenceDateTime":"2023-11-30","authoredOn":"2023-11-24T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
6	\N	\N	\N	R4	f	2024-03-29 23:51:34.845	2024-03-29 23:51:34.845	JSON	EOHc8gtKZupAHNbK	\N	6	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/4"},"occurrenceDateTime":"2024-01-09","authoredOn":"2024-01-02T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
7	\N	\N	\N	R4	f	2024-03-29 23:51:41.609	2024-03-29 23:51:41.609	JSON	jm8gWJ7OxXIiFznL	\N	7	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2093-3","display":"Cholesterol [Mass/volume] in Serum or Plasma"}],"text":"Cholesterol Total"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-11-30","issued":"2023-11-30T10:30:00Z","valueQuantity":{"value":4.7,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":5.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
8	\N	\N	\N	R4	f	2024-03-29 23:51:44.748	2024-03-29 23:51:44.748	JSON	SASrKB6YOtiGamg9	\N	8	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2571-8","display":"Triglyceride [Mass/volume] in Serum or Plasma"}],"text":"Triglycerides"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-11-30","issued":"2023-11-30T10:30:00Z","valueQuantity":{"value":1.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":1.7,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
9	\N	\N	\N	R4	f	2024-03-29 23:51:47.861	2024-03-29 23:51:47.861	JSON	Lq1RlJWsxcjCqWCR	\N	9	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2085-9","display":"Cholesterol in HDL [Mass/volume] in Serum or Plasma"}],"text":"HDL Cholesterol"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-11-30","issued":"2023-11-30T10:30:00Z","valueQuantity":{"value":2.8,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":1.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal HDL range for males"},"appliesTo":[{"coding":[{"system":"http://hl7.org/fhir/administrative-gender","code":"male","display":"Male"}]}]}]}	Observation	1	\N
10	\N	\N	\N	R4	f	2024-03-29 23:51:58.9	2024-03-29 23:51:58.9	JSON	E0KwKs3AsURYJSXE	\N	10	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"13457-7","display":"Cholesterol in LDL [Mass/volume] in Serum or Plasma"}],"text":"LDL Cholesterol"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-11-30","issued":"2023-11-30T10:30:00Z","valueQuantity":{"value":2.9,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":3.4,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
11	\N	\N	\N	R4	f	2024-03-29 23:52:06.229	2024-03-29 23:52:06.229	JSON	mVe4uMJ0RiSfsksZ	\N	11	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2947-0","display":"Sodium [Moles/volume] in Blood"}],"text":"Sodium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":140,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":136,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":145,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
12	\N	\N	\N	R4	f	2024-03-29 23:52:13.102	2024-03-29 23:52:13.102	JSON	xEZSg69NBb1sDZb5	\N	12	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"6298-4","display":"Potassium [Moles/volume] in Blood"}],"text":"Potassium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":6.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"H","display":"High"}]}],"referenceRange":[{"low":{"value":3.5,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":5.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
13	\N	\N	\N	R4	f	2024-03-29 23:52:18.104	2024-03-29 23:52:18.104	JSON	NPMxWWQUhkoR1PWh	\N	13	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2069-3","display":"Chloride [Moles/volume] in Blood"}],"text":"Chloride"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":99,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":98,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":106,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
14	\N	\N	\N	R4	f	2024-03-29 23:52:30.942	2024-03-29 23:52:30.942	JSON	4VhKd19GjKspSyym	\N	14	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"20565-8","display":"Carbon dioxide, total [Moles/volume] in Blood"}],"text":"Carbon dioxide"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":24,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":23,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":28,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
15	\N	\N	\N	R4	f	2024-03-29 23:52:36.874	2024-03-29 23:52:36.874	JSON	ftTttAGHsAZr3G8g	\N	15	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"20565-8","display":"Urea nitrogen [Mass/volume] in Blood"}],"text":"Blood Urea Nitrogen (BUN)"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":20,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":8,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":20,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
16	\N	\N	\N	R4	f	2024-03-29 23:52:41.933	2024-03-29 23:52:41.933	JSON	PajB0kW7EanLNL7x	\N	16	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"38483-4","display":"Creatinine [Mass/volume] in Blood"}],"text":"Creatinine"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":1.4,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"H","display":"High"}]}],"referenceRange":[{"low":{"value":0.6,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":1.3,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
17	\N	\N	\N	R4	f	2024-03-29 23:52:45.811	2024-03-29 23:52:45.811	JSON	ZYZsmO636u2X4D8s	\N	17	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"49765-1","display":"Calcium [Mass/volume] in Blood"}],"text":"Calcium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":9.2,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":8.6,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":10.2,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
18	\N	\N	\N	R4	f	2024-03-29 23:52:50.645	2024-03-29 23:52:50.645	JSON	idUKvPsnGMcM61Hz	\N	18	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2339-0","display":"Glucose [Mass/volume] in Blood"}],"text":"Blood Glucose"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09","issued":"2024-01-09T10:30:00Z","valueQuantity":{"value":4.3,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.8,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Nonfasting Blood Glucose Reference Range"}}]}	Observation	1	\N
19	\N	\N	\N	R4	f	2024-03-29 23:53:08.206	2024-03-29 23:53:08.206	JSON	lrJ2651obAygjfYI	\N	19	{"resourceType":"DiagnosticReport","basedOn":[{"reference":"ServiceRequest/5"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"100898-6","display":"Lipid panel - Serum or Plasma"}],"text":"Lipid Panel"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-11-30T08:30:00+11:00","issued":"2023-11-30T12:30:00Z","performer":[{"display":"ABC Laboratory"}],"result":[{"reference":"Observation/7","display":"Cholesterol [Mass/volume] in Serum or Plasma"},{"reference":"Observation/8","display":"Triglyceride [Mass/volume] in Serum or Plasma"},{"reference":"Observation/9","display":"Cholesterol in HDL [Mass/volume] in Serum or Plasma"},{"reference":"Observation/10","display":"Cholesterol in LDL [Mass/volume] in Serum or Plasma"}],"conclusion":"The Lipid Panel results are within normal ranges."}	DiagnosticReport	1	\N
20	\N	\N	\N	R4	f	2024-03-29 23:53:37.276	2024-03-29 23:53:37.276	JSON	DVMvlqBjKzrqhEFY	\N	20	{"resourceType":"DiagnosticReport","basedOn":[{"reference":"ServiceRequest/6"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"51990-0","display":"Basic metabolic panel - Blood"}],"text":"Basic metabolic panel"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2024-01-09T08:30:00+11:00","issued":"2024-11-09T12:30:00Z","performer":[{"display":"DEF Laboratory"}],"result":[{"reference":"Observation/11","display":"Sodium [Moles/volume] in Blood"},{"reference":"Observation/12","display":"Potassium [Moles/volume] in Blood"},{"reference":"Observation/13","display":"Chloride [Moles/volume] in Blood"},{"reference":"Observation/14","display":"Carbon dioxide, total [Moles/volume] in Blood"},{"reference":"Observation/15","display":"Urea nitrogen [Mass/volume] in Blood"},{"reference":"Observation/16","display":"Creatinine [Mass/volume] in Blood"},{"reference":"Observation/17","display":"Calcium [Mass/volume] in Blood"},{"reference":"Observation/18","display":"Glucose [Mass/volume] in Blood"}],"conclusion":"The Basic Metabolic Panel results are within normal ranges."}	DiagnosticReport	1	\N
52	\N	\N	\N	R4	t	2024-03-30 04:26:05.517	2024-03-30 04:26:05.517	JSON	6Py9hYzS89gQ6cPT	\N	52	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
53	\N	\N	\N	R4	t	2024-03-30 04:26:09.137	2024-03-30 04:26:09.137	JSON	9ZRtw77LHTsGOekS	\N	53	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
54	\N	\N	\N	R4	t	2024-03-30 04:26:12.997	2024-03-30 04:26:12.997	JSON	AWfjesWDeJUoRCL0	\N	54	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
55	\N	\N	\N	R4	t	2024-03-30 04:26:15.97	2024-03-30 04:26:15.97	JSON	w5qOxG1LTA2ThJ5g	\N	55	{"resourceType":"Encounter","status":"finished","subject":{"reference":"Patient/1"},"participant":[{"type":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ParticipationType","code":"ATND","display":"Attender"}]}]}],"location":[{"location":{"display":"Kitchener Walking Clinic"}}]}	Encounter	1	\N
56	\N	\N	\N	R4	f	2024-03-30 04:26:35.106	2024-03-30 04:26:35.106	JSON	4JIgckuiVv1WBmPS	\N	56	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/52"},"occurrenceDateTime":"2023-05-20","authoredOn":"2023-05-20T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
57	\N	\N	\N	R4	f	2024-03-30 04:27:28.171	2024-03-30 04:27:28.171	JSON	EIvNsVYPd7AXPQpJ	\N	57	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/53"},"occurrenceDateTime":"2022-11-21","authoredOn":"2022-11-21T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
58	\N	\N	\N	R4	f	2024-03-30 04:29:25.948	2024-03-30 04:29:25.948	JSON	FPKSf0JuMhKI2wzN	\N	58	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/54"},"occurrenceDateTime":"2023-08-01","authoredOn":"2023-08-01T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
59	\N	\N	\N	R4	f	2024-03-30 04:29:42.34	2024-03-30 04:29:42.34	JSON	dvZy41bKNvuNorUP	\N	59	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/55"},"occurrenceDateTime":"2023-01-10","authoredOn":"2023-01-10T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
60	\N	\N	\N	R4	f	2024-03-30 04:31:56.282	2024-03-30 04:31:56.282	JSON	kJoeDRTri3bvi9AP	\N	60	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2093-3","display":"Cholesterol [Mass/volume] in Serum or Plasma"}],"text":"Cholesterol Total"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":4.3,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":5.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
61	\N	\N	\N	R4	f	2024-03-30 04:33:07.05	2024-03-30 04:33:07.05	JSON	hMu098hpWiKdZXC1	\N	61	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2571-8","display":"Triglyceride [Mass/volume] in Serum or Plasma"}],"text":"Triglycerides"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":1.3,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":1.7,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
62	\N	\N	\N	R4	f	2024-03-30 04:33:53.184	2024-03-30 04:33:53.184	JSON	GJZdc5vbJWFgZVsI	\N	62	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2085-9","display":"Cholesterol in HDL [Mass/volume] in Serum or Plasma"}],"text":"HDL Cholesterol"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":3.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":1.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal HDL range for males"},"appliesTo":[{"coding":[{"system":"http://hl7.org/fhir/administrative-gender","code":"male","display":"Male"}]}]}]}	Observation	1	\N
63	\N	\N	\N	R4	f	2024-03-30 04:34:37.247	2024-03-30 04:34:37.247	JSON	GHLIelWJfhemQDeA	\N	63	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"13457-7","display":"Cholesterol in LDL [Mass/volume] in Serum or Plasma"}],"text":"LDL Cholesterol"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":3.1,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":3.4,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
64	\N	\N	\N	R4	f	2024-03-30 04:36:58.287	2024-03-30 04:36:58.287	JSON	hawMMWICNMi2BKzG	\N	64	{"resourceType":"DiagnosticReport","basedOn":[{"reference":"ServiceRequest/56"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"100898-6","display":"Lipid panel - Serum or Plasma"}],"text":"Lipid Panel"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27T08:30:00+11:00","issued":"2023-05-27T12:30:00Z","performer":[{"display":"ABC Laboratory"}],"result":[{"reference":"Observation/60","display":"Cholesterol [Mass/volume] in Serum or Plasma"},{"reference":"Observation/61","display":"Triglyceride [Mass/volume] in Serum or Plasma"},{"reference":"Observation/62","display":"Cholesterol in HDL [Mass/volume] in Serum or Plasma"},{"reference":"Observation/63","display":"Cholesterol in LDL [Mass/volume] in Serum or Plasma"}],"conclusion":"The Lipid Panel results are within normal ranges."}	DiagnosticReport	1	\N
65	\N	\N	\N	R4	f	2024-03-30 04:38:52.576	2024-03-30 04:38:52.576	JSON	2QVGMObF1R84u4Vx	\N	65	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2093-3","display":"Cholesterol [Mass/volume] in Serum or Plasma"}],"text":"Cholesterol Total"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":4.3,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":5.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
66	\N	\N	\N	R4	f	2024-03-30 04:39:45.262	2024-03-30 04:39:45.262	JSON	ADlGqOwcDf4LZsvW	\N	66	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2571-8","display":"Triglyceride [Mass/volume] in Serum or Plasma"}],"text":"Triglycerides"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":1.3,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":1.7,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
67	\N	\N	\N	R4	f	2024-03-30 04:40:32.538	2024-03-30 04:40:32.538	JSON	9EidwKNgXD72vOmr	\N	67	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2085-9","display":"Cholesterol in HDL [Mass/volume] in Serum or Plasma"}],"text":"HDL Cholesterol"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":3.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":1.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Normal HDL range for males"},"appliesTo":[{"coding":[{"system":"http://hl7.org/fhir/administrative-gender","code":"male","display":"Male"}]}]}]}	Observation	1	\N
68	\N	\N	\N	R4	f	2024-03-30 04:41:13.966	2024-03-30 04:41:13.966	JSON	BzC0OcuCMl5kzDq5	\N	68	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"13457-7","display":"Cholesterol in LDL [Mass/volume] in Serum or Plasma"}],"text":"LDL Cholesterol"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-05-27","issued":"2023-05-27T10:30:00Z","valueQuantity":{"value":3.1,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"high":{"value":3.4,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
69	\N	\N	\N	R4	f	2024-03-30 04:43:14.94	2024-03-30 04:43:14.94	JSON	PlND4jiTuR3MuwLZ	\N	69	{"resourceType":"DiagnosticReport","basedOn":[{"reference":"ServiceRequest/57"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"100898-6","display":"Lipid panel - Serum or Plasma"}],"text":"Lipid Panel"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2022-11-28T08:30:00+11:00","issued":"2022-11-28T12:30:00Z","performer":[{"display":"ABC Laboratory"}],"result":[{"reference":"Observation/65","display":"Cholesterol [Mass/volume] in Serum or Plasma"},{"reference":"Observation/66","display":"Triglyceride [Mass/volume] in Serum or Plasma"},{"reference":"Observation/67","display":"Cholesterol in HDL [Mass/volume] in Serum or Plasma"},{"reference":"Observation/68","display":"Cholesterol in LDL [Mass/volume] in Serum or Plasma"}],"conclusion":"The Lipid Panel results are within normal ranges."}	DiagnosticReport	1	\N
70	\N	\N	\N	R4	f	2024-03-30 04:44:53.418	2024-03-30 04:44:53.418	JSON	UPgZbPJ9RPlVibVF	\N	70	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2947-0","display":"Sodium [Moles/volume] in Blood"}],"text":"Sodium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":144,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":136,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":145,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
71	\N	\N	\N	R4	f	2024-03-30 04:45:48.146	2024-03-30 04:45:48.146	JSON	ZyIIEQUgbFXyT2vP	\N	71	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"6298-4","display":"Potassium [Moles/volume] in Blood"}],"text":"Potassium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":6.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"H","display":"High"}]}],"referenceRange":[{"low":{"value":3.5,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":5.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
72	\N	\N	\N	R4	f	2024-03-30 04:46:26.864	2024-03-30 04:46:26.864	JSON	EzfTyfijSs6kMUxH	\N	72	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2069-3","display":"Chloride [Moles/volume] in Blood"}],"text":"Chloride"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":101,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":98,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":106,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
73	\N	\N	\N	R4	f	2024-03-30 04:47:11.586	2024-03-30 04:47:11.586	JSON	qvxVBTg3p2ploMvO	\N	73	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"20565-8","display":"Carbon dioxide, total [Moles/volume] in Blood"}],"text":"Carbon dioxide"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":25,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":23,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":28,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
74	\N	\N	\N	R4	f	2024-03-30 04:47:58.496	2024-03-30 04:47:58.496	JSON	TVYHzHq8U7tIQFjv	\N	74	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"20565-8","display":"Urea nitrogen [Mass/volume] in Blood"}],"text":"Blood Urea Nitrogen (BUN)"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":16,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":8,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":20,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
75	\N	\N	\N	R4	f	2024-03-30 04:48:37.308	2024-03-30 04:48:37.308	JSON	3V6WsbspvDBZr9rm	\N	75	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"38483-4","display":"Creatinine [Mass/volume] in Blood"}],"text":"Creatinine"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":1.2,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":0.6,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":1.3,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
76	\N	\N	\N	R4	f	2024-03-30 04:49:29.535	2024-03-30 04:49:29.535	JSON	dV2XVpZ8HU1NbVNP	\N	76	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"49765-1","display":"Calcium [Mass/volume] in Blood"}],"text":"Calcium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":9.1,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":8.6,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":10.2,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
77	\N	\N	\N	R4	f	2024-03-30 04:50:10.779	2024-03-30 04:50:10.779	JSON	wBTl8VddJ96eMCBd	\N	77	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2339-0","display":"Glucose [Mass/volume] in Blood"}],"text":"Blood Glucose"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08","issued":"2023-08-08T10:30:00Z","valueQuantity":{"value":5.2,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.8,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Nonfasting Blood Glucose Reference Range"}}]}	Observation	1	\N
78	\N	\N	\N	R4	f	2024-03-30 04:52:21.763	2024-03-30 04:52:21.763	JSON	av1ssoiHnJos1Pw1	\N	78	{"resourceType":"DiagnosticReport","basedOn":[{"reference":"ServiceRequest/58"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"51990-0","display":"Basic metabolic panel - Blood"}],"text":"Basic metabolic panel"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-08-08T08:30:00+11:00","issued":"2023-08-08T12:30:00Z","performer":[{"display":"DEF Laboratory"}],"result":[{"reference":"Observation/70","display":"Sodium [Moles/volume] in Blood"},{"reference":"Observation/71","display":"Potassium [Moles/volume] in Blood"},{"reference":"Observation/72","display":"Chloride [Moles/volume] in Blood"},{"reference":"Observation/73","display":"Carbon dioxide, total [Moles/volume] in Blood"},{"reference":"Observation/74","display":"Urea nitrogen [Mass/volume] in Blood"},{"reference":"Observation/75","display":"Creatinine [Mass/volume] in Blood"},{"reference":"Observation/76","display":"Calcium [Mass/volume] in Blood"},{"reference":"Observation/77","display":"Glucose [Mass/volume] in Blood"}],"conclusion":"The Basic Metabolic Panel results are within normal ranges."}	DiagnosticReport	1	\N
79	\N	\N	\N	R4	f	2024-03-30 04:53:53.703	2024-03-30 04:53:53.703	JSON	j445nXcI74t3kIvY	\N	79	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2947-0","display":"Sodium [Moles/volume] in Blood"}],"text":"Sodium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":143,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":136,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":145,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
80	\N	\N	\N	R4	f	2024-03-30 04:54:42.536	2024-03-30 04:54:42.536	JSON	joA8sPJWqlov2Prs	\N	80	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"6298-4","display":"Potassium [Moles/volume] in Blood"}],"text":"Potassium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":4.8,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.5,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":5.0,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
81	\N	\N	\N	R4	f	2024-03-30 04:55:23.364	2024-03-30 04:55:23.364	JSON	w0z3sQAm7eATtYCS	\N	81	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2069-3","display":"Chloride [Moles/volume] in Blood"}],"text":"Chloride"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":103,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":98,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":106,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
82	\N	\N	\N	R4	f	2024-03-30 04:56:04.597	2024-03-30 04:56:04.597	JSON	y7l6xaX5CY28rFfM	\N	82	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"20565-8","display":"Carbon dioxide, total [Moles/volume] in Blood"}],"text":"Carbon dioxide"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":24,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":23,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":28,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"}}]}	Observation	1	\N
83	\N	\N	\N	R4	f	2024-03-30 04:56:47.414	2024-03-30 04:56:47.414	JSON	K56vEGFhc1Zv06Aw	\N	83	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"20565-8","display":"Urea nitrogen [Mass/volume] in Blood"}],"text":"Blood Urea Nitrogen (BUN)"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":14,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":8,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":20,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
84	\N	\N	\N	R4	f	2024-03-30 04:57:28.702	2024-03-30 04:57:28.702	JSON	nep1ymhxc36HpWd0	\N	84	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"38483-4","display":"Creatinine [Mass/volume] in Blood"}],"text":"Creatinine"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":1.3,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":0.6,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":1.3,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
85	\N	\N	\N	R4	f	2024-03-30 04:58:13.109	2024-03-30 04:58:13.109	JSON	7u2UnecSfNpv53rO	\N	85	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"49765-1","display":"Calcium [Mass/volume] in Blood"}],"text":"Calcium"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":9.0,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":8.6,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"},"high":{"value":10.2,"unit":"mg/dL","system":"http://unitsofmeasure.org","code":"mg/dL"}}]}	Observation	1	\N
86	\N	\N	\N	R4	f	2024-03-30 04:58:53.964	2024-03-30 04:58:53.964	JSON	09pd5UaP1ey1E5UE	\N	86	{"resourceType":"Observation","status":"final","code":{"coding":[{"system":"http://loinc.org","code":"2339-0","display":"Glucose [Mass/volume] in Blood"}],"text":"Blood Glucose"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17","issued":"2023-01-17T10:30:00Z","valueQuantity":{"value":6.1,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"interpretation":[{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation","code":"N","display":"Normal"}]}],"referenceRange":[{"low":{"value":3.9,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"high":{"value":7.8,"unit":"mmol/L","system":"http://unitsofmeasure.org","code":"mmol/L"},"type":{"text":"Nonfasting Blood Glucose Reference Range"}}]}	Observation	1	\N
87	\N	\N	\N	R4	f	2024-03-30 05:00:46.183	2024-03-30 05:00:46.183	JSON	aT6aYjxEQ6xH7owa	\N	87	{"resourceType":"DiagnosticReport","basedOn":[{"reference":"ServiceRequest/59"}],"status":"final","code":{"coding":[{"system":"http://loinc.org","code":"51990-0","display":"Basic metabolic panel - Blood"}],"text":"Basic metabolic panel"},"subject":{"reference":"Patient/1"},"effectiveDateTime":"2023-01-17T08:30:00+11:00","issued":"2023-01-17T12:30:00Z","performer":[{"display":"DEF Laboratory"}],"result":[{"reference":"Observation/79","display":"Sodium [Moles/volume] in Blood"},{"reference":"Observation/80","display":"Potassium [Moles/volume] in Blood"},{"reference":"Observation/81","display":"Chloride [Moles/volume] in Blood"},{"reference":"Observation/82","display":"Carbon dioxide, total [Moles/volume] in Blood"},{"reference":"Observation/83","display":"Urea nitrogen [Mass/volume] in Blood"},{"reference":"Observation/84","display":"Creatinine [Mass/volume] in Blood"},{"reference":"Observation/85","display":"Calcium [Mass/volume] in Blood"},{"reference":"Observation/86","display":"Glucose [Mass/volume] in Blood"}],"conclusion":"The Basic Metabolic Panel results are within normal ranges."}	DiagnosticReport	1	\N
161	\N	\N	\N	R4	f	2024-03-30 04:27:28.171	2024-03-30 18:09:06.624	JSON	eTU0B23vh8uiF3sr	\N	57	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"100898-6"}],"text":"Lipid panel - Serum or Plasma"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/53"},"occurrenceDateTime":"2022-11-21","authoredOn":"2022-11-21T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
102	\N	\N	\N	R4	t	2024-03-30 05:34:48.236	2024-03-30 05:34:48.236	JSON	tsrdovjPtw3HCanc	\N	102	{"resourceType":"Patient","identifier":[{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"RRI"}],"text":"eHealth Ontario Enterprise Identifier"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid","value":"2923"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"MR"}],"text":"Wait Time Information System"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-example-uri","value":"FULL_PROFILE_LEN3"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"JHN"}],"text":"Ontario, Canada Personal Health Number"},"system":"https://fhir.infoway-inforoute.ca/NamingSystem/ca-on-patient-hcn","value":"6132001124"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"MR"}],"text":"Brantford General"},"system":"http://ehealthontario.ca/fhir/NamingSystem/id-example1-uri","value":"WSD00038992"},{"type":{"coding":[{"system":"http://hl7.org/fhir/v2/0203","code":"JHN"}],"text":"British Columbia, Personal Health Number"},"system":"https://fhir.infoway-inforoute.ca/NamingSystem/ca-bc-patient-healthcare-id","value":"1806194839"}],"name":[{"use":"official","family":"Ma","given":["Yun"]}],"telecom":[{"system":"phone","value":"+1-222-22-22","use":"home"},{"system":"email","value":"test2@uwaterloo.ca","use":"home"}],"gender":"male","birthDate":"1951-01-02","address":[{"use":"home","type":"physical","line":["HomeAd HomeAddress.stName 2"],"city":"Waterloo","state":"ON","postalCode":"K4A0K6","country":"CAN"}],"contact":[{"relationship":[{"coding":[{"system":"http://hl7.org/fhir/v2/0131","code":"C","display":"Emergency Contact"}]}],"telecom":[{"system":"phone","value":"+1-222-22-23"}]}],"communication":[{"language":{"coding":[{"system":"urn:ietf:bcp:47","code":"en","display":"English"}]},"preferred":true}]}	Patient	1	\N
103	\N	\N	2024-03-30 05:35:30.333	R4	t	2024-03-30 05:34:48.236	2024-03-30 05:35:30.333	DEL	ufeaxMCmZQBY2z3b	\N	102	\N	Patient	2	\N
152	\N	\N	\N	R4	f	2024-03-30 17:58:42.089	2024-03-30 17:58:42.089	JSON	e9BT3aJmrLBoNVKH	\N	152	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"51990-0"}],"text":"Basic metabolic panel - Blood"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/55"},"occurrenceDateTime":"2023-01-10","authoredOn":"2023-01-10T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
153	\N	\N	2024-03-30 17:59:30.221	R4	f	2024-03-30 17:58:42.089	2024-03-30 17:59:30.221	DEL	oo6Uqd1z1C1WZQpv	\N	152	\N	ServiceRequest	2	\N
154	\N	\N	\N	R4	f	2024-03-30 18:01:06.793	2024-03-30 18:01:06.793	JSON	f2LjBr2nd5j2O4oK	\N	153	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"51990-0"}],"text":"Basic metabolic panel - Blood"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/55"},"occurrenceDateTime":"2023-01-10","authoredOn":"2023-01-10T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
155	\N	\N	2024-03-30 18:02:04.168	R4	f	2024-03-30 18:01:06.793	2024-03-30 18:02:04.168	DEL	FFteNK9Ri9ymt2qW	\N	153	\N	ServiceRequest	2	\N
156	\N	\N	\N	R4	f	2024-03-30 18:03:47.217	2024-03-30 18:03:47.217	JSON	PKPch3w2NElQO5Mw	\N	154	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/55"},"occurrenceDateTime":"2023-01-10","authoredOn":"2023-01-10T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	1	\N
157	\N	\N	\N	R4	f	2024-03-30 18:03:47.217	2024-03-30 18:05:45.75	JSON	b4kygEY2VKGqgGOm	\N	154	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"51990-0"}],"text":"Basic metabolic panel - Blood"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/55"},"occurrenceDateTime":"2023-01-10","authoredOn":"2023-01-10T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
158	\N	\N	\N	R4	f	2024-03-29 23:51:30.453	2024-03-30 18:06:44.473	JSON	sNSQ2LmLvoabd5Fn	\N	5	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"100898-6"}],"text":"Lipid panel - Serum or Plasma"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/3"},"occurrenceDateTime":"2023-11-30","authoredOn":"2023-11-24T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
159	\N	\N	\N	R4	f	2024-03-29 23:51:34.845	2024-03-30 18:07:36.645	JSON	krWUW7NIwu5VWo4d	\N	6	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"51990-0"}],"text":"Basic metabolic panel - Blood"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/4"},"occurrenceDateTime":"2024-01-09","authoredOn":"2024-01-02T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
160	\N	\N	\N	R4	f	2024-03-30 04:26:35.106	2024-03-30 18:08:24.163	JSON	7euTPhFD2JYvC1AO	\N	56	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"100898-6"}],"text":"Lipid panel - Serum or Plasma"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/52"},"occurrenceDateTime":"2023-05-20","authoredOn":"2023-05-20T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
162	\N	\N	\N	R4	f	2024-03-30 04:29:25.948	2024-03-30 18:09:53.003	JSON	7cq2e1ePCzCmx1QX	\N	58	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"51990-0"}],"text":"Basic metabolic panel - Blood"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/54"},"occurrenceDateTime":"2023-08-01","authoredOn":"2023-08-01T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
163	\N	\N	\N	R4	f	2024-03-30 04:29:42.34	2024-03-30 18:21:32.889	JSON	QAkM4V3c2DXxQiuW	\N	59	{"resourceType":"ServiceRequest","identifier":[{"type":{"coding":[{"system":"http://terminology.hl7.org/CodeSystem/v2-0203","code":"PLAC"}],"text":"Placer"},"system":"urn:oid:1.3.4.5.6.7","value":"2345234234234"}],"status":"completed","intent":"original-order","code":{"coding":[{"system":"http://loinc.org","code":"51990-0"}],"text":"Basic metabolic panel - Blood"},"subject":{"reference":"Patient/1"},"encounter":{"reference":"Encounter/55"},"occurrenceDateTime":"2023-01-10","authoredOn":"2023-01-10T10:30:00Z","requester":{"reference":"Practitioner/2"},"note":[{"text":"Patient is afraid of needles"}]}	ServiceRequest	2	\N
164	\N	\N	2024-03-30 18:22:47.033	R4	f	2024-03-30 18:03:47.217	2024-03-30 18:22:47.033	DEL	0zP79TGPz1Afn4oe	\N	154	\N	ServiceRequest	3	\N
\.


--
-- Data for Name: hfj_res_ver_prov; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_res_ver_prov (res_ver_pid, partition_date, partition_id, request_id, source_uri, res_pid) FROM stdin;
1	\N	\N	tbAAa35HWA6bpO0X	\N	1
2	\N	\N	EzG4zz0BdUsKcXAz	\N	2
3	\N	\N	o9pzBU6VsOjZm5HZ	\N	3
4	\N	\N	gpTnVsc6aeHicOZe	\N	4
5	\N	\N	m5ZumuJiuUqkcVej	\N	5
6	\N	\N	EOHc8gtKZupAHNbK	\N	6
7	\N	\N	jm8gWJ7OxXIiFznL	\N	7
8	\N	\N	SASrKB6YOtiGamg9	\N	8
9	\N	\N	Lq1RlJWsxcjCqWCR	\N	9
10	\N	\N	E0KwKs3AsURYJSXE	\N	10
11	\N	\N	mVe4uMJ0RiSfsksZ	\N	11
12	\N	\N	xEZSg69NBb1sDZb5	\N	12
13	\N	\N	NPMxWWQUhkoR1PWh	\N	13
14	\N	\N	4VhKd19GjKspSyym	\N	14
15	\N	\N	ftTttAGHsAZr3G8g	\N	15
16	\N	\N	PajB0kW7EanLNL7x	\N	16
17	\N	\N	ZYZsmO636u2X4D8s	\N	17
18	\N	\N	idUKvPsnGMcM61Hz	\N	18
19	\N	\N	lrJ2651obAygjfYI	\N	19
20	\N	\N	DVMvlqBjKzrqhEFY	\N	20
52	\N	\N	6Py9hYzS89gQ6cPT	\N	52
53	\N	\N	9ZRtw77LHTsGOekS	\N	53
54	\N	\N	AWfjesWDeJUoRCL0	\N	54
55	\N	\N	w5qOxG1LTA2ThJ5g	\N	55
56	\N	\N	4JIgckuiVv1WBmPS	\N	56
57	\N	\N	EIvNsVYPd7AXPQpJ	\N	57
58	\N	\N	FPKSf0JuMhKI2wzN	\N	58
59	\N	\N	dvZy41bKNvuNorUP	\N	59
60	\N	\N	kJoeDRTri3bvi9AP	\N	60
61	\N	\N	hMu098hpWiKdZXC1	\N	61
62	\N	\N	GJZdc5vbJWFgZVsI	\N	62
63	\N	\N	GHLIelWJfhemQDeA	\N	63
64	\N	\N	hawMMWICNMi2BKzG	\N	64
65	\N	\N	2QVGMObF1R84u4Vx	\N	65
66	\N	\N	ADlGqOwcDf4LZsvW	\N	66
67	\N	\N	9EidwKNgXD72vOmr	\N	67
68	\N	\N	BzC0OcuCMl5kzDq5	\N	68
69	\N	\N	PlND4jiTuR3MuwLZ	\N	69
70	\N	\N	UPgZbPJ9RPlVibVF	\N	70
71	\N	\N	ZyIIEQUgbFXyT2vP	\N	71
72	\N	\N	EzfTyfijSs6kMUxH	\N	72
73	\N	\N	qvxVBTg3p2ploMvO	\N	73
74	\N	\N	TVYHzHq8U7tIQFjv	\N	74
75	\N	\N	3V6WsbspvDBZr9rm	\N	75
76	\N	\N	dV2XVpZ8HU1NbVNP	\N	76
77	\N	\N	wBTl8VddJ96eMCBd	\N	77
78	\N	\N	av1ssoiHnJos1Pw1	\N	78
79	\N	\N	j445nXcI74t3kIvY	\N	79
80	\N	\N	joA8sPJWqlov2Prs	\N	80
81	\N	\N	w0z3sQAm7eATtYCS	\N	81
82	\N	\N	y7l6xaX5CY28rFfM	\N	82
83	\N	\N	K56vEGFhc1Zv06Aw	\N	83
84	\N	\N	nep1ymhxc36HpWd0	\N	84
85	\N	\N	7u2UnecSfNpv53rO	\N	85
86	\N	\N	09pd5UaP1ey1E5UE	\N	86
87	\N	\N	aT6aYjxEQ6xH7owa	\N	87
102	\N	\N	tsrdovjPtw3HCanc	\N	102
103	\N	\N	ufeaxMCmZQBY2z3b	\N	102
152	\N	\N	e9BT3aJmrLBoNVKH	\N	152
153	\N	\N	oo6Uqd1z1C1WZQpv	\N	152
154	\N	\N	f2LjBr2nd5j2O4oK	\N	153
155	\N	\N	FFteNK9Ri9ymt2qW	\N	153
156	\N	\N	PKPch3w2NElQO5Mw	\N	154
157	\N	\N	b4kygEY2VKGqgGOm	\N	154
158	\N	\N	sNSQ2LmLvoabd5Fn	\N	5
159	\N	\N	krWUW7NIwu5VWo4d	\N	6
160	\N	\N	7euTPhFD2JYvC1AO	\N	56
161	\N	\N	eTU0B23vh8uiF3sr	\N	57
162	\N	\N	7cq2e1ePCzCmx1QX	\N	58
163	\N	\N	QAkM4V3c2DXxQiuW	\N	59
164	\N	\N	0zP79TGPz1Afn4oe	\N	154
\.


--
-- Data for Name: hfj_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_resource (res_id, partition_date, partition_id, res_deleted_at, res_version, has_tags, res_published, res_updated, fhir_id, sp_has_links, hash_sha256, sp_index_status, res_language, sp_cmpstr_uniq_present, sp_cmptoks_present, sp_coords_present, sp_date_present, sp_number_present, sp_quantity_nrml_present, sp_quantity_present, sp_string_present, sp_token_present, sp_uri_present, res_type, search_url_present, res_ver) FROM stdin;
1	\N	\N	\N	R4	t	2024-03-29 23:51:02.473	2024-03-29 23:51:02.473	1	f	85b0976c7c22bf0348e72ea5a71140454e6e99566c3e94f9b4d71d93ce439352	1	\N	f	f	f	t	f	f	f	t	t	f	Patient	f	1
2	\N	\N	\N	R4	f	2024-03-29 23:51:10.897	2024-03-29 23:51:10.897	2	f	a0f95c1d93f94cce9995a30dbfd931e29516b6e0c28de90f3d20ba66b7fefd49	1	\N	f	f	f	f	f	f	f	t	t	f	Practitioner	f	1
3	\N	\N	\N	R4	t	2024-03-29 23:51:19.362	2024-03-29 23:51:19.362	3	t	567549cd29131c9fb94835806689051ee2f284efcd096ae7eb58e68648b5ed82	1	\N	f	f	f	f	f	f	f	t	t	f	Encounter	f	1
4	\N	\N	\N	R4	t	2024-03-29 23:51:24.703	2024-03-29 23:51:24.703	4	t	567549cd29131c9fb94835806689051ee2f284efcd096ae7eb58e68648b5ed82	1	\N	f	f	f	f	f	f	f	t	t	f	Encounter	f	1
7	\N	\N	\N	R4	f	2024-03-29 23:51:41.609	2024-03-29 23:51:41.609	7	t	c96016606b1cc188ee3e32e470e0e6440e8b392bd2b5a63bc4d4386ee96cc99d	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
8	\N	\N	\N	R4	f	2024-03-29 23:51:44.748	2024-03-29 23:51:44.748	8	t	d3f695853d9f83f8e871433e41a449ad0767bed791048bec5e040367a55a3418	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
9	\N	\N	\N	R4	f	2024-03-29 23:51:47.861	2024-03-29 23:51:47.861	9	t	a8d448b200bda1195d44b08411a632181a9d8857659a5a82a766351110fbe1f0	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
10	\N	\N	\N	R4	f	2024-03-29 23:51:58.9	2024-03-29 23:51:58.9	10	t	a440048e3c4f2d0a737fd13d6f0f2fb7cc9172ef63a24a22eca12a5c0832c360	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
11	\N	\N	\N	R4	f	2024-03-29 23:52:06.229	2024-03-29 23:52:06.229	11	t	245366ab6d5071fd4a4d36a5f3a1c938c8dc8928bd45f7ed06913635766822a0	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
12	\N	\N	\N	R4	f	2024-03-29 23:52:13.102	2024-03-29 23:52:13.102	12	t	6ccf6be722ad5ce92434da4fa4bc939a7b45f75017fbb12c2a5063ae06f48f21	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
13	\N	\N	\N	R4	f	2024-03-29 23:52:18.104	2024-03-29 23:52:18.104	13	t	5769221fd91c1967e5ffa699784e6bc8aa7ad955f7684cabaa0582e6106da1fe	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
14	\N	\N	\N	R4	f	2024-03-29 23:52:30.942	2024-03-29 23:52:30.942	14	t	d0f1a313ee3d733d7b0025c90f4c14ce31983b6f1f0673bd81f69a35d4ccfa51	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
15	\N	\N	\N	R4	f	2024-03-29 23:52:36.874	2024-03-29 23:52:36.874	15	t	a46836fdb4bcb3e30e50abdc6cf0876d0a5227bcc001b77e1fed8bc7dcf0fa3d	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
16	\N	\N	\N	R4	f	2024-03-29 23:52:41.933	2024-03-29 23:52:41.933	16	t	2ff2d5469819ebd6221c3bc8d68b46e9e5fcc65a35399ca9ac4a17dced157b42	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
17	\N	\N	\N	R4	f	2024-03-29 23:52:45.811	2024-03-29 23:52:45.811	17	t	c58a71c50021c03696f5ce763baf45f6fd78ef4fcbbb451c435e92e27f5835f9	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
18	\N	\N	\N	R4	f	2024-03-29 23:52:50.645	2024-03-29 23:52:50.645	18	t	1c8a5ac28637229f1ec3e19714f42c593f6618d5efe46fe2038e8ac43292a0e4	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
19	\N	\N	\N	R4	f	2024-03-29 23:53:08.206	2024-03-29 23:53:08.206	19	t	79c12a4a181f347d73e998144450a166a39bcf692e64e98082aade42d02e20c0	1	\N	f	f	f	t	f	f	f	t	t	f	DiagnosticReport	f	1
20	\N	\N	\N	R4	f	2024-03-29 23:53:37.276	2024-03-29 23:53:37.276	20	t	503ac5c9d4d9b89b781595a62b1329488f42ba8c4f257320abe1e6752b14331e	1	\N	f	f	f	t	f	f	f	t	t	f	DiagnosticReport	f	1
52	\N	\N	\N	R4	t	2024-03-30 04:26:05.517	2024-03-30 04:26:05.517	52	t	567549cd29131c9fb94835806689051ee2f284efcd096ae7eb58e68648b5ed82	1	\N	f	f	f	f	f	f	f	t	t	f	Encounter	f	1
53	\N	\N	\N	R4	t	2024-03-30 04:26:09.137	2024-03-30 04:26:09.137	53	t	567549cd29131c9fb94835806689051ee2f284efcd096ae7eb58e68648b5ed82	1	\N	f	f	f	f	f	f	f	t	t	f	Encounter	f	1
54	\N	\N	\N	R4	t	2024-03-30 04:26:12.997	2024-03-30 04:26:12.997	54	t	567549cd29131c9fb94835806689051ee2f284efcd096ae7eb58e68648b5ed82	1	\N	f	f	f	f	f	f	f	t	t	f	Encounter	f	1
55	\N	\N	\N	R4	t	2024-03-30 04:26:15.97	2024-03-30 04:26:15.97	55	t	567549cd29131c9fb94835806689051ee2f284efcd096ae7eb58e68648b5ed82	1	\N	f	f	f	f	f	f	f	t	t	f	Encounter	f	1
60	\N	\N	\N	R4	f	2024-03-30 04:31:56.282	2024-03-30 04:31:56.282	60	t	17b31a70b9d424531bf56b710633b115abbba23fdaf00887c680ca87ce6b6d82	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
61	\N	\N	\N	R4	f	2024-03-30 04:33:07.05	2024-03-30 04:33:07.05	61	t	b07d31921317815019dd1b5f86f33fe50d7c45abe120850ce8af246f9880c587	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
62	\N	\N	\N	R4	f	2024-03-30 04:33:53.184	2024-03-30 04:33:53.184	62	t	4f04a4b5ed3412644f83cf8ece4e65650d34d982746ebb9f30244aadf8a01441	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
63	\N	\N	\N	R4	f	2024-03-30 04:34:37.247	2024-03-30 04:34:37.247	63	t	dd8276395b9fd45a009a7fdc5f5187d14dd0684ec0044cc85b3582c7f8c64b93	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
64	\N	\N	\N	R4	f	2024-03-30 04:36:58.287	2024-03-30 04:36:58.287	64	t	d26e789070be37ae11fc3d2efa68ec345ff02a34158144099ea4036bf0af4d8b	1	\N	f	f	f	t	f	f	f	t	t	f	DiagnosticReport	f	1
65	\N	\N	\N	R4	f	2024-03-30 04:38:52.576	2024-03-30 04:38:52.576	65	t	17b31a70b9d424531bf56b710633b115abbba23fdaf00887c680ca87ce6b6d82	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
66	\N	\N	\N	R4	f	2024-03-30 04:39:45.262	2024-03-30 04:39:45.262	66	t	b07d31921317815019dd1b5f86f33fe50d7c45abe120850ce8af246f9880c587	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
67	\N	\N	\N	R4	f	2024-03-30 04:40:32.538	2024-03-30 04:40:32.538	67	t	4f04a4b5ed3412644f83cf8ece4e65650d34d982746ebb9f30244aadf8a01441	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
68	\N	\N	\N	R4	f	2024-03-30 04:41:13.966	2024-03-30 04:41:13.966	68	t	dd8276395b9fd45a009a7fdc5f5187d14dd0684ec0044cc85b3582c7f8c64b93	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
69	\N	\N	\N	R4	f	2024-03-30 04:43:14.94	2024-03-30 04:43:14.94	69	t	1536d65471f473b87060202d0036df3dc63145d22dc3b004653789333c760c34	1	\N	f	f	f	t	f	f	f	t	t	f	DiagnosticReport	f	1
70	\N	\N	\N	R4	f	2024-03-30 04:44:53.418	2024-03-30 04:44:53.418	70	t	a7f50d43276b42641060108f66569cacfa67a2d28677226453eff0fac582d08f	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
71	\N	\N	\N	R4	f	2024-03-30 04:45:48.146	2024-03-30 04:45:48.146	71	t	bff38fa516b2a033b37387e71e285c837742ab917c271ac65d2b064fc8da80e8	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
72	\N	\N	\N	R4	f	2024-03-30 04:46:26.864	2024-03-30 04:46:26.864	72	t	c1699aec694e20bb4ff35fdc55a51e09a51753228f6aa880a98f3d90a1e3510c	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
73	\N	\N	\N	R4	f	2024-03-30 04:47:11.586	2024-03-30 04:47:11.586	73	t	07fb9a4323085887c59b29d704f08bcfa2226a77ef05dd476b7b9db70dd32667	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
74	\N	\N	\N	R4	f	2024-03-30 04:47:58.496	2024-03-30 04:47:58.496	74	t	7f328a5c2ee67c575d964b99e1e3569a71412b0753ac3ace7da2789a2ca22d0c	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
75	\N	\N	\N	R4	f	2024-03-30 04:48:37.308	2024-03-30 04:48:37.308	75	t	94c3bb445b8c8d92c1cc3d58d5241abd9baa565f0bd443a16735520f8dfa29bd	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
6	\N	\N	\N	R4	f	2024-03-29 23:51:34.845	2024-03-30 18:07:36.645	6	t	06c3de5a56b3e5c078470af4502b9d322b6a07e43e33d672c63b4e49dd1db773	1	\N	f	f	f	t	f	f	f	t	t	f	ServiceRequest	f	2
56	\N	\N	\N	R4	f	2024-03-30 04:26:35.106	2024-03-30 18:08:24.163	56	t	e7f7c14b0fee82023d652272b2e58b595c992dbef6705e65779abb8b16980b62	1	\N	f	f	f	t	f	f	f	t	t	f	ServiceRequest	f	2
57	\N	\N	\N	R4	f	2024-03-30 04:27:28.171	2024-03-30 18:09:06.624	57	t	2294551db7b4161d46500657d30c1701f4be60c5026ace4efeb143acbb88b6f2	1	\N	f	f	f	t	f	f	f	t	t	f	ServiceRequest	f	2
58	\N	\N	\N	R4	f	2024-03-30 04:29:25.948	2024-03-30 18:09:53.003	58	t	9a48bbe05de47facba7f93e878e8ccfd16ca24798acaece7d9e480764332f1b6	1	\N	f	f	f	t	f	f	f	t	t	f	ServiceRequest	f	2
59	\N	\N	\N	R4	f	2024-03-30 04:29:42.34	2024-03-30 18:21:32.889	59	t	e864ae2c04df297573479d269d1e08816204fc6e9d9299dde160bbc7b490ed71	1	\N	f	f	f	t	f	f	f	t	t	f	ServiceRequest	f	2
76	\N	\N	\N	R4	f	2024-03-30 04:49:29.535	2024-03-30 04:49:29.535	76	t	830a10f8cd11f4d0aaddf2251c27e90bb962ffb8406a31d41ee9beca8f4d6637	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
77	\N	\N	\N	R4	f	2024-03-30 04:50:10.779	2024-03-30 04:50:10.779	77	t	c6cfd8ffd4b626804d77a187cf21f55a969de693d605bc4ef82e148ae14711ba	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
78	\N	\N	\N	R4	f	2024-03-30 04:52:21.763	2024-03-30 04:52:21.763	78	t	ab6753278179b05126effb9cf068287c4a153c43faa6740734b5dff64605bf40	1	\N	f	f	f	t	f	f	f	t	t	f	DiagnosticReport	f	1
79	\N	\N	\N	R4	f	2024-03-30 04:53:53.703	2024-03-30 04:53:53.703	79	t	db1b2ca7dee74d2eec4e2d501008e0df699db1a01532c0857ad0d247d45d2c1b	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
80	\N	\N	\N	R4	f	2024-03-30 04:54:42.536	2024-03-30 04:54:42.536	80	t	ffad239eaa39d792f635fe033dce5cb2736dccef83d6c149a1c706d67b6cad26	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
81	\N	\N	\N	R4	f	2024-03-30 04:55:23.364	2024-03-30 04:55:23.364	81	t	93d85e36582be1ba04a7db09a60784cfe33f2353bba21c53300ba33b06956147	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
82	\N	\N	\N	R4	f	2024-03-30 04:56:04.597	2024-03-30 04:56:04.597	82	t	12d9590a837a8be003088823f3ea6ab3f47221a420c531014ab5a4b2f75bcdf6	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
83	\N	\N	\N	R4	f	2024-03-30 04:56:47.414	2024-03-30 04:56:47.414	83	t	23f5899ec1d185184a8a87c9229aacba74b07814db3a35e7580850c3eeed2d6b	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
84	\N	\N	\N	R4	f	2024-03-30 04:57:28.702	2024-03-30 04:57:28.702	84	t	0d6e8af343747cfa8b22080b7a53cf2a6f156fce23485760cd7126fc37c12b8c	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
85	\N	\N	\N	R4	f	2024-03-30 04:58:13.109	2024-03-30 04:58:13.109	85	t	f145ca1abb6e46e9d2cb311a735ae572e75e3505fe1f74cab79331ff81054d80	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
86	\N	\N	\N	R4	f	2024-03-30 04:58:53.964	2024-03-30 04:58:53.964	86	t	d69ae22f83eed0de77094c4459e87c20a0253d47bd579c7855bc8dce2e55a1b2	1	\N	f	f	f	t	f	f	t	t	t	f	Observation	f	1
87	\N	\N	\N	R4	f	2024-03-30 05:00:46.183	2024-03-30 05:00:46.183	87	t	c536212b3c8ba8e49e79e6e1fa78f627759319eafaffde2a26b1043eb6bc980a	1	\N	f	f	f	t	f	f	f	t	t	f	DiagnosticReport	f	1
102	\N	\N	2024-03-30 05:35:30.333	R4	t	2024-03-30 05:34:48.236	2024-03-30 05:35:30.333	102	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	Patient	f	2
152	\N	\N	2024-03-30 17:59:30.221	R4	f	2024-03-30 17:58:42.089	2024-03-30 17:59:30.221	152	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	ServiceRequest	f	2
153	\N	\N	2024-03-30 18:02:04.168	R4	f	2024-03-30 18:01:06.793	2024-03-30 18:02:04.168	153	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	ServiceRequest	f	2
5	\N	\N	\N	R4	f	2024-03-29 23:51:30.453	2024-03-30 18:06:44.473	5	t	0482b12bc0351958c371d5214af5405ee98b687a7bff75012ef272f4ea2d2cbb	1	\N	f	f	f	t	f	f	f	t	t	f	ServiceRequest	f	2
154	\N	\N	2024-03-30 18:22:47.033	R4	f	2024-03-30 18:03:47.217	2024-03-30 18:22:47.033	154	f	\N	1	\N	f	f	f	f	f	f	f	f	f	f	ServiceRequest	f	3
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
154	2024-03-30 17:49:29.875	f	\N	\N	\N	\N	\N	0	6	20	\N	ServiceRequest	\N	33592	223007692	1	FINISHED	6	bf1c144d-b805-4eab-9aee-2254e1cbcb89	1
155	2024-03-30 18:11:31.965	f	\N	\N	\N	\N	\N	0	7	20	\N	ServiceRequest	\N	33593	223007692	1	FINISHED	7	6c0c4cde-5177-4931-9c71-57922098b3d3	1
156	2024-03-30 18:23:05.315	f	\N	\N	\N	\N	\N	0	6	20	\N	ServiceRequest	\N	33594	223007692	1	FINISHED	6	dfded6af-8c8a-40b3-a5d3-f7496bcdc587	1
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
164	0	5	154
165	1	6	154
166	2	56	154
167	3	57	154
168	4	58	154
169	5	59	154
170	0	59	155
171	1	6	155
172	2	56	155
173	3	57	155
174	4	58	155
175	5	154	155
176	6	5	155
177	0	6	156
178	1	56	156
179	2	57	156
180	3	58	156
181	4	59	156
182	5	5	156
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
1	\N	\N	f	birthdate	1	Patient	2024-03-29 23:51:02.473	5247847184787287691	1951-01-02 23:59:59.999	19510102	1951-01-02 00:00:00	19510102
2	\N	\N	f	authored	5	ServiceRequest	2024-03-29 23:51:30.453	-5308877520493424965	2023-11-24 10:30:00	20231124	2023-11-24 10:30:00	20231124
3	\N	\N	f	occurrence	5	ServiceRequest	2024-03-29 23:51:30.453	7919372641922860549	2023-11-30 23:59:59.999	20231130	2023-11-30 00:00:00	20231130
4	\N	\N	f	occurrence	6	ServiceRequest	2024-03-29 23:51:34.845	7919372641922860549	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
5	\N	\N	f	authored	6	ServiceRequest	2024-03-29 23:51:34.845	-5308877520493424965	2024-01-02 10:30:00	20240102	2024-01-02 10:30:00	20240102
6	\N	\N	f	date	7	Observation	2024-03-29 23:51:41.609	123682819940570799	2023-11-30 23:59:59.999	20231130	2023-11-30 00:00:00	20231130
7	\N	\N	f	date	8	Observation	2024-03-29 23:51:44.748	123682819940570799	2023-11-30 23:59:59.999	20231130	2023-11-30 00:00:00	20231130
8	\N	\N	f	date	9	Observation	2024-03-29 23:51:47.861	123682819940570799	2023-11-30 23:59:59.999	20231130	2023-11-30 00:00:00	20231130
9	\N	\N	f	date	10	Observation	2024-03-29 23:51:58.9	123682819940570799	2023-11-30 23:59:59.999	20231130	2023-11-30 00:00:00	20231130
10	\N	\N	f	date	11	Observation	2024-03-29 23:52:06.229	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
11	\N	\N	f	date	12	Observation	2024-03-29 23:52:13.102	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
12	\N	\N	f	date	13	Observation	2024-03-29 23:52:18.104	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
13	\N	\N	f	date	14	Observation	2024-03-29 23:52:30.942	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
14	\N	\N	f	date	15	Observation	2024-03-29 23:52:36.874	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
15	\N	\N	f	date	16	Observation	2024-03-29 23:52:41.933	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
16	\N	\N	f	date	17	Observation	2024-03-29 23:52:45.811	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
17	\N	\N	f	date	18	Observation	2024-03-29 23:52:50.645	123682819940570799	2024-01-09 23:59:59.999	20240109	2024-01-09 00:00:00	20240109
18	\N	\N	f	issued	19	DiagnosticReport	2024-03-29 23:53:08.206	-1049879100077826548	2023-11-30 12:30:00	20231130	2023-11-30 12:30:00	20231130
19	\N	\N	f	date	19	DiagnosticReport	2024-03-29 23:53:08.206	-2826489077040426915	2023-11-29 21:30:00	20231130	2023-11-29 21:30:00	20231130
20	\N	\N	f	date	20	DiagnosticReport	2024-03-29 23:53:37.276	-2826489077040426915	2024-01-08 21:30:00	20240109	2024-01-08 21:30:00	20240109
21	\N	\N	f	issued	20	DiagnosticReport	2024-03-29 23:53:37.276	-1049879100077826548	2024-11-09 12:30:00	20241109	2024-11-09 12:30:00	20241109
52	\N	\N	f	authored	56	ServiceRequest	2024-03-30 04:26:35.106	-5308877520493424965	2023-05-20 10:30:00	20230520	2023-05-20 10:30:00	20230520
53	\N	\N	f	occurrence	56	ServiceRequest	2024-03-30 04:26:35.106	7919372641922860549	2023-05-20 23:59:59.999	20230520	2023-05-20 00:00:00	20230520
54	\N	\N	f	occurrence	57	ServiceRequest	2024-03-30 04:27:28.171	7919372641922860549	2022-11-21 23:59:59.999	20221121	2022-11-21 00:00:00	20221121
55	\N	\N	f	authored	57	ServiceRequest	2024-03-30 04:27:28.171	-5308877520493424965	2022-11-21 10:30:00	20221121	2022-11-21 10:30:00	20221121
56	\N	\N	f	occurrence	58	ServiceRequest	2024-03-30 04:29:25.948	7919372641922860549	2023-08-01 23:59:59.999	20230801	2023-08-01 00:00:00	20230801
57	\N	\N	f	authored	58	ServiceRequest	2024-03-30 04:29:25.948	-5308877520493424965	2023-08-01 10:30:00	20230801	2023-08-01 10:30:00	20230801
58	\N	\N	f	authored	59	ServiceRequest	2024-03-30 04:29:42.34	-5308877520493424965	2023-01-10 10:30:00	20230110	2023-01-10 10:30:00	20230110
59	\N	\N	f	occurrence	59	ServiceRequest	2024-03-30 04:29:42.34	7919372641922860549	2023-01-10 23:59:59.999	20230110	2023-01-10 00:00:00	20230110
60	\N	\N	f	date	60	Observation	2024-03-30 04:31:56.282	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
61	\N	\N	f	date	61	Observation	2024-03-30 04:33:07.05	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
62	\N	\N	f	date	62	Observation	2024-03-30 04:33:53.184	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
63	\N	\N	f	date	63	Observation	2024-03-30 04:34:37.247	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
64	\N	\N	f	date	64	DiagnosticReport	2024-03-30 04:36:58.287	-2826489077040426915	2023-05-26 21:30:00	20230527	2023-05-26 21:30:00	20230527
65	\N	\N	f	issued	64	DiagnosticReport	2024-03-30 04:36:58.287	-1049879100077826548	2023-05-27 12:30:00	20230527	2023-05-27 12:30:00	20230527
66	\N	\N	f	date	65	Observation	2024-03-30 04:38:52.576	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
67	\N	\N	f	date	66	Observation	2024-03-30 04:39:45.262	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
68	\N	\N	f	date	67	Observation	2024-03-30 04:40:32.538	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
69	\N	\N	f	date	68	Observation	2024-03-30 04:41:13.966	123682819940570799	2023-05-27 23:59:59.999	20230527	2023-05-27 00:00:00	20230527
70	\N	\N	f	issued	69	DiagnosticReport	2024-03-30 04:43:14.94	-1049879100077826548	2022-11-28 12:30:00	20221128	2022-11-28 12:30:00	20221128
71	\N	\N	f	date	69	DiagnosticReport	2024-03-30 04:43:14.94	-2826489077040426915	2022-11-27 21:30:00	20221128	2022-11-27 21:30:00	20221128
72	\N	\N	f	date	70	Observation	2024-03-30 04:44:53.418	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
73	\N	\N	f	date	71	Observation	2024-03-30 04:45:48.146	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
74	\N	\N	f	date	72	Observation	2024-03-30 04:46:26.864	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
75	\N	\N	f	date	73	Observation	2024-03-30 04:47:11.586	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
76	\N	\N	f	date	74	Observation	2024-03-30 04:47:58.496	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
77	\N	\N	f	date	75	Observation	2024-03-30 04:48:37.308	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
78	\N	\N	f	date	76	Observation	2024-03-30 04:49:29.535	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
79	\N	\N	f	date	77	Observation	2024-03-30 04:50:10.779	123682819940570799	2023-08-08 23:59:59.999	20230808	2023-08-08 00:00:00	20230808
80	\N	\N	f	issued	78	DiagnosticReport	2024-03-30 04:52:21.763	-1049879100077826548	2023-08-08 12:30:00	20230808	2023-08-08 12:30:00	20230808
81	\N	\N	f	date	78	DiagnosticReport	2024-03-30 04:52:21.763	-2826489077040426915	2023-08-07 21:30:00	20230808	2023-08-07 21:30:00	20230808
82	\N	\N	f	date	79	Observation	2024-03-30 04:53:53.703	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
83	\N	\N	f	date	80	Observation	2024-03-30 04:54:42.536	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
84	\N	\N	f	date	81	Observation	2024-03-30 04:55:23.364	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
85	\N	\N	f	date	82	Observation	2024-03-30 04:56:04.597	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
86	\N	\N	f	date	83	Observation	2024-03-30 04:56:47.414	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
87	\N	\N	f	date	84	Observation	2024-03-30 04:57:28.702	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
88	\N	\N	f	date	85	Observation	2024-03-30 04:58:13.109	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
89	\N	\N	f	date	86	Observation	2024-03-30 04:58:53.964	123682819940570799	2023-01-17 23:59:59.999	20230117	2023-01-17 00:00:00	20230117
90	\N	\N	f	issued	87	DiagnosticReport	2024-03-30 05:00:46.183	-1049879100077826548	2023-01-17 12:30:00	20230117	2023-01-17 12:30:00	20230117
91	\N	\N	f	date	87	DiagnosticReport	2024-03-30 05:00:46.183	-2826489077040426915	2023-01-16 21:30:00	20230117	2023-01-16 21:30:00	20230117
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
1	\N	\N	f	value-quantity	7	Observation	2024-03-29 23:51:41.609	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	4.7
2	\N	\N	f	combo-value-quantity	7	Observation	2024-03-29 23:51:41.609	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	4.7
3	\N	\N	f	value-quantity	8	Observation	2024-03-29 23:51:44.748	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	1
4	\N	\N	f	combo-value-quantity	8	Observation	2024-03-29 23:51:44.748	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	1
5	\N	\N	f	value-quantity	9	Observation	2024-03-29 23:51:47.861	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	2.8
6	\N	\N	f	combo-value-quantity	9	Observation	2024-03-29 23:51:47.861	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	2.8
7	\N	\N	f	value-quantity	10	Observation	2024-03-29 23:51:58.9	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	2.9
8	\N	\N	f	combo-value-quantity	10	Observation	2024-03-29 23:51:58.9	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	2.9
9	\N	\N	f	value-quantity	11	Observation	2024-03-29 23:52:06.229	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	140
10	\N	\N	f	combo-value-quantity	11	Observation	2024-03-29 23:52:06.229	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	140
11	\N	\N	f	value-quantity	12	Observation	2024-03-29 23:52:13.102	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	6
12	\N	\N	f	combo-value-quantity	12	Observation	2024-03-29 23:52:13.102	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	6
13	\N	\N	f	value-quantity	13	Observation	2024-03-29 23:52:18.104	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	99
14	\N	\N	f	combo-value-quantity	13	Observation	2024-03-29 23:52:18.104	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	99
15	\N	\N	f	value-quantity	14	Observation	2024-03-29 23:52:30.942	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	24
16	\N	\N	f	combo-value-quantity	14	Observation	2024-03-29 23:52:30.942	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	24
17	\N	\N	f	combo-value-quantity	15	Observation	2024-03-29 23:52:36.874	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	20
18	\N	\N	f	value-quantity	15	Observation	2024-03-29 23:52:36.874	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	20
19	\N	\N	f	combo-value-quantity	16	Observation	2024-03-29 23:52:41.933	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	1.4
20	\N	\N	f	value-quantity	16	Observation	2024-03-29 23:52:41.933	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	1.4
21	\N	\N	f	combo-value-quantity	17	Observation	2024-03-29 23:52:45.811	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	9.2
22	\N	\N	f	value-quantity	17	Observation	2024-03-29 23:52:45.811	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	9.2
23	\N	\N	f	value-quantity	18	Observation	2024-03-29 23:52:50.645	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	4.3
24	\N	\N	f	combo-value-quantity	18	Observation	2024-03-29 23:52:50.645	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	4.3
52	\N	\N	f	value-quantity	60	Observation	2024-03-30 04:31:56.282	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	4.3
53	\N	\N	f	combo-value-quantity	60	Observation	2024-03-30 04:31:56.282	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	4.3
54	\N	\N	f	value-quantity	61	Observation	2024-03-30 04:33:07.05	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	1.3
55	\N	\N	f	combo-value-quantity	61	Observation	2024-03-30 04:33:07.05	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	1.3
56	\N	\N	f	value-quantity	62	Observation	2024-03-30 04:33:53.184	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	3.2
57	\N	\N	f	combo-value-quantity	62	Observation	2024-03-30 04:33:53.184	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	3.2
58	\N	\N	f	value-quantity	63	Observation	2024-03-30 04:34:37.247	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	3.1
59	\N	\N	f	combo-value-quantity	63	Observation	2024-03-30 04:34:37.247	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	3.1
60	\N	\N	f	value-quantity	65	Observation	2024-03-30 04:38:52.576	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	4.3
61	\N	\N	f	combo-value-quantity	65	Observation	2024-03-30 04:38:52.576	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	4.3
62	\N	\N	f	value-quantity	66	Observation	2024-03-30 04:39:45.262	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	1.3
63	\N	\N	f	combo-value-quantity	66	Observation	2024-03-30 04:39:45.262	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	1.3
64	\N	\N	f	value-quantity	67	Observation	2024-03-30 04:40:32.538	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	3.2
65	\N	\N	f	combo-value-quantity	67	Observation	2024-03-30 04:40:32.538	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	3.2
66	\N	\N	f	value-quantity	68	Observation	2024-03-30 04:41:13.966	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	3.1
67	\N	\N	f	combo-value-quantity	68	Observation	2024-03-30 04:41:13.966	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	3.1
68	\N	\N	f	value-quantity	70	Observation	2024-03-30 04:44:53.418	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	144
69	\N	\N	f	combo-value-quantity	70	Observation	2024-03-30 04:44:53.418	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	144
70	\N	\N	f	value-quantity	71	Observation	2024-03-30 04:45:48.146	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	6.2
71	\N	\N	f	combo-value-quantity	71	Observation	2024-03-30 04:45:48.146	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	6.2
72	\N	\N	f	value-quantity	72	Observation	2024-03-30 04:46:26.864	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	101
73	\N	\N	f	combo-value-quantity	72	Observation	2024-03-30 04:46:26.864	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	101
74	\N	\N	f	value-quantity	73	Observation	2024-03-30 04:47:11.586	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	25
75	\N	\N	f	combo-value-quantity	73	Observation	2024-03-30 04:47:11.586	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	25
76	\N	\N	f	combo-value-quantity	74	Observation	2024-03-30 04:47:58.496	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	16
77	\N	\N	f	value-quantity	74	Observation	2024-03-30 04:47:58.496	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	16
78	\N	\N	f	combo-value-quantity	75	Observation	2024-03-30 04:48:37.308	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	1.2
79	\N	\N	f	value-quantity	75	Observation	2024-03-30 04:48:37.308	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	1.2
80	\N	\N	f	combo-value-quantity	76	Observation	2024-03-30 04:49:29.535	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	9.1
81	\N	\N	f	value-quantity	76	Observation	2024-03-30 04:49:29.535	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	9.1
82	\N	\N	f	value-quantity	77	Observation	2024-03-30 04:50:10.779	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	5.2
83	\N	\N	f	combo-value-quantity	77	Observation	2024-03-30 04:50:10.779	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	5.2
84	\N	\N	f	value-quantity	79	Observation	2024-03-30 04:53:53.703	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	143
85	\N	\N	f	combo-value-quantity	79	Observation	2024-03-30 04:53:53.703	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	143
86	\N	\N	f	value-quantity	80	Observation	2024-03-30 04:54:42.536	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	4.8
87	\N	\N	f	combo-value-quantity	80	Observation	2024-03-30 04:54:42.536	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	4.8
88	\N	\N	f	value-quantity	81	Observation	2024-03-30 04:55:23.364	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	103
89	\N	\N	f	combo-value-quantity	81	Observation	2024-03-30 04:55:23.364	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	103
90	\N	\N	f	value-quantity	82	Observation	2024-03-30 04:56:04.597	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	24
91	\N	\N	f	combo-value-quantity	82	Observation	2024-03-30 04:56:04.597	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	24
92	\N	\N	f	combo-value-quantity	83	Observation	2024-03-30 04:56:47.414	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	14
93	\N	\N	f	value-quantity	83	Observation	2024-03-30 04:56:47.414	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	14
94	\N	\N	f	combo-value-quantity	84	Observation	2024-03-30 04:57:28.702	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	1.3
95	\N	\N	f	value-quantity	84	Observation	2024-03-30 04:57:28.702	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	1.3
96	\N	\N	f	combo-value-quantity	85	Observation	2024-03-30 04:58:13.109	7236300805658457870	-4216928325095969408	-6435849753451015076	http://unitsofmeasure.org	mg/dL	9
97	\N	\N	f	value-quantity	85	Observation	2024-03-30 04:58:13.109	-1901136387361512731	-8259379513893590421	1128613043918174232	http://unitsofmeasure.org	mg/dL	9
98	\N	\N	f	value-quantity	86	Observation	2024-03-30 04:58:53.964	-1901136387361512731	-8959505232117466855	-3571105859576330486	http://unitsofmeasure.org	mmol/L	6.1
99	\N	\N	f	combo-value-quantity	86	Observation	2024-03-30 04:58:53.964	7236300805658457870	-3935885776705262278	7508899509870610812	http://unitsofmeasure.org	mmol/L	6.1
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
1	\N	\N	f	name	1	Patient	2024-03-29 23:51:02.473	2374967257783229968	-1575415002568401616	-1463252090913723117	Yun	YUN
2	\N	\N	f	phonetic	1	Patient	2024-03-29 23:51:02.473	4748149162531866042	7732772475369838403	8317716575692629438	Ma	MA
3	\N	\N	f	address	1	Patient	2024-03-29 23:51:02.473	-3245261296918131802	-9161155455489687346	6193891337602857657	K4A0K6	K4A0K6
4	\N	\N	f	address-city	1	Patient	2024-03-29 23:51:02.473	3728378764232781438	4606538046458125917	-2007342453513273382	Waterloo	WATERLOO
5	\N	\N	f	family	1	Patient	2024-03-29 23:51:02.473	6230551898613947727	-9208284524139093953	8785853102554743158	Ma	MA
6	\N	\N	f	address-postalcode	1	Patient	2024-03-29 23:51:02.473	6441953884142218794	1142610086203790987	6783823457865320082	K4A0K6	K4A0K6
7	\N	\N	f	address	1	Patient	2024-03-29 23:51:02.473	1895554620606153389	-9161155455489687346	6193891337602857657	Waterloo	WATERLOO
8	\N	\N	f	language	1	Patient	2024-03-29 23:51:02.473	4995740588116258854	-6338030716006204643	8668447586533091895	English	ENGLISH
9	\N	\N	f	address	1	Patient	2024-03-29 23:51:02.473	3948778197267779573	-9161155455489687346	6193891337602857657	HomeAd HomeAddress.stName 2	HOMEAD HOMEADDRESS.STNAME 2
10	\N	\N	f	name	1	Patient	2024-03-29 23:51:02.473	-4898293605585357492	-1575415002568401616	-1463252090913723117	Ma	MA
11	\N	\N	f	given	1	Patient	2024-03-29 23:51:02.473	-8765631125341099714	-7533943853970611242	2239503174397326353	Yun	YUN
12	\N	\N	f	phonetic	1	Patient	2024-03-29 23:51:02.473	2172835642610956947	7732772475369838403	8317716575692629438	Yun	YUN
13	\N	\N	f	address	1	Patient	2024-03-29 23:51:02.473	-6949423222572959759	-9161155455489687346	6193891337602857657	ON	ON
14	\N	\N	f	address-country	1	Patient	2024-03-29 23:51:02.473	-6483138198484899228	8394007005180337668	4199164108628295473	CAN	CAN
15	\N	\N	f	address	1	Patient	2024-03-29 23:51:02.473	3220726170287243136	-9161155455489687346	6193891337602857657	CAN	CAN
16	\N	\N	f	address-state	1	Patient	2024-03-29 23:51:02.473	-8058086075220455848	6163711124349647528	-6233579723713934864	ON	ON
17	\N	\N	f	address	2	Practitioner	2024-03-29 23:51:10.897	5088189988039362551	2929207385677660662	3999206484153535711	M1M M2M	M1M M2M
18	\N	\N	f	name	2	Practitioner	2024-03-29 23:51:10.897	6541000931134721232	-7931873357669484274	-2009386940445156674	DR	DR
19	\N	\N	f	address	2	Practitioner	2024-03-29 23:51:10.897	2258612827530553612	2929207385677660662	3999206484153535711	13 ABC St	13 ABC ST
20	\N	\N	f	phonetic	2	Practitioner	2024-03-29 23:51:10.897	-3874971595135932254	-4837052605276332642	7416436656645620527	Anne	ANNE
21	\N	\N	f	address	2	Practitioner	2024-03-29 23:51:10.897	-7615607486372340047	2929207385677660662	3999206484153535711	Canada	CANADA
22	\N	\N	f	address	2	Practitioner	2024-03-29 23:51:10.897	4870796199017684646	2929207385677660662	3999206484153535711	Toronto	TORONTO
23	\N	\N	f	address-city	2	Practitioner	2024-03-29 23:51:10.897	-225652271291605807	626061985208954997	-4645899191247418827	Toronto	TORONTO
24	\N	\N	f	given	2	Practitioner	2024-03-29 23:51:10.897	6619547016488946566	-8858620394209886201	-3353312479235310071	Anne	ANNE
25	\N	\N	f	phonetic	2	Practitioner	2024-03-29 23:51:10.897	-8031154669094287646	-4837052605276332642	7416436656645620527	DR	DR
26	\N	\N	f	address-state	2	Practitioner	2024-03-29 23:51:10.897	-1626720293709640235	7452608035177761588	-1395272960991710404	ON	ON
27	\N	\N	f	address-postalcode	2	Practitioner	2024-03-29 23:51:10.897	-702613348428213182	4997617732140239277	-631157017320490383	M1M M2M	M1M M2M
28	\N	\N	f	family	2	Practitioner	2024-03-29 23:51:10.897	-3740313168769139225	4400083668656880465	5600118371937366559	Smith	SMITH
29	\N	\N	f	name	2	Practitioner	2024-03-29 23:51:10.897	6962999059796848649	-7931873357669484274	-2009386940445156674	Anne	ANNE
30	\N	\N	f	address	2	Practitioner	2024-03-29 23:51:10.897	-4377539014928371722	2929207385677660662	3999206484153535711	ON	ON
31	\N	\N	f	address-country	2	Practitioner	2024-03-29 23:51:10.897	2769050513369209078	-5225733123797295152	-5337184754610788876	Canada	CANADA
32	\N	\N	f	name	2	Practitioner	2024-03-29 23:51:10.897	2480330241925548917	-7931873357669484274	-2009386940445156674	Smith	SMITH
33	\N	\N	f	phonetic	2	Practitioner	2024-03-29 23:51:10.897	3472477119466695077	-4837052605276332642	7416436656645620527	Smith	SMITH
34	\N	\N	f	participant-type	3	Encounter	2024-03-29 23:51:19.362	2337568344886830956	-5371663801521722987	-7359323698783872344	Attender	ATTENDER
35	\N	\N	f	participant-type	4	Encounter	2024-03-29 23:51:24.703	2337568344886830956	-5371663801521722987	-7359323698783872344	Attender	ATTENDER
36	\N	\N	f	combo-code	7	Observation	2024-03-29 23:51:41.609	-8581746947556588906	-1575406001252496924	3219723693549490985	Cholesterol [Mass/volume] in Serum or Plasma	CHOLESTEROL [MASS/VOLUME] IN SERUM OR PLASMA
37	\N	\N	f	code	7	Observation	2024-03-29 23:51:41.609	-547295962750014032	2255293283549704696	7952934451955757422	Cholesterol Total	CHOLESTEROL TOTAL
38	\N	\N	f	combo-code	7	Observation	2024-03-29 23:51:41.609	9061215102015415096	-1575406001252496924	3219723693549490985	Cholesterol Total	CHOLESTEROL TOTAL
39	\N	\N	f	code	7	Observation	2024-03-29 23:51:41.609	7246441234054466946	2255293283549704696	7952934451955757422	Cholesterol [Mass/volume] in Serum or Plasma	CHOLESTEROL [MASS/VOLUME] IN SERUM OR PLASMA
40	\N	\N	f	combo-code	8	Observation	2024-03-29 23:51:44.748	1469296039069425098	-1575406001252496924	3219723693549490985	Triglyceride [Mass/volume] in Serum or Plasma	TRIGLYCERIDE [MASS/VOLUME] IN SERUM OR PLASMA
41	\N	\N	f	code	8	Observation	2024-03-29 23:51:44.748	7088981547590288966	2255293283549704696	7952934451955757422	Triglycerides	TRIGLYCERIDES
42	\N	\N	f	combo-code	8	Observation	2024-03-29 23:51:44.748	3438705216464412745	-1575406001252496924	3219723693549490985	Triglycerides	TRIGLYCERIDES
43	\N	\N	f	code	8	Observation	2024-03-29 23:51:44.748	4335145522709947847	2255293283549704696	7952934451955757422	Triglyceride [Mass/volume] in Serum or Plasma	TRIGLYCERIDE [MASS/VOLUME] IN SERUM OR PLASMA
44	\N	\N	f	combo-code	9	Observation	2024-03-29 23:51:47.861	-5722067262143408521	-1575406001252496924	3219723693549490985	HDL Cholesterol	HDL CHOLESTEROL
45	\N	\N	f	code	9	Observation	2024-03-29 23:51:47.861	-5031882055509686364	2255293283549704696	7952934451955757422	HDL Cholesterol	HDL CHOLESTEROL
46	\N	\N	f	combo-code	9	Observation	2024-03-29 23:51:47.861	8282020099403792385	-1575406001252496924	3219723693549490985	Cholesterol in HDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN HDL [MASS/VOLUME] IN SERUM OR PLASMA
47	\N	\N	f	code	9	Observation	2024-03-29 23:51:47.861	-2352442194959281521	2255293283549704696	7952934451955757422	Cholesterol in HDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN HDL [MASS/VOLUME] IN SERUM OR PLASMA
48	\N	\N	f	code	10	Observation	2024-03-29 23:51:58.9	-815990996031721104	2255293283549704696	7952934451955757422	LDL Cholesterol	LDL CHOLESTEROL
49	\N	\N	f	code	10	Observation	2024-03-29 23:51:58.9	-1746526924469582058	2255293283549704696	7952934451955757422	Cholesterol in LDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN LDL [MASS/VOLUME] IN SERUM OR PLASMA
50	\N	\N	f	combo-code	10	Observation	2024-03-29 23:51:58.9	5238336998874521258	-1575406001252496924	3219723693549490985	Cholesterol in LDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN LDL [MASS/VOLUME] IN SERUM OR PLASMA
51	\N	\N	f	combo-code	10	Observation	2024-03-29 23:51:58.9	-3957019558173465338	-1575406001252496924	3219723693549490985	LDL Cholesterol	LDL CHOLESTEROL
52	\N	\N	f	code	11	Observation	2024-03-29 23:52:06.229	8893304149050838504	2255293283549704696	7952934451955757422	Sodium [Moles/volume] in Blood	SODIUM [MOLES/VOLUME] IN BLOOD
53	\N	\N	f	combo-code	11	Observation	2024-03-29 23:52:06.229	-8878196531663186150	-1575406001252496924	3219723693549490985	Sodium [Moles/volume] in Blood	SODIUM [MOLES/VOLUME] IN BLOOD
54	\N	\N	f	code	11	Observation	2024-03-29 23:52:06.229	3006255479008128299	2255293283549704696	7952934451955757422	Sodium	SODIUM
55	\N	\N	f	combo-code	11	Observation	2024-03-29 23:52:06.229	-5463900833747401680	-1575406001252496924	3219723693549490985	Sodium	SODIUM
56	\N	\N	f	combo-code	12	Observation	2024-03-29 23:52:13.102	-5383380684496061498	-1575406001252496924	3219723693549490985	Potassium	POTASSIUM
57	\N	\N	f	code	12	Observation	2024-03-29 23:52:13.102	813046777322615546	2255293283549704696	7952934451955757422	Potassium	POTASSIUM
58	\N	\N	f	code	12	Observation	2024-03-29 23:52:13.102	3134037314694519407	2255293283549704696	7952934451955757422	Potassium [Moles/volume] in Blood	POTASSIUM [MOLES/VOLUME] IN BLOOD
59	\N	\N	f	combo-code	12	Observation	2024-03-29 23:52:13.102	-320242156012432318	-1575406001252496924	3219723693549490985	Potassium [Moles/volume] in Blood	POTASSIUM [MOLES/VOLUME] IN BLOOD
60	\N	\N	f	code	13	Observation	2024-03-29 23:52:18.104	-6392468113108463230	2255293283549704696	7952934451955757422	Chloride	CHLORIDE
61	\N	\N	f	combo-code	13	Observation	2024-03-29 23:52:18.104	-5090473836638888971	-1575406001252496924	3219723693549490985	Chloride [Moles/volume] in Blood	CHLORIDE [MOLES/VOLUME] IN BLOOD
62	\N	\N	f	code	13	Observation	2024-03-29 23:52:18.104	6245376970862121436	2255293283549704696	7952934451955757422	Chloride [Moles/volume] in Blood	CHLORIDE [MOLES/VOLUME] IN BLOOD
63	\N	\N	f	combo-code	13	Observation	2024-03-29 23:52:18.104	4980540696134520183	-1575406001252496924	3219723693549490985	Chloride	CHLORIDE
64	\N	\N	f	code	14	Observation	2024-03-29 23:52:30.942	-6760003347818903505	2255293283549704696	7952934451955757422	Carbon dioxide, total [Moles/volume] in Blood	CARBON DIOXIDE, TOTAL [MOLES/VOLUME] IN BLOOD
65	\N	\N	f	combo-code	14	Observation	2024-03-29 23:52:30.942	-860898582731822381	-1575406001252496924	3219723693549490985	Carbon dioxide	CARBON DIOXIDE
66	\N	\N	f	code	14	Observation	2024-03-29 23:52:30.942	7266411725796706555	2255293283549704696	7952934451955757422	Carbon dioxide	CARBON DIOXIDE
67	\N	\N	f	combo-code	14	Observation	2024-03-29 23:52:30.942	5355630009599654603	-1575406001252496924	3219723693549490985	Carbon dioxide, total [Moles/volume] in Blood	CARBON DIOXIDE, TOTAL [MOLES/VOLUME] IN BLOOD
68	\N	\N	f	code	15	Observation	2024-03-29 23:52:36.874	-8513431408874473291	2255293283549704696	7952934451955757422	Urea nitrogen [Mass/volume] in Blood	UREA NITROGEN [MASS/VOLUME] IN BLOOD
69	\N	\N	f	combo-code	15	Observation	2024-03-29 23:52:36.874	-1337974398128731936	-1575406001252496924	3219723693549490985	Urea nitrogen [Mass/volume] in Blood	UREA NITROGEN [MASS/VOLUME] IN BLOOD
70	\N	\N	f	code	15	Observation	2024-03-29 23:52:36.874	-2909346854918280294	2255293283549704696	7952934451955757422	Blood Urea Nitrogen (BUN)	BLOOD UREA NITROGEN (BUN)
71	\N	\N	f	combo-code	15	Observation	2024-03-29 23:52:36.874	-902616560640436594	-1575406001252496924	3219723693549490985	Blood Urea Nitrogen (BUN)	BLOOD UREA NITROGEN (BUN)
72	\N	\N	f	code	16	Observation	2024-03-29 23:52:41.933	-3370553945660505630	2255293283549704696	7952934451955757422	Creatinine [Mass/volume] in Blood	CREATININE [MASS/VOLUME] IN BLOOD
73	\N	\N	f	code	16	Observation	2024-03-29 23:52:41.933	4874352794153080286	2255293283549704696	7952934451955757422	Creatinine	CREATININE
74	\N	\N	f	combo-code	16	Observation	2024-03-29 23:52:41.933	2219628078399443017	-1575406001252496924	3219723693549490985	Creatinine	CREATININE
75	\N	\N	f	combo-code	16	Observation	2024-03-29 23:52:41.933	-4482478491300664973	-1575406001252496924	3219723693549490985	Creatinine [Mass/volume] in Blood	CREATININE [MASS/VOLUME] IN BLOOD
76	\N	\N	f	combo-code	17	Observation	2024-03-29 23:52:45.811	3589328243673927935	-1575406001252496924	3219723693549490985	Calcium	CALCIUM
77	\N	\N	f	combo-code	17	Observation	2024-03-29 23:52:45.811	2275894495522739549	-1575406001252496924	3219723693549490985	Calcium [Mass/volume] in Blood	CALCIUM [MASS/VOLUME] IN BLOOD
78	\N	\N	f	code	17	Observation	2024-03-29 23:52:45.811	5917947472818157707	2255293283549704696	7952934451955757422	Calcium [Mass/volume] in Blood	CALCIUM [MASS/VOLUME] IN BLOOD
79	\N	\N	f	code	17	Observation	2024-03-29 23:52:45.811	2311087003060569019	2255293283549704696	7952934451955757422	Calcium	CALCIUM
80	\N	\N	f	combo-code	18	Observation	2024-03-29 23:52:50.645	-729878255765274360	-1575406001252496924	3219723693549490985	Blood Glucose	BLOOD GLUCOSE
81	\N	\N	f	combo-code	18	Observation	2024-03-29 23:52:50.645	3625656230168511124	-1575406001252496924	3219723693549490985	Glucose [Mass/volume] in Blood	GLUCOSE [MASS/VOLUME] IN BLOOD
82	\N	\N	f	code	18	Observation	2024-03-29 23:52:50.645	4417901827135323106	2255293283549704696	7952934451955757422	Blood Glucose	BLOOD GLUCOSE
83	\N	\N	f	code	18	Observation	2024-03-29 23:52:50.645	2874010700076545834	2255293283549704696	7952934451955757422	Glucose [Mass/volume] in Blood	GLUCOSE [MASS/VOLUME] IN BLOOD
84	\N	\N	f	code	19	DiagnosticReport	2024-03-29 23:53:08.206	-781094058477516670	-3916981602437818560	3626723361271617949	Lipid Panel	LIPID PANEL
85	\N	\N	f	code	19	DiagnosticReport	2024-03-29 23:53:08.206	-4023430451375657967	-3916981602437818560	3626723361271617949	Lipid panel - Serum or Plasma	LIPID PANEL - SERUM OR PLASMA
86	\N	\N	f	code	20	DiagnosticReport	2024-03-29 23:53:37.276	-6550107811515209367	-3916981602437818560	3626723361271617949	Basic metabolic panel	BASIC METABOLIC PANEL
87	\N	\N	f	code	20	DiagnosticReport	2024-03-29 23:53:37.276	-178878069667911357	-3916981602437818560	3626723361271617949	Basic metabolic panel - Blood	BASIC METABOLIC PANEL - BLOOD
102	\N	\N	f	participant-type	52	Encounter	2024-03-30 04:26:05.517	2337568344886830956	-5371663801521722987	-7359323698783872344	Attender	ATTENDER
103	\N	\N	f	participant-type	53	Encounter	2024-03-30 04:26:09.137	2337568344886830956	-5371663801521722987	-7359323698783872344	Attender	ATTENDER
104	\N	\N	f	participant-type	54	Encounter	2024-03-30 04:26:12.997	2337568344886830956	-5371663801521722987	-7359323698783872344	Attender	ATTENDER
105	\N	\N	f	participant-type	55	Encounter	2024-03-30 04:26:15.97	2337568344886830956	-5371663801521722987	-7359323698783872344	Attender	ATTENDER
106	\N	\N	f	combo-code	60	Observation	2024-03-30 04:31:56.282	-8581746947556588906	-1575406001252496924	3219723693549490985	Cholesterol [Mass/volume] in Serum or Plasma	CHOLESTEROL [MASS/VOLUME] IN SERUM OR PLASMA
107	\N	\N	f	code	60	Observation	2024-03-30 04:31:56.282	-547295962750014032	2255293283549704696	7952934451955757422	Cholesterol Total	CHOLESTEROL TOTAL
108	\N	\N	f	combo-code	60	Observation	2024-03-30 04:31:56.282	9061215102015415096	-1575406001252496924	3219723693549490985	Cholesterol Total	CHOLESTEROL TOTAL
109	\N	\N	f	code	60	Observation	2024-03-30 04:31:56.282	7246441234054466946	2255293283549704696	7952934451955757422	Cholesterol [Mass/volume] in Serum or Plasma	CHOLESTEROL [MASS/VOLUME] IN SERUM OR PLASMA
110	\N	\N	f	combo-code	61	Observation	2024-03-30 04:33:07.05	1469296039069425098	-1575406001252496924	3219723693549490985	Triglyceride [Mass/volume] in Serum or Plasma	TRIGLYCERIDE [MASS/VOLUME] IN SERUM OR PLASMA
111	\N	\N	f	code	61	Observation	2024-03-30 04:33:07.05	7088981547590288966	2255293283549704696	7952934451955757422	Triglycerides	TRIGLYCERIDES
112	\N	\N	f	combo-code	61	Observation	2024-03-30 04:33:07.05	3438705216464412745	-1575406001252496924	3219723693549490985	Triglycerides	TRIGLYCERIDES
113	\N	\N	f	code	61	Observation	2024-03-30 04:33:07.05	4335145522709947847	2255293283549704696	7952934451955757422	Triglyceride [Mass/volume] in Serum or Plasma	TRIGLYCERIDE [MASS/VOLUME] IN SERUM OR PLASMA
114	\N	\N	f	combo-code	62	Observation	2024-03-30 04:33:53.184	-5722067262143408521	-1575406001252496924	3219723693549490985	HDL Cholesterol	HDL CHOLESTEROL
115	\N	\N	f	code	62	Observation	2024-03-30 04:33:53.184	-5031882055509686364	2255293283549704696	7952934451955757422	HDL Cholesterol	HDL CHOLESTEROL
116	\N	\N	f	combo-code	62	Observation	2024-03-30 04:33:53.184	8282020099403792385	-1575406001252496924	3219723693549490985	Cholesterol in HDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN HDL [MASS/VOLUME] IN SERUM OR PLASMA
117	\N	\N	f	code	62	Observation	2024-03-30 04:33:53.184	-2352442194959281521	2255293283549704696	7952934451955757422	Cholesterol in HDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN HDL [MASS/VOLUME] IN SERUM OR PLASMA
118	\N	\N	f	code	63	Observation	2024-03-30 04:34:37.247	-815990996031721104	2255293283549704696	7952934451955757422	LDL Cholesterol	LDL CHOLESTEROL
119	\N	\N	f	code	63	Observation	2024-03-30 04:34:37.247	-1746526924469582058	2255293283549704696	7952934451955757422	Cholesterol in LDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN LDL [MASS/VOLUME] IN SERUM OR PLASMA
120	\N	\N	f	combo-code	63	Observation	2024-03-30 04:34:37.247	5238336998874521258	-1575406001252496924	3219723693549490985	Cholesterol in LDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN LDL [MASS/VOLUME] IN SERUM OR PLASMA
121	\N	\N	f	combo-code	63	Observation	2024-03-30 04:34:37.247	-3957019558173465338	-1575406001252496924	3219723693549490985	LDL Cholesterol	LDL CHOLESTEROL
122	\N	\N	f	code	64	DiagnosticReport	2024-03-30 04:36:58.287	-781094058477516670	-3916981602437818560	3626723361271617949	Lipid Panel	LIPID PANEL
123	\N	\N	f	code	64	DiagnosticReport	2024-03-30 04:36:58.287	-4023430451375657967	-3916981602437818560	3626723361271617949	Lipid panel - Serum or Plasma	LIPID PANEL - SERUM OR PLASMA
124	\N	\N	f	combo-code	65	Observation	2024-03-30 04:38:52.576	-8581746947556588906	-1575406001252496924	3219723693549490985	Cholesterol [Mass/volume] in Serum or Plasma	CHOLESTEROL [MASS/VOLUME] IN SERUM OR PLASMA
125	\N	\N	f	code	65	Observation	2024-03-30 04:38:52.576	-547295962750014032	2255293283549704696	7952934451955757422	Cholesterol Total	CHOLESTEROL TOTAL
126	\N	\N	f	combo-code	65	Observation	2024-03-30 04:38:52.576	9061215102015415096	-1575406001252496924	3219723693549490985	Cholesterol Total	CHOLESTEROL TOTAL
127	\N	\N	f	code	65	Observation	2024-03-30 04:38:52.576	7246441234054466946	2255293283549704696	7952934451955757422	Cholesterol [Mass/volume] in Serum or Plasma	CHOLESTEROL [MASS/VOLUME] IN SERUM OR PLASMA
128	\N	\N	f	combo-code	66	Observation	2024-03-30 04:39:45.262	1469296039069425098	-1575406001252496924	3219723693549490985	Triglyceride [Mass/volume] in Serum or Plasma	TRIGLYCERIDE [MASS/VOLUME] IN SERUM OR PLASMA
129	\N	\N	f	code	66	Observation	2024-03-30 04:39:45.262	7088981547590288966	2255293283549704696	7952934451955757422	Triglycerides	TRIGLYCERIDES
130	\N	\N	f	combo-code	66	Observation	2024-03-30 04:39:45.262	3438705216464412745	-1575406001252496924	3219723693549490985	Triglycerides	TRIGLYCERIDES
131	\N	\N	f	code	66	Observation	2024-03-30 04:39:45.262	4335145522709947847	2255293283549704696	7952934451955757422	Triglyceride [Mass/volume] in Serum or Plasma	TRIGLYCERIDE [MASS/VOLUME] IN SERUM OR PLASMA
132	\N	\N	f	combo-code	67	Observation	2024-03-30 04:40:32.538	-5722067262143408521	-1575406001252496924	3219723693549490985	HDL Cholesterol	HDL CHOLESTEROL
133	\N	\N	f	code	67	Observation	2024-03-30 04:40:32.538	-5031882055509686364	2255293283549704696	7952934451955757422	HDL Cholesterol	HDL CHOLESTEROL
134	\N	\N	f	combo-code	67	Observation	2024-03-30 04:40:32.538	8282020099403792385	-1575406001252496924	3219723693549490985	Cholesterol in HDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN HDL [MASS/VOLUME] IN SERUM OR PLASMA
135	\N	\N	f	code	67	Observation	2024-03-30 04:40:32.538	-2352442194959281521	2255293283549704696	7952934451955757422	Cholesterol in HDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN HDL [MASS/VOLUME] IN SERUM OR PLASMA
136	\N	\N	f	code	68	Observation	2024-03-30 04:41:13.966	-815990996031721104	2255293283549704696	7952934451955757422	LDL Cholesterol	LDL CHOLESTEROL
137	\N	\N	f	code	68	Observation	2024-03-30 04:41:13.966	-1746526924469582058	2255293283549704696	7952934451955757422	Cholesterol in LDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN LDL [MASS/VOLUME] IN SERUM OR PLASMA
138	\N	\N	f	combo-code	68	Observation	2024-03-30 04:41:13.966	5238336998874521258	-1575406001252496924	3219723693549490985	Cholesterol in LDL [Mass/volume] in Serum or Plasma	CHOLESTEROL IN LDL [MASS/VOLUME] IN SERUM OR PLASMA
139	\N	\N	f	combo-code	68	Observation	2024-03-30 04:41:13.966	-3957019558173465338	-1575406001252496924	3219723693549490985	LDL Cholesterol	LDL CHOLESTEROL
140	\N	\N	f	code	69	DiagnosticReport	2024-03-30 04:43:14.94	-781094058477516670	-3916981602437818560	3626723361271617949	Lipid Panel	LIPID PANEL
141	\N	\N	f	code	69	DiagnosticReport	2024-03-30 04:43:14.94	-4023430451375657967	-3916981602437818560	3626723361271617949	Lipid panel - Serum or Plasma	LIPID PANEL - SERUM OR PLASMA
142	\N	\N	f	code	70	Observation	2024-03-30 04:44:53.418	8893304149050838504	2255293283549704696	7952934451955757422	Sodium [Moles/volume] in Blood	SODIUM [MOLES/VOLUME] IN BLOOD
143	\N	\N	f	combo-code	70	Observation	2024-03-30 04:44:53.418	-8878196531663186150	-1575406001252496924	3219723693549490985	Sodium [Moles/volume] in Blood	SODIUM [MOLES/VOLUME] IN BLOOD
144	\N	\N	f	code	70	Observation	2024-03-30 04:44:53.418	3006255479008128299	2255293283549704696	7952934451955757422	Sodium	SODIUM
145	\N	\N	f	combo-code	70	Observation	2024-03-30 04:44:53.418	-5463900833747401680	-1575406001252496924	3219723693549490985	Sodium	SODIUM
146	\N	\N	f	combo-code	71	Observation	2024-03-30 04:45:48.146	-5383380684496061498	-1575406001252496924	3219723693549490985	Potassium	POTASSIUM
147	\N	\N	f	code	71	Observation	2024-03-30 04:45:48.146	813046777322615546	2255293283549704696	7952934451955757422	Potassium	POTASSIUM
148	\N	\N	f	code	71	Observation	2024-03-30 04:45:48.146	3134037314694519407	2255293283549704696	7952934451955757422	Potassium [Moles/volume] in Blood	POTASSIUM [MOLES/VOLUME] IN BLOOD
149	\N	\N	f	combo-code	71	Observation	2024-03-30 04:45:48.146	-320242156012432318	-1575406001252496924	3219723693549490985	Potassium [Moles/volume] in Blood	POTASSIUM [MOLES/VOLUME] IN BLOOD
150	\N	\N	f	code	72	Observation	2024-03-30 04:46:26.864	-6392468113108463230	2255293283549704696	7952934451955757422	Chloride	CHLORIDE
151	\N	\N	f	combo-code	72	Observation	2024-03-30 04:46:26.864	-5090473836638888971	-1575406001252496924	3219723693549490985	Chloride [Moles/volume] in Blood	CHLORIDE [MOLES/VOLUME] IN BLOOD
152	\N	\N	f	code	72	Observation	2024-03-30 04:46:26.864	6245376970862121436	2255293283549704696	7952934451955757422	Chloride [Moles/volume] in Blood	CHLORIDE [MOLES/VOLUME] IN BLOOD
153	\N	\N	f	combo-code	72	Observation	2024-03-30 04:46:26.864	4980540696134520183	-1575406001252496924	3219723693549490985	Chloride	CHLORIDE
154	\N	\N	f	code	73	Observation	2024-03-30 04:47:11.586	-6760003347818903505	2255293283549704696	7952934451955757422	Carbon dioxide, total [Moles/volume] in Blood	CARBON DIOXIDE, TOTAL [MOLES/VOLUME] IN BLOOD
155	\N	\N	f	combo-code	73	Observation	2024-03-30 04:47:11.586	-860898582731822381	-1575406001252496924	3219723693549490985	Carbon dioxide	CARBON DIOXIDE
156	\N	\N	f	code	73	Observation	2024-03-30 04:47:11.586	7266411725796706555	2255293283549704696	7952934451955757422	Carbon dioxide	CARBON DIOXIDE
157	\N	\N	f	combo-code	73	Observation	2024-03-30 04:47:11.586	5355630009599654603	-1575406001252496924	3219723693549490985	Carbon dioxide, total [Moles/volume] in Blood	CARBON DIOXIDE, TOTAL [MOLES/VOLUME] IN BLOOD
158	\N	\N	f	code	74	Observation	2024-03-30 04:47:58.496	-8513431408874473291	2255293283549704696	7952934451955757422	Urea nitrogen [Mass/volume] in Blood	UREA NITROGEN [MASS/VOLUME] IN BLOOD
159	\N	\N	f	combo-code	74	Observation	2024-03-30 04:47:58.496	-1337974398128731936	-1575406001252496924	3219723693549490985	Urea nitrogen [Mass/volume] in Blood	UREA NITROGEN [MASS/VOLUME] IN BLOOD
160	\N	\N	f	code	74	Observation	2024-03-30 04:47:58.496	-2909346854918280294	2255293283549704696	7952934451955757422	Blood Urea Nitrogen (BUN)	BLOOD UREA NITROGEN (BUN)
161	\N	\N	f	combo-code	74	Observation	2024-03-30 04:47:58.496	-902616560640436594	-1575406001252496924	3219723693549490985	Blood Urea Nitrogen (BUN)	BLOOD UREA NITROGEN (BUN)
162	\N	\N	f	code	75	Observation	2024-03-30 04:48:37.308	-3370553945660505630	2255293283549704696	7952934451955757422	Creatinine [Mass/volume] in Blood	CREATININE [MASS/VOLUME] IN BLOOD
163	\N	\N	f	code	75	Observation	2024-03-30 04:48:37.308	4874352794153080286	2255293283549704696	7952934451955757422	Creatinine	CREATININE
164	\N	\N	f	combo-code	75	Observation	2024-03-30 04:48:37.308	2219628078399443017	-1575406001252496924	3219723693549490985	Creatinine	CREATININE
165	\N	\N	f	combo-code	75	Observation	2024-03-30 04:48:37.308	-4482478491300664973	-1575406001252496924	3219723693549490985	Creatinine [Mass/volume] in Blood	CREATININE [MASS/VOLUME] IN BLOOD
166	\N	\N	f	combo-code	76	Observation	2024-03-30 04:49:29.535	3589328243673927935	-1575406001252496924	3219723693549490985	Calcium	CALCIUM
167	\N	\N	f	combo-code	76	Observation	2024-03-30 04:49:29.535	2275894495522739549	-1575406001252496924	3219723693549490985	Calcium [Mass/volume] in Blood	CALCIUM [MASS/VOLUME] IN BLOOD
168	\N	\N	f	code	76	Observation	2024-03-30 04:49:29.535	5917947472818157707	2255293283549704696	7952934451955757422	Calcium [Mass/volume] in Blood	CALCIUM [MASS/VOLUME] IN BLOOD
169	\N	\N	f	code	76	Observation	2024-03-30 04:49:29.535	2311087003060569019	2255293283549704696	7952934451955757422	Calcium	CALCIUM
170	\N	\N	f	combo-code	77	Observation	2024-03-30 04:50:10.779	-729878255765274360	-1575406001252496924	3219723693549490985	Blood Glucose	BLOOD GLUCOSE
171	\N	\N	f	combo-code	77	Observation	2024-03-30 04:50:10.779	3625656230168511124	-1575406001252496924	3219723693549490985	Glucose [Mass/volume] in Blood	GLUCOSE [MASS/VOLUME] IN BLOOD
172	\N	\N	f	code	77	Observation	2024-03-30 04:50:10.779	4417901827135323106	2255293283549704696	7952934451955757422	Blood Glucose	BLOOD GLUCOSE
173	\N	\N	f	code	77	Observation	2024-03-30 04:50:10.779	2874010700076545834	2255293283549704696	7952934451955757422	Glucose [Mass/volume] in Blood	GLUCOSE [MASS/VOLUME] IN BLOOD
174	\N	\N	f	code	78	DiagnosticReport	2024-03-30 04:52:21.763	-6550107811515209367	-3916981602437818560	3626723361271617949	Basic metabolic panel	BASIC METABOLIC PANEL
175	\N	\N	f	code	78	DiagnosticReport	2024-03-30 04:52:21.763	-178878069667911357	-3916981602437818560	3626723361271617949	Basic metabolic panel - Blood	BASIC METABOLIC PANEL - BLOOD
176	\N	\N	f	code	79	Observation	2024-03-30 04:53:53.703	8893304149050838504	2255293283549704696	7952934451955757422	Sodium [Moles/volume] in Blood	SODIUM [MOLES/VOLUME] IN BLOOD
177	\N	\N	f	combo-code	79	Observation	2024-03-30 04:53:53.703	-8878196531663186150	-1575406001252496924	3219723693549490985	Sodium [Moles/volume] in Blood	SODIUM [MOLES/VOLUME] IN BLOOD
178	\N	\N	f	code	79	Observation	2024-03-30 04:53:53.703	3006255479008128299	2255293283549704696	7952934451955757422	Sodium	SODIUM
179	\N	\N	f	combo-code	79	Observation	2024-03-30 04:53:53.703	-5463900833747401680	-1575406001252496924	3219723693549490985	Sodium	SODIUM
180	\N	\N	f	combo-code	80	Observation	2024-03-30 04:54:42.536	-5383380684496061498	-1575406001252496924	3219723693549490985	Potassium	POTASSIUM
181	\N	\N	f	code	80	Observation	2024-03-30 04:54:42.536	813046777322615546	2255293283549704696	7952934451955757422	Potassium	POTASSIUM
182	\N	\N	f	code	80	Observation	2024-03-30 04:54:42.536	3134037314694519407	2255293283549704696	7952934451955757422	Potassium [Moles/volume] in Blood	POTASSIUM [MOLES/VOLUME] IN BLOOD
183	\N	\N	f	combo-code	80	Observation	2024-03-30 04:54:42.536	-320242156012432318	-1575406001252496924	3219723693549490985	Potassium [Moles/volume] in Blood	POTASSIUM [MOLES/VOLUME] IN BLOOD
184	\N	\N	f	code	81	Observation	2024-03-30 04:55:23.364	-6392468113108463230	2255293283549704696	7952934451955757422	Chloride	CHLORIDE
185	\N	\N	f	combo-code	81	Observation	2024-03-30 04:55:23.364	-5090473836638888971	-1575406001252496924	3219723693549490985	Chloride [Moles/volume] in Blood	CHLORIDE [MOLES/VOLUME] IN BLOOD
186	\N	\N	f	code	81	Observation	2024-03-30 04:55:23.364	6245376970862121436	2255293283549704696	7952934451955757422	Chloride [Moles/volume] in Blood	CHLORIDE [MOLES/VOLUME] IN BLOOD
187	\N	\N	f	combo-code	81	Observation	2024-03-30 04:55:23.364	4980540696134520183	-1575406001252496924	3219723693549490985	Chloride	CHLORIDE
188	\N	\N	f	code	82	Observation	2024-03-30 04:56:04.597	-6760003347818903505	2255293283549704696	7952934451955757422	Carbon dioxide, total [Moles/volume] in Blood	CARBON DIOXIDE, TOTAL [MOLES/VOLUME] IN BLOOD
189	\N	\N	f	combo-code	82	Observation	2024-03-30 04:56:04.597	-860898582731822381	-1575406001252496924	3219723693549490985	Carbon dioxide	CARBON DIOXIDE
190	\N	\N	f	code	82	Observation	2024-03-30 04:56:04.597	7266411725796706555	2255293283549704696	7952934451955757422	Carbon dioxide	CARBON DIOXIDE
191	\N	\N	f	combo-code	82	Observation	2024-03-30 04:56:04.597	5355630009599654603	-1575406001252496924	3219723693549490985	Carbon dioxide, total [Moles/volume] in Blood	CARBON DIOXIDE, TOTAL [MOLES/VOLUME] IN BLOOD
192	\N	\N	f	code	83	Observation	2024-03-30 04:56:47.414	-8513431408874473291	2255293283549704696	7952934451955757422	Urea nitrogen [Mass/volume] in Blood	UREA NITROGEN [MASS/VOLUME] IN BLOOD
193	\N	\N	f	combo-code	83	Observation	2024-03-30 04:56:47.414	-1337974398128731936	-1575406001252496924	3219723693549490985	Urea nitrogen [Mass/volume] in Blood	UREA NITROGEN [MASS/VOLUME] IN BLOOD
194	\N	\N	f	code	83	Observation	2024-03-30 04:56:47.414	-2909346854918280294	2255293283549704696	7952934451955757422	Blood Urea Nitrogen (BUN)	BLOOD UREA NITROGEN (BUN)
195	\N	\N	f	combo-code	83	Observation	2024-03-30 04:56:47.414	-902616560640436594	-1575406001252496924	3219723693549490985	Blood Urea Nitrogen (BUN)	BLOOD UREA NITROGEN (BUN)
196	\N	\N	f	code	84	Observation	2024-03-30 04:57:28.702	-3370553945660505630	2255293283549704696	7952934451955757422	Creatinine [Mass/volume] in Blood	CREATININE [MASS/VOLUME] IN BLOOD
197	\N	\N	f	code	84	Observation	2024-03-30 04:57:28.702	4874352794153080286	2255293283549704696	7952934451955757422	Creatinine	CREATININE
198	\N	\N	f	combo-code	84	Observation	2024-03-30 04:57:28.702	2219628078399443017	-1575406001252496924	3219723693549490985	Creatinine	CREATININE
199	\N	\N	f	combo-code	84	Observation	2024-03-30 04:57:28.702	-4482478491300664973	-1575406001252496924	3219723693549490985	Creatinine [Mass/volume] in Blood	CREATININE [MASS/VOLUME] IN BLOOD
200	\N	\N	f	combo-code	85	Observation	2024-03-30 04:58:13.109	3589328243673927935	-1575406001252496924	3219723693549490985	Calcium	CALCIUM
201	\N	\N	f	combo-code	85	Observation	2024-03-30 04:58:13.109	2275894495522739549	-1575406001252496924	3219723693549490985	Calcium [Mass/volume] in Blood	CALCIUM [MASS/VOLUME] IN BLOOD
202	\N	\N	f	code	85	Observation	2024-03-30 04:58:13.109	5917947472818157707	2255293283549704696	7952934451955757422	Calcium [Mass/volume] in Blood	CALCIUM [MASS/VOLUME] IN BLOOD
203	\N	\N	f	code	85	Observation	2024-03-30 04:58:13.109	2311087003060569019	2255293283549704696	7952934451955757422	Calcium	CALCIUM
204	\N	\N	f	combo-code	86	Observation	2024-03-30 04:58:53.964	-729878255765274360	-1575406001252496924	3219723693549490985	Blood Glucose	BLOOD GLUCOSE
205	\N	\N	f	combo-code	86	Observation	2024-03-30 04:58:53.964	3625656230168511124	-1575406001252496924	3219723693549490985	Glucose [Mass/volume] in Blood	GLUCOSE [MASS/VOLUME] IN BLOOD
206	\N	\N	f	code	86	Observation	2024-03-30 04:58:53.964	4417901827135323106	2255293283549704696	7952934451955757422	Blood Glucose	BLOOD GLUCOSE
207	\N	\N	f	code	86	Observation	2024-03-30 04:58:53.964	2874010700076545834	2255293283549704696	7952934451955757422	Glucose [Mass/volume] in Blood	GLUCOSE [MASS/VOLUME] IN BLOOD
208	\N	\N	f	code	87	DiagnosticReport	2024-03-30 05:00:46.183	-6550107811515209367	-3916981602437818560	3626723361271617949	Basic metabolic panel	BASIC METABOLIC PANEL
209	\N	\N	f	code	87	DiagnosticReport	2024-03-30 05:00:46.183	-178878069667911357	-3916981602437818560	3626723361271617949	Basic metabolic panel - Blood	BASIC METABOLIC PANEL - BLOOD
305	\N	\N	f	code	5	ServiceRequest	2024-03-30 18:06:44.473	-8996361140464897136	2834087348067369440	4178290700673806038	Lipid panel - Serum or Plasma	LIPID PANEL - SERUM OR PLASMA
306	\N	\N	f	code	6	ServiceRequest	2024-03-30 18:07:36.645	7658643001008282855	2834087348067369440	4178290700673806038	Basic metabolic panel - Blood	BASIC METABOLIC PANEL - BLOOD
307	\N	\N	f	code	56	ServiceRequest	2024-03-30 18:08:24.163	-8996361140464897136	2834087348067369440	4178290700673806038	Lipid panel - Serum or Plasma	LIPID PANEL - SERUM OR PLASMA
308	\N	\N	f	code	57	ServiceRequest	2024-03-30 18:09:06.624	-8996361140464897136	2834087348067369440	4178290700673806038	Lipid panel - Serum or Plasma	LIPID PANEL - SERUM OR PLASMA
309	\N	\N	f	code	58	ServiceRequest	2024-03-30 18:09:53.003	7658643001008282855	2834087348067369440	4178290700673806038	Basic metabolic panel - Blood	BASIC METABOLIC PANEL - BLOOD
310	\N	\N	f	code	59	ServiceRequest	2024-03-30 18:21:32.889	7658643001008282855	2834087348067369440	4178290700673806038	Basic metabolic panel - Blood	BASIC METABOLIC PANEL - BLOOD
\.


--
-- Data for Name: hfj_spidx_token; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hfj_spidx_token (sp_id, partition_date, partition_id, sp_missing, sp_name, res_id, res_type, sp_updated, hash_identity, hash_sys, hash_sys_and_value, hash_value, sp_system, sp_value) FROM stdin;
1	\N	\N	f	deceased	1	Patient	2024-03-29 23:51:02.473	-2830809394128781005	7353680702239462393	-5327334097351605748	3407954849507134049	\N	false
2	\N	\N	f	phone	1	Patient	2024-03-29 23:51:02.473	-6551284011736109816	3676693649649869469	2217014884160737748	-4072635845336352155	phone	+1-222-22-22
3	\N	\N	f	identifier	1	Patient	2024-03-29 23:51:02.473	7001889285610424179	4763316194923162749	-2870423601700616926	-3301897089165252159	http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid	2923
4	\N	\N	f	identifier	1	Patient	2024-03-29 23:51:02.473	7001889285610424179	1715342199149986150	2488130311416695625	759552698550387343	https://fhir.infoway-inforoute.ca/NamingSystem/ca-on-patient-hcn	6132001124
5	\N	\N	f	telecom	1	Patient	2024-03-29 23:51:02.473	-2077596379165548657	8516278519576469875	8590648028235324968	-3343275632807121655	email	test2@uwaterloo.ca
6	\N	\N	f	language	1	Patient	2024-03-29 23:51:02.473	-6338030716006204643	-1940310015748265732	4810204165161749264	6299247892550696020	urn:ietf:bcp:47	en
7	\N	\N	f	telecom	1	Patient	2024-03-29 23:51:02.473	-2077596379165548657	-6891370790566514502	-7066425611039986254	8704819228189717495	phone	+1-222-22-22
8	\N	\N	f	identifier	1	Patient	2024-03-29 23:51:02.473	7001889285610424179	4257320668095098482	-8651841328355220569	-7081826293240340558	http://ehealthontario.ca/fhir/NamingSystem/id-example-uri	FULL_PROFILE_LEN3
9	\N	\N	f	identifier	1	Patient	2024-03-29 23:51:02.473	7001889285610424179	9021741681284811582	1234501713321297036	-3918135224496054290	https://fhir.infoway-inforoute.ca/NamingSystem/ca-bc-patient-healthcare-id	1806194839
10	\N	\N	f	email	1	Patient	2024-03-29 23:51:02.473	8843210077643414697	8013842278858588266	-8293275544597234423	-5572307882528425927	email	test2@uwaterloo.ca
11	\N	\N	f	gender	1	Patient	2024-03-29 23:51:02.473	2817066266609047850	-3105809197943607223	-394015888313699303	-5305902187566578701	http://hl7.org/fhir/administrative-gender	male
12	\N	\N	f	identifier	1	Patient	2024-03-29 23:51:02.473	7001889285610424179	9206385278132055722	2357603312228963506	-450861936932088867	http://ehealthontario.ca/fhir/NamingSystem/id-example1-uri	WSD00038992
13	\N	\N	f	address-use	1	Patient	2024-03-29 23:51:02.473	-5709780511353405485	2861726891246574650	-1860926926013048045	-8022872449579766223	http://hl7.org/fhir/address-use	home
14	\N	\N	f	phone	2	Practitioner	2024-03-29 23:51:10.897	-1037881135558997745	-147222542506157838	-2283110318051306788	-2972563938248941093	phone	555-555-5555
15	\N	\N	f	identifier	2	Practitioner	2024-03-29 23:51:10.897	-2243684955071374540	-7917309023128612321	2702324789785869991	-4902237428445688922	http://www.acme.org/practitioners	23
16	\N	\N	f	telecom	2	Practitioner	2024-03-29 23:51:10.897	387807586595864093	-3286349477844834914	1526089160929978637	6012740397526684500	phone	555-555-5555
17	\N	\N	f	address-use	2	Practitioner	2024-03-29 23:51:10.897	-7505439946886088432	-1426638405431506382	8301779404586836441	3914796655566257351	http://hl7.org/fhir/address-use	home
18	\N	\N	f	participant-type	3	Encounter	2024-03-29 23:51:19.362	-5371663801521722987	7016678455483815776	4705486097375669023	-399966206479922728	http://terminology.hl7.org/CodeSystem/v3-ParticipationType	ATND
19	\N	\N	f	status	3	Encounter	2024-03-29 23:51:19.362	2943755954119626025	182027417510160691	406749297711232410	7183990986795589525	http://hl7.org/fhir/encounter-status	finished
20	\N	\N	f	participant-type	4	Encounter	2024-03-29 23:51:24.703	-5371663801521722987	7016678455483815776	4705486097375669023	-399966206479922728	http://terminology.hl7.org/CodeSystem/v3-ParticipationType	ATND
21	\N	\N	f	status	4	Encounter	2024-03-29 23:51:24.703	2943755954119626025	182027417510160691	406749297711232410	7183990986795589525	http://hl7.org/fhir/encounter-status	finished
22	\N	\N	f	status	5	ServiceRequest	2024-03-29 23:51:30.453	-3147188080387594445	5364609586080114156	7126772436959758958	-9191178599921922137	http://hl7.org/fhir/request-status	completed
23	\N	\N	f	intent	5	ServiceRequest	2024-03-29 23:51:30.453	-1808132413950182279	-7841548022304666673	220781156037754794	-5831669902935645909	http://hl7.org/fhir/request-intent	original-order
24	\N	\N	f	identifier	5	ServiceRequest	2024-03-29 23:51:30.453	5119828810776094679	6951052077505339378	6990178950295359372	-862664255998681308	urn:oid:1.3.4.5.6.7	2345234234234
25	\N	\N	f	status	6	ServiceRequest	2024-03-29 23:51:34.845	-3147188080387594445	5364609586080114156	7126772436959758958	-9191178599921922137	http://hl7.org/fhir/request-status	completed
26	\N	\N	f	intent	6	ServiceRequest	2024-03-29 23:51:34.845	-1808132413950182279	-7841548022304666673	220781156037754794	-5831669902935645909	http://hl7.org/fhir/request-intent	original-order
27	\N	\N	f	identifier	6	ServiceRequest	2024-03-29 23:51:34.845	5119828810776094679	6951052077505339378	6990178950295359372	-862664255998681308	urn:oid:1.3.4.5.6.7	2345234234234
28	\N	\N	f	status	7	Observation	2024-03-29 23:51:41.609	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
29	\N	\N	f	code	7	Observation	2024-03-29 23:51:41.609	2255293283549704696	3544617184093811114	865839895818003113	1689542286790361481	http://loinc.org	2093-3
30	\N	\N	f	combo-code	7	Observation	2024-03-29 23:51:41.609	-1575406001252496924	-7445927209719109166	5205951787221096241	-7611975215107104412	http://loinc.org	2093-3
31	\N	\N	f	combo-code	8	Observation	2024-03-29 23:51:44.748	-1575406001252496924	-7445927209719109166	-673795832914152157	-1281552927338604866	http://loinc.org	2571-8
32	\N	\N	f	code	8	Observation	2024-03-29 23:51:44.748	2255293283549704696	3544617184093811114	-436319147550084479	-410988587052156097	http://loinc.org	2571-8
33	\N	\N	f	status	8	Observation	2024-03-29 23:51:44.748	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
34	\N	\N	f	status	9	Observation	2024-03-29 23:51:47.861	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
35	\N	\N	f	code	9	Observation	2024-03-29 23:51:47.861	2255293283549704696	3544617184093811114	4699786162527064405	-5610751133244557571	http://loinc.org	2085-9
36	\N	\N	f	combo-code	9	Observation	2024-03-29 23:51:47.861	-1575406001252496924	-7445927209719109166	4778577101806050027	5997571194957626266	http://loinc.org	2085-9
37	\N	\N	f	combo-code	10	Observation	2024-03-29 23:51:58.9	-1575406001252496924	-7445927209719109166	-1764236238949096726	-5387520339925616855	http://loinc.org	13457-7
38	\N	\N	f	status	10	Observation	2024-03-29 23:51:58.9	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
39	\N	\N	f	code	10	Observation	2024-03-29 23:51:58.9	2255293283549704696	3544617184093811114	1744676917191209743	-4907498734112606099	http://loinc.org	13457-7
40	\N	\N	f	code	11	Observation	2024-03-29 23:52:06.229	2255293283549704696	3544617184093811114	-1788853872121592387	-3876769170373495391	http://loinc.org	2947-0
41	\N	\N	f	status	11	Observation	2024-03-29 23:52:06.229	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
42	\N	\N	f	combo-code	11	Observation	2024-03-29 23:52:06.229	-1575406001252496924	-7445927209719109166	-5876468539955411063	4171337606893745956	http://loinc.org	2947-0
43	\N	\N	f	combo-code	12	Observation	2024-03-29 23:52:13.102	-1575406001252496924	-7445927209719109166	91119742187291174	-78234795385865469	http://loinc.org	6298-4
44	\N	\N	f	status	12	Observation	2024-03-29 23:52:13.102	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
45	\N	\N	f	code	12	Observation	2024-03-29 23:52:13.102	2255293283549704696	3544617184093811114	-4071821029768209656	936739095624186166	http://loinc.org	6298-4
46	\N	\N	f	code	13	Observation	2024-03-29 23:52:18.104	2255293283549704696	3544617184093811114	7792770155190827789	-8896485680262186004	http://loinc.org	2069-3
47	\N	\N	f	combo-code	13	Observation	2024-03-29 23:52:18.104	-1575406001252496924	-7445927209719109166	5940902253636578356	1766709432338592481	http://loinc.org	2069-3
48	\N	\N	f	status	13	Observation	2024-03-29 23:52:18.104	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
49	\N	\N	f	code	14	Observation	2024-03-29 23:52:30.942	2255293283549704696	3544617184093811114	-112261398086944301	-1560285381393271579	http://loinc.org	20565-8
50	\N	\N	f	status	14	Observation	2024-03-29 23:52:30.942	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
51	\N	\N	f	combo-code	14	Observation	2024-03-29 23:52:30.942	-1575406001252496924	-7445927209719109166	-3076037516691539261	5601872151582180511	http://loinc.org	20565-8
52	\N	\N	f	code	15	Observation	2024-03-29 23:52:36.874	2255293283549704696	3544617184093811114	-112261398086944301	-1560285381393271579	http://loinc.org	20565-8
53	\N	\N	f	status	15	Observation	2024-03-29 23:52:36.874	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
54	\N	\N	f	combo-code	15	Observation	2024-03-29 23:52:36.874	-1575406001252496924	-7445927209719109166	-3076037516691539261	5601872151582180511	http://loinc.org	20565-8
55	\N	\N	f	code	16	Observation	2024-03-29 23:52:41.933	2255293283549704696	3544617184093811114	2189867948587183750	5968531095411028704	http://loinc.org	38483-4
56	\N	\N	f	combo-code	16	Observation	2024-03-29 23:52:41.933	-1575406001252496924	-7445927209719109166	434831649408467545	-8495183398571991275	http://loinc.org	38483-4
57	\N	\N	f	status	16	Observation	2024-03-29 23:52:41.933	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
58	\N	\N	f	code	17	Observation	2024-03-29 23:52:45.811	2255293283549704696	3544617184093811114	-7397961021207069228	4789830672868367348	http://loinc.org	49765-1
59	\N	\N	f	combo-code	17	Observation	2024-03-29 23:52:45.811	-1575406001252496924	-7445927209719109166	3025155936532492177	2166745986655077303	http://loinc.org	49765-1
60	\N	\N	f	status	17	Observation	2024-03-29 23:52:45.811	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
61	\N	\N	f	code	18	Observation	2024-03-29 23:52:50.645	2255293283549704696	3544617184093811114	-3880569354711826241	2043706721353938912	http://loinc.org	2339-0
62	\N	\N	f	status	18	Observation	2024-03-29 23:52:50.645	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
63	\N	\N	f	combo-code	18	Observation	2024-03-29 23:52:50.645	-1575406001252496924	-7445927209719109166	3790279195787844590	4401825082380038523	http://loinc.org	2339-0
64	\N	\N	f	code	19	DiagnosticReport	2024-03-29 23:53:08.206	-3916981602437818560	2594497875333274272	-5627998614340020773	-4274445795264333633	http://loinc.org	100898-6
65	\N	\N	f	status	19	DiagnosticReport	2024-03-29 23:53:08.206	5099951916665761693	7851490687183160034	-9206743552120168165	1897687856213184221	http://hl7.org/fhir/diagnostic-report-status	final
66	\N	\N	f	code	20	DiagnosticReport	2024-03-29 23:53:37.276	-3916981602437818560	2594497875333274272	3319050714030799406	6768056423286483180	http://loinc.org	51990-0
67	\N	\N	f	status	20	DiagnosticReport	2024-03-29 23:53:37.276	5099951916665761693	7851490687183160034	-9206743552120168165	1897687856213184221	http://hl7.org/fhir/diagnostic-report-status	final
102	\N	\N	f	participant-type	52	Encounter	2024-03-30 04:26:05.517	-5371663801521722987	7016678455483815776	4705486097375669023	-399966206479922728	http://terminology.hl7.org/CodeSystem/v3-ParticipationType	ATND
103	\N	\N	f	status	52	Encounter	2024-03-30 04:26:05.517	2943755954119626025	182027417510160691	406749297711232410	7183990986795589525	http://hl7.org/fhir/encounter-status	finished
104	\N	\N	f	participant-type	53	Encounter	2024-03-30 04:26:09.137	-5371663801521722987	7016678455483815776	4705486097375669023	-399966206479922728	http://terminology.hl7.org/CodeSystem/v3-ParticipationType	ATND
105	\N	\N	f	status	53	Encounter	2024-03-30 04:26:09.137	2943755954119626025	182027417510160691	406749297711232410	7183990986795589525	http://hl7.org/fhir/encounter-status	finished
106	\N	\N	f	participant-type	54	Encounter	2024-03-30 04:26:12.997	-5371663801521722987	7016678455483815776	4705486097375669023	-399966206479922728	http://terminology.hl7.org/CodeSystem/v3-ParticipationType	ATND
107	\N	\N	f	status	54	Encounter	2024-03-30 04:26:12.997	2943755954119626025	182027417510160691	406749297711232410	7183990986795589525	http://hl7.org/fhir/encounter-status	finished
108	\N	\N	f	participant-type	55	Encounter	2024-03-30 04:26:15.97	-5371663801521722987	7016678455483815776	4705486097375669023	-399966206479922728	http://terminology.hl7.org/CodeSystem/v3-ParticipationType	ATND
109	\N	\N	f	status	55	Encounter	2024-03-30 04:26:15.97	2943755954119626025	182027417510160691	406749297711232410	7183990986795589525	http://hl7.org/fhir/encounter-status	finished
110	\N	\N	f	status	56	ServiceRequest	2024-03-30 04:26:35.106	-3147188080387594445	5364609586080114156	7126772436959758958	-9191178599921922137	http://hl7.org/fhir/request-status	completed
111	\N	\N	f	intent	56	ServiceRequest	2024-03-30 04:26:35.106	-1808132413950182279	-7841548022304666673	220781156037754794	-5831669902935645909	http://hl7.org/fhir/request-intent	original-order
112	\N	\N	f	identifier	56	ServiceRequest	2024-03-30 04:26:35.106	5119828810776094679	6951052077505339378	6990178950295359372	-862664255998681308	urn:oid:1.3.4.5.6.7	2345234234234
113	\N	\N	f	status	57	ServiceRequest	2024-03-30 04:27:28.171	-3147188080387594445	5364609586080114156	7126772436959758958	-9191178599921922137	http://hl7.org/fhir/request-status	completed
114	\N	\N	f	intent	57	ServiceRequest	2024-03-30 04:27:28.171	-1808132413950182279	-7841548022304666673	220781156037754794	-5831669902935645909	http://hl7.org/fhir/request-intent	original-order
115	\N	\N	f	identifier	57	ServiceRequest	2024-03-30 04:27:28.171	5119828810776094679	6951052077505339378	6990178950295359372	-862664255998681308	urn:oid:1.3.4.5.6.7	2345234234234
116	\N	\N	f	status	58	ServiceRequest	2024-03-30 04:29:25.948	-3147188080387594445	5364609586080114156	7126772436959758958	-9191178599921922137	http://hl7.org/fhir/request-status	completed
117	\N	\N	f	intent	58	ServiceRequest	2024-03-30 04:29:25.948	-1808132413950182279	-7841548022304666673	220781156037754794	-5831669902935645909	http://hl7.org/fhir/request-intent	original-order
118	\N	\N	f	identifier	58	ServiceRequest	2024-03-30 04:29:25.948	5119828810776094679	6951052077505339378	6990178950295359372	-862664255998681308	urn:oid:1.3.4.5.6.7	2345234234234
119	\N	\N	f	status	59	ServiceRequest	2024-03-30 04:29:42.34	-3147188080387594445	5364609586080114156	7126772436959758958	-9191178599921922137	http://hl7.org/fhir/request-status	completed
120	\N	\N	f	intent	59	ServiceRequest	2024-03-30 04:29:42.34	-1808132413950182279	-7841548022304666673	220781156037754794	-5831669902935645909	http://hl7.org/fhir/request-intent	original-order
121	\N	\N	f	identifier	59	ServiceRequest	2024-03-30 04:29:42.34	5119828810776094679	6951052077505339378	6990178950295359372	-862664255998681308	urn:oid:1.3.4.5.6.7	2345234234234
122	\N	\N	f	status	60	Observation	2024-03-30 04:31:56.282	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
123	\N	\N	f	code	60	Observation	2024-03-30 04:31:56.282	2255293283549704696	3544617184093811114	865839895818003113	1689542286790361481	http://loinc.org	2093-3
124	\N	\N	f	combo-code	60	Observation	2024-03-30 04:31:56.282	-1575406001252496924	-7445927209719109166	5205951787221096241	-7611975215107104412	http://loinc.org	2093-3
125	\N	\N	f	combo-code	61	Observation	2024-03-30 04:33:07.05	-1575406001252496924	-7445927209719109166	-673795832914152157	-1281552927338604866	http://loinc.org	2571-8
126	\N	\N	f	code	61	Observation	2024-03-30 04:33:07.05	2255293283549704696	3544617184093811114	-436319147550084479	-410988587052156097	http://loinc.org	2571-8
127	\N	\N	f	status	61	Observation	2024-03-30 04:33:07.05	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
128	\N	\N	f	status	62	Observation	2024-03-30 04:33:53.184	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
129	\N	\N	f	code	62	Observation	2024-03-30 04:33:53.184	2255293283549704696	3544617184093811114	4699786162527064405	-5610751133244557571	http://loinc.org	2085-9
130	\N	\N	f	combo-code	62	Observation	2024-03-30 04:33:53.184	-1575406001252496924	-7445927209719109166	4778577101806050027	5997571194957626266	http://loinc.org	2085-9
131	\N	\N	f	combo-code	63	Observation	2024-03-30 04:34:37.247	-1575406001252496924	-7445927209719109166	-1764236238949096726	-5387520339925616855	http://loinc.org	13457-7
132	\N	\N	f	status	63	Observation	2024-03-30 04:34:37.247	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
133	\N	\N	f	code	63	Observation	2024-03-30 04:34:37.247	2255293283549704696	3544617184093811114	1744676917191209743	-4907498734112606099	http://loinc.org	13457-7
134	\N	\N	f	code	64	DiagnosticReport	2024-03-30 04:36:58.287	-3916981602437818560	2594497875333274272	-5627998614340020773	-4274445795264333633	http://loinc.org	100898-6
135	\N	\N	f	status	64	DiagnosticReport	2024-03-30 04:36:58.287	5099951916665761693	7851490687183160034	-9206743552120168165	1897687856213184221	http://hl7.org/fhir/diagnostic-report-status	final
136	\N	\N	f	status	65	Observation	2024-03-30 04:38:52.576	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
137	\N	\N	f	code	65	Observation	2024-03-30 04:38:52.576	2255293283549704696	3544617184093811114	865839895818003113	1689542286790361481	http://loinc.org	2093-3
138	\N	\N	f	combo-code	65	Observation	2024-03-30 04:38:52.576	-1575406001252496924	-7445927209719109166	5205951787221096241	-7611975215107104412	http://loinc.org	2093-3
139	\N	\N	f	combo-code	66	Observation	2024-03-30 04:39:45.262	-1575406001252496924	-7445927209719109166	-673795832914152157	-1281552927338604866	http://loinc.org	2571-8
140	\N	\N	f	code	66	Observation	2024-03-30 04:39:45.262	2255293283549704696	3544617184093811114	-436319147550084479	-410988587052156097	http://loinc.org	2571-8
141	\N	\N	f	status	66	Observation	2024-03-30 04:39:45.262	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
142	\N	\N	f	status	67	Observation	2024-03-30 04:40:32.538	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
143	\N	\N	f	code	67	Observation	2024-03-30 04:40:32.538	2255293283549704696	3544617184093811114	4699786162527064405	-5610751133244557571	http://loinc.org	2085-9
144	\N	\N	f	combo-code	67	Observation	2024-03-30 04:40:32.538	-1575406001252496924	-7445927209719109166	4778577101806050027	5997571194957626266	http://loinc.org	2085-9
145	\N	\N	f	combo-code	68	Observation	2024-03-30 04:41:13.966	-1575406001252496924	-7445927209719109166	-1764236238949096726	-5387520339925616855	http://loinc.org	13457-7
146	\N	\N	f	status	68	Observation	2024-03-30 04:41:13.966	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
147	\N	\N	f	code	68	Observation	2024-03-30 04:41:13.966	2255293283549704696	3544617184093811114	1744676917191209743	-4907498734112606099	http://loinc.org	13457-7
148	\N	\N	f	code	69	DiagnosticReport	2024-03-30 04:43:14.94	-3916981602437818560	2594497875333274272	-5627998614340020773	-4274445795264333633	http://loinc.org	100898-6
149	\N	\N	f	status	69	DiagnosticReport	2024-03-30 04:43:14.94	5099951916665761693	7851490687183160034	-9206743552120168165	1897687856213184221	http://hl7.org/fhir/diagnostic-report-status	final
150	\N	\N	f	code	70	Observation	2024-03-30 04:44:53.418	2255293283549704696	3544617184093811114	-1788853872121592387	-3876769170373495391	http://loinc.org	2947-0
151	\N	\N	f	status	70	Observation	2024-03-30 04:44:53.418	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
152	\N	\N	f	combo-code	70	Observation	2024-03-30 04:44:53.418	-1575406001252496924	-7445927209719109166	-5876468539955411063	4171337606893745956	http://loinc.org	2947-0
153	\N	\N	f	combo-code	71	Observation	2024-03-30 04:45:48.146	-1575406001252496924	-7445927209719109166	91119742187291174	-78234795385865469	http://loinc.org	6298-4
154	\N	\N	f	status	71	Observation	2024-03-30 04:45:48.146	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
155	\N	\N	f	code	71	Observation	2024-03-30 04:45:48.146	2255293283549704696	3544617184093811114	-4071821029768209656	936739095624186166	http://loinc.org	6298-4
156	\N	\N	f	code	72	Observation	2024-03-30 04:46:26.864	2255293283549704696	3544617184093811114	7792770155190827789	-8896485680262186004	http://loinc.org	2069-3
157	\N	\N	f	combo-code	72	Observation	2024-03-30 04:46:26.864	-1575406001252496924	-7445927209719109166	5940902253636578356	1766709432338592481	http://loinc.org	2069-3
158	\N	\N	f	status	72	Observation	2024-03-30 04:46:26.864	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
159	\N	\N	f	code	73	Observation	2024-03-30 04:47:11.586	2255293283549704696	3544617184093811114	-112261398086944301	-1560285381393271579	http://loinc.org	20565-8
160	\N	\N	f	status	73	Observation	2024-03-30 04:47:11.586	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
161	\N	\N	f	combo-code	73	Observation	2024-03-30 04:47:11.586	-1575406001252496924	-7445927209719109166	-3076037516691539261	5601872151582180511	http://loinc.org	20565-8
162	\N	\N	f	code	74	Observation	2024-03-30 04:47:58.496	2255293283549704696	3544617184093811114	-112261398086944301	-1560285381393271579	http://loinc.org	20565-8
163	\N	\N	f	status	74	Observation	2024-03-30 04:47:58.496	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
164	\N	\N	f	combo-code	74	Observation	2024-03-30 04:47:58.496	-1575406001252496924	-7445927209719109166	-3076037516691539261	5601872151582180511	http://loinc.org	20565-8
165	\N	\N	f	code	75	Observation	2024-03-30 04:48:37.308	2255293283549704696	3544617184093811114	2189867948587183750	5968531095411028704	http://loinc.org	38483-4
166	\N	\N	f	combo-code	75	Observation	2024-03-30 04:48:37.308	-1575406001252496924	-7445927209719109166	434831649408467545	-8495183398571991275	http://loinc.org	38483-4
167	\N	\N	f	status	75	Observation	2024-03-30 04:48:37.308	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
168	\N	\N	f	code	76	Observation	2024-03-30 04:49:29.535	2255293283549704696	3544617184093811114	-7397961021207069228	4789830672868367348	http://loinc.org	49765-1
169	\N	\N	f	combo-code	76	Observation	2024-03-30 04:49:29.535	-1575406001252496924	-7445927209719109166	3025155936532492177	2166745986655077303	http://loinc.org	49765-1
170	\N	\N	f	status	76	Observation	2024-03-30 04:49:29.535	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
171	\N	\N	f	code	77	Observation	2024-03-30 04:50:10.779	2255293283549704696	3544617184093811114	-3880569354711826241	2043706721353938912	http://loinc.org	2339-0
172	\N	\N	f	status	77	Observation	2024-03-30 04:50:10.779	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
173	\N	\N	f	combo-code	77	Observation	2024-03-30 04:50:10.779	-1575406001252496924	-7445927209719109166	3790279195787844590	4401825082380038523	http://loinc.org	2339-0
174	\N	\N	f	code	78	DiagnosticReport	2024-03-30 04:52:21.763	-3916981602437818560	2594497875333274272	3319050714030799406	6768056423286483180	http://loinc.org	51990-0
175	\N	\N	f	status	78	DiagnosticReport	2024-03-30 04:52:21.763	5099951916665761693	7851490687183160034	-9206743552120168165	1897687856213184221	http://hl7.org/fhir/diagnostic-report-status	final
176	\N	\N	f	code	79	Observation	2024-03-30 04:53:53.703	2255293283549704696	3544617184093811114	-1788853872121592387	-3876769170373495391	http://loinc.org	2947-0
177	\N	\N	f	status	79	Observation	2024-03-30 04:53:53.703	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
178	\N	\N	f	combo-code	79	Observation	2024-03-30 04:53:53.703	-1575406001252496924	-7445927209719109166	-5876468539955411063	4171337606893745956	http://loinc.org	2947-0
179	\N	\N	f	combo-code	80	Observation	2024-03-30 04:54:42.536	-1575406001252496924	-7445927209719109166	91119742187291174	-78234795385865469	http://loinc.org	6298-4
180	\N	\N	f	status	80	Observation	2024-03-30 04:54:42.536	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
181	\N	\N	f	code	80	Observation	2024-03-30 04:54:42.536	2255293283549704696	3544617184093811114	-4071821029768209656	936739095624186166	http://loinc.org	6298-4
182	\N	\N	f	code	81	Observation	2024-03-30 04:55:23.364	2255293283549704696	3544617184093811114	7792770155190827789	-8896485680262186004	http://loinc.org	2069-3
183	\N	\N	f	combo-code	81	Observation	2024-03-30 04:55:23.364	-1575406001252496924	-7445927209719109166	5940902253636578356	1766709432338592481	http://loinc.org	2069-3
184	\N	\N	f	status	81	Observation	2024-03-30 04:55:23.364	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
185	\N	\N	f	code	82	Observation	2024-03-30 04:56:04.597	2255293283549704696	3544617184093811114	-112261398086944301	-1560285381393271579	http://loinc.org	20565-8
186	\N	\N	f	status	82	Observation	2024-03-30 04:56:04.597	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
187	\N	\N	f	combo-code	82	Observation	2024-03-30 04:56:04.597	-1575406001252496924	-7445927209719109166	-3076037516691539261	5601872151582180511	http://loinc.org	20565-8
188	\N	\N	f	code	83	Observation	2024-03-30 04:56:47.414	2255293283549704696	3544617184093811114	-112261398086944301	-1560285381393271579	http://loinc.org	20565-8
189	\N	\N	f	status	83	Observation	2024-03-30 04:56:47.414	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
190	\N	\N	f	combo-code	83	Observation	2024-03-30 04:56:47.414	-1575406001252496924	-7445927209719109166	-3076037516691539261	5601872151582180511	http://loinc.org	20565-8
191	\N	\N	f	code	84	Observation	2024-03-30 04:57:28.702	2255293283549704696	3544617184093811114	2189867948587183750	5968531095411028704	http://loinc.org	38483-4
192	\N	\N	f	combo-code	84	Observation	2024-03-30 04:57:28.702	-1575406001252496924	-7445927209719109166	434831649408467545	-8495183398571991275	http://loinc.org	38483-4
193	\N	\N	f	status	84	Observation	2024-03-30 04:57:28.702	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
194	\N	\N	f	code	85	Observation	2024-03-30 04:58:13.109	2255293283549704696	3544617184093811114	-7397961021207069228	4789830672868367348	http://loinc.org	49765-1
195	\N	\N	f	combo-code	85	Observation	2024-03-30 04:58:13.109	-1575406001252496924	-7445927209719109166	3025155936532492177	2166745986655077303	http://loinc.org	49765-1
196	\N	\N	f	status	85	Observation	2024-03-30 04:58:13.109	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
197	\N	\N	f	code	86	Observation	2024-03-30 04:58:53.964	2255293283549704696	3544617184093811114	-3880569354711826241	2043706721353938912	http://loinc.org	2339-0
198	\N	\N	f	status	86	Observation	2024-03-30 04:58:53.964	7375858673047561080	9061685838912626732	-3233906697319870894	4065983036873278523	http://hl7.org/fhir/observation-status	final
199	\N	\N	f	combo-code	86	Observation	2024-03-30 04:58:53.964	-1575406001252496924	-7445927209719109166	3790279195787844590	4401825082380038523	http://loinc.org	2339-0
200	\N	\N	f	code	87	DiagnosticReport	2024-03-30 05:00:46.183	-3916981602437818560	2594497875333274272	3319050714030799406	6768056423286483180	http://loinc.org	51990-0
201	\N	\N	f	status	87	DiagnosticReport	2024-03-30 05:00:46.183	5099951916665761693	7851490687183160034	-9206743552120168165	1897687856213184221	http://hl7.org/fhir/diagnostic-report-status	final
264	\N	\N	f	code	5	ServiceRequest	2024-03-30 18:06:44.473	2834087348067369440	395797913585979755	-1877627185004940373	1355901946891737699	http://loinc.org	100898-6
265	\N	\N	f	code	6	ServiceRequest	2024-03-30 18:07:36.645	2834087348067369440	395797913585979755	6484869485695654743	8659420766132094040	http://loinc.org	51990-0
266	\N	\N	f	code	56	ServiceRequest	2024-03-30 18:08:24.163	2834087348067369440	395797913585979755	-1877627185004940373	1355901946891737699	http://loinc.org	100898-6
267	\N	\N	f	code	57	ServiceRequest	2024-03-30 18:09:06.624	2834087348067369440	395797913585979755	-1877627185004940373	1355901946891737699	http://loinc.org	100898-6
268	\N	\N	f	code	58	ServiceRequest	2024-03-30 18:09:53.003	2834087348067369440	395797913585979755	6484869485695654743	8659420766132094040	http://loinc.org	51990-0
269	\N	\N	f	code	59	ServiceRequest	2024-03-30 18:21:32.889	2834087348067369440	395797913585979755	6484869485695654743	8659420766132094040	http://loinc.org	51990-0
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
3	http://ehealthontario.ca/fhir/StructureDefinition/ca-on-lab-profile-Encounter|2.0.0	\N	https://github.com/hapifhir/hapi-fhir/ns/jpa/profile	1	\N	\N
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

SELECT pg_catalog.setval('public.seq_reslink_id', 301, true);


--
-- Name: seq_resource_history_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_resource_history_id', 201, true);


--
-- Name: seq_resource_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_resource_id', 201, true);


--
-- Name: seq_resparmpresent_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_resparmpresent_id', 1, false);


--
-- Name: seq_restag_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_restag_id', 151, true);


--
-- Name: seq_search; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_search', 201, true);


--
-- Name: seq_search_inc; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_search_inc', 1, false);


--
-- Name: seq_search_res; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_search_res', 201, true);


--
-- Name: seq_spidx_coords; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_coords', 1, false);


--
-- Name: seq_spidx_date; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_date', 201, true);


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

SELECT pg_catalog.setval('public.seq_spidx_string', 351, true);


--
-- Name: seq_spidx_token; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.seq_spidx_token', 301, true);


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

SELECT pg_catalog.setval('public.seq_tagdef_id', 51, true);


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

SELECT pg_catalog.lo_open('17209', 131072);
SELECT pg_catalog.lowrite(0, '\x3f6973737565643d6765323032332d30312d30312670617469656e742e6269727468646174653d313935312d30312d30322670617469656e742e6964656e7469666965723d68747470253341253246253246656865616c74686f6e746172696f2e6361253246666869722532464e616d696e6753797374656d25324669642d7063722d65696425374332393233265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17210', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f69643d31302c372c382c39265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17211', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17213', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17216', 131072);
SELECT pg_catalog.lowrite(0, '\x3f6973737565643d6765323032332d30312d30312670617469656e742e6269727468646174653d313935312d30312d30322670617469656e742e6964656e7469666965723d68747470253341253246253246656865616c74686f6e746172696f2e6361253246666869722532464e616d696e6753797374656d25324669642d7063722d65696425374332393233265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17217', 131072);
SELECT pg_catalog.lowrite(0, '\x3f6973737565643d6765323032322d30312d30312670617469656e742e6269727468646174653d313935312d30312d30322670617469656e742e6964656e7469666965723d68747470253341253246253246656865616c74686f6e746172696f2e6361253246666869722532464e616d696e6753797374656d25324669642d7063722d65696425374332393233265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('17218', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f69643d31302c372c382c39265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('25398', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33590', 131072);
SELECT pg_catalog.lowrite(0, '\x3f6973737565643d6765323032322d30312d30312670617469656e742e6269727468646174653d313935312d30312d30322670617469656e742e6964656e7469666965723d68747470253341253246253246656865616c74686f6e746172696f2e6361253246666869722532464e616d696e6753797374656d25324669642d7063722d65696425374332393233265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33591', 131072);
SELECT pg_catalog.lowrite(0, '\x3f6973737565643d6765323032322d30312d30312670617469656e742e6269727468646174653d313935312d30312d30322670617469656e742e6964656e7469666965723d68747470253341253246253246656865616c74686f6e746172696f2e6361253246666869722532464e616d696e6753797374656d25324669642d7063722d65696425374332393233265f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33592', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33593', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
SELECT pg_catalog.lo_close(0);

SELECT pg_catalog.lo_open('33594', 131072);
SELECT pg_catalog.lowrite(0, '\x3f5f636f756e743d3230');
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

