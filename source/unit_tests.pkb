/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE BODY unit_tests AS

-- Excercise 1

  FUNCTION unit_test_1
  RETURN PLS_INTEGER
  AS
    result PLS_INTEGER := 0;
    ln_numberToInsert NUMBER;
    li_countRows PLS_INTEGER;
  BEGIN
    ln_numberToInsert := DBMS_RANDOM.NORMAL;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE table_1';

    EXECUTE IMMEDIATE 'BEGIN perf.excercise_1( :n ); END;'
    USING ln_numberToInsert;

    SELECT COUNT(*)
      INTO li_countRows
      FROM (SELECT ROWNUM as id,
                   ln_numberToInsert as value
              FROM dual
           CONNECT BY ROWNUM <= 100
           ) t_corr1
      FULL OUTER JOIN table_1 t_exc1
        ON t_exc1.id = t_corr1.id
       AND t_exc1.value = t_exc1.value
     WHERE DECODE(t_exc1.id, t_corr1.id, 1, 0) = 0
        OR DECODE(t_exc1.value, t_corr1.value, 1, 0) = 0;

    IF li_countRows = 0 THEN
      result := 1;
    END IF;

    RETURN result;
  END unit_test_1;


-- Tests engine

  FUNCTION run_unit_test(pii_excerciseID IN PLS_INTEGER)
  RETURN BOOLEAN
  AS
    li_unitTestResult PLS_INTEGER;
    result BOOLEAN := FALSE;
  BEGIN
    ROLLBACK;

    CASE pii_excerciseID
      WHEN 1 THEN
        li_unitTestResult := unit_test_1;
      ELSE li_unitTestResult := 0;
    END CASE;

    IF li_unitTestResult = 1 THEN
      result := TRUE;
    END IF;
    
    RETURN result;
  END run_unit_test;

END unit_tests;
/ 
