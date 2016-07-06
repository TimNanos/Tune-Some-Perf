-- Exercise 1

CREATE TABLE table_1
(
  id NUMBER,
  value NUMBER
)
NOLOGGING;

GRANT INSERT ON table_1 TO perf;

-- Exercise 2

CREATE TABLE table_2_corr
  NOLOGGING
AS
SELECT (CASE WHEN DBMS_RANDOM.VALUE(0,2) > 1 THEN DBMS_RANDOM.NORMAL END) AS value
  FROM DUAL
CONNECT BY ROWNUM <= 1000;

-- CREATE INDEX ind_table_2_corr ON table_2_corr (value);

GRANT SELECT, INSERT, DELETE ON table_2_corr TO perf;

CREATE TABLE table_2
  NOLOGGING
AS
SELECT *
  FROM table_2_corr;

GRANT SELECT, INSERT, DELETE ON table_2 TO perf;

@perf_tests.pks
@perf_tests.pkb
@unit_tests.pks
@unit_tests.pkb
@reports.pks
@reports.pkb

GRANT EXECUTE ON reports TO perf;
EXIT
