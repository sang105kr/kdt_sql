--테이블 생성
 create table emp2 
    as  select * from emp where 1<>1;
    
desc emp2;
select * from emp2;

--시퀀스 생성
create sequence emp2_empno_seq;

--현재 시퀀스 번호 확인
select emp2_empno_seq.currval from dual;

--시퀀스 번호 생성
select emp2_empno_seq.nextval from dual;


select * from user_tables;
select owner,table_name from all_tables;
