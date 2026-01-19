-- 1. DATABASE INITIALIZATION
DROP DATABASE IF EXISTS Thesis_Tracker_db;
CREATE DATABASE Thesis_Tracker_db;
USE Thesis_Tracker_db;

-- 2. PHASE 1: SCHEMA TABLES (Building the "Rooms")
-- These files create all primary tables without foreign keys.
SOURCE 1_schema_tables/dev1_users_and_setup.sql;
SOURCE 1_schema_tables/dev2_groups_and_proposals.sql;
SOURCE 1_schema_tables/dev3_workflow_and_final.sql;

-- 3. PHASE 2: SCHEMA RELATIONS (Building the "Hallways")
-- These files add foreign key constraints and establish connections.
SOURCE 2_schema_relations/dev1_relations.sql;
SOURCE 2_schema_relations/dev2_relations.sql;
SOURCE 2_schema_relations/dev3_relations.sql;

-- 4. PATCHES (System Extensions)
-- These files add specific modules like academic blocks and committee oversight.
SOURCE patch/blocks.sql;
SOURCE patch/committee.sql;

-- 5. PHASE 3: SEEDS (Dummy Data)
-- These files populate the database with test data for development.
SOURCE 3_seeds/01_seed_users.sql;
SOURCE 3_seeds/02_seed_courses.sql;
SOURCE 3_seeds/03_seed_groups.sql;
SOURCE 3_seeds/04_workflow_seed.sql;
