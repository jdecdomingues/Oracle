CREATE OR REPLACE FUNCTION formatarCPF_CNPJ(Valor VARCHAR2)
   RETURN VARCHAR2
IS
   RESULT   VARCHAR2 (20);
BEGIN
   IF LENGTH (Valor) > 11
   THEN
      result :=
            SUBSTR (Valor, 1, 2)
         || '.'
         || SUBSTR (Valor, 3, 3)
         || '.'
         || SUBSTR (Valor, 6, 3)
         || '/'
         || SUBSTR (Valor, 9, 4)
         || '-'
         || SUBSTR (Valor, 13, 2);
   ELSE
      result :=
            SUBSTR (Valor, 1, 3)
         || '.'
         || SUBSTR (Valor, 4, 3)
         || '.'
         || SUBSTR (Valor, 7, 3)
         || '-'
         || SUBSTR (Valor, 10, 2);
   END IF;

   RETURN (RESULT);
END;
/
