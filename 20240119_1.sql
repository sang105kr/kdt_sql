--�����ּ�
/* ������ �ּ� */
--���̺� ��������
desc emp;
desc dept;
desc salgrade;

--���̺��� ��� �÷� ��ȸ
select * from emp;

--�Ϻ� �÷� ��ȸ
select empno, ename from emp;

--�÷� ����� ��Ī �ֱ�
select empno as "�����ȣ" , ename as "�����" from emp; -- ��Ī�� �ֵ���ǥ�� ���Ѵ�.
select empno "�����ȣ" , ename "�����" from emp; --as�� ��������

--�ߺ�����
select distinct deptno from emp;
select all deptno from emp;  -- ����Ʈ all, ��������

select ename,sal,sal*12, (sal*12)+comm from emp;
select ename,sal,sal*12, (sal*12)+comm from emp; -- null���� ������� ����� null
select ename,sal,sal*12, (sal*12)+nvl(comm,0) from emp; -- nvl(null,0) : null���̸� 0���� ġȯ)
select ename    "�̸�",
       sal      "����",
       sal*12   "����(��������)",   
       (sal*12)+nvl(comm,0) "����(��������)" -- nvl(null,0) : null���̸� 0���� ġȯ)
  from emp; 
  
-- ���� : asc(�⺻��), desc
  select ename    "�̸�",
         sal      "����",
         sal*12   "����(��������)",   
        (sal*12)+nvl(comm,0) "����(��������)" -- nvl(null,0) : null���̸� 0���� ġȯ)
    from emp
order by  (sal*12)+nvl(comm,0) desc, ename desc; 

--���ڵ� ���͸� where
select ename, sal
  from emp
 where sal >= 2000 and sal <= 3000;
 
select ename, sal
  from emp
 where sal between 2000 and 3000; 
 
select ename, sal
  from emp
 where sal not between 2000 and 3000; 
 
 
--not������ 
select *
 from emp
where not sal = 3000;  
--where sal != 3000
--where sal <> 3000

--or������ 
select *
 from emp
where sal = 3000 or sal = 5000;  

-- in������
select *
  from emp
 where sal in(3000,5000); 
 
 select *
  from emp
 where sal not in(3000,5000);  
 
--���� ���̺� dual
--�������
select 1+2, 3-4 , 5*6, 10/2, mod(10,4) from dual;
desc dual;

--like ������ _(�ѹ���),%(�ѹ����̻�)
select *
  from emp
 where ename like 'A%'; 
  
-- null��
select *
  from emp
 where comm is null;
 
 
select empno,ename
  from emp
 where deptno = 10
union all
select empno,ename
  from emp
 where deptno = 10; 
 
 
 
 