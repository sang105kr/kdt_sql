--���� 1)
--
--�⺻ �䱸����:
--1. Customers, Orders, OrderDetails, Product �� ���� ���̺��� �����մϴ�.
--2. Customers ���̺��� CustomerID, CustomerName, Loc �÷��� �־�� �մϴ�.
--3. Orders ���̺��� OrderID, CustomerID, OrderDate, Status �÷��� �־�� �մϴ�.
--4. OrderDetails ���̺��� OrderDetailID, OrderID, ProductID, Quantity, Price �÷��� �־�� �մϴ�.
--5. Product ���̺��� ProductID, ProductName, ,Price �÷��� �־�� �մϴ�.
--6. ��� ���̺��� ������ ������ Ÿ���� ���� �ʿ��� �⺻ Ű(primary key)�� �ܷ� Ű(foreign key)�� �����ؾ� �մϴ�.
--7. �� ���̺� ��� 5�� �̻��� ���� �����Ͽ� �׽�Ʈ �����͸� �غ��մϴ�.
--
--��� �䱸���� (�߰� ���� �ο�):
--1. Orders ���̺��� Status �÷��� 'Pending', 'Completed', 'Cancelled' �� �ϳ��� ���� ���� �� �ֵ��� ���� ������ �����մϴ�.
--2. Customers ���̺��� Ư�� ������ �����ϴ� ���� ���� ã�� ������ �ۼ��մϴ�.
--3. Orders ���̺��� �ֱ� 30�� �̳��� ������ �ֹ��� ã�� ������ �ۼ��մϴ�.
--4. OrderDetails ���̺��� ����Ͽ� Ư�� �ֹ��� �� �ݾ��� ����ϴ� ������ �ۼ��մϴ�.
--5. Customers�� Orders�� �����Ͽ�, �� ������ �ֹ� Ƚ���� ����ϴ� ������ �ۼ��մϴ�.
--���̺� ����
drop table orderdetails;
drop table orders;
drop table product;
drop table customers;

--���̺����
create table customers(
    customer_id     number(3), 
    customername    varchar2(12), 
    loc             varchar2(15),
--    cuser           varchar2(10),   --������
    cdate           timestamp,      --�����Ͻ�
--    uuser           varchar2(10),   --������
    udate           timestamp       --�����Ͻ�
);
create table orders(
    order_id        number(3), 
    customer_id     number(3), 
    orderdate       date, 
    status          varchar2(10)
);
create table orderdetails(
    orderdetail_id  number(4), 
    order_id        number(3), 
    product_id      number(4), 
    quantity        number(3), 
    price           number(7)
);
create table product(
    product_id      number(4), 
    productname     varchar2(30), 
    price           number(7)
);

--�⺻Ű(primary key) ��������
alter table customers add constraint customers_pk primary key(customer_id);
alter table orders  add constraint orders_pk primary key(order_id);
alter table orderdetails add constraint orderdetails_pk primary key(orderdetail_id);
alter table product add constraint product_pk primary key(product_id);

--�ܷ�Ű(foreign key) ��������
alter table orders add constraint orders_fk foreign key (customer_id) references customers;
alter table orderdetails add constraint orderdetail_fk1 foreign key (order_id) references orders;
alter table orderdetails add constraint orderdetail_fk2 foreign key (product_id) references product;

--not null üũ ��������
--�ٸ� �������ǰ� �ٸ��� constraint Ű����� �Բ� �߰� �Ұ��ϸ� 
--alter table ... modify������ ����ؾ��Ѵ�.
--alter table customers add constraint customers_nn not null(customername);
alter table customers modify customername not null;
alter table customers modify loc not null;

alter table orders modify customer_id not null; 
alter table orders modify orderdate not null; 
alter table orders modify status not null;

alter table orderdetails modify order_id not null; 
alter table orderdetails modify product_id not null; 
alter table orderdetails modify quantity not null; 
alter table orderdetails modify price not null;

alter table product modify productname not null; 
alter table product modify price not null;

-- üũ ��������
alter table orders add constraint orders_ck check (status in ('pending', 'completed', 'cancelled'));

-- unique ��������
alter table product add constraint product_uk unique(productname);

-- default ��������
--�ٸ� �������ǰ� �ٸ��� constraint Ű����� �Բ� �߰� �Ұ��ϸ� 
--alter table ... modify������ ����ؾ��Ѵ�.
alter table customers modify cdate default sysdate;
alter table customers modify udate default sysdate;

--���õ�����
insert into customers (customer_id,customername,loc ) values (1,'ȫ�浿1','���1');
insert into customers (customer_id,customername,loc ) values (2,'ȫ�浿2','���2');
insert into customers (customer_id,customername,loc ) values (3,'ȫ�浿3','���3');
insert into customers (customer_id,customername,loc ) values (4,'ȫ�浿4','���4');
insert into customers (customer_id,customername,loc ) values (5,'ȫ�浿5','���5');
select * from customers;

insert into orders (order_id,customer_id,orderdate,status) values (1,1,to_date('2024/1/1','YYYY/MM/DD'),'pending');
insert into orders (order_id,customer_id,orderdate,status) values (2,1,to_date('2024/1/2','YYYY/MM/DD'),'pending');
insert into orders (order_id,customer_id,orderdate,status) values (3,2,to_date('2024/1/1','YYYY/MM/DD'),'completed');
insert into orders (order_id,customer_id,orderdate,status) values (4,2,to_date('2024/1/2','YYYY/MM/DD'),'cancelled');
insert into orders (order_id,customer_id,orderdate,status) values (5,2,to_date('2024/1/3','YYYY/MM/DD'),'pending');
select * from orders;

insert into product (product_id,productname,price) values (1,'��ǻ��',1000000);
insert into product (product_id,productname,price) values (2,'����Ʈ',500000);
insert into product (product_id,productname,price) values (3,'���콺',50000);
insert into product (product_id,productname,price) values (4,'Ű����',100000);
insert into product (product_id,productname,price) values (5,'�����',400000);
select * from product;

insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (1,1,1,1,1000000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (2,2,1,1,1000000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (3,2,2,1,500000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (4,3,3,1,50000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (5,4,4,1,100000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (6,5,5,1,400000);
select * from orderdetails;



