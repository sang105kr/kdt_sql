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

--시퀀스제거
drop sequence customers_customer_id;
drop sequence orders_order_id;
drop sequence orderdetails_orderdetail_id;
drop sequence product_product_id;

--시퀀스생성
create sequence customers_customer_id;
create sequence orders_order_id;
create sequence orderdetails_orderdetail_id;
create sequence product_product_id;

--샘플데이터
insert into customers (customer_id,customername,loc ) 
    values (customers_customer_id.nextval,'홍길동1','울산1');
insert into customers (customer_id,customername,loc ) 
    values (customers_customer_id.nextval,'홍길동2','울산1');
insert into customers (customer_id,customername,loc ) 
    values (customers_customer_id.nextval,'홍길동3','울산2');
insert into customers (customer_id,customername,loc ) 
    values (customers_customer_id.nextval,'홍길동4','울산2');
insert into customers (customer_id,customername,loc ) 
    values (customers_customer_id.nextval,'홍길동5','울산2');
select * from customers;

insert into orders (order_id,customer_id,orderdate,status) 
    values (orders_order_id.nextval,1,to_date('2024/1/1','YYYY/MM/DD'),'pending');
insert into orders (order_id,customer_id,orderdate,status) 
    values (orders_order_id.nextval,1,to_date('2024/1/2','YYYY/MM/DD'),'pending');
insert into orders (order_id,customer_id,orderdate,status) 
    values (orders_order_id.nextval,2,to_date('2024/1/1','YYYY/MM/DD'),'completed');
insert into orders (order_id,customer_id,orderdate,status) 
    values (orders_order_id.nextval,2,to_date('2024/1/2','YYYY/MM/DD'),'cancelled');
insert into orders (order_id,customer_id,orderdate,status) 
    values (orders_order_id.nextval,2,to_date('2024/1/3','YYYY/MM/DD'),'pending');
select * from orders;

insert into product (product_id,productname,price) 
    values (product_product_id.nextval,'컴퓨터',1000000);
insert into product (product_id,productname,price) 
    values (product_product_id.nextval,'프린트',500000);
insert into product (product_id,productname,price) 
    values (product_product_id.nextval,'마우스',50000);
insert into product (product_id,productname,price) 
    values (product_product_id.nextval,'키보드',100000);
insert into product (product_id,productname,price) 
    values (product_product_id.nextval,'모니터',400000);
select * from product;

insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) 
    values (orderdetails_orderdetail_id.nextval,1,1,1,1000000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) 
    values (orderdetails_orderdetail_id.nextval,2,1,1,1000000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) 
    values (orderdetails_orderdetail_id.nextval,2,2,1,500000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) 
    values (orderdetails_orderdetail_id.nextval,3,3,1,50000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) 
    values (orderdetails_orderdetail_id.nextval,4,4,1,100000);
insert into orderdetails (orderdetail_id,order_id,product_id,quantity,price) 
    values (orderdetails_orderdetail_id.nextval,5,5,1,400000);
select * from orderdetails;

--인덱스 제거
drop index customers_customername_idx; 
--인덱스 생성
create index customers_customername_idx on customers(customername);

--2. Customers 테이블에서 특정 지역에 거주하는 고객의 수를 찾는 쿼리를 작성합니다.
  select loc "지역명", count(*) "고객수"
    from customers
group by loc; 
--3. Orders 테이블에서 최근 30일 이내에 생성된 주문을 찾는 쿼리를 작성합니다.
select *
  from orders
 where orderdate >= ( select sysdate - interval '30' day  
                        from dual);
select sysdate - interval '30' day  
  from dual;
select sysdate - 30 from dual;    
select to_date(sysdate) - 30 from dual;                        
--4. OrderDetails 테이블을 사용하여 특정 주문의 총 금액을 계산하는 쿼리를 작성합니다.
  select order_id, sum( quantity * price )
    from orderdetails
group by order_id;

--5. Customers와 Orders를 조인하여, 각 고객별로 주문 횟수를 계산하는 쿼리를 작성합니다.
    select t1.customername, count(*)
      from customers t1, orders t2
     where t1.customer_id = t2.customer_id
  group by t1.customername;   
--6. 주문이력이 없는 고객의 이름을 보이시오
select t1.customername
  from customers t1
 where not exists ( select *
                      from orders t2
                     where t2.customer_id = t1.customer_id);

select t1.customername
  from customers t1 left outer join orders t2 on t1.customer_id = t2.customer_id
 where t2.order_id is null;

--7. 일일 판매총액 내림차순으로 주문 정보를 보이시오.(주문번호,고객명,주문액,주문일)
    select t1.orderdate,t3.customername, sum(t2.quantity * t2.price)
      from orders t1, orderdetails t2, customers t3
     where t1.order_id = t2.order_id
       and t1.customer_id = t3.customer_id
  group by t1.orderdate, t3.customername
  order by t1.orderdate, sum(t2.quantity * t2.price) desc; 
       
--8. 3번이상 주문한 고객의 이름을 보이시오.
    select t2.customername, count(*)
      from orders t1, customers t2
     where t1.customer_id = t2.customer_id 
  group by t2.customername
    having count(*) >= 3 ;      


    select *
      from customers t1, orders t2, orderdetails t3, product t4
     where t1.customer_id = t2.customer_id
       and t2.order_id = t3.order_id
       and t3.product_id = t4.product_id;
       
-- 고객 구매 정보       
    select t1.custerme_id, t1.customername, t1.loc,
           t2.order_id, t2.orderdate, t2,status,
           t3.orderdetail_id, t3.quantity. t3.price saleprice,
           t4.product_id, t4.productname, t4.price
      from customers t1, orders t2, orderdetails t3, product t4
     where t1.customer_id = t2.customer_id(+)
       and t2.order_id    = t3.order_id(+)
       and t3.product_id  = t4.product_id(+);       

    select t1.custerme_id, t1.customername, t1.loc,
           t2.order_id, t2.orderdate, t2,status,
           t3.orderdetail_id, t3.quantity. t3.price saleprice,
           t4.product_id, t4.productname, t4.price
      from customers t1 left outer join orders t2       on t1.customer_id = t2.customer_id
                        left outer join orderdetails t3 on t2.order_id = t3.order_id
                        left outer join product t4      on t3.product_id = t4.product_id;


-- 총 구매액이 높은순으로 고객 정보와 총구매액을 보이시오.
select t1.customername, nvl(sum( t1.quantity * t1.saleprice),0)
  from (     select t1.customer_id, t1.customername, t1.loc,
                    t2.order_id, t2.orderdate, t2.status,
                    t3.orderdetail_id, t3.quantity, t3.price saleprice,
                    t4.product_id, t4.productname, t4.price
               from customers t1, orders t2, orderdetails t3, product t4
              where t1.customer_id = t2.customer_id(+)
                and t2.order_id    = t3.order_id(+)
                and t3.product_id  = t4.product_id(+) ) t1
group by  t1.customername
order by  nvl(sum( t1.quantity * t1.saleprice),0) desc;              

-- 뷰생성
create view customer_sales_info_vw as
   select t1.customer_id, t1.customername, t1.loc,
                    t2.order_id, t2.orderdate, t2.status,
                    t3.orderdetail_id, t3.quantity, t3.price saleprice,
                    t4.product_id, t4.productname, t4.price
    from customers t1, orders t2, orderdetails t3, product t4
   where t1.customer_id = t2.customer_id(+)
     and t2.order_id    = t3.order_id(+)
     and t3.product_id  = t4.product_id(+);
         
select *
  from customer_sales_info_vw;
