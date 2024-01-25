--문제 1)
--
--기본 요구사항:
--1. Customers, Orders, OrderDetails, Product 네 개의 테이블을 생성합니다.
--2. Customers 테이블에는 CustomerID, CustomerName, Loc 컬럼이 있어야 합니다.
--3. Orders 테이블에는 OrderID, CustomerID, OrderDate, Status 컬럼이 있어야 합니다.
--4. OrderDetails 테이블에는 OrderDetailID, OrderID, ProductID, Quantity, Price 컬럼이 있어야 합니다.
--5. Product 테이블에는 ProductID, ProductName, ,Price 컬럼이 있어야 합니다.
--6. 모든 테이블은 적절한 데이터 타입을 가진 필요한 기본 키(primary key)와 외래 키(foreign key)를 설정해야 합니다.
--7. 각 테이블에 적어도 5개 이상의 행을 삽입하여 테스트 데이터를 준비합니다.
--
--고급 요구사항 (추가 점수 부여):
--1. Orders 테이블의 Status 컬럼은 'Pending', 'Completed', 'Cancelled' 중 하나의 값을 가질 수 있도록 제약 조건을 설정합니다.
--2. Customers 테이블에서 특정 지역에 거주하는 고객의 수를 찾는 쿼리를 작성합니다.
--3. Orders 테이블에서 최근 30일 이내에 생성된 주문을 찾는 쿼리를 작성합니다.
--4. OrderDetails 테이블을 사용하여 특정 주문의 총 금액을 계산하는 쿼리를 작성합니다.
--5. Customers와 Orders를 조인하여, 각 고객별로 주문 횟수를 계산하는 쿼리를 작성합니다.
--테이블 삭제
drop table orderdetails;
drop table orders;
drop table product;
drop table customers;

--테이블생성
create table customers(
    customer_id     number(3), 
    customername    varchar2(12), 
    loc             varchar2(15),
--    cuser           varchar2(10),   --생성자
    cdate           timestamp,      --생성일시
--    uuser           varchar2(10),   --수정자
    udate           timestamp       --수정일시
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

--기본키(primary key) 제약조건
alter table customers add constraint customers_pk primary key(customer_id);
alter table orders  add constraint orders_pk primary key(order_id);
alter table orderdetails add constraint orderdetails_pk primary key(orderdetail_id);
alter table product add constraint product_pk primary key(product_id);

--외래키(foreign key) 제약조건
alter table orders add constraint orders_fk foreign key (customer_id) references customers;
alter table orderdetails add constraint orderdetail_fk1 foreign key (order_id) references orders;
alter table orderdetails add constraint orderdetail_fk2 foreign key (product_id) references product;

--not null 체크 제약조건
--다른 제약조건과 다르게 constraint 키워드와 함께 추가 불가하며 
--alter table ... modify구문을 사용해야한다.
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

-- 체크 제약조건
alter table orders add constraint orders_ck check (status in ('pending', 'completed', 'cancelled'));

-- unique 제약조건
alter table product add constraint product_uk unique(productname);

-- default 제약조건
--다른 제약조건과 다르게 constraint 키워드와 함께 추가 불가하며 
--alter table ... modify구문을 사용해야한다.
alter table customers modify cdate default sysdate;
alter table customers modify udate default sysdate;

--샘플데이터
insert into customers (customer_id,customername,loc ) values (1,'홍길동1','울산1');
insert into customers (customer_id,customername,loc ) values (2,'홍길동2','울산2');
insert into customers (customer_id,customername,loc ) values (3,'홍길동3','울산3');
insert into customers (customer_id,customername,loc ) values (4,'홍길동4','울산4');
insert into customers (customer_id,customername,loc ) values (5,'홍길동5','울산5');
select * from customers;

insert into orders (order_id,customer_id,orderdate,status) values (1,1,to_date('2024/1/1','YYYY/MM/DD'),'pending');
insert into orders (order_id,customer_id,orderdate,status) values (2,1,to_date('2024/1/2','YYYY/MM/DD'),'pending');
insert into orders (order_id,customer_id,orderdate,status) values (3,2,to_date('2024/1/1','YYYY/MM/DD'),'completed');
insert into orders (order_id,customer_id,orderdate,status) values (4,2,to_date('2024/1/2','YYYY/MM/DD'),'cancelled');
insert into orders (order_id,customer_id,orderdate,status) values (5,2,to_date('2024/1/3','YYYY/MM/DD'),'pending');
select * from orders;

insert into product (product_id,productname,price) values (1,'컴퓨터',1000000);
insert into product (product_id,productname,price) values (2,'프린트',500000);
insert into product (product_id,productname,price) values (3,'마우스',50000);
insert into product (product_id,productname,price) values (4,'키보드',100000);
insert into product (product_id,productname,price) values (5,'모니터',400000);
select * from product;

insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (1,1,1,1,1000000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (2,2,1,1,1000000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (3,2,2,1,500000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (4,3,3,1,50000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (5,4,4,1,100000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) values (6,5,5,1,400000);
select * from orderdetails;



