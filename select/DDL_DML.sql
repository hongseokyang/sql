-- DDL
drop table user;
create table user(
	no int unsigned not null auto_increment,
    email varchar(100) not null default 'NO EMAIL',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    
    primary key(no)
);

desc user;
alter table user add juminbunho char(13) not null  after no;
alter table user drop juminbunho;
alter table user add join_date datetime default now();
alter table user change email email varchar(200) not null default 'no email';
alter table user change dept_name department_name varchar(25);
alter table user rename users; 
desc users;
drop table users;

create table user(
	no int unsigned not null auto_increment,
    email varchar(100) not null default 'NO EMAIL',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    
    primary key(no)
);

-- DML : insert
insert into user values(null, 'kickscar@gmail.com', password('1234'), '안대혁', '개발팀');
insert into user(email, passwd) values('kickscar2@gmail.com', password('1234'));
insert into user(passwd) values(password('1234'));
insert into user(passwd, email) values(password('1234'), 'kickscar2@gmail.com');

select * from user;
select * from user where passwd = password('1234');

-- DML : update
update user
set email = 'hongseok@gmail.com',
    name = '양홍석'
where no = 3;

select * from user;

-- DML : delete
delete 
from user
where no = 4;

select * from user;