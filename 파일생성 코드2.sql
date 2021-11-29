create database mysql_kty2;
create user user_kty2@localhost identified by '1234';
grant all privileges on mysql_kty2.*to user_kty2@localhost;
select user();
