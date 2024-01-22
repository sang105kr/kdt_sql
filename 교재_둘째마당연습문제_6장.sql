desc emp;
--1)
select empno,
       rpad(substr(empno,1,2),length(empno),'*') "masking_empno",
       rpad(substr(ename,1,1),length(ename),'*')  "masking_ename"
  from emp;
--2)  
select empno,
       ename,
       sal,
       trunc(sal / 21.5 ,2) "pay_day",
       round(sal / 21.5 / 8,2) "time_pay"
  from emp;
--3)
select empno,
       ename,
       hiredate,
--       add_months(hiredate,3),
--       next_day(add_months(hiredate,3),'월요일'),
       to_char(next_day(add_months(hiredate,3),'월요일'),'YYYY-MM-DD') "r_job",
       nvl(to_char(comm),'N/A') "comm"
  from emp;
--4)
select  empno,
        ename,
        mgr,
        case when mgr is null then '0000'
             when substr(mgr,1,2) = '75' then '5555'
             when substr(mgr,1,2) = '76' then '6666'
             when substr(mgr,1,2) = '77' then '7777'             
             when substr(mgr,1,2) = '78' then '8888'             
             else to_char(mgr)
        end "chg_mgr"
  from emp;
  
  