--���̺� ����
 create table emp2 
    as  select * from emp where 1<>1;
    
desc emp2;
select * from emp2;

--������ ����
create sequence emp2_empno_seq;

--���� ������ ��ȣ Ȯ��
select emp2_empno_seq.currval from dual;

--������ ��ȣ ����
select emp2_empno_seq.nextval from dual;


select * from user_tables;
select owner,table_name from all_tables;
