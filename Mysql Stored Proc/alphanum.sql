CREATE DEFINER=`root`@`%` FUNCTION `alphanum`(str CHAR(255)) RETURNS char(255) CHARSET latin1
    DETERMINISTIC
BEGIN 
  DECLARE i, len SMALLINT DEFAULT 1; 
  DECLARE ret text DEFAULT ''; 
  DECLARE c VARCHAR(1); 
  SET len = CHAR_LENGTH( str ); 
  REPEAT 
    BEGIN 
      SET c = MID( str, i, 1 ); 
			
      IF c REGEXP '[[:alnum:][:space:]]' THEN 
        SET ret=CONCAT(ret,c); 
      END IF; 
			
      SET i = i + 1; 
    END; 
  UNTIL i > len END REPEAT; 
  RETURN ret; 
END