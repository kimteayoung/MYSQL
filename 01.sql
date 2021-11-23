-- database
-- tesr211101 이라는 database 생성
create database tesr211101;
-- tesr211101 database 사용
use tesr211101;
-- student 테이블 생성
-- 컬럼은 이름(문자), 학번(문자), 나이(숫자)
-- 컬럼 정의: 이름:(student_name): 문자, 최대5자
--          학번(student_number): 문자, 최대8자
--          나이(student_age): 숫자, 최대 3자
drop table student;
create table student(
student_name varchar(5),
student_number varchar(8),
student_age int
);
-- 하나의 데이터베이스 안에서 같은 이름의 테이블이 2개일 수 없음.
-- 테이블 조회
select * from student;
-- 테이블에 데이터 저장하기 (삽입)
insert into student(student_name, student_number, student_age)
   values('학생', '12345678', 20);
   
   