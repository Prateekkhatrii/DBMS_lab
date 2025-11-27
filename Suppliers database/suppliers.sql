create database supplier_database;
use supplier_database;

create table supplier(sid int primary key,sname varchar(50),city varchar(50));
create table parts(pid int primary key,pname varchar(50),color varchar(50));
create table catalog (sid int,pid int, cost int,
foreign key (sid) references supplier(sid),
foreign key(pid) references parts(pid));

insert into supplier values(10001,"acme widget","bangalore");
insert into supplier values(10002,"johns","kolkata");
insert into supplier values(10003,"vimal","mumbai");
insert into supplier values(10004,"reliance","delhi");

insert into parts values(20001,"book","red");
insert into parts values(20002,"pen","red");
insert into parts values(20003,"pencil","green");
insert into parts values(20004,"mobile","green");
insert into parts values(20005,"charger","black");


insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);


select * from supplier;
select * from parts;
select * from catalog;

select distinct p.pname
from parts p
join catalog c on p.pid=c.pid;

select s.sname
from supplier s
where not exists( select p.pid from parts p where not exists(select * from catalog c where c.sid=s.sid and c.pid=p.pid));
		
select sname from supplier s 
where sid in(select sid from catalog where pid in (select pid from parts where color="red"));

select p.pname from parts p
join catalog c on p.pid=c.pid
join supplier s on s.sid=c.sid
group by p.pname
having count(distinct s.sid)=1
and max(s.sname)="acme widget";

select s.sid
from supplier s 
join catalog c on s.sid=c.sid
where c.cost>(select avg(cost) from catalog where pid=c.pid);

select p.pname, s.sname,c.cost
from catalog c
join supplier s on s.sid=c.sid
join parts p on p.pid=c.pid
where c.cost=(select max(cost) from catalog where pid=c.pid);
