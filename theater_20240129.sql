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
    
insert into movie values(movie_movie_id_seq.nextval,'영화1','감독2','장르1',100,to_date('2023-11-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화2','감독2','장르1',200,to_date('2024-02-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화3','감독3','장르2',150,to_date('2024-03-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화4','감독3','장르2',200,to_date('2024-04-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화5','감독3','장르2',300,to_date('2024-05-01','YYYY-MM-DD'));    
insert into movie values(movie_movie_id_seq.nextval,'영화6','감독4','장르3',300,to_date('2024-05-01','YYYY-MM-DD'));    

insert into theater values(theater_theater_id_seq.nextval,'극장1','위치1',100);
insert into theater values(theater_theater_id_seq.nextval,'극장2','위치2',200);
insert into theater values(theater_theater_id_seq.nextval,'극장3','위치3',300);
insert into theater values(theater_theater_id_seq.nextval,'극장4','위치4',150);
insert into theater values(theater_theater_id_seq.nextval,'극장5','위치5',250);

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
--샘플데이터 확인
select * from customer;
select * from movie;
select * from reservation;
select * from theater;

--1.영화 테이블의 개봉일 컬럼을 사용하여 현재 상영 중인 영화를 찾는 쿼리를 작성합니다.
select *
  from movie
 where release_date <= sysdate; 
--2.극장 테이블에서 특정 위치에 있는 극장을 찾고, 해당 극장에서 상영하는 영화 목록을 가져오는 쿼리를 작성합니다.
select t3.title
  from reservation t1, theater t2, movie t3
 where t1.theater_id = t2.theater_id
   and t1.movie_id = t3.movie_id
   and t2.location = '위치1';
--3.예약 테이블을 사용하여 특정 고객의 예약 내역과 예약한 영화의 정보를 함께 제공하는 쿼리를 작성합니다.
select t3.*
  from reservation t1, customer t2, movie t3
 where t1.customer_id = t2.customer_id
   and t1.movie_id = t3.movie_id
   and t2.customer_name = '고객1';
--SQL-99   
select t3.*
  from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                      join movie t3    on t1.movie_id = t3.movie_id
 where t2.customer_name = '고객1';
--4.예약과 극장을 조인하여, 각 극장별로 예약된 좌석 수를 계산하는 쿼리를 작성합니다.
    select t2.theater_name "극장명", count(*) "예약된 좌석 수"
      from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
  group by t2.theater_name;
--5.가장 인기 있는 영화 장르를 결정하는 쿼리를 작성합니다. (예: 예약 수 기준) 
  select genre, count(*) cnt
    from movie
group by genre
having count(*) = ( select max(t1.cnt)
                      from ( select genre, count(*) cnt
                               from movie
                           group by genre ) t1 );

--fetch first ~ rows사용
 select genre, count(*) cnt
   from movie
group by genre 
order by count(*) desc
fetch first 1 rows only;   -- oracle

--분석함수 rank사용
select t1.genre, t1.cnt
  from ( select genre, count(*) as cnt,
                rank() over(order by count(*) desc) as rank
           from movie
        group by genre ) t1
 where t1.rank = 1;

--개봉일로부터 2달이상 지난 영화를 찾는 쿼리 작성
 select *
  from movie
 where release_date <= add_months(sysdate,-2);

--러닝타임이 가장 짧은 영화를 찾는 쿼리 작성
select title, running_time
  from movie
 where running_time = ( select min(running_time)
                          from movie );
--개봉예정작을 찾는 쿼리 작성"
select title, release_date
  from movie
 where release_date > sysdate; 
--장르별로 상영시간이 가장긴 영화의 정보를 결정
  select genre, max(running_time)
    from movie
group by genre; 
--가장 많은 영화감독을 맡은 감독의 영화 정보를 출력
  select director, count(*) cnt
    from movie
group by director
  having count(*) in ( select max(cnt)
                         from (  select director, count(*) cnt
                                   from movie
                               group by director ) );

--특정 고객이 봤던 영화중 가장 오래전에 본 영화"
    select t3.title
      from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                          join movie t3    on t1.movie_id = t3.movie_id
     where t2.customer_name = '고객2'
  order by t1.reservation_date
  fetch first 1 rows only;                           
      
--영화표가 12,000원일 때 영화별 매출총액
    select t2.title "영화제목", count(*) * 12000 "매출액"
      from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
  group by t2.title
  order by count(*) * 12000 desc;

--고객이 극장별 영화를 보는데 보낸 총 시간
  select (select customer_name
            from customer
           where customer_id = t2.customer_id ) "고객명", 
         (select theater_name
            from theater
           where theater_id = t3.theater_id ) "극장명", 
         sum(t4.running_time)   "총 관람시간"
    from reservation t1 join customer t2 on t1.customer_id = t2.customer_id
                        join theater t3  on t1.theater_id  = t3.theater_id
                        join movie t4 on t1.movie_id = t4.movie_id
group by t2.customer_id, t3.theater_id                        
having (select customer_name
            from customer
           where customer_id = t2.customer_id ) = '고객2';    
  
    
--10년동안 개봉한 영화 중 가장 인기있는 영화감독
      select ( select title
                 from movie
               where movie_id = t2.movie_id ) "영화명",
               count(*) "예약건수"
        from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
        where t2.release_date between add_months(sysdate,-1*12*10) and sysdate 
     group by t2.movie_id
     order by count(*) desc
     fetch first 1 rows only;

--위치별 영화관 갯수
    select location, count(*)
      from theater
  group by location;

--상영시간이 가장 긴 영화의 영화감독
  select title, director, running_time
    from movie
   where running_time = ( select max(running_time)
                            from movie );

--장르별 평균 상영시간
    select genre, round(avg(running_time),2)
      from movie
  group by genre ;
--가장 최근에 개봉한 영화"
    select title
      from movie
     where release_date <= sysdate
  order by release_date desc
  fetch first 1 rows only; 
--예약 건수가 가장 많은 영화 조회
   select t2.movie_id, t2.title, count(*)
     from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
 group by t2.movie_id,t2.title
 order by count(*) desc
 fetch first 1 rows only;    
--고객 포인트 적립내역 조회
    select customer_name, points
      from customer;
      
--감독으로 상영중인 영화 찾기
    select t2.director, t2.title
      from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
     where t2.release_date >= sysdate;
--장르로 영화 조회
    select *
      from movie
     where genre = '장르1' ;
--남은 좌석이 많은 영화관 조회
    select count(*)
      from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
                          join movie t3  on t1.movie_id = t3.movie_id
     where t3.release_date >= sysdate
       and t2.theater_id = '1';
  
  select t4.theater_id, 
         t4.theater_name,  
         t4.capacity "수용인원",
         t4.capacity - ( select count(*)
              from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
                                  join movie t3  on t1.movie_id = t3.movie_id
             where t3.release_date >= sysdate
               and t2.theater_id = t4.theater_id ) "남은자리수"
    from theater t4;    
--해당 영화를 상영하는 극장 전부 찾기
    select distinct t2.*
      from reservation t1 join theater t2 on t1.theater_id = t2.theater_id
                          join movie t3 on t1.movie_id = t3.movie_id
     where t3.title = '영화5';
--상영 시간이 긴 영화 찾기 
  select title
    from movie
   where running_time = ( select max(running_time)
                            from movie );
--좌석 수가 가장 많은 극장 찾기
  select theater_name, capacity
    from theater
   where capacity = ( select max(capacity)
                        from theater );
--최근 5년동안 개봉된 영화와 관객의 총합
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
--상영시간이 가장 짧은 영화와 그 영화를 본 관객의 이름과 이메일    
    select movie_id,title,customer_name,email
      from reservation_vw
     where running_time = (select min(running_time)
                             from movie);
--가장 관객수가 많은 영화를 본 고객별 포인트와 10000점을 채우기 위해 남은 포인트
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

--한곳의 극장에서만 방영한 영화
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
--영화 방영 시간이 가장 많은 극장
  select ( select theater_name
             from theater
            where theater_id = t1.theater_id ) "극장명", 
          sum(running_time) "방영시간"
    from reservation_vw t1
group by theater_id 
  having sum(running_time) = (  select max(tot_time)
                                  from ( select theater_id, sum(running_time) tot_time
                                           from reservation_vw
                                       group by theater_id ));
--고객 포인트가 가장 많은 사람이 보지 않은 영화
select t2.title
  from reservation t1 join movie t2 on t1.movie_id = t2.movie_id
 where t1.customer_id not in ( select customer_id
                                 from customer 
                                where points =  ( select max(points)
                                                    from customer ) );
--좌석이 가득찬 영화를 방영한 극장
select distinct t1.theater_name, t1.title
  from reservation_vw t1 
 where t1.capacity = ( select count(*)
                         from reservation_vw
                        where theater_id = t1.theater_id
                          and movie_id = t1.movie_id) ;
--가장 많이 예약된 영화를 방영하지 않은 극장에서 방영한 영화중 가장 많이 예약된 영화
--1)가장 많이 예약된 영화
  select movie_id
    from reservation_vw
group by movie_id 
  having count(*) = (   select max(cnt)
                          from ( select movie_id, count(*) cnt
                                   from reservation_vw
                               group by movie_id ) );   

--2)영화를 방영하지 않은 극장 에서 방영된 영화
  select distinct theater_id, movie_id
    from reservation_vw
   where movie_id not in (   select movie_id
                                from reservation_vw
                            group by movie_id 
                              having count(*) = (   select max(cnt)
                                                      from ( select movie_id, count(*) cnt
                                                               from reservation_vw
                                                           group by movie_id ) ) );    
 --3) 가장 많이 예약된 영화   
 select ( select theater_name
            from theater
           where theater_id = t1.theater_id ) "극장명",
         ( select title
             from movie
            where movie_id = t1.movie_id ) "영화명", 
          max(t1.cnt) "상영횟수"
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
order by "극장명", "영화명";
--최근 한달간 영화를 가장 많이 본 고객  
    select customer_id,count(*)
      from reservation_vw
     where reservation_date between add_months(sysdate,-1) and sysdate
  group by customer_id;
--가장 최근에 개봉한 영화 
--한달간 가장 인기있었던 극장
--고객이 예약한 영화, 상영시간, 극장명, 위치를 보이시오
--현재 상영 영화중 상영시간이 가장 짧은 장르는?
--가장 많은 예약을 한 장르?



