--과제: 영화 예약 시스템을 위한 데이터베이스 SQL 쿼리 작성 및 확장
--
--목표:
--SQL을 사용하여 영화 예약 시스템을 위한 데이터베이스의 테이블을 확장하여 설계하고, 데이터를 쿼리하는 연습을 합니다.
--
--기본 요구사항:
--1.고객, 영화, 예약, 극장 네 개의 테이블을 생성합니다.
--2.고객 테이블에는 고객ID, 고객명, 연락처, 이메일, 적립포인트 컬럼이 있어야 합니다. 
--  적립포인트는 필수, 기본값 0
--3.영화 테이블에는 영화ID, 제목, 감독, 장르, 상영시간, 개봉일 컬럼이 있어야 합니다.
--4.예약 테이블에는 예약ID, 고객ID, 영화ID, 극장ID, 예약일, 상영시간, 좌석 컬럼이 있어야 합니다.
--5.극장 테이블에는 극장ID, 극장명, 위치, 수용인원 컬럼이 있어야 합니다. 
--  수용인원은 최대 300명을 초과하지 않는다.
--6.모든 테이블은 적절한 데이터 타입을 가진 필요한 기본 키(primary key)와 외래 키(foreign key)를 설정해야 합니다.
--7.그외에 필요하다고 생각되는 제약조건, 시퀀스, 뷰, 인덱스를 생성합니다.
--8.ERD를 작성합니다.
--9.각 테이블에 최소 5개 이상의 행을 삽입하여 테스트 데이터를 준비합니다.
--
--고급 요구사항 (추가 점수 부여):
--1.영화 테이블의 개봉일 컬럼을 사용하여 현재 상영 중인 영화를 찾는 쿼리를 작성합니다.
--2.극장 테이블에서 특정 위치에 있는 극장을 찾고, 해당 극장에서 상영하는 영화 목록을 가져오는 쿼리를 작성합니다.
--3.예약 테이블을 사용하여 특정 고객의 예약 내역과 예약한 영화의 정보를 함께 제공하는 쿼리를 작성합니다.
--4.예약과 극장을 조인하여, 각 극장별로 예약된 좌석 수를 계산하는 쿼리를 작성합니다.
--5.가장 인기 있는 영화 장르를 결정하는 쿼리를 작성합니다. (예: 예약 수 기준)
--6.위의 쿼리말고 필요로하는 쿼리문을 3건 작성합니다. (SQL문이 아닌 한글질의문)

--테이블삭제
drop table reservation;
drop table customer;
drop table movie;
drop table theater;

--테이블생성
--고객 테이블
create table customer(
    customer_id     number(3),
    customer_name   varchar2(30),
    contact         varchar2(20),       --연락처
    email           varchar2(100),
    points          number(5)           --적립포인트
);
--영화 테이블
create table movie(
    movie_id        number(3),
    title           varchar2(100),
    director        varchar2(30),       --감독
    genre           varchar2(30),       --장르
    running_time    number(3),          --상영시간(분)
    release_date    date                --개봉일
);
--예약 테이블
create table reservation (
    reservation_id  number(3),
    customer_id     number(3),
    movie_id        number(3),
    theater_id      number(3),
    reservation_date    date,           --예약일
    show_time       number(4),          --상영시간(HHMM)   
    seat            varchar(10)         --좌석
);
--극장 테이블
create table theater(
    theater_id      number(3),
    theater_name    varchar2(100),
    location        varchar2(100),      --위치
    capacity        number(3)           --수용인원
);

--기본키 제약조건
alter table customer add constraint customer_customer_id_pk primary key(customer_id);
alter table movie add constraint movie_movie_id_pk primary key(movie_id);
alter table reservation add constraint reservation_reservation_id_pk primary key(reservation_id);
alter table theater add constraint theater_theater_id_pk primary key(theater_id);

--외래키 제약조건
alter table reservation add constraint reservation_customer_id_fk1
    foreign key (customer_id) references customer(customer_id);
alter table reservation add constraint reservation_movie_id_fk1
    foreign key (movie_id) references movie(movie_id);
alter table reservation add constraint reservation_theater_id_fk1
    foreign key (theater_id) references theater(theater_id);

--not null 제약조건
alter table customer modify points not null ;

--default 제약조건
alter table customer modify points default 0;

--check 제약조건
alter table theater add constraint theater_capacity_ck check (capacity <= 300);

--unique 제약조건
alter table theater add constraint theater_theater_name_uk unique(theater_name);

--시퀀스삭제
drop sequence customer_customer_id_seq;
drop sequence movie_movie_id_seq;
drop sequence reservation_reservation_id_seq;
drop sequence theater_theater_id_seq;
--시퀀스생성
create sequence customer_customer_id_seq;
create sequence movie_movie_id_seq;
create sequence reservation_reservation_id_seq;
create sequence theater_theater_id_seq;

--샘플 데이터
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'고객1','010-1234-1111','client1@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'고객2','010-1234-2222','client2@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'고객3','010-1234-3333','client3@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'고객4','010-1234-4444','client4@example.com');
insert into customer (customer_id,customer_name,contact,email)
    values(customer_customer_id_seq.nextval,'고객5','010-1234-5555','client5@example.com');
    
insert into movie values(movie_movie_id_seq.nextval,'영화1','감독1','장르1',100,to_date('2024-01-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화2','감독2','장르2',200,to_date('2024-02-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화3','감독3','장르3',150,to_date('2024-03-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화4','감독4','장르4',200,to_date('2024-04-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화5','감독5','장르5',300,to_date('2024-05-01','YYYY-MM-DD'));    

insert into theater values(theater_theater_id_seq.nextval,'극장1','위치1',100);
insert into theater values(theater_theater_id_seq.nextval,'극장2','위치2',200);
insert into theater values(theater_theater_id_seq.nextval,'극장3','위치3',300);
insert into theater values(theater_theater_id_seq.nextval,'극장4','위치4',150);
insert into theater values(theater_theater_id_seq.nextval,'극장5','위치5',250);

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

    

