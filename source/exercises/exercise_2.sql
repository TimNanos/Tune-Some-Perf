CREATE OR REPLACE PROCEDURE exercise_2 (pin_numberParameter IN NUMBER)
AS
/*
-- To get the results please run the following commands:

set serveroutput on
EXEC reports.report(2)

*/
  lb_valueExists BOOLEAN;
BEGIN
  lb_valueExists := FALSE;

  -- Check if the pin_numberParameter value exists in the table
  FOR curs IN
  (
    SELECT t.value
      FROM table_2 t
     WHERE t.value <> NULL
  )
  LOOP
    IF curs.value = pin_numberParameter THEN
      lb_valueExists := TRUE;
    END IF;
  END LOOP;

  IF lb_valueExists = TRUE THEN
    -- If the value exists, delete it from the table
    DELETE FROM table_2 t
     WHERE t.value = pin_numberParameter;
  ELSIF lb_valueExists = FALSE THEN
    -- If the value does not exist, insert it into the table
    INSERT INTO table_2 VALUES (pin_numberParameter);
  END IF;

  COMMIT;

END exercise_2;
/
