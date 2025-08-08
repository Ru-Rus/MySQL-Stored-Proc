CREATE DEFINER=`root`@`%` FUNCTION `IsNumeric`(`val` VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    NO SQL
RETURN val REGEXP'^(-|\\+){0,1}([0-9]+\\.[0-9]*|[0-9]*\\.[0-9]+|[0-9]+)$'