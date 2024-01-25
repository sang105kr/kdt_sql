--7��4����
  select nvl2(to_char(t1.comm),'O','X') "exist_comm",
         count(*) "cnt"
    from emp t1
group by nvl2(to_char(t1.comm),'O','X');

--8��4����
    select t1.deptno, t1.dname,                     
           t2.empno, t2.ename, t2.mgr, t2.sal, t2.deptno,
           t3.losal, t3.hisal, t3.grade,
           t4.empno "MGR_EMPNO", t4.ename "MGR_ENAME"
      from dept t1, emp t2, salgrade t3, emp t4
     where t1.deptno = t2.deptno(+)
       and t2.sal between t3.losal and t3.hisal
       and t2.mgr = t4.empno
  order by t1.deptno,t2.empno;

    select t1.deptno, t1.dname,                     
           t2.empno, t2.ename, t2.mgr, t2.sal, t2.deptno,
           t3.losal, t3.hisal, t3.grade,
           t4.empno "MGR_EMPNO", t4.ename "MGR_ENAME"
      from dept t1 left outer join emp t2 on t1.deptno = t2.deptno 
                   join salgrade t3       on t2.sal between t3.losal and t3.hisal
                   join emp t4            on t2.mgr = t4.empno
  order by t1.deptno,t2.empno;

--9��4����  
-- �����࿬����  
-- ex) �������� ��� 10,20,30
-- =any, =some�� in�� �����ǹ� 
-- >any, >some : �ּҰ����� ū,  > min()
-- <any, <some : �ִ밪���� ���� < max() 
-- >all        : �ִ밪���� ū   > max()
-- <all        : �ּҰ����� ���� < min() 

-- case1)������ �Լ� ���
select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal 
   and t1.sal > ( select max(sal)
                    from emp 
                   where job = 'SALESMAN')
order by t1.empno;  

select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1 join salgrade t2 on t1.sal between t2.losal and t2.hisal 
 where t1.sal > ( select max(sal)
                    from emp 
                   where job = 'SALESMAN')
order by t1.empno;  

--case2)������ ������ ���
select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal 
   and t1.sal > all ( select sal
                        from emp 
                       where job = 'SALESMAN')
order by t1.empno;                         

select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1 join salgrade t2 on t1.sal between t2.losal and t2.hisal 
 where t1.sal > all( select sal
                    from emp 
                   where job = 'SALESMAN')
order by t1.empno;  

--10��
drop table chap10hw_emp;
drop table chap10hw_dept;
drop table chap10hw_salgrade;
create table chap10hw_emp as select * from emp;
create table chap10hw_dept as select * from dept;
create table chap10hw_salgrade as select * from salgrade;

--10��1����
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'ORACLE', 'BUSAN'); 
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (80, 'DML', 'BUNDANG'); 
--10��2����
INSERT INTO CHAP10HW_EMP
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
 
INSERT INTO CHAP10HW_EMP
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
 
INSERT INTO CHAP10HW_EMP
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
 
INSERT INTO CHAP10HW_EMP
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
 
INSERT INTO CHAP10HW_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
 
INSERT INTO CHAP10HW_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
 
INSERT INTO CHAP10HW_EMP
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);

--10��3����
--update chap10hw_emp
--   set deptno = 70
-- where empno in ( select empno
--                    from chap10hw_emp
--                   where sal > ( select avg(sal)
--                                   from chap10hw_emp
--                                  where deptno = 50 ) ); 
update chap10hw_emp
   set deptno = 70
 where sal > ( select avg(sal)
                 from chap10hw_emp
                where deptno = 50 ); 
                
--10��4����   
--������
select *
  from chap10hw_emp
 where hiredate > ( select min(hiredate)
                      from chap10hw_emp
                     where deptno = 60); 
--����                     
update chap10hw_emp
   set sal = sal * 1.1,
       deptno = 80
 where hiredate > ( select min(hiredate)
                      from chap10hw_emp
                     where deptno = 60); 
--������                     
select *
  from chap10hw_emp
 where empno in( 8000,7205,7206,7207,7208);
                 
--10��5����  
--������
select count(*)
  from chap10hw_emp
 where empno in (7839,8000,7201,7203);  --4��
--���� 
delete from chap10hw_emp
 where empno in ( select t1.empno
                   from chap10hw_emp t1, chap10hw_salgrade t2
                  where t1.sal between t2.losal and t2.hisal
                    and t2.grade = 5 );
--������
select count(*)
  from chap10hw_emp
 where empno in (7839,8000,7201,7203);  --0��

