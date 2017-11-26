CREATE OR REPLACE PROCEDURE PASSWORD_CHECK (in_password IN VARCHAR2) IS
   co_digitarray CONSTANT STRING(10)     := '0123456789';
   co_one        CONSTANT SIMPLE_INTEGER := 1;
   co_errno      CONSTANT SIMPLE_INTEGER := -20501;
   co_errmsg     CONSTANT STRING(100)    := 'Password must contain a digit.';
   l_isdigit     BOOLEAN;
   l_len_pw      PLS_INTEGER;
   l_len_array   PLS_INTEGER;
BEGIN
   -- initialize variables
   l_isdigit := FALSE;
   l_len_pw := LENGTH(in_password);
   l_len_array := LENGTH(co_digitarray);
   <<check_digit>>
   FOR i IN co_one .. l_len_array
   LOOP
      <<check_pw_char>>
      FOR j IN co_one .. l_len_pw
      LOOP
         IF SUBSTR(in_password, j, co_one) = SUBSTR(co_digitarray, i, co_one) THEN
            l_isdigit := TRUE;
            GOTO check_other_things;
         END IF;
      END LOOP check_pw_char;
   END LOOP check_digit;
   <<check_other_things>>
   NULL;
   
   IF NOT l_isdigit THEN
      raise_application_error(co_errno, co_errmsg);
   END IF;
END password_check;
/