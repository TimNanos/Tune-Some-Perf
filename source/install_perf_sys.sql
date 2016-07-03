CREATE TABLE table_1
(
  id NUMBER,
  value NUMBER
);

GRANT INSERT ON table_1 TO perf;

@perf_tests.pks
@perf_tests.pkb
@unit_tests.pks
@unit_tests.pkb
@reports.pks
@reports.pkb

GRANT EXECUTE ON reports TO perf;

EXIT
