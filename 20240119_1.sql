--한줄주석
/* 여러줄 주석 */
--테이블 구조보기
desc emp;
desc dept;
desc salgrade;

--테이블의 모든 컬럼 조회
select * from emp;

--일부 컬럼 조회
select empno, ename from emp;

--컬럼 헤더에 별칭 주기
select empno as "사원번호" , ename as "사원명" from emp; -- 별칭은 쌍따옴표로 감싼다.
select empno "사원번호" , ename "사원명" from emp; --as는 생략가능

--중복제거
select distinct deptno from emp;
select all deptno from emp;  -- 디폴트 all, 생략가능

select ename,sal,sal*12, (sal*12)+comm from emp;
select ename,sal,sal*12, (sal*12)+comm from emp; -- null값과 산술연산 결과는 null
select ename,sal,sal*12, (sal*12)+nvl(comm,0) from emp; -- nvl(null,0) : null값이면 0으로 치환)
select ename    "이름",
       sal      "월급",
       sal*12   "연봉(수당제외)",   
       (sal*12)+nvl(comm,0) "연봉(수당포함)" -- nvl(null,0) : null값이면 0으로 치환)
  from emp; 
  
-- 정렬 : asc(기본값), desc
  select ename    "이름",
         sal      "월급",
         sal*12   "연봉(수당제외)",   
        (sal*12)+nvl(comm,0) "연봉(수당포함)" -- nvl(null,0) : null값이면 0으로 치환)
    from emp
order by  (sal*12)+nvl(comm,0) desc, ename desc; 

--레코드 필터링 where
select ename, sal
  from emp
 where sal >= 2000 and sal <= 3000;
 
select ename, sal
  from emp
 where sal between 2000 and 3000; 
 
select ename, sal
  from emp
 where sal not between 2000 and 3000; 
 
 
--not연산자 
select *
 from emp
where not sal = 3000;  
--where sal != 3000
--where sal <> 3000

--or연산자 
select *
 from emp
where sal = 3000 or sal = 5000;  

-- in연산자
select *
  from emp
 where sal in(3000,5000); 
 
 select *
  from emp
 where sal not in(3000,5000);  
 
--더미 테이블 dual
--산술연산
select 1+2, 3-4 , 5*6, 10/2, mod(10,4) from dual;
desc dual;

--like 연산자 _(한문자),%(한문자이상)
select *
  from emp
 where ename like 'A%'; 
  
-- null비교
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
 
 
 
 