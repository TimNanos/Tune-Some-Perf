/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE BODY unit_tests AS

  FUNCTION unit_test_1
  RETURN INTEGER
  AS
    result INTEGER := 0;
    ln_numberToCheck NUMBER;
    li_countRows INTEGER;
  BEGIN
    ln_numberToCheck := DBMS_RANDOM.NORMAL;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE table_1';

    EXECUTE IMMEDIATE 'BEGIN perf.exercise_1( :n ); END;'
    USING ln_numberToCheck;

    SELECT COUNT(*)
      INTO li_countRows
      FROM (SELECT ROWNUM AS id,
                   ln_numberToCheck AS value
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


  FUNCTION unit_test_2
  RETURN INTEGER
  AS
    result INTEGER := 0;
    ln_numberToCheck1 NUMBER;
    ln_numberToCheck2 NUMBER;
    li_countRows INTEGER;
  BEGIN

    EXECUTE IMMEDIATE 'TRUNCATE TABLE table_2';
    
    INSERT INTO table_2 (value)
    SELECT value
      FROM table_2_corr;

    COMMIT;

    -- Check a not existing random number
    ln_numberToCheck1 := 1 + DBMS_RANDOM.NORMAL;
    EXECUTE IMMEDIATE 'BEGIN perf.exercise_2( :n ); END;'
    USING ln_numberToCheck1;

    -- Check an existing number
    SELECT value
      INTO ln_numberToCheck2
      FROM table_2_corr
     WHERE value IS NOT NULL
       AND value <> ln_numberToCheck1
       AND ROWNUM <= 1;

    EXECUTE IMMEDIATE 'BEGIN perf.exercise_2( :n ); END;'
    USING ln_numberToCheck2;

    -- Do the same checks with the working procedure
    EXECUTE IMMEDIATE 'BEGIN perf_tests.best_exercise_2( :n ); END;'
    USING ln_numberToCheck1;

    EXECUTE IMMEDIATE 'BEGIN perf_tests.best_exercise_2( :n ); END;'
    USING ln_numberToCheck2;

    SELECT COUNT(*)
      INTO li_countRows
      FROM table_2_corr t_corr2
      FULL OUTER JOIN table_2 t_exc2
        ON t_exc2.value = t_exc2.value
     WHERE DECODE(t_exc2.value, t_corr2.value, 1, 0) = 0;

    IF li_countRows = 0 THEN
      result := 1;
    END IF;

    RETURN result;
  END unit_test_2;


-- Tests engine

  FUNCTION run_unit_test(pii_exerciseID IN INTEGER)
  RETURN BOOLEAN
  AS
    li_unitTestResult INTEGER;
    result BOOLEAN := FALSE;
  BEGIN
    ROLLBACK;
    
    CASE pii_exerciseID
      WHEN 1 THEN
        li_unitTestResult := unit_test_1;
      WHEN 2 THEN
        li_unitTestResult := unit_test_2;
      ELSE li_unitTestResult := 0;
    END CASE;

    IF li_unitTestResult = 1 THEN
      result := TRUE;
    END IF;
    
    RETURN result;
  END run_unit_test;

END unit_tests;
/ 
