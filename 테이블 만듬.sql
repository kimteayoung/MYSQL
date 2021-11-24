use spring_kty;

create table trainee(
	t_number bigint auto_increment,
    t_name varchar(20),
    t_age int,
    t_phone varchar(20),
    t_gender varchar(10),
    t_birth date,
    t_assress varchar(50),
    constraint primary key(t_number));