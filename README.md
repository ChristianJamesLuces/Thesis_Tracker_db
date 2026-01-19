# Thesis_Tracker_db
SQL database for the DBMS Final Project (Group 2). Manages the thesis and research process.

## 📁 Database Code Architecture

Our database is built using a **3-phase implementation** to ensure stability and allow for parallel development. The code is organized as follows:

```
/
├── uploads/                  # Active file directory (New proposals & manuscripts)
├── archive/                  # Permanent repository (Successfully defended research)
└── sql/                      # SQL Implementation Scripts
    ├── 1_schema_tables/      # Phase 1: Physical Table Creation
    │   ├── dev1_users_and_setup.sql
    │   ├── dev2_groups_and_proposals.sql
    │   └── dev3_workflow_and_final.sql
    │
    ├── 2_schema_relations/   # Phase 2: Foreign Key Implementation
    │   ├── dev1_relations.sql
    │   ├── dev2_relations.sql
    │   └── dev3_relations.sql
    │
    ├── 3_seeds/              # Phase 3: Dummy Data Population
    │   ├── 01_seed_users.sql
    │   ├── 02_seed_courses.sql
    │   ├── 03_seed_groups.sql
    │   └── 04_workflow_seed.sql
    │
    ├── patch/                # System Extensions & Modifications
    │   ├── blocks.sql        # Academic section & adviser setup
    │   └── committee.sql     # MOR review workflow & panel data
    │
    └── Z_run_all.sql         # Master Deployment Script    
```

### 📖 Folder Descriptions

* **`uploads` (File Directory)**
    * **Purpose:** Contains the physical files that are currently active in the system, such as new proposals, manuscripts, and required legal forms (Co-ownership, Tech Transfer).
    * **Rule:** These files are referenced by the `FilePath` column in the `Submissions` table.

* **`archive` (File Directory)**
    * **Purpose:** Stores the final, full manuscripts and abstracts of successfully defended research projects.
    * **Rule:** These files are referenced by the `ResearchArchive` table.

* **`1_schema_tables` (Phase 1)**
    * **Purpose:** Contains all `CREATE TABLE` scripts.
    * **Rule:** **No foreign keys** are defined in this phase. This builds the "rooms".

* **`2_schema_relations` (Phase 2)**
    * **Purpose:** Contains all `ALTER TABLE ... ADD FOREIGN KEY` scripts.
    * **Rule:** This connects the tables *after* they all exist. This builds the "hallways".

* **`3_seeds` (Phase 3)**
    * **Purpose:** Contains `INSERT` scripts to populate the database with "dummy" test data for the frontend and backend teams.
    * **Rule:** Files must be executed in order (01, 02, 03, 04).
      
* **`patch` (Phase 3)**
    * **Purpose:**Contains modular extensions and system modifications, such as academic section (Block) management and specialized committee review workflows.
    * **Rule:** Patch scripts must be executed after the core schema is established but before final seeding to ensure structural updates are available for dummy data.

* **`Z_run_all.sql` (Master Script)**
    * **Purpose:** The **master script**. This single file runs all scripts from the other folders in the correct order to build the entire database from scratch.
    * **Rule:** This is the only file you run to fully deploy the database.
