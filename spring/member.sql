use spring_kty2;

create table members(
	m_number bigint auto_increment,
    m_id varchar(20),
    m_pw int,
    m_name varchar(20),
    m_email varchar(20),
    m_phone int,
	constraint primary key(m_number));
    
    -- insert into trainee(t_name,t_age,t_phone,t_gender,t_birth,t_assress)
    -- values()
    
    select * from members;
    -- 두번째 훈련생에 대한 정보만 조최할 때 쿼리는?
    	select * from members where t_number=2;
        
        delete  from members where t_number=?;
        -- 전화번호, 주소를 수정하는 쿼리
        update members set t_phone ='010-1111-2222', t_assress='제주도' where t_number=18;
    