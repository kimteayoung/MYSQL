CREATE TABLE dept (
    deptno INT,
    dname VARCHAR(14),
    loc VARCHAR(13)
);


CREATE TABLE emp (
    empno INT,
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr INT,
    hiredate DATE,
    sal INT,
    comm INT,
    deptno INT
);


CREATE TABLE bonus (
    ename VARCHAR(10),
    job VARCHAR(9),
    sal INT,
    comm INT
);


CREATE TABLE salgrade (
    grade INT,
    losal INT,
    hisal INT
);
    

INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');    

INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902, str_to_date('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,str_to_date('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,str_to_date('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,str_to_date('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,str_to_date('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,str_to_date('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,str_to_date('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,str_to_date('13-7-87','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,str_to_date('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,str_to_date('8-9-1981','%d-%m-%Y'),1500,0,30);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,str_to_date('13-7-87','%d-%m-%Y'),1100,NULL,20);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,str_to_date('3-12-1981','%d-%m-%Y'),950,NULL,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,str_to_date('3-12-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,str_to_date('23-1-1982','%d-%m-%Y'),1300,NULL,10);
		 
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

-- pc를 껏다가 다시 접속하는 경우 database 사용 쿼리를 실행해야 함.
use mysql_kty;
-- 급여 중 최대 급여 조회
select max(sal) from emp; -- 금액중 가장 높은 금액
select max(ename) from emp; -- 알파벳중 가장 높은거
-- 급여 중 최소 급여 조회
select min(sal) from emp;
-- 급여 평균 조회
select avg(sal) from emp; -- 2073.2143
select round(avg(sal), 1) from emp; -- 2073.2 -- 소수자 몇부터 반올림 할것인가 1이면 소수점 둘째에서 반올림함
-- dual 테이블: 가상의 테이블로 여기서 뭘 가지고 오겠다는 것이 아니라 select 하는 내용만 보고싶을 때
select round(123.345, 2) from dual; -- 2073.2
select round(avg(sal), 2) from emp; -- 2073.21

-- 그룹핑(그룹화) 중복문 없애기
select * from emp;
select deptno from emp group by deptno;
-- 그룹화를 할 떄 조회 데이터는 그룹화를 수행한 컬럼을 주로 조회함.
-- select * from emp group by deptno; -- * = (x)
-- deptno를 기준으로 그룹화를 하고 부서별 평균 급여 조회
select deptno, avg(sal) from emp group by deptno;
select deptno, round(avg(sal),1) from emp group by deptno;
select deptno, round(avg(sal),1), count(empno) from emp group by deptno;

-- 직급별 평균급여, 사원수 조회
select job ,
round(avg(sal),1) as 평균급여,
count(empno) as '사원수'
from emp
group by job
order by job asc;

-- 부서별 (deptno) 로 그룹화를 하고 그 안에서 직급(job)별로 그룹화를 한 뒤 평균 급여, 사원수 조회
select job ,deptno,
round(avg(sal),1) as '평균급여',
count(empno) as '사원수'
from emp
group by deptno,job
order by deptno asc, job desc;

-- 그룹화를 하고 조건을 따지고 싶다면 
-- having절에 사용되는 조건은 집계함수
-- 부서번호를 기준으로 그룹화를 하고 드 안에서 job 으로 그룹화한 뒤 평균 급여가 2500인 것만 조회
-- 조회결과는 직급, 부서번호, 평균급여, 사원수를 조회하고 부서번호를 기준으로 오름차순, 직급을 기준으로 내림차순 정렬
select job ,deptno,
round(avg(sal),1) as '평균급여',
count(empno) as '사원수'
from emp
group by deptno,job
having avg(sal) >= 2500
order by deptno asc, job desc;
select *from emp order by deptno asc, job asc;


-- 급여가 3000이하인 사원을 대상으로
-- 부서번호를 기준으로 그룹화를 하고 드 안에서 job 으로 그룹화한 뒤 평균 급여가 2500인 것만 조회
-- 조회결과는 직급, 부서번호, 평균급여, 사원수를 조회하고 부서번호를 기준으로 오름차순, 직급을 기준으로 내림차순 정렬 
-- 1단계: 급여가 3000이하인 사원만 조회
select * from emp where sal<=3000;
-- 2단계: 급여가 3000이하인 사원을 부서번호로 1차 그룹핑, 직급으로 2차 그룹핑하고 
select job, deptno,round(avg(sal),1),count(empno) from emp where sal<= 3000 group by deptno, job; 
-- 3단계: 2단계에 평균급여가 2000이상인 조건 추가
select job, deptno, round(avg(sal),1), count(empno) from emp where sal<= 3000 group by deptno, job
having avg(sal)>= 2000;
-- 4단계: 3단계 조회 결과를 부서번호 오름차순, 직급 내임차순으로 정렬
select job, deptno, round(avg(sal),1), count(empno) from emp where sal<= 3000 group by deptno, job
having avg(sal)>= 2000 order by deptno,job desc;

/*
		연습문제 그룹화 단계별로해보기
        1. 부서별 평균급여, 최고급여, 최저급여, 사원수 조회(평균급여는 소수점 둘째자리에서 반올림)
        2. 직급별 사원수 조회(단3명 이상인 결과만 출력)
        3. 연도별 입사한 사원수 조회(조회결과 : 연도(yyyy), 사원수)
        3.1 위의 결과에서 각 연도별로 부서별 인사한 사원수 조회(조회결과 : 연도(yyyy), 부서번호, 사원수)
*/
select * from emp;
-- date 타입을 문자타입으로 표현할때 스트링으로 되있는것들을 문자타입으로표현
select date_format(hiredate, '%Y') from emp;
-- 1
select round(avg(sal),1), max(sal), min(sal), count(empno) from emp;
select deptno, round(avg(sal),1), max(sal), min(sal), count(empno) from emp group by deptno;
-- 2
select job, count(empno) from emp group by job;
select job, count(empno) from emp group by job having count(empno) >= 3;
-- 3
select hiredate from emp;
select date_format(hiredate, '%Y') from emp;
select date_format(hiredate, '%Y') from emp group by date_format(hiredate, '%Y');
select date_format(hiredate, '%Y') as '입사년도',count(empno)
from emp group by date_format(hiredate, '%Y');
-- 3.1
select date_format(hiredate, '%Y') as '입사년도',deptno,count(empno)
from emp group by date_format(hiredate, '%Y'), deptno;
        
-- join : 테이블 조인
-- 2개 이상의 테이블을 한번에 조회할 때 사용
select * from emp;
select * from dept;
-- 조인 조건 : 공통 컬럼이 있어야 조인 가능
select * from emp, dept where emp.deptno = dept.deptno;
select * from emp e, dept d where e.deptno = d.deptno;
-- select * from emp, dept; (x) 이렇게하면 하나하나 계속 조회됨
select empno, ename, job from emp e, dept d where e.deptno = d.deptno;
-- 공통컬럼을 select 할때는 어떤테이블의 컬럼인지를 정확하게 지정해야함.
select empno, ename, job, deptno from emp e, dept d where e.deptno = d.deptno;
select e.empno, e.ename, e.job, d.deptno, d.dname 
	from emp as e, dept as d where e.deptno = d.deptno;
select e.*, d.* from emp as e, dept as d where e.deptno = d.deptno;

-- emp, dept 테이블을 조인하여 empno, ename, deptno, dname, loc 조회
-- (단, 급여가2500 이상인 사원만 조회하고, 조회결과는 deptno 기준으로 오름차순 정렬)
select e.empno, e.ename, d.deptno, d.dname,d.loc 
	from emp as e, dept as d where e.deptno = d.deptno and e.sal>=2500
    order by d.deptno asc;
    
-- sub query (서브쿼리)
select * from emp order by sal asc;
-- allen 보다 급여가 높은 사원 조회 
-- 1. allen 급여 확인 2. allen 급여보다 높은 사원 조회
select sal from emp where ename = 'allen';
select * from emp where sal > 1600;
-- 서브쿼리 이용
select * from emp where sal > (select sal from emp where ename = 'allen');
-- select * from emp where sal > (select * from emp where ename = 'allen'); (x)
-- select * from emp where sal > (select ename from emp where ename = 'allen') (x)alter

-- 급여를 가장 적게 받는 사원의 이름 조회
select min(sal) from emp; 
select ename from emp where sal= 800;
select ename from emp where sal=  (select min(sal) from emp);
-- 급여를 가장 많이 받는 사원의 이름 조회
select max(sal) from emp; 
select ename from emp where sal= 5000;
select ename from emp where sal=  (select max(sal) from emp);

/* 연습문제
	1. clark 보다 늦게 입사한 사원 조회
    2. 부서번호가 20인 사원 중에서 전체 사원 평균 급여보다 높은 급여를 받는 사원 조회
    3. 2번 조회 결과에서 부서이름, 부서위치도 함께 조회
*/
-- 1.
select hiredate from emp where ename = 'clark';
select ename from emp where hiredate < (select hiredate from emp where ename = 'clark');
-- 2.
select avg(sal) from emp;
select * from emp where deptno = '20';
select * from emp where sal>= (select avg(sal) from emp);
select * from emp where deptno ='20' and sal> (select avg(sal) from emp);
-- 3. 위랑 밑에랑 순서 바꿔도 상관 없음
-- dept, emp 테이블 조인
select * from emp as e, dept as d 
	where e.deptno = d.deptno and e.deptno = '20' and e.sal> (select avg(sal) from emp);
select * from emp as e, dept as d 
	where e.deptno = d.deptno and e.sal> (select avg(sal) from emp)and e.deptno = '20';

/*
	create table [테이블] (
		[컬럼명] [타입](크기),
        [컬럼명2]int
        [컬럼며우] [타입](크기),
        constraint [제약조건종류] [제약조건이름 필수는아님](제약조건 지정할 컬럼명)
	);
*/
/*
	제약조건
    1. primary key (주기, 유일키, pk): 테이블당 하나의 컬럼만 지정. 테이블에 저장된 데이터를 구분하는데 주로 사용.
									필수로 입력해야 하며(not null), 중복값은 허용하지 않음(unique).
        예) 회원테이블에서 아이디, 게시글테이블에서 글번호, 현실에서 주민등록번호 등
	2. foreign key (외래키, 참조키, fk): 2개의 테이블간 연관관계 지정시 사용. 참조하고자 하는 테이블의 pk를 지정함.
    3. not null: 해당 컬럼에 값을 필수로 입력해야 함.
    4. unique: 중복값을 허용하지 않음.
    
*/
create table trainee1(
	t_id varchar(20),
    t_name varchar(5),
    t_age int,
    t_birth date,
    t_phone varchar(20),
    t_email varchar(30),
    constraint primary key pk_trainee1(t_id)
    
);
-- now(): 현재시간을 사용할 때
insert into trainee1(t_id,t_name,t_age,t_birth,t_phone,t_email)
	values ('id1','이름1',20,now(),'010-1111-1111','aaa@aaa.com');
    -- pk로 지정한 t_id 컬럼에 같은 값을 삽입하면
insert into trainee1(t_id,t_name,t_age,t_birth,t_phone,t_email)
	values ('id1','이름1',20,now(),'010-1111-1111','aaa@aaa.com');
	-- pk로 지정한 t_id 컬럼에 null을 삽입하면
insert into trainee1(t_id,t_name,t_age,t_birth,t_phone,t_email)
	values (null,'이름1',20,now(),'010-1111-1111','aaa@aaa.com');
    
insert into trainee1(t_id,t_name,t_age,t_birth,t_phone,t_email)
	values ('id3',null,20,now(),null,'aaa@aaa.com');

select * from trainee1;
    
-- 현재 databade에 지정된 제약조건들 조회
select * from information_schema.table_constraints;
    
    
use mysql_kty;
-- 댓글
-- 필요정보: 작성자, 작성시간, 작성내용, 원글정보

constraint foreign key(b_number) references naver_category(c_number);

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
select * from naver_member;
select * from naver_board;

insert into  naver_comment(c_writer, c_date, c_contents, b_number)
	values('id',now(),'댓글내용1',1);
    
create table naver_category(
	c_number int auto_increment,
    c_name varchar(30),
    constraint primary key(c_name)
);
    
    
    
    
    
    
    
    
    
    
    
    

