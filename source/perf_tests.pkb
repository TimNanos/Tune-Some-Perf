/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE BODY perf_tests AS

  FUNCTION run_perf_test(pii_excerciseID IN PLS_INTEGER)
  RETURN NUMBER
  AS
    ln_startTime NUMBER;
    ln_originalProcedure NUMBER := 0;
    ln_bestPossibleProcedure NUMBER := 0;
    ln_excercise NUMBER := 0;
  BEGIN
    FOR i IN 1..1000
    LOOP
      -- run the original procedure
      ln_startTime := DBMS_UTILITY.GET_TIME;
      -- TODO
      ln_originalProcedure := ln_originalProcedure + DBMS_UTILITY.GET_TIME - ln_startTime;
      
      -- run the best possible procedure
      ln_startTime := DBMS_UTILITY.GET_TIME;
      -- TODO
      ln_bestPossibleProcedure := ln_bestPossibleProcedure + DBMS_UTILITY.GET_TIME - ln_startTime;

      -- run the excercise
      ln_startTime := DBMS_UTILITY.GET_TIME;
      -- TODO
      ln_excercise := ln_excercise + DBMS_UTILITY.GET_TIME - ln_startTime;
    END LOOP;
  END run_perf_test;

END perf_tests; 
/ 
