-- �μ��� �޿� �Ѿ�
    select deptno, sum(sal)
      from emp
  group by deptno;
  
-- 10�� �μ��� �޿� �Ѿ�
    select deptno, sum(sal)
      from emp
  group by deptno
    having deptno = 10;
    
-- �μ��� ������ 'clerk'�� ������ �޿� �Ѿ�    
    select deptno, sum(sal) -- 4
      from emp              -- 1
     where job = 'CLERK'    -- 2 
  group by deptno;          -- 3
-- 10�� �μ����� ������ 'clerk'�� ������ �޿� �Ѿ�    
    select deptno, sum(sal) --5
      from emp              --1
     where job = 'CLERK'    --2  
  group by deptno           --3
    having deptno = 10;     --4
    
-- �μ��� ������ �޿��Ѿ�   
    select deptno,job,sum(sal)
      from emp
  group by deptno,job;
-- �μ��� ������ �޿��Ѿ��� �޿��Ѿ� ��������    
    select deptno,job,sum(sal)
      from emp
  group by deptno,job  
  order by sum(sal) desc;  
    
-- ȸ���� �����ϰ� �μ��� ������ �޿��Ѿ��� �޿��Ѿ� ������������ ���̽ÿ�.    
    select deptno,job,sum(sal)
      from emp
     where job != 'PRESIDENT' 
  group by deptno,job  
  order by sum(sal) desc;      
    
-- ȸ���� �����ϰ� �μ��� ������ �޿��Ѿ��� 'CLERK'������ �����ϰ� �޿��Ѿ� ������������ ���̽ÿ�.       
    select deptno,job,sum(sal)
      from emp
     where job != 'PRESIDENT' 
  group by deptno,job  
    having job != 'CLERK'
  order by sum(sal) desc;          
    
-- group by�� �ڿ� ������ �÷� �Ǵ� �׷��Լ��� select���� �ü� �ִ�.    
    select deptno,job,sum(sal)
      from emp
     where job != 'PRESIDENT' 
  group by deptno,job  
    having job != 'CLERK'
  order by sum(sal) desc;       
    

  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by deptno, job
order by deptno, job;

--rollup:�������׷�ȭ, �����: n+1
  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by rollup(deptno, job) 
order by deptno, job;
    
--cube:�������� �׷�ȭ, �����: 2�� n��    
  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by cube(deptno, job)
order by deptno, job;    
    
--grouping sets : ����ȭ�� �׷�ȭ , ����� n�� 
  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by grouping sets(deptno, job)
order by deptno, job;      

--grouping : �÷����� ������ ����� ���� ������ �Ǻ� 1 or 0
  select deptno, job, count(*),max(sal),sum(sal),avg(sal),grouping(deptno),grouping(job) 
    from emp
group by rollup(deptno, job) 
order by deptno, job;

  select decode(grouping(deptno),1,'�μ�����',deptno) "deptno", 
         decode(grouping(job),1,'��������',job) "job", 
         count(*),max(sal),sum(sal),avg(sal)
    from emp
group by rollup(deptno, job) 
order by deptno, job;

--grouping_id : �÷����� ������ ����� ���� ������ �Ǻ�, ���ڴ� ������ �ü��ִ�.
-- group by���� rollup�Լ��� ����� ��� n+1 ���� ���°��� 0 ���� ���������� ����
-- group by���� cube�Լ��� ����� ��� 2��n�� ���� ���°��� 0 ���� ���������� ����
  select deptno, job, count(*),max(sal),sum(sal),avg(sal),
         grouping(deptno),grouping(job),grouping_id(deptno,job) 
    from emp
group by rollup(deptno, job) 
order by deptno, job;

  select decode(grouping_id(deptno,job),3,'��ü',
                                        2,'��������',deptno) deptno, 
         decode(grouping_id(deptno,job),1,'�μ�����',
                                        3,' ',job) job, 
         count(*),max(sal),sum(sal),round(avg(sal),2)
    from emp
group by cube(deptno, job) 
order by deptno, job;

select *
  from (select deptno,job,sal,ename
          from emp)
  pivot(max(sal) for ename in('SMITH','ALLEN','WARD'))
order by job;  

select * from dept;



