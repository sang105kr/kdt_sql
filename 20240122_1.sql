select length('�ѱ�'), lengthb('�ѱ�') from dual;

--�κй��ڿ� ����
--KH���米����
select substr('KH���米����',1) from dual; --KH���米����
select substr('KH���米����',3) from dual; --���米����
select substr('KH���米����',3,2) from dual; --����
select substr('ȫ�浿',1,1) "��",substr('ȫ�浿',2) "�̸�" from dual; 
select substr('ȫ�浿',-2) from dual; --�浿
select substr('ȫ�浿',-2,1) from dual; --��
select substr('ȫ�浿',-2,2) from dual; --�浿

select  job,
        substr(job, -length(job)),
        substr(job, -length(job),2),
        substr(job, -3)
  from emp;


select * from emp;

--�Ի���� 2���� ���
select *
  from emp
 where substr(to_char(hiredate),4,2) = '06' ;
 
select *
  from emp
 where to_char(hiredate,'MM') = '06' ;
 
--������� �Ի��� ��� 
select to_char(sysdate,'MM') from dual;

select *
  from emp
 where to_char(hiredate,'MM') =  to_char(sysdate,'MM');

--�ټӳ�����ϱ� O�� O���� 
select ename "�����", 
       hiredate "�Ի���", 
--       trunc(months_between(sysdate,hiredate)) "�ټӰ�����",
--       trunc(months_between(sysdate,hiredate) / 12) "�ټӳ�",
--       trunc(mod(months_between(sysdate,hiredate), 12)) "��",
       
       trunc(months_between(sysdate,hiredate) / 12) || 
       '��' || 
       trunc(mod(months_between(sysdate,hiredate), 12)) || 
       '��' "�ټӳ��"
  from emp;
  
select nvl(comm,0), nvl(comm,0) + 100, nvl2(comm,'O','X') from emp;


select empno, ename, job,
       sal "�޿��λ���",
       decode(job,'MANAGER',sal*1.1,
                  'SALESMAN',sal*1.05,
                  'ANALYST',sal,
                  sal*1.03) "�޿��λ���",
      decode(job,'MANAGER',sal*1.1,
                 'SALESMAN',sal*1.05,
                 'ANALYST',sal,
                 sal*1.03) - sal "�λ��"         
  from emp;
select empno, ename, job,
       sal "�޿��λ���",
       case job
            when 'MANAGER' then sal*1.1
            when 'SALESMAN' then sal*1.05
            when 'ANALYST' then sal
            else  sal*1.03
       end "�޿��λ���",
       case job
            when 'MANAGER' then sal*1.1
            when 'SALESMAN' then sal*1.05
            when 'ANALYST' then sal
            else  sal*1.03
       end - sal "�λ��"         
  from emp;  
select empno, ename, job,
       sal "�޿��λ���",
       case when job = 'MANAGER' then sal*1.1
            when job = 'SALESMAN' then sal*1.05
            when job = 'ANALYST' then sal
            else  sal*1.03
       end "�޿��λ���",
       case when job = 'MANAGER' then sal*1.1
            when job = 'SALESMAN' then sal*1.05
            when job = 'ANALYST' then sal
            else  sal*1.03
       end - sal "�λ��"         
  from emp;  

--�μ��� �޿��� ����
select * from emp;

    select deptno   "�μ���ȣ",  
           sum(sal) "�޿���", 
           round(avg(sal),2) "�޿����", 
           max(sal) "�ִ�޿�", 
           min(sal) "�ּұ޿�",
           count(*) "�ο���"
      from emp
  group by deptno
  order by sum(sal) desc;

select sum(sal) "�޿���", 
       round(avg(sal),2) "�޿����", 
       max(sal) "�ִ�޿�", 
       min(sal) "�ּұ޿�",
       count(*) "�ο���"
  from emp;




