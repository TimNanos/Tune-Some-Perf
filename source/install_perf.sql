@exercises.sql
GRANT EXECUTE ON exercise_1 TO perf_sys;
GRANT EXECUTE ON exercise_2 TO perf_sys;
CREATE SYNONYM reports FOR perf_sys.reports;
CREATE SYNONYM table_1 FOR perf_sys.table_1;
CREATE SYNONYM table_2 FOR perf_sys.table_2;
EXIT
