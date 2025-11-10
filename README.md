# Thesis_Tracker_db
SQL database for the DBMS Final Project (Group 2). Manages the thesis and research process.

## 📁 Database Code Architecture

Our database is built using a **2-phase implementation** to ensure stability and allow for parallel development. The code is organized as follows:

```
/sql
├── 1_schema_tables
│   ├── dev1_users_and_setup.sql
│   ├── dev2_groups_and_proposals.sql
│   └── dev3_workflow_and_final.sql
│
├── 2_schema_relations
│   ├── dev1_relations.sql
│   ├── dev2_relations.sql
│   └── dev3_relations.sql
│
├── 3_seeds
│   ├── 01_seed_users.sql
│   ├── 02_seed_courses.sql
│   └── 03_seed_groups.sql
│
└── Z_run_all.sql
```

### 📖 Folder Descriptions

* **`1_schema_tables` (Phase 1)**
    * **Purpose:** Contains all `CREATE TABLE` scripts.
    * **Rule:** **No foreign keys** are defined in this phase. This builds the "rooms."

* **`2_schema_relations` (Phase 2)**
    * **Purpose:** Contains all `ALTER TABLE ... ADD FOREIGN KEY` scripts.
    * **Rule:** This connects the tables *after* they all exist. This builds the "hallways."

* **`3_seeds`**
    * **Purpose:** Contains `INSERT` scripts to populate the database with "dummy" test data for the frontend and backend teams.

* **`Z_run_all.sql`**
    * **Purpose:** The **master script**. This single file runs all scripts from the other folders in the correct order to build the entire database from scratch.