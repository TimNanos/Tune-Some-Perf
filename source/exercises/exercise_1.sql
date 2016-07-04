CREATE OR REPLACE PROCEDURE exercise_1 (pin_numberParameter IN NUMBER)
AS
/*
-- To get the results please run the following commands:

set serveroutput on
EXEC reports.report(1)

*/
BEGIN
  FOR i IN 1..100
  LOOP
    EXECUTE IMMEDIATE 'INSERT INTO table_1 (id, value) VALUES (' || TO_CHAR(i) || ', ' || TO_CHAR(pin_numberParameter) || ')';
    COMMIT;
  END LOOP;
END exercise_1;
/
