/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE perf_tests AS 

  FUNCTION run_perf_test(pii_excerciseID IN PLS_INTEGER)
  RETURN NUMBER;
  
END perf_tests; 
/ 
