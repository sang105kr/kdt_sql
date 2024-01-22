select length('한글'), lengthb('한글') from dual;

--부분문자열 추출
--KH인재교육원
select substr('KH인재교육원',1) from dual; --KH인재교육원
select substr('KH인재교육원',3) from dual; --인재교육원
select substr('KH인재교육원',3,2) from dual; --인재
select substr('홍길동',1,1) "성",substr('홍길동',2) "이름" from dual; 
select substr('홍길동',-2) from dual; --길동
select substr('홍길동',-2,1) from dual; --길
select substr('홍길동',-2,2) from dual; --길동

select  job,
        substr(job, -length(job)),
        substr(job, -length(job),2),
        substr(job, -3)
  from emp;


select * from emp;

--입사월이 2월인 사원
select *
  from emp
 where substr(to_char(hiredate),4,2) = '06' ;
 
select *
  from emp
 where to_char(hiredate,'MM') = '06' ;
 
--현재월에 입사한 사원 
select to_char(sysdate,'MM') from dual;

select *
  from emp
 where to_char(hiredate,'MM') =  to_char(sysdate,'MM');

--근속년수구하기 O년 O개월 
select ename "사원명", 
       hiredate "입사일", 
--       trunc(months_between(sysdate,hiredate)) "근속개월수",
--       trunc(months_between(sysdate,hiredate) / 12) "근속년",
--       trunc(mod(months_between(sysdate,hiredate), 12)) "월",
       
       trunc(months_between(sysdate,hiredate) / 12) || 
       '년' || 
       trunc(mod(months_between(sysdate,hiredate), 12)) || 
       '월' "근속년월"
  from emp;
  
select nvl(comm,0), nvl(comm,0) + 100, nvl2(comm,'O','X') from emp;


select empno, ename, job,
       sal "급여인상전",
       decode(job,'MANAGER',sal*1.1,
                  'SALESMAN',sal*1.05,
                  'ANALYST',sal,
                  sal*1.03) "급여인상후",
      decode(job,'MANAGER',sal*1.1,
                 'SALESMAN',sal*1.05,
                 'ANALYST',sal,
                 sal*1.03) - sal "인상액"         
  from emp;
select empno, ename, job,
       sal "급여인상전",
       case job
            when 'MANAGER' then sal*1.1
            when 'SALESMAN' then sal*1.05
            when 'ANALYST' then sal
            else  sal*1.03
       end "급여인상후",
       case job
            when 'MANAGER' then sal*1.1
            when 'SALESMAN' then sal*1.05
            when 'ANALYST' then sal
            else  sal*1.03
       end - sal "인상액"         
  from emp;  
select empno, ename, job,
       sal "급여인상전",
       case when job = 'MANAGER' then sal*1.1
            when job = 'SALESMAN' then sal*1.05
            when job = 'ANALYST' then sal
            else  sal*1.03
       end "급여인상후",
       case when job = 'MANAGER' then sal*1.1
            when job = 'SALESMAN' then sal*1.05
            when job = 'ANALYST' then sal
            else  sal*1.03
       end - sal "인상액"         
  from emp;  

--부서별 급여의 총합
select * from emp;

    select deptno   "부서번호",  
           sum(sal) "급여합", 
           round(avg(sal),2) "급여평균", 
           max(sal) "최대급여", 
           min(sal) "최소급여",
           count(*) "인원수"
      from emp
  group by deptno
  order by sum(sal) desc;

select sum(sal) "급여합", 
       round(avg(sal),2) "급여평균", 
       max(sal) "최대급여", 
       min(sal) "최소급여",
       count(*) "인원수"
  from emp;




