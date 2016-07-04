/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE BODY perf_tests AS

  PROCEDURE best_exercise_1 (pin_numberParameter IN NUMBER)
  AS
  BEGIN
    INSERT INTO table_1 (id, value)
    SELECT ROWNUM,
           pin_numberParameter
      FROM DUAL
   CONNECT BY ROWNUM <= 100;

    COMMIT;
  END best_exercise_1;


  FUNCTION run_perf_test(pii_exerciseID IN INTEGER)
  RETURN NUMBER
  AS
    result NUMBER := 0;
    ln_startTime NUMBER;
    ln_bestPossibleProcedure NUMBER := 0;
    ln_exercise NUMBER := 0;
    ln_numberToCheck NUMBER;
  BEGIN
    FOR i IN 1..10000
    LOOP
      ln_numberToCheck := DBMS_RANDOM.NORMAL;

      -- run the best possible option
      ln_startTime := DBMS_UTILITY.GET_TIME;
      EXECUTE IMMEDIATE 'BEGIN perf_tests.best_exercise_' || TO_CHAR(pii_exerciseID) || '( :n ); END;'
      USING ln_numberToCheck;
      ln_bestPossibleProcedure := ln_bestPossibleProcedure + DBMS_UTILITY.GET_TIME - ln_startTime;

      -- run the exercise
      ln_startTime := DBMS_UTILITY.GET_TIME;
      EXECUTE IMMEDIATE 'BEGIN perf.exercise_' || TO_CHAR(pii_exerciseID) || '( :n ); END;'
      USING ln_numberToCheck;
      ln_exercise := ln_exercise + DBMS_UTILITY.GET_TIME - ln_startTime;

      -- Exit the loop if the check takes longer than 10 sec
      EXIT WHEN (ln_bestPossibleProcedure + ln_exercise) / 100 >= 10;
    END LOOP;

    IF ln_exercise = 0 THEN
      result := 100;
    ELSE
      result := ROUND((ln_bestPossibleProcedure / ln_exercise) * 100);
    END IF;

    RETURN result;
  END run_perf_test;

END perf_tests; 
/ 
