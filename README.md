You will find some Stored Proc for MySQL/ SQL

Almost all of the Stored Procedure here has a "DEFINER" you can Remove the "DEFINER" Clause 
or 
Grant Required Privileges to root@% (NOT RECOMMENDED ON PRODUCTION!!!)
Only do this if you want to allow root to connect from any host, which can be a security risk if not firewalled properly. -ChatGPT

code:::

CREATE USER 'root'@'%' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

