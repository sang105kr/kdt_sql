--join(����) : 2���̻��� ���̺��� ��� ���� �����ϰ��� �Ҷ�
select count(*) from emp;
select count(*) from dept;

--inner join(��������) : ���̺��� ���� �Ӽ��� �����ϰ� �Ӽ����� ���� �ุ �����ϰ��� �Ҷ�.
select emp.ename, dept.dname
  from emp, dept
 where emp.deptno = dept.deptno;
 
select t1.ename, t2.dname
  from emp t1, dept t2
 where t1.deptno = t2.deptno; 
 
select t1.*
  from emp t1, dept t2
 where t1.deptno = t2.deptno; 
 
select t2.*
  from emp t1, dept t2
 where t1.deptno = t2.deptno; 
 
select t1.*, t2.*
  from emp t1, dept t2
 where t1.deptno = t2.deptno;  
 
 
select *
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal ;
 
 
 select t1.ename, t2.ename
   from emp t1, emp t2
  where t1.mgr = t2.empno ;
  
insert into emp values(8000,'gildong','CLERK',null,to_date(sysdate),4000,null,null);  
select * from emp; 
insert into dept values(50,'HUMANRESOURCES','LA');
select * from dept;

--inner join
--case1)
select t1.ename, t2.dname
  from emp t1, dept t2
 where t1.deptno = t2.deptno; 
--case2) ansi sqlǥ�� 
select t1.ename, t2.dname
  from emp t1 join dept t2 on t1.deptno = t2.deptno; 
 
--left outer join : ���Ӽ��� �����ִ� ���� ���̺��� ����
--case1)
select t1.ename, t2.dname
  from emp t1, dept t2
 where t1.deptno = t2.deptno(+);  
--case2) 
select t1.ename, t2.dname
  from emp t1 left outer join dept t2
    on t1.deptno = t2.deptno;   
--case3)     
--right outer join : ���Ӽ��� �����ִ� ���� ���̺��� ������
select t1.ename, t2.dname
  from emp t1 right outer join dept t2
    on t1.deptno = t2.deptno;    
    
select t1.ename, t2.dname
  from emp t1 full outer join dept t2
    on t1.deptno = t2.deptno;     
    