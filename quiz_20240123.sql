--1. EMP ���̺�� DEPT ���̺��� ������ؼ� ��� �̸��� �ش� ����� �μ� �̸��� ����Ͻÿ�.
select t1.ename "�����", t2.dname "�μ���"
  from emp t1, dept t2
 where t1.deptno = t2.deptno ;

--SQL-99ǥ��� : ��� ������ ������ ���̽��� ������ ������ �����. 
--join ~ on
select t1.ename "�����", t2.dname "�μ���"
  from emp t1 join dept t2 on t1.deptno = t2.deptno; 
--natural join : ���̺��� �÷���� �ڷ����� ���� ��(�Ӽ�,�÷�)�� �ڵ����� ã�� ����  
select t1.ename "�����", t2.dname "�μ���"
  from emp t1 natural join dept t2;
--join ~ using 
select t1.ename "�����", t2.dname "�μ���"
  from emp t1 join dept t2 using(deptno);

--2. EMP ���̺�� DEPT ���̺��� �ܺ������ؼ� ��� �̸��� �ش� ����� �μ� �̸��� ����Ͻÿ�. 
--�μ��� ���� ����� �����Ͻÿ�.
select t1.ename "�����", t2.dname "�μ���"
  from emp t1, dept t2 
 where t1.deptno = t2.deptno(+); 
select t1.ename "�����", t2.dname "�μ���"
  from emp t1 left outer join dept t2 on t1.deptno = t2.deptno; 
--3. emp ���̺�� salgrade ���̺��� �������ؼ� ��� �̸��� �ش� ����� �޿� ����� ����Ͻÿ�.
select t1.ename, t2.grade
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal; 
  
select t1.ename, t2.grade
  from emp t1 join salgrade t2 on t1.sal between t2.losal and t2.hisal;   
  
--4. emp ���̺�� salgrade ���̺��� �ܺ������ؼ� ��� �̸��� �ش� ����� �޿� ����� ����Ͻÿ�. 
--�޿� ����� ���� ����� �����Ͻÿ�.
select t1.ename, t2.grade
  from emp t1,salgrade t2
 where t1.sal between t2.losal and t2.hisal(+);

select t1.ename, t2.grade
  from emp t1 left outer join salgrade t2 on t1.sal between t2.losal and t2.hisal; 
 
--5. emp ���̺�� dept ���̺��� ������ؼ� ��ü ����� ��� �޿��� �μ����� ����Ͻÿ�.
   select t2.dname "�μ���", trunc(avg(t1.sal),2) "��ձ޿�"
     from emp t1, dept t2
    where t1.deptno = t2.deptno
 group by t2.dname;

   select t2.dname "�μ���", trunc(avg(t1.sal),2) "��ձ޿�"
     from emp t1 join dept t2 on t1.deptno = t2.deptno
 group by t2.dname;
--6. emp ���̺�� dept ���̺��� �ܺ������ؼ� ��ü ����� ��� �޿��� �μ����� ����Ͻÿ�. 
--�μ��� ���� ����� �����Ͻÿ�.
   select nvl(t2.dname,'�μ������»���׷�') "�μ���", trunc(avg(t1.sal),2) "��ձ޿�"
     from emp t1, dept t2
    where t1.deptno = t2.deptno(+)
 group by t2.dname;

   select nvl(t2.dname,'�μ������»���׷�') "�μ���", trunc(avg(t1.sal),2) "��ձ޿�"
     from emp t1 left join dept t2 on t1.deptno = t2.deptno
 group by t2.dname;
--7. emp ���̺�� dept ���̺��� ������ؼ� ��� ���� 5�� �̻��� �μ��� �μ� �̸��� ��� ���� ����Ͻÿ�.
  select t2.dname "�μ���", count(*) "�����"
    from emp t1, dept t2
   where t1.deptno = t2.deptno 
group by t2.dname
  having  count(*) >= 5;
  
  select t2.dname "�μ���", count(*) "�����"
    from emp t1 join dept t2 on t1.deptno = t2.deptno 
group by t2.dname
  having count(*) >= 5;  

--8. emp ���̺�� dept ���̺��� �ܺ������ؼ� ��� ���� 5�� �̻��� �μ��� �μ� �̸��� ��� ���� ����Ͻÿ�. 
--�μ��� ���� ����� �����Ͻÿ�.
  select t2.dname "�μ���", count(*) "�����"
    from emp t1, dept t2
   where t1.deptno = t2.deptno(+) 
group by t2.dname
  having  count(*) >= 5;
  
  select t2.dname "�μ���", count(*) "�����"
    from emp t1 left outer join dept t2 on t1.deptno = t2.deptno 
group by t2.dname
  having count(*) >= 5;  
--9. emp ���̺�� bonus ���̺��� ������ؼ� ��� �̸��� ���ʽ��� ����Ͻÿ�.
    select t2.ename, t2.comm
      from emp t1, bonus t2
     where t1.ename = t2.ename; 

    select t2.ename, t2.comm
      from emp t1 join bonus t2 on t1.ename = t2.ename; 
--10. emp ���̺�� bonus ���̺��� �ܺ������ؼ� ��� �̸��� ���ʽ��� ����Ͻÿ�. 
--���ʽ��� ���� ���� ����� �����Ͻÿ�.
    select t1.ename, nvl(t2.comm,0)
      from emp t1, bonus t2
     where t1.ename = t2.ename(+);
     
    select t1.ename, nvl(t2.comm,0)
      from emp t1 left outer join bonus t2 on t1.ename = t2.ename;
--11. EMP ���̺��� ���� �����ؼ� ���� �μ����� ���ϴ� ������� �̸��� ����Ͻÿ�.
  select distinct t3.dname, t2.ename
    from emp t1, emp t2, dept t3
   where t1.deptno = t2.deptno
     and t2.deptno = t3.deptno
order by t3.dname;

  select distinct t3.dname, t2.ename
    from emp t1 join emp t2   on t1.deptno = t2.deptno
                join dept t3  on t2.deptno = t3.deptno
order by t3.dname;    

--12. EMP ���̺��� ���� �����ؼ� �ڽź��� �� ���� �޿��� �޴� ������� �̸��� ����Ͻÿ�.
  select t1.ename,t1.sal , t2.ename, t2.sal
    from emp t1, emp t2
   where t1.sal < t2.sal;
   
  select t1.ename,t1.sal,
         listagg(t2.ename,',') within group(order by t2.sal)
    from emp t1, emp t2
   where t1.sal < t2.sal
group by t1.ename,t1.sal
order by t1.sal;   
   
   
   