--1. EMP 테이블과 DEPT 테이블을 등가조인해서 사원 이름과 해당 사원의 부서 이름을 출력하시오.
select t1.ename "사원명", t2.dname "부서명"
  from emp t1, dept t2
 where t1.deptno = t2.deptno ;

--SQL-99표기법 : 모든 관계형 데이터 베이스에 동일한 문법이 적용됨. 
--join ~ on
select t1.ename "사원명", t2.dname "부서명"
  from emp t1 join dept t2 on t1.deptno = t2.deptno; 
--natural join : 테이블간에 컬럼명과 자료형이 같은 열(속성,컬럼)을 자동으로 찾아 조인  
select t1.ename "사원명", t2.dname "부서명"
  from emp t1 natural join dept t2;
--join ~ using 
select t1.ename "사원명", t2.dname "부서명"
  from emp t1 join dept t2 using(deptno);

--2. EMP 테이블과 DEPT 테이블을 외부조인해서 사원 이름과 해당 사원의 부서 이름을 출력하시오. 
--부서가 없는 사원도 포함하시오.
select t1.ename "사원명", t2.dname "부서명"
  from emp t1, dept t2 
 where t1.deptno = t2.deptno(+); 
select t1.ename "사원명", t2.dname "부서명"
  from emp t1 left outer join dept t2 on t1.deptno = t2.deptno; 
--3. emp 테이블과 salgrade 테이블을 비등가조인해서 사원 이름과 해당 사원의 급여 등급을 출력하시오.
select t1.ename, t2.grade
  from emp t1, salgrade t2
 where t1.sal between t2.losal and t2.hisal; 
  
select t1.ename, t2.grade
  from emp t1 join salgrade t2 on t1.sal between t2.losal and t2.hisal;   
  
--4. emp 테이블과 salgrade 테이블을 외부조인해서 사원 이름과 해당 사원의 급여 등급을 출력하시오. 
--급여 등급이 없는 사원도 포함하시오.
select t1.ename, t2.grade
  from emp t1,salgrade t2
 where t1.sal between t2.losal and t2.hisal(+);

select t1.ename, t2.grade
  from emp t1 left outer join salgrade t2 on t1.sal between t2.losal and t2.hisal; 
 
--5. emp 테이블과 dept 테이블을 등가조인해서 전체 사원의 평균 급여를 부서별로 출력하시오.
   select t2.dname "부서명", trunc(avg(t1.sal),2) "평균급여"
     from emp t1, dept t2
    where t1.deptno = t2.deptno
 group by t2.dname;

   select t2.dname "부서명", trunc(avg(t1.sal),2) "평균급여"
     from emp t1 join dept t2 on t1.deptno = t2.deptno
 group by t2.dname;
--6. emp 테이블과 dept 테이블을 외부조인해서 전체 사원의 평균 급여를 부서별로 출력하시오. 
--부서가 없는 사원도 포함하시오.
   select nvl(t2.dname,'부서가없는사원그룹') "부서명", trunc(avg(t1.sal),2) "평균급여"
     from emp t1, dept t2
    where t1.deptno = t2.deptno(+)
 group by t2.dname;

   select nvl(t2.dname,'부서가없는사원그룹') "부서명", trunc(avg(t1.sal),2) "평균급여"
     from emp t1 left join dept t2 on t1.deptno = t2.deptno
 group by t2.dname;
--7. emp 테이블과 dept 테이블을 등가조인해서 사원 수가 5명 이상인 부서의 부서 이름과 사원 수를 출력하시오.
--8. emp 테이블과 dept 테이블을 외부조인해서 사원 수가 5명 이상인 부서의 부서 이름과 사원 수를 출력하시오. 
--부서가 없는 사원도 포함하시오.
--9. emp 테이블과 bonus 테이블을 등가조인해서 사원 이름과 보너스를 출력하시오.
--10. emp 테이블과 bonus 테이블을 외부조인해서 사원 이름과 보너스를 출력하시오. 
--보너스를 받지 못한 사원도 포함하시오.
--11. EMP 테이블을 셀프 조인해서 같은 부서에서 일하는 사원들의 이름을 출력하시오.
--12. EMP 테이블을 셀프 조인해서 자신보다 더 많은 급여를 받는 사원들의 이름을 출력하시오.