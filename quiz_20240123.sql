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
--8. emp ���̺�� dept ���̺��� �ܺ������ؼ� ��� ���� 5�� �̻��� �μ��� �μ� �̸��� ��� ���� ����Ͻÿ�. 
--�μ��� ���� ����� �����Ͻÿ�.
--9. emp ���̺�� bonus ���̺��� ������ؼ� ��� �̸��� ���ʽ��� ����Ͻÿ�.
--10. emp ���̺�� bonus ���̺��� �ܺ������ؼ� ��� �̸��� ���ʽ��� ����Ͻÿ�. 
--���ʽ��� ���� ���� ����� �����Ͻÿ�.
--11. EMP ���̺��� ���� �����ؼ� ���� �μ����� ���ϴ� ������� �̸��� ����Ͻÿ�.
--12. EMP ���̺��� ���� �����ؼ� �ڽź��� �� ���� �޿��� �޴� ������� �̸��� ����Ͻÿ�.