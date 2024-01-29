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
    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ1','����1','�帣1',100,to_date('2024-01-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ2','����2','�帣2',200,to_date('2024-02-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ3','����3','�帣3',150,to_date('2024-03-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ4','����4','�帣4',200,to_date('2024-04-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'��ȭ5','����5','�帣5',300,to_date('2024-05-01','YYYY-MM-DD'));    

insert into theater values(theater_theater_id_seq.nextval,'����1','��ġ1',100);
insert into theater values(theater_theater_id_seq.nextval,'����2','��ġ2',200);
insert into theater values(theater_theater_id_seq.nextval,'����3','��ġ3',300);
insert into theater values(theater_theater_id_seq.nextval,'����4','��ġ4',150);
insert into theater values(theater_theater_id_seq.nextval,'����5','��ġ5',250);

insert into reservation 
    values(reservation_reservation_id_seq.nextval,1,1,1,to_date('2024-06-01','YYYY-MM-DD'),1400,'A1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,2,2,1,to_date('2024-06-01','YYYY-MM-DD'),1600,'B1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,3,3,2,to_date('2024-06-01','YYYY-MM-DD'),1800,'C1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,4,4,2,to_date('2024-06-01','YYYY-MM-DD'),2000,'D1');
insert into reservation 
    values(reservation_reservation_id_seq.nextval,5,5,3,to_date('2024-06-01','YYYY-MM-DD'),2200,'E1');


commit;

    

