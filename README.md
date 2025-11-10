# Thesis_Tracker_db
SQL database for the DBMS Final Project (Group 2). Manages the thesis and research process.

## 📁 Database Code Architecture

This repository contains all SQL scripts required to build and test the database. The code is organized into a 2-phase implementation (schema, then relations) and includes seed data for testing.

```
/sql
├── 1_schema_tables
│   ├── dev1_01_users.sql
│   ├── dev1_02_faculty.sql
│   ├── dev2_01_groups.sql
│   ├── dev2_02_enrollments.sql
│   ├── dev3_01_proposals.sql
│   └── dev3_02_defenses.sql
│
├── 2_schema_relations
│   ├── dev1_relations.sql
│   ├── dev2_relations.sql
│   └── dev3_relations.sql
│
├── 3_seeds
│   ├── 01_users_data.sql
│   ├── 02_courses_data.sql
│   └── ...
│
└── Z_run_all.sql
```

### 📖 Folder Descriptions

* **`1_schema_tables`**: Contains all `CREATE TABLE` scripts. **No foreign keys** are defined here.
* **`2_schema_relations`**: Contains all `ALTER TABLE ... ADD FOREIGN KEY` scripts to connect the tables.
* **`3_seeds`**: Contains `INSERT` scripts to populate the database with "dummy" test data.
* **`Z_run_all.sql`**: The master script that runs all the above files in the correct order to build the entire database from scratch.
