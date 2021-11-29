create database spring_kty2;
create user spring_kty2@localhost identified by '1234';
grant all privileges on spring_kty2.* to spring_kty2@localhost;
select user();