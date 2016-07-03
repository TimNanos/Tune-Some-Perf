-- System objects

CREATE TABLE PERF_BENCHMARKS
(
  ID NUMBER,
  EXEC_TIME NUMBER
);

-- Excercise related objects

CREATE TABLE TABLE_1
(
  N NUMBER
);

GRANT INSERT ON TABLE_1 TO PERF;

@perf_tests.pks
@perf_tests.pkb
@unit_tests.pks
@unit_tests.pkb
@excercises.sql
EXIT
