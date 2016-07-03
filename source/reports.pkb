/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE BODY reports AS

  PROCEDURE p (piv_stringToPrint IN VARCHAR2)
  AS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(piv_stringToPrint);
  END p;


  PROCEDURE report (pii_excerciseID IN PLS_INTEGER)
  AS
    lv_stringToPrint VARCHAR2(200);
  BEGIN
    lv_stringToPrint := 'Excercise ' || TO_CHAR(pii_excerciseID) || '. Tests: ';

    IF unit_tests.run_unit_test(pii_excerciseID) THEN
      lv_stringToPrint := lv_stringToPrint || 'Pass. Performance score: ' || ROUND(perf_tests.run_perf_test(pii_excerciseID), 2) || '/10.';
    ELSE
      -- TODO add reinstall command
      lv_stringToPrint := lv_stringToPrint || 'FAIL. Please reinstall the excercise.';
    END IF;

    p(lv_stringToPrint);
  END report;


  PROCEDURE report
  AS
  BEGIN
    -- TODO report all excercises
    NULL;
  END report;
  
END reports;
/ 
