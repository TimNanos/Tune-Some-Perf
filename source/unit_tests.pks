/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE unit_tests AS

  FUNCTION run_unit_test(pii_excerciseID IN PLS_INTEGER)
  RETURN BOOLEAN;

END unit_tests;
/
