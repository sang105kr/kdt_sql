select count(*) from emp;
--비상관쿼리
--전체 사원의 급여 평균보다 큰 사원 정보
select *
  from emp t1
 where t1.sal > ( select avg(t2.sal)
                    from emp t2 ) ;
                    
--상관쿼리
--부서급여 평균보다 큰 사원 정보
select *
  from emp t1
 where t1.sal > (select avg(t2.sal)
                   from emp t2
                  where t1.deptno = t2.deptno);
                  
--테이블 복사(구조+데이터)
create table dept_tmp as select * from dept;
select * from dept_tmp;
--테이블 복사(구조)
create table dept_tmp as select * from dept where 1=2;
select * from dept_tmp;
--테이블 삭제
drop table dept_tmp;

insert into dept_tmp (deptno, dname, loc)
     values (60,'NETWOR','ULSAN'); 
     
insert into dept_tmp (deptno, dname)
     values (70,'NETWORk2'); 
--속성리스트가 생략 가능한경우는 values절에 모든 속성값을 입력해야한다.     
insert into dept_tmp 
     values (80,'NETWORk3','PUSAN');      
/*
commit;  --이전 commit이후의 작업을 db에 반영                  
rollback; --최근 commit이후의 작업을 취소                 
*/

insert into dept_tmp (deptno,dname,loc)
     values (80,'NETWORk3','');  
insert into dept_tmp (deptno,dname,loc)
     values (90,'NETWORk4',' ');       
select * from dept_tmp;    
rollback;
