--����: ��ȭ ���� �ý����� ���� �����ͺ��̽� SQL ���� �ۼ� �� Ȯ��
--
--��ǥ:
--SQL�� ����Ͽ� ��ȭ ���� �ý����� ���� �����ͺ��̽��� ���̺��� Ȯ���Ͽ� �����ϰ�, �����͸� �����ϴ� ������ �մϴ�.
--
--�⺻ �䱸����:
--1.��, ��ȭ, ����, ���� �� ���� ���̺��� �����մϴ�.
--2.�� ���̺��� ��ID, ����, ����ó, �̸���, ��������Ʈ �÷��� �־�� �մϴ�. 
--  ��������Ʈ�� �ʼ�, �⺻�� 0
--3.��ȭ ���̺��� ��ȭID, ����, ����, �帣, �󿵽ð�, ������ �÷��� �־�� �մϴ�.
--4.���� ���̺��� ����ID, ��ID, ��ȭID, ����ID, ������, �󿵽ð�, �¼� �÷��� �־�� �մϴ�.
--5.���� ���̺��� ����ID, �����, ��ġ, �����ο� �÷��� �־�� �մϴ�. 
--  �����ο��� �ִ� 300���� �ʰ����� �ʴ´�.
--6.��� ���̺��� ������ ������ Ÿ���� ���� �ʿ��� �⺻ Ű(primary key)�� �ܷ� Ű(foreign key)�� �����ؾ� �մϴ�.
--7.�׿ܿ� �ʿ��ϴٰ� �����Ǵ� ��������, ������, ��, �ε����� �����մϴ�.
--8.ERD�� �ۼ��մϴ�.
--9.�� ���̺� �ּ� 5�� �̻��� ���� �����Ͽ� �׽�Ʈ �����͸� �غ��մϴ�.
--
--��� �䱸���� (�߰� ���� �ο�):
--1.��ȭ ���̺��� ������ �÷��� ����Ͽ� ���� �� ���� ��ȭ�� ã�� ������ �ۼ��մϴ�.
--2.���� ���̺��� Ư�� ��ġ�� �ִ� ������ ã��, �ش� ���忡�� ���ϴ� ��ȭ ����� �������� ������ �ۼ��մϴ�.
--3.���� ���̺��� ����Ͽ� Ư�� ���� ���� ������ ������ ��ȭ�� ������ �Բ� �����ϴ� ������ �ۼ��մϴ�.
--4.����� ������ �����Ͽ�, �� ���庰�� ����� �¼� ���� ����ϴ� ������ �ۼ��մϴ�.
--5.���� �α� �ִ� ��ȭ �帣�� �����ϴ� ������ �ۼ��մϴ�. (��: ���� �� ����)
--6.���� �������� �ʿ���ϴ� �������� 3�� �ۼ��մϴ�. (SQL���� �ƴ� �ѱ����ǹ�)

--���̺����
drop table reservation;
drop table customer;
drop table movie;
drop table theater;

--���̺����
--�� ���̺�
create table customer(
    customer_id     number(3),
    customer_name   varchar2(30),
    contact         varchar2(20),       --����ó
    email           varchar2(100),
    points          number(5)           --��������Ʈ
);
--��ȭ ���̺�
create table movie(
    movie_id        number(3),
    title           varchar2(100),
    director        varchar2(30),       --����
    genre           varchar2(30),       --�帣
    running_time    number(3),          --�󿵽ð�(��)
    release_date    date                --������
);
--���� ���̺�
create table reservation (
    reservation_id  number(3),
    customer_id     number(3),
    movie_id        number(3),
    theater_id      number(3),
    reservation_date    date,           --������
    show_time       number(4),          --�󿵽ð�(HHMM)   
    seat            varchar(10)         --�¼�
);
--���� ���̺�
create table theater(
    theater_id      number(3),
    theater_name    varchar2(100),
    location        varchar2(100),      --��ġ
    capacity        number(3)           --�����ο�
);

--�⺻Ű ��������
alter table customer add constraint customer_customer_id_pk primary key(customer_id);
alter table movie add constraint movie_movie_id_pk primary key(movie_id);
alter table reservation add constraint reservation_reservation_id_pk primary key(reservation_id);
alter table theater add constraint theater_theater_id_pk primary key(theater_id);

--�ܷ�Ű ��������
alter table reservation add constraint reservation_customer_id_fk1
    foreign key (customer_id) references customer(customer_id);
alter table reservation add constraint reservation_movie_id_fk1
    foreign key (movie_id) references movie(movie_id);
alter table reservation add constraint reservation_theater_id_fk1
    foreign key (theater_id) references theater(theater_id);

--not null ��������
alter table customer modify points not null ;

--default ��������
alter table customer modify points default 0;

--check ��������
alter table theater add constraint theater_capacity_ck check (capacity <= 300);

--unique ��������
alter table theater add constraint theater_theater_name_uk unique(theater_name);

--����������
drop sequence customer_customer_id_seq;
drop sequence movie_movie_id_seq;
drop sequence reservation_reservation_id_seq;
drop sequence theater_theater_id_seq;
--����������
create sequence customer_customer_id_seq;
create sequence movie_movie_id_seq;
create sequence reservation_reservation_id_seq;
create sequence theater_theater_id_seq;

--���� ������
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'��1','010-1234-1111','client1@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'��2','010-1234-2222','client2@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'��3','010-1234-3333','client3@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'��4','010-1234-4444','client4@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'��5','010-1234-5555','client5@example.com');
    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ1','����2','�帣1',100,to_date('2023-11-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ2','����2','�帣1',200,to_date('2024-02-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ3','����3','�帣2',150,to_date('2024-03-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ4','����3','�帣2',200,to_date('2024-04-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ5','����3','�帣2',300,to_date('2024-05-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ6','����4','�帣3',300,to_date('2024-05-01','YYYY-MM-DD'));    

insert into theater values(theater_theater_id_seq.nextval,'����1','��ġ1',100);
insert into theater values(theater_theater_id_seq.nextval,'����2','��ġ2',200);
insert into theater values(theater_theater_id_seq.nextval,'����3','��ġ3',300);
insert into theater values(theater_theater_id_seq.nextval,'����4','��ġ4',150);
insert into theater values(theater_theater_id_seq.nextval,'����5','��ġ5',250);

insert into reservation 
    values(reservation_reservation_id_seq.nextval,1,1,1,to_date('2024-06-01','YYYY-MM-DD'),1400,'A1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,1,2,1,to_date('2024-06-01','YYYY-MM-DD'),1600,'B1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,2,3,2,to_date('2024-06-01','YYYY-MM-DD'),1800,'C1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,2,4,2,to_date('2024-06-01','YYYY-MM-DD'),2000,'D1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,2,5,3,to_date('2024-06-01','YYYY-MM-DD'),2200,'E1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,3,5,3,to_date('2024-06-01','YYYY-MM-DD'),2200,'F1');    
commit;
--���õ����� Ȯ��
select * from customer;
select * from movie;
select * from reservation;
select * from theater;

--1.��ȭ ���̺��� ������ �÷��� ����Ͽ� ���� �� ���� ��ȭ�� ã�� ������ �ۼ��մϴ�.
select *
  from movie
 where release_date <= sysdate; 
--2.���� ���̺��� Ư�� ��ġ�� �ִ� ������ ã��, �ش� ���忡�� ���ϴ� ��ȭ ����� �������� ������ �ۼ��մϴ�.
select t3.title
  from reservation t1, theater t2, movie t3
 where t1.theater_id = t2.theater_id
   and t1.movie_id = t3.movie_id
   and t2.location = '��ġ1';
--3.���� ���̺��� ����Ͽ� Ư�� ���� ���� ������ ������ ��ȭ�� ������ �Բ� �����ϴ� ������ �ۼ��մϴ�.
select t3.*
  from reservation t1, customer t2, movie t3
 where t1.customer_id = t2.customer_id
   and t1.movie_id = t3.movie_id
   and t2.customer_name = '��1';
--SQL-99   
select t3.*
  from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                      join movie t3    on t1.movie_id = t3.movie_id
 where t2.customer_name = '��1';
--4.����� ������ �����Ͽ�, �� ���庰�� ����� �¼� ���� ����ϴ� ������ �ۼ��մϴ�.
    select t2.theater_name "�����", count(*) "����� �¼� ��"
      from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
  group by t2.theater_name;
--5.���� �α� �ִ� ��ȭ �帣�� �����ϴ� ������ �ۼ��մϴ�. (��: ���� �� ����) 
  select genre, count(*) cnt
    from movie
group by genre
having count(*) = ( select max(t1.cnt)
                      from ( select genre, count(*) cnt
                               from movie
                           group by genre ) t1 );

--fetch first ~ rows���
 select genre, count(*) cnt
   from movie
group by genre 
order by count(*) desc
fetch first 1 rows only;   -- oracle

--�м��Լ� rank���
select t1.genre, t1.cnt
  from ( select genre, count(*) as cnt,
                rank() over(order by count(*) desc) as rank
           from movie
        group by genre ) t1
 where t1.rank = 1;

--�����Ϸκ��� 2���̻� ���� ��ȭ�� ã�� ���� �ۼ�
 select *
  from movie
 where release_date <= add_months(sysdate,-2);

--����Ÿ���� ���� ª�� ��ȭ�� ã�� ���� �ۼ�
select title, running_time
  from movie
 where running_time = ( select min(running_time)
                          from movie );
--������������ ã�� ���� �ۼ�"
select title, release_date
  from movie
 where release_date > sysdate; 
--�帣���� �󿵽ð��� ����� ��ȭ�� ������ ����
  select genre, max(running_time)
    from movie
group by genre; 
--���� ���� ��ȭ������ ���� ������ ��ȭ ������ ���
  select director, count(*) cnt
    from movie
group by director
  having count(*) in ( select max(cnt)
                         from (  select director, count(*) cnt
                                   from movie
                               group by director ) );

--Ư�� ���� �ô� ��ȭ�� ���� �������� �� ��ȭ"
    select t3.title
      from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                          join movie t3    on t1.movie_id = t3.movie_id
     where t2.customer_name = '��2'
  order by t1.reservation_date
  fetch first 1 rows only;                           
      
--��ȭǥ�� 12,000���� �� ��ȭ�� �����Ѿ�
    select t2.title "��ȭ����", count(*) * 12000 "�����"
      from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
  group by t2.title
  order by count(*) * 12000 desc;

--���� ���庰 ��ȭ�� ���µ� ���� �� �ð�
  select (select customer_name
            from customer
           where customer_id = t2.customer_id ) "����", 
         (select theater_name
            from theater
           where theater_id = t3.theater_id ) "�����", 
         sum(t4.running_time)   "�� �����ð�"
    from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                        join theater t3  on t1.theater_id  = t3.theater_id
                        join movie t4 on t1.movie_id = t4.movie_id
group by t2.customer_id, t3.theater_id                        
having (select customer_name
            from customer
           where customer_id = t2.customer_id ) = '��2';    
  
    
--10�⵿�� ������ ��ȭ �� ���� �α��ִ� ��ȭ����
      select ( select title
                 from movie
               where movie_id = t2.movie_id ) "��ȭ��",
               count(*) "����Ǽ�"
        from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
        where t2.release_date between add_months(sysdate,-1*12*10) and sysdate 
     group by t2.movie_id
     order by count(*) desc
     fetch first 1 rows only;

--��ġ�� ��ȭ�� ����
    select location, count(*)
      from theater
  group by location;

--�󿵽ð��� ���� �� ��ȭ�� ��ȭ����
  select title, director, running_time
    from movie
   where running_time = ( select max(running_time)
                            from movie );

--�帣�� ��� �󿵽ð�
    select genre, round(avg(running_time),2)
      from movie
  group by genre ;
--���� �ֱٿ� ������ ��ȭ"
    select title
      from movie
     where release_date <= sysdate
  order by release_date desc
  fetch first 1 rows only; 
--���� �Ǽ��� ���� ���� ��ȭ ��ȸ
   select t2.movie_id, t2.title, count(*)
     from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
 group by t2.movie_id,t2.title
 order by count(*) desc
 fetch first 1 rows only;    
--�� ����Ʈ �������� ��ȸ
    select customer_name, points
      from customer;
      
--�������� ������ ��ȭ ã��
    select t2.director, t2.title
      from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
     where t2.release_date >= sysdate;
--�帣�� ��ȭ ��ȸ
    select *
      from movie
     where genre = '�帣1' ;
--���� �¼��� ���� ��ȭ�� ��ȸ
    select count(*)
      from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
                          join movie t3  on t1.movie_id = t3.movie_id
     where t3.release_date >= sysdate
       and t2.theater_id = '1';
  
  select t4.theater_id, 
         t4.theater_name,  
         t4.capacity "�����ο�",
         t4.capacity - ( select count(*)
              from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
                                  join movie t3  on t1.movie_id = t3.movie_id
             where t3.release_date >= sysdate
               and t2.theater_id = t4.theater_id ) "�����ڸ���"
    from theater t4;    
--�ش� ��ȭ�� ���ϴ� ���� ���� ã��
    select distinct t2.*
      from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
                          join movie t3 on t1.movie_id = t3.movie_id
     where t3.title = '��ȭ5';
--�� �ð��� �� ��ȭ ã�� 
  select title
    from movie
   where running_time = ( select max(running_time)
                            from movie );
--�¼� ���� ���� ���� ���� ã��
  select theater_name, capacity
    from theater
   where capacity = ( select max(capacity)
                        from theater );
--�ֱ� 5�⵿�� ������ ��ȭ�� ������ ����
  create view reservation_vw as
    select t1.reservation_id, t1.reservation_date, t1.show_time, t1.seat,
           t2.customer_id, t2.customer_name, t2.contact, t2.email, t2.points,
           t3.theater_id, t3.theater_name, t3.location, t3.capacity,
           t4.movie_id, t4.title, t4.director, t4.genre, t4.running_time, t4.release_date
      from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                          join theater t3  on t1.theater_id = t3.theater_id
                          join movie t4    on t1.movie_id = t4.movie_id;

  select title
    from movie
   where release_date between add_months(sysdate,-1*12*5) and sysdate;
   
  select count(*) 
    from reservation_vw
   where release_date between add_months(sysdate,-1*12*5) and sysdate;   
--�󿵽ð��� ���� ª�� ��ȭ�� �� ��ȭ�� �� ������ �̸��� �̸���    
    select movie_id,title,customer_name,email
      from reservation_vw
     where running_time = (select min(running_time)
                             from movie);
--���� �������� ���� ��ȭ�� �� ���� ����Ʈ�� 10000���� ä��� ���� ���� ����Ʈ
select customer_id, customer_name, points, 10000-points
  from customer
 where customer_id in ( select customer_id
                          from reservation
                         where movie_id in (   select movie_id
                                                 from reservation
                                             group by movie_id 
                                               having count(*) =  ( select max(cnt)
                                                                          from ( select movie_id, count(*) cnt
                                                                                   from reservation
                                                                               group by movie_id )) ));
 select t2.customer_id,t2.customer_name, t2.points, 10000-points
   from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
  where t1.movie_id in ( select movie_id
                           from reservation
                       group by movie_id 
                         having count(*) =  ( select max(cnt)
                                                from ( select movie_id, count(*) cnt
                                                         from reservation
                                                     group by movie_id )) );

--�Ѱ��� ���忡���� �濵�� ��ȭ
select title
  from movie
 where movie_id in ( select movie_id
                       from (  select movie_id, theater_id,count(*)
                                 from reservation_vw
                             group by movie_id, theater_id
                               having count(*) = 1 ) );  
                               
select (select title
          from movie
         where movie_id =  t1.movie_id )
  from (  select movie_id, theater_id, count(*)
            from reservation_vw
        group by movie_id, theater_id
          having count(*) = 1 ) t1;                                 
--��ȭ �濵 �ð��� ���� ���� ����
  select ( select theater_name
             from theater
            where theater_id = t1.theater_id ) "�����", 
          sum(running_time) "�濵�ð�"
    from reservation_vw t1
group by theater_id 
  having sum(running_time) = (  select max(tot_time)
                                  from ( select theater_id, sum(running_time) tot_time
                                           from reservation_vw
                                       group by theater_id ));
--�� ����Ʈ�� ���� ���� ����� ���� ���� ��ȭ
select t2.title
  from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
 where t1.customer_id not in ( select customer_id
                                 from customer 
                                where points =  ( select max(points)
                                                    from customer ) );
--�¼��� ������ ��ȭ�� �濵�� ����
select distinct t1.theater_name, t1.title
  from reservation_vw t1 
 where t1.capacity = ( select count(*)
                         from reservation_vw
                        where theater_id = t1.theater_id
                          and movie_id = t1.movie_id) ;
--���� ���� ����� ��ȭ�� �濵���� ���� ���忡�� �濵�� ��ȭ�� ���� ���� ����� ��ȭ
--1)���� ���� ����� ��ȭ
  select movie_id
    from reservation_vw
group by movie_id 
  having count(*) = (   select max(cnt)
                          from ( select movie_id, count(*) cnt
                                   from reservation_vw
                               group by movie_id ) );   

--2)��ȭ�� �濵���� ���� ���� ���� �濵�� ��ȭ
  select distinct theater_id, movie_id
    from reservation_vw
   where movie_id not in (   select movie_id
                                from reservation_vw
                            group by movie_id 
                              having count(*) = (   select max(cnt)
                                                      from ( select movie_id, count(*) cnt
                                                               from reservation_vw
                                                           group by movie_id ) ) );    
 --3) ���� ���� ����� ��ȭ   
 select ( select theater_name
            from theater
           where theater_id = t1.theater_id ) "�����",
         ( select title
             from movie
            where movie_id = t1.movie_id ) "��ȭ��", 
          max(t1.cnt) "��Ƚ��"
   from ( select theater_id,movie_id, count(*) cnt
            from reservation_vw
           where (theater_id, movie_id) in (  select distinct theater_id, movie_id
                                                from reservation_vw
                                               where movie_id not in (   select movie_id
                                                                            from reservation_vw
                                                                        group by movie_id 
                                                                          having count(*) = (   select max(cnt)
                                                                                                  from ( select movie_id, count(*) cnt
                                                                                                           from reservation_vw
                                                                                                       group by movie_id ) ) ) )    
        group by theater_id,movie_id) t1
group by t1.theater_id,t1.movie_id                                                                                                    
order by "�����", "��ȭ��";
--�ֱ� �Ѵް� ��ȭ�� ���� ���� �� ��  
    select customer_id,count(*)
      from reservation_vw
     where reservation_date between add_months(sysdate,-1) and sysdate
  group by customer_id;
--���� �ֱٿ� ������ ��ȭ 
--�Ѵް� ���� �α��־��� ����
--���� ������ ��ȭ, �󿵽ð�, �����, ��ġ�� ���̽ÿ�
--���� �� ��ȭ�� �󿵽ð��� ���� ª�� �帣��?
--���� ���� ������ �� �帣?



