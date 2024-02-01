--�ܷ�Ű ����
alter table department drop constraint department_manager_fk;
alter table employee drop constraint employee_deptno_fk;
alter table project drop constraint project_deptno_fk;
alter table works drop constraint works_projno_fk;
alter table works drop constraint works_empno_fk;

--���̺����
drop table department;
drop table employee;
drop table project;
drop table works;

--����1) ���̺� ����
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

--��������
--����2)�⺻Ű
alter table department add constraint department_deptno_pk primary key(deptno);
alter table employee add constraint employee_empno_pk primary key(empno);
alter table project add constraint project_projno_pk primary key(projno);
alter table works add constraint works_empno_projno_pk primary key(empno,projno); 

--����3)�ܷ�Ű
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
    
--����4) ������ ��������
--1.1. Employee.sex ������ or �������� ������ ������ �� �ִ�. 
alter table employee add constraint employee_sex_ck check( sex in('��','��') );
--1.2. Works.hoursworked �÷��� ������� ������ �� �ִ�.
alter table works add constraint employee_hoursworked_ck check (hoursworked > 0);
--1.3. Employee.name, Department.deptname, Project.projname�� �ʼ����� ���´�.
alter table employee modify name not null;
alter table department modify deptname not null;
alter table project modify projname not null;
--1.4. Department.deptname�� �ߺ��� ������Ѵ�.
alter table department add constraint department_deptname_uk unique(deptname);
--1.5. employee.salary�� �⺻���� 0 �̴�.
alter table employee modify salary default 0;

--����5)
drop sequence employee_empno_seq;
create sequence employee_empno_seq start with 1001;

--����6) ������ insert
--���� ������ ����
insert into department (deptno, deptname) values (10, '������');
insert into department (deptno, deptname) values (20, 'ȸ����');
insert into department (deptno, deptname) values (30,'������');
insert into department (deptno, deptname) values (40, '�ѹ���');
insert into department (deptno, deptname) values (50,'�λ���');

insert into project values (101, '�����ͱ���', 10);
insert into project values (102, 'IFRS', 20);
insert into project values (103, '������', 30);

insert into employee values (employee_empno_seq.nextval,'ȫ�浿1','010-111-1001','���1','��','����',7000000,10);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿2','010-111-1002','���2','��','����1',4000000,10);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿3','010-111-1003','���3','��','����2',3000000,10);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿4','010-111-1004','�λ�1','��','����',6000000,20);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿5','010-111-1005','�λ�2','��','����1',3500000,20);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿6','010-111-1006','�λ�3','��','����2',2500000,20);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿7','010-111-1007','����1','��','����',5000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿8','010-111-1008','����2','��','����1',4000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿9','010-111-1009','����3','��','����2',3000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿10',null,'����4','��','����3',2000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿11','010-111-1011','�뱸1','��','����',5500000,40);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿12','010-111-1012','�뱸2','��','����1',2000000,40);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿13','010-111-1013','����1','��','����',6500000,50);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿14','010-111-1014','����2','��','����1',3500000,50);

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
