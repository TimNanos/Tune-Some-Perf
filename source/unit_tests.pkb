CREATE OR REPLACE PACKAGE BODY unit_tests AS

  FUNCTION run_unit_test(pii_excerciseID IN PLS_INTEGER)
  RETURN BOOLEAN
  AS
    li_unitTestResult PLS_INTEGER;
    result BOOLEAN := FALSE;
  BEGIN
    EXECUTE IMMEDIATE 'UNIT_TEST_' || TO_CHAR(pii_excerciseID)
    INTO li_unitTestResult;

    IF li_unitTestResult = 1 THEN
      result := TRUE;
    END IF;
  END run_unit_test;

  FUNCTION unit_test_1
  RETURN PLS_INTEGER
  AS
    result PLS_INTEGER := 0;
    ln_numberToInsert NUMBER;
    ln_insertedNumber NUMBER;
    li_countRows PLS_INTEGER;
  BEGIN
    ln_numberToInsert := DBMS_RANDOM.NORMAL;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE TABLE_1';

    PERF_EXCERCISE_1(ln_numberToInsert);

    BEGIN
      SELECT t.N,
             COUNT(*)
        INTO ln_insertedNumber,
             li_countRows
        FROM TABLE_1 t;
    EXCEPTION
        -- TODO fix to too_many_rows and No_Rows
      WHEN OTHERS THEN
        NULL;
    END;
    
    IF ln_numberToInsert = ln_insertedNumber AND li_countRows = 100 THEN
      result := 1;
    END IF;

    RETURN result;
  END unit_test_1;

END unit_tests;
/ 
