Create database dbprove;
use dbprove;

create table Punetori(
	Punetori_Id int,
    Emri_Punetori varchar(30),
    Mbiemri_Punetori varchar(30),
    Adresa varchar(255),
    Mosha int
);

-- fshijme gjithe tabelen
drop table punetori;

-- ALTER
-- shtoj/fshij nje kolone
ALter table punetori
add email_adrs varchar(255);

alter table punetori
drop column email_adrs;

alter table punetori
add datelindja date;

alter table punetori
modify column datelindja year;

-- ALter + Constraints
alter table punetori
modify Mosha int Not Null;

create table Punetori(
	Punetori_Id int Not Null,
    Emri_Punetori varchar(30) Not Null,
    Mbiemri_Punetori varchar(30) Not Null,
    Adresa varchar(255),
    Mosha int Not Null,
    constraint u_column unique (Punetori_Id,Emri_Punetori)
);

-- fshij constraint unique
alter table punetori
drop index U_column;


-- PRIMARY KEY

-- MI
create table Punetori(
	Punetori_Id int Not Null,
    Emri_Punetori varchar(30) Not Null,
    Mbiemri_Punetori varchar(30) Not Null,
    Adresa varchar(255),
    Mosha int Not Null,
    primary key (Punetori_Id)
);

-- MII

create table Punetori(
	Punetori_Id int Primary key,
    Emri_Punetori varchar(30) Not Null,
    Mbiemri_Punetori varchar(30) Not Null,
    Adresa varchar(255),
    Mosha int Not Null
);

-- MIII
create table Punetori(
	Punetori_Id int Not Null,
    Emri_Punetori varchar(30) Not Null,
    Mbiemri_Punetori varchar(30) Not Null,
    Adresa varchar(255),
    Mosha int Not Null,
    constraint pk_colmn primary key (Punetori_Id)
);

-- MIV
alter table punetori
modify Punetori_Id int Primary key;

alter table punetori
drop primary key;

-- FOREIGN KEY
Create table Departamenti(
	dep_id int primary key,
    dep_emer varchar(255),
    nr_punonj int,
    Punetori_Id int,
    foreign key (Punetori_Id) references Punetori (Punetori_Id)
);

alter table Departamenti
drop foreign key Punetori_Id;

drop table departamenti;

Create table Departamenti(
	dep_id int primary key,
    dep_emer varchar(255),
    nr_punonj int,
    Punetori_Id int,
    constraint fk_punetori foreign key (Punetori_Id) references Punetori (Punetori_Id)
);

alter table Departamenti
drop foreign key fk_punetori;


-- Deafult
alter table departamenti
modify dep_emer varchar(255) default ('Programim');

alter table punetori
add reg_date date default(current_date());
