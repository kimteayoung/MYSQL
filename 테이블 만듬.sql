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
    
    -- insert into trainee(t_name,t_age,t_phone,t_gender,t_birth,t_assress)
    -- values()
    
    select * from trainee;
    -- 두번째 훈련생에 대한 정보만 조최할 때 쿼리는?
    	select * from trainee where t_number=2;
        
        delete  from trainee where t_number=?;
        -- 전화번호, 주소를 수정하는 쿼리
        update trainee set t_phone ='010-1111-2222', t_assress='제주도' where t_number=18;
    