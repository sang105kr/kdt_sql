select count(*) from emp;
--��������
--��ü ����� �޿� ��պ��� ū ��� ����
select *
  from emp t1
 where t1.sal > ( select avg(t2.sal)
                    from emp t2 ) ;
                    
--�������
--�μ��޿� ��պ��� ū ��� ����
select *
  from emp t1
 where t1.sal > (select avg(t2.sal)
                   from emp t2
                  where t1.deptno = t2.deptno);
                  
--���̺� ����(����+������)
create table dept_tmp as select * from dept;
select * from dept_tmp;
--���̺� ����(����)
create table dept_tmp as select * from dept where 1=2;
select * from dept_tmp;
--���̺� ����
drop table dept_tmp;

insert into dept_tmp (deptno, dname, loc)
     values (60,'NETWOR','ULSAN'); 
     
insert into dept_tmp (deptno, dname)
     values (70,'NETWORk2'); 
--�Ӽ�����Ʈ�� ���� �����Ѱ��� values���� ��� �Ӽ����� �Է��ؾ��Ѵ�.     
insert into dept_tmp 
     values (80,'NETWORk3','PUSAN');      
/*
commit;  --���� commit������ �۾��� db�� �ݿ�                  
rollback; --�ֱ� commit������ �۾��� ���                 
*/

insert into dept_tmp (deptno,dname,loc)
     values (80,'NETWORk3','');  
insert into dept_tmp (deptno,dname,loc)
     values (90,'NETWORk4',' ');       
select * from dept_tmp;    
rollback;
