use mysql_kty2;

drop table naver_member;
create table naver_member(
	n_id varchar(20),
    n_password varchar(16)not null,
    n_name varchar(10)not null,
    n_birth date not null,
    n_gender varchar(10)not null,
    n_emil varchar(30),
    n_phon varchar(20)not null,
    constraint primary key (n_id)
);

insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_emil,  n_phon)
	values('태영','123','김태영',str_to_date('1997-03-03','%Y-%m-%d'),'남자','aaa@aaa.com','010-0000-0000');
select*from naver_member;

drop table naver_board;
create table naver_board(
	b_number int auto_increment,
    b_title varchar(30) not null,
    b_writer varchar(20)not null,
    b_contrnts varchar(200),
    b_date datetime not null,
    b_like int default 0,
    b_hits int default 0,
    b_category varbinary(30) not null,
    constraint primary key(b_number),
    constraint foreign key(b_writer) references naver_member(n_id) on delete cascade
);
insert into naver_board( b_title, b_writer, b_contrnts, b_date, b_category)
	values('오늘 저녁은 집밥','태영','집에서 밥먹어야지',now(),'출석체크');
select * from naver_board;

drop table naver_comment;
create table naver_comment(
	c_number int auto_increment, -- auto_increment: 자동 번호를 입력해줌
	c_writer varchar(20) not null,
    c_date datetime not null,
    c_contents varchar(200) not null,
    b_number int not null,
    constraint primary key(c_number),
    constraint foreign key(c_writer) references naver_member(n_id) on delete cascade,
    constraint foreign key(b_number) references naver_board(b_number) on delete cascade
);

insert into  naver_comment(c_writer, c_date, c_contents, b_number)
	values('태영',now(),'댓글내용1',1);
select * from naver_comment;

drop table naver_category;
create table naver_category(
	c_number int auto_increment,
    c_name varchar(30),
    constraint primary key(c_number)
);
select * from naver_category;
    
    -- ------------------------------------------------------
    
select * from naver_member;

insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_emil,  n_phon)
    values('태영','123','김태영',str_to_date('1997-03-03','%Y-%m-%d'),'남자','aaa@aaa.com','010-0000-0000');
insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_emil,  n_phon)
    values('태영1','1234','김태영1',str_to_date('1998-04-04','%Y-%m-%d'),'여자','bbb@bbb.com','010-2222-2222');
    -- 회원 로그인
select * from naver_member where n_id='태영' and n_password='123';
	-- 상세정보 조회
select * from naver_member where n_id='태영';
	-- 전체 회원목록 조회
select * from naver_member;
	-- 2 회원 비밀번호 변경
update naver_member set n_password='12345' where n_id='태영1';
	-- 회원 탈퇴
delete from naver_member where n_id='태영';
	-- 신규회원 하나 추가
insert into naver_member(n_id, n_password, n_name, n_birth, n_gender, n_emil,  n_phon)
    values('태영2','123456','김태영2',str_to_date('1999-05-05','%Y-%m-%d'),'남자2','ccc@ccc.com','010-3333-3333');
select * from naver_member;
	-- 카테고리는 자유게시판, 공지사항 두가지만 있다고 가정
select * from naver_category;
insert into naver_category(c_name) values('자유게시판');
insert into naver_category(c_name) values('공지사항');   
    -- 게시판 관련
select* from naver_board;
insert into naver_board(b_title, b_writer, b_contrnts, b_date, b_category)
	values('제목1','태영','내용내용1',now(),'1');
insert into naver_board(b_title, b_writer, b_contrnts, b_date, b_category)
	values('제목3','태영','내용내용3',now(),'1');
    -- 회원 게시글 작성
insert into naver_board(b_title, b_writer, b_contrnts, b_date, b_category)
	values('제목4','id1','내용내용4',now(),2);
insert into naver_board(b_title, b_writer, b_contrnts, b_date, b_category)
	values('제목2','id3','내용내용2',now(),2);
    -- 전체 게시글 목록 출력
    -- 조회수 순으로 전체 게시글 목록 출력
    -- 작성일자 순으로 전체 게시글 목록 출력
select *from naver_board order by b_date desc;
select b_number, b_title, b_writer, b_date, b_hits, b_like from naver_board order by b_date desc;
	-- 자유 게시판 글만 출력
select *from naver_board where b_category=1 order by b_date desc;
	-- 상세조회시 조회수 증가
update naver_board set b_hits=b_hits+1 where b_number=2;
select *from naver_board where b_number=2;
	-- 1회원이 본인 작성 게시글 내용 수정
update naver_board set b_contents='수정내용입니다.' where b_number=1;
    -- 두번째로 작성된(글번호 2) 게시글 삭제
delete from naver_board where b_number=4;
	-- 댓글관련
    -- 1회원이 1번 게시글에 갯글 작성
select * from naver_comment;
insert into naver_comment(c_writer, c_date, c_contents, b_number)
	values('id1',now(),'댓글내용1',1);
    -- 3회원이 1번,2번 게시글에 댓글 각각 작성
insert into naver_comment(c_writer, c_date, c_contents, b_number)
	values('id3',now(),'댓글내용2',1);
insert into naver_comment(c_writer, c_date, c_contents, b_number)
	values('id3',now(),'댓글내용2',2);
    -- 1번 게시글에 대한 댓글 목록 출력
select * from naver_comment where b_number=1;
    -- 2번 게시글에 대한 댓글 목록 출력
select * from naver_comment where b_number=2;
    
    
-- 컬럼 추가, 삭제 등
select * from naver_member;
-- 회원 주소를 저장할 컬럼 필요
-- n_address values(50) 있다 치고
alter table naver_member add n_address varchar(50);
-- 컬럼 이름 변경
alter table naver_member change n_address n_add varchar(50);
-- 컬럼의 타입이나 크기 변경
alter table naver_member modify n_add varchar(100);
alter table naver_member modify n_password varchar(30);
desc naver_member;
-- 컬럼 삭제
alter table naver_member drop n_add;

-- db 쿼리 카테고리 정리
/*
	1. DDL: create(테이블, 사용자), alter(테이블 구조변경할때), drop(테이블 삭제할때)
    2. DML: insert, select, update, delete
    3. DCL: grant, revoke, commt, rollback
    commit: DB에 쿼리 수행결과를 완전히 반영하는 것
    rollback: commit 이후 수행한 내용을 되돌림
    DDL, DCL: commit이 같이 수행됨.
    commit - commit : transaction(트랜잭션)
*/
drop table test1;
create table test1(
	col1 varchar(10),
    col2 varbinary(20)
);
insert into test1(col1,col2) values('aa','aa');
select * from test1;
commit;
rollback;
select @@autocommit; -- 1:autocommit
set autocommit = false; -- 하기 싫을때 코드
set autocommit = true;

















    
    
    
    
    
    
    
    