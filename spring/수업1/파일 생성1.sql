create database spring_kty;
create user spring_kty@localhost identified by '1234';
grant all privileges on spring_kty.* to spring_kty@localhost;
select user();

