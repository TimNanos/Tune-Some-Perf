-- perf_sys user
CREATE USER perf_sys IDENTIFIED BY oracle;
-- perf_sys privileges
GRANT CREATE SESSION TO perf_sys;
GRANT CREATE TABLE TO perf_sys;
GRANT CREATE PROCEDURE TO perf_sys;
-- perf user
CREATE USER perf IDENTIFIED BY oracle;
-- perf_sys privileges
GRANT CREATE SESSION TO perf;
GRANT CREATE TABLE TO perf;
GRANT CREATE PROCEDURE TO perf;
EXIT
