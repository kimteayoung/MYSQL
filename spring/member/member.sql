use spring_kty2;
drop table member_table;
create table member_table(
	m_number bigint auto_increment,
    m_id varchar(20),
    m_pw varchar(20),
    m_name varchar(20),
    m_email varchar(30),
    m_phone varchar(20),
	constraint primary key(m_number));
    
    
    select * from member_table;
    
	select * from member_table where m_id='aa' and m_pw='a';
    
    insert into member_table(m_id,m_pw,m_name,m_email,m_phone)
		values('bb','bb','bb','bb','bb');
    
    
    
    
    
    
    