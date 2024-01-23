-- 부서별 급여 총액
    select deptno, sum(sal)
      from emp
  group by deptno;
  
-- 10번 부서의 급여 총액
    select deptno, sum(sal)
      from emp
  group by deptno
    having deptno = 10;
    
-- 부서별 직무가 'clerk'인 직원의 급여 총액    
    select deptno, sum(sal) -- 4
      from emp              -- 1
     where job = 'CLERK'    -- 2 
  group by deptno;          -- 3
-- 10번 부서에서 직무가 'clerk'인 직원의 급여 총액    
    select deptno, sum(sal) --5
      from emp              --1
     where job = 'CLERK'    --2  
  group by deptno           --3
    having deptno = 10;     --4
    
-- 부서별 직무별 급여총액   
    select deptno,job,sum(sal)
      from emp
  group by deptno,job;
-- 부서별 직무별 급여총액을 급여총액 내림차순    
    select deptno,job,sum(sal)
      from emp
  group by deptno,job  
  order by sum(sal) desc;  
    
-- 회장을 제외하고 부서별 직무별 급여총액을 급여총액 내림차순으로 보이시오.    
    select deptno,job,sum(sal)
      from emp
     where job != 'PRESIDENT' 
  group by deptno,job  
  order by sum(sal) desc;      
    
-- 회장을 제외하고 부서별 직무별 급여총액중 'CLERK'직무를 제외하고 급여총액 내림차순으로 보이시오.       
    select deptno,job,sum(sal)
      from emp
     where job != 'PRESIDENT' 
  group by deptno,job  
    having job != 'CLERK'
  order by sum(sal) desc;          
    
-- group by절 뒤에 나열된 컬럼 또는 그룹함수만 select절에 올수 있다.    
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

--rollup:계층적그룹화, 집계수: n+1
  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by rollup(deptno, job) 
order by deptno, job;
    
--cube:다차원적 그룹화, 집계수: 2의 n승    
  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by cube(deptno, job)
order by deptno, job;    
    
--grouping sets : 평준화된 그룹화 , 집계수 n개 
  select deptno, job, count(*),max(sal),sum(sal),avg(sal) 
    from emp
group by grouping sets(deptno, job)
order by deptno, job;      

--grouping : 컬럼값이 집계한 결과로 생긴 행인지 판별 1 or 0
  select deptno, job, count(*),max(sal),sum(sal),avg(sal),grouping(deptno),grouping(job) 
    from emp
group by rollup(deptno, job) 
order by deptno, job;

  select decode(grouping(deptno),1,'부서집계',deptno) "deptno", 
         decode(grouping(job),1,'직무집계',job) "job", 
         count(*),max(sal),sum(sal),avg(sal)
    from emp
group by rollup(deptno, job) 
order by deptno, job;

--grouping_id : 컬럼값이 집계한 결과로 생긴 행인지 판별, 인자는 여러개 올수있다.
-- group by절에 rollup함수를 사용한 경우 n+1 개의 상태값을 0 부터 순차적으로 가짐
-- group by절에 cube함수를 사용한 경우 2의n승 개의 상태값을 0 부터 순차적으로 가짐
  select deptno, job, count(*),max(sal),sum(sal),avg(sal),
         grouping(deptno),grouping(job),grouping_id(deptno,job) 
    from emp
group by rollup(deptno, job) 
order by deptno, job;

  select decode(grouping_id(deptno,job),3,'전체',
                                        2,'직무집계',deptno) deptno, 
         decode(grouping_id(deptno,job),1,'부서집계',
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



