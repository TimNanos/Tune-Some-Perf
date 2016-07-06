/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE perf_tests AS 

  FUNCTION run_perf_test (pii_exerciseID IN INTEGER)
  RETURN NUMBER;

  PROCEDURE best_exercise_1 (pin_numberParameter IN NUMBER);

  PROCEDURE best_exercise_2 (pin_numberParameter IN NUMBER);

END perf_tests; 
/ 
