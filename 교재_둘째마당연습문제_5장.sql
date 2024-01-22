--1)
select *
  from emp
 where ename like '%S'; 
--2)
select empno,ename,job,sal,deptno
  from emp
 where deptno = 30
   and job = 'SALESMAN';  
--3)
--집합연산자 사용하지 않은 방식
select empno,ename,job,sal,deptno
  from emp
 where (deptno = 20 or deptno = 30) 
   and sal > 2000;
--집합연사자 사용한 방식   
select empno,ename,job,sal,deptno
  from emp
 where deptno in (20,30) 
   and sal > 2000;
   
--4)
--case1)
select *
  from emp
 where not (sal >= 2000 and sal <= 3000);
 
--case2)
select *
  from emp
 where sal < 2000 or sal > 3000;

--5)
--case1)
select *
  from emp
 where ename like '%E%'
   and deptno = 30
   and sal not between 1000 and 2000;
   
--case2)
select *
  from emp
 where ename like '%E%'
   and deptno = 30
   and sal < 1000 or sal > 2000;   
   
--6)
--case1)
select *
  from emp
 where comm is null
   and mgr is not null
   and job in ('MANAGER','CLERK')
   and ename not like '_L%';
SELECT *
  from emp
 where comm is null
   and mgr is not null
   and (job = 'MANAGER' or job = 'CLERK')
   and ename not like '_L%';
  