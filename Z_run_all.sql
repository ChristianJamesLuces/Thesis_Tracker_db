SET FOREIGN_KEY_CHECKS = 0;

SELECT 'PHASE 1: Creating tables...' AS 'Status';
SOURCE 1_schema_tables/dev1_users_and_setup.sql;

SET FOREIGN_KEY_CHECKS = 1;
SELECT '*** DATABASE BUILD v0.1 (Phase 1a) COMPLETE ***' AS 'Final Status';