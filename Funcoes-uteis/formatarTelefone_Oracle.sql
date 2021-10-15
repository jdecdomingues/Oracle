CREATE OR REPLACE FUNCTION FORMATA_FONE( TELEFONE IN VARCHAR2 )
   RETURN VARCHAR2 IS
   /************************************************************************************************
   BANCO DE DADOS: ORACLE
   OBJETIVO..: Recebe uma string de telefone e formata nos padrões de telefone mais comuns. i.e.: +55 (34) 99154-6285

   PARAMETROS DE ENTRADA:
            TELEFONE: string de telefone sem formatação que se deseja formatar

   EXEMPLO DE USO: SELECT FORMATA_FONE( '08009402121' ) FROM DUAL
   *************************************************************************************************/

   P_FONE      VARCHAR2( 400 );
   P_TAMANHO   INT;
BEGIN
   P_FONE := REPLACE( TELEFONE, ' ', '' );
   P_TAMANHO := LENGTH( P_FONE );

   IF P_FONE IS NULL THEN
      P_FONE := 'FONE VAZIO';
   ELSIF P_TAMANHO NOT IN (8, 9, 10, 11, 12, 13) THEN
      P_FONE := 'FONE INVÁLIDO';
   ELSIF P_TAMANHO = 13 THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{2})(\d{2})(\d{5})(\d{4})', '+\1 (\2) \3-\4' );
   ELSIF P_TAMANHO = 12 THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{2})(\d{2})(\d{4})(\d{4})', '+\1 (\2) \3-\4' );
   ELSIF P_TAMANHO = 11
         AND SUBSTR( P_FONE, 1, 4 ) IN ('0800', '0900', '0300') THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{4})(\d{3})(\d{4})', '\1-\2-\3' );
   ELSIF P_TAMANHO = 11 THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{2})(\d{5})(\d{4})', '(\1) \2-\3' );
   ELSIF P_TAMANHO = 10 THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{2})(\d{4})(\d{4})', '(\1) \2-\3' );
   ELSIF P_TAMANHO = 9 THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{5})(\d{4})', '\1-\2' );
   ELSIF P_TAMANHO = 8 THEN
      P_FONE := REGEXP_REPLACE( P_FONE, '(\d{4})(\d{4})', '\1-\2' );
   END IF;

   RETURN P_FONE;
END;
/
