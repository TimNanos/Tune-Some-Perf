CREATE OR REPLACE PROCEDURE excercise_1 (pin_numberParameter IN NUMBER)
AS
BEGIN
  FOR i IN 1..100
  LOOP
    EXECUTE IMMEDIATE 'INSERT INTO TABLE_1(' || TO_CHAR(pin_numberParameter) || ')';
    COMMIT;
  END LOOP;
END excercise_1;
/
