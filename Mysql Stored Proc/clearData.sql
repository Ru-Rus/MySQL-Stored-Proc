CREATE DEFINER=`root`@`%` PROCEDURE `clearData`()
BEGIN

  DECLARE tbl_name VARCHAR(120);
  DECLARE n INT;
  DECLARE done boolean;
  DECLARE msg TEXT;

  DECLARE `_rollback` BOOL DEFAULT 0;
  DECLARE cursor_i CURSOR FOR SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = 'your_database_name' AND TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME NOT IN (SELECT table_name FROM table_no_clear);
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cursor_i;
    read_loop: LOOP
    FETCH cursor_i INTO tbl_name;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SELECT COUNT(table_name) INTO n FROM table_no_clear WHERE table_name = tbl_name;
    IF n <= 0 THEN

      START TRANSACTION;
        SET msg = CONCAT(msg,'
Clear Table : ',tbl_name);
        SET @sql_text = CONCAT("DELETE FROM ",tbl_name);

        PREPARE stm FROM @sql_text;
        EXECUTE stm;
        DEALLOCATE PREPARE stm;
        SET msg = CONCAT(msg,'
',tbl_name,' Cleared.');
        SET msg = CONCAT(msg,'
Alter Table : ',tbl_name);
        SET @sql_text = CONCAT("ALTER TABLE ",tbl_name," AUTO_INCREMENT = 1");

        PREPARE stm FROM @sql_text;
        EXECUTE stm;
        DEALLOCATE PREPARE stm;
        SET msg = CONCAT(msg,'
',tbl_name,' Altered');
      IF `_rollback` THEN
        ROLLBACK;
      ELSE
        SET msg = CONCAT(msg,'
Error in : ',tbl_name);
        COMMIT;
      END IF;

    END IF;
  END LOOP;
  CLOSE cursor_i;
SELECT msg;
END