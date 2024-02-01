--외래키 삭제
alter table department drop constraint department_manager_fk;
alter table employee drop constraint employee_deptno_fk;
alter table project drop constraint project_deptno_fk;
alter table works drop constraint works_projno_fk;
alter table works drop constraint works_empno_fk;

--테이블삭제
drop table department;
drop table employee;
drop table project;
drop table works;

--문제1) 테이블 생성
--1) department
create table department(
    deptno      number(2),
    deptname    varchar2(20),
    manager     number(4)
);

--2) employee
create table employee(
    empno       number(4),
    name        varchar2(20),
    phoneno     varchar2(20),
    address     varchar2(20),
    sex         char(3),
    position    varchar2(20),
    salary      number(7),
    deptno      number(2)
);

--3) project
create table project(
    projno      number(3),
    projname    varchar2(20),
    deptno      number(2)
);

--4) works
create table works(
    projno      number(3),
    empno       number(4),
    hoursworked number(3)
);

--제약조건
--문제2)기본키
alter table department add constraint department_deptno_pk primary key(deptno);
alter table employee add constraint employee_empno_pk primary key(empno);
alter table project add constraint project_projno_pk primary key(projno);
alter table works add constraint works_empno_projno_pk primary key(empno,projno); 

--문제3)외래키
alter table department add constraint department_manager_fk
    foreign key(manager) references employee(empno);
alter table employee add constraint employee_deptno_fk
    foreign key(deptno) references department(deptno);
alter table project add constraint project_deptno_fk
    foreign key(deptno) references department(deptno);
alter table works add constraint works_projno_fk
    foreign key(projno) references project(projno);
alter table works add constraint works_empno_fk
    foreign key(empno) references employee(empno);
    
--문제4) 도메인 제약조건
--1.1. Employee.sex ‘남’ or ‘여’의 값만을 저장할 수 있다. 
alter table employee add constraint employee_sex_ck check( sex in('남','여') );
--1.2. Works.hoursworked 컬럼은 양수값만 저장할 수 있다.
alter table works add constraint employee_hoursworked_ck check (hoursworked > 0);
--1.3. Employee.name, Department.deptname, Project.projname는 필수값을 갖는다.
alter table employee modify name not null;
alter table department modify deptname not null;
alter table project modify projname not null;
--1.4. Department.deptname는 중복이 없어야한다.
alter table department add constraint department_deptname_uk unique(deptname);
--1.5. employee.salary의 기본값은 0 이다.
alter table employee modify salary default 0;

--문제5)
drop sequence employee_empno_seq;
create sequence employee_empno_seq start with 1001;

--문제6) 데이터 insert
--샘플 데이터 생성
insert into department (deptno, deptname) values (10, '전산팀');
insert into department (deptno, deptname) values (20, '회계팀');
insert into department (deptno, deptname) values (30,'영업팀');
insert into department (deptno, deptname) values (40, '총무팀');
insert into department (deptno, deptname) values (50,'인사팀');

insert into project values (101, '빅데이터구축', 10);
insert into project values (102, 'IFRS', 20);
insert into project values (103, '마케팅', 30);

insert into employee values (employee_empno_seq.nextval,'홍길동1','010-111-1001','울산1','남','팀장',7000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동2','010-111-1002','울산2','남','팀원1',4000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동3','010-111-1003','울산3','남','팀원2',3000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동4','010-111-1004','부산1','여','팀장',6000000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동5','010-111-1005','부산2','남','팀원1',3500000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동6','010-111-1006','부산3','남','팀원2',2500000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동7','010-111-1007','서울1','남','팀장',5000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동8','010-111-1008','서울2','남','팀원1',4000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동9','010-111-1009','서울3','남','팀원2',3000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동10',null,'서울4','남','팀원3',2000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동11','010-111-1011','대구1','여','팀장',5500000,40);
insert into employee values (employee_empno_seq.nextval,'홍길동12','010-111-1012','대구2','남','팀원1',2000000,40);
insert into employee values (employee_empno_seq.nextval,'홍길동13','010-111-1013','제주1','남','팀장',6500000,50);
insert into employee values (employee_empno_seq.nextval,'홍길동14','010-111-1014','제주2','남','팀원1',3500000,50);

insert into works values (101, 1001, 800);
insert into works values (101, 1002, 400);
insert into works values (101, 1003, 300);
insert into works values (102, 1004, 700);
insert into works values (102, 1005, 500);
insert into works values (102, 1006, 200);
insert into works values (103, 1007, 500);
insert into works values (103, 1008, 400);
insert into works values (103, 1009, 300);
insert into works values (103, 1010, 200);
commit;

select * from employee;
