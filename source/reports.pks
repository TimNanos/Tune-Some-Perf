/*
  Copyright 2016 Tim Nanos, timnanos.com
  Licensed under the Apache License, Version 2.0
*/


CREATE OR REPLACE PACKAGE reports AS 

  PROCEDURE report (pii_excerciseID IN PLS_INTEGER);

  PROCEDURE report;

END reports;
/ 
