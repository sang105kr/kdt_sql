--7장4문제
  select nvl2(to_char(t1.comm),'O','X') "exist_comm",
         count(*) "cnt"
    from emp t1
group by nvl2(to_char(t1.comm),'O','X');

--8장4문제
    select t1.deptno, t1.dname,                     
           t2.empno, t2.ename, t2.mgr, t2.sal, t2.deptno,
           t3.losal, t3.hisal, t3.grade,
           t4.empno "MGR_EMPNO", t4.ename "MGR_ENAME"
      from dept t1, emp t2, salgrade t3, emp t4
     where t1.deptno = t2.deptno(+)
       and t2.sal between t3.losal and t3.hisal
       and t2.mgr = t4.empno
  order by t1.deptno,t2.empno;

    select t1.deptno, t1.dname,                     
           t2.empno, t2.ename, t2.mgr, t2.sal, t2.deptno,
           t3.losal, t3.hisal, t3.grade,
           t4.empno "MGR_EMPNO", t4.ename "MGR_ENAME"
      from dept t1 left outer join emp t2 on t1.deptno = t2.deptno 
                   join salgrade t3       on t2.sal between t3.losal and t3.hisal
                   join emp t4            on t2.mgr = t4.empno
  order by t1.deptno,t2.empno;

--9장4문제  
-- 다중행연산자  
-- ex) 서브쿼리 결과 10,20,30
-- =any, =some는 in과 같은의미 
-- >any, >some : 최소값보다 큰,  > min()
-- <any, <some : 최대값보다 작은 < max() 
-- >all        : 최대값보다 큰   > max()
-- <all        : 최소값보다 작은 < min() 

-- case1)단일행 함수 사용
select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal 
   and t1.sal > ( select max(sal)
                    from emp 
                   where job = 'SALESMAN')
order by t1.empno;  

select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1 join salgrade t2 on t1.sal between t2.losal and t2.hisal 
 where t1.sal > ( select max(sal)
                    from emp 
                   where job = 'SALESMAN')
order by t1.empno;  

--case2)다중행 연산자 사용
select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal 
   and t1.sal > all ( select sal
                        from emp 
                       where job = 'SALESMAN')
order by t1.empno;                         

select t1.empno, t1.ename, t1.sal, t2.grade
  from emp t1 join salgrade t2 on t1.sal between t2.losal and t2.hisal 
 where t1.sal > all( select sal
                    from emp 
                   where job = 'SALESMAN')
order by t1.empno;  


  