create database mysql_kty;
create user user_kty@localhost identified by '1234';
grant all privileges on mysql_kty.* to user_kty@localhost;
select user();
