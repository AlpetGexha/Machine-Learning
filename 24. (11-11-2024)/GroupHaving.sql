use ushtrimjoin;

-- group by
-- sintaksa:
-- select col_name(s)
-- from table_name
-- where cond
-- group col_name
-- order by col_name

-- 1- grupojme studentet sipas moshes/tabela e frekuences se moshes
select Mosha, count(student_id) as Nrstd
from studenti
group by mosha
order by Mosha;

-- 2- klasifikoj studnetet kalues dhe jo kalues
-- fillimisht ndertoj nje kolone me keto dy klasifikime
alter table studenti
add Status_std varchar(50);

set sql_safe_updates = 0;

update studenti
set Status_std = case
	when Piket_Prov>150 then 'Kalues'
    else 'JoKalues'
end;

select Status_std, count(student_id) as Nrstd_kalues
from studenti
group by Status_std
order by Nrstd_kalues desc;

-- 3- sa studente jane rregj ne secilin kurs
select kursi.Emri_Kursi, count(student_id) as Nr_Std_Kurse
from studenti
right join kursi on kursi.Kursi_id = studenti.Kursi_id
group by Emri_Kursi;

-- 4- Piket max dhe min ne secilin kurs
select kursi.Emri_Kursi, min(Piket_Prov) as MinPike, max(Piket_Prov) as MaxPik
from studenti
inner join kursi on kursi.Kursi_id = studenti.Kursi_id
group by Emri_Kursi
order by Emri_Kursi;

-- ///Having

-- 5- grupojme std sipas moshave por dua vetem grupet me me shume se 1 studente
select  Mosha, count(Student_id) as NrStd
from studenti
group by mosha
having NrStd>1
order by NrStd;

-- 6- grupojme std kalues sipas pikeve te provimit dhe grupet me me shume se 1 studente
select Piket_Prov, count(Student_id) as NrStd
from studenti
where Status_std='Kalues'
group by Piket_Prov
having NrStd>1
order by NrStd;


-- Exists
-- sintaksa
-- select col_name
-- from table_name
-- where (exists (select col_name
-- 					from table_name
--                     where cond)) = true/false

-- 7- Emrat e std kalues, ,kursin, viti2
select studenti.Emri_Student, studenti.Student_ID, studenti.Status_std
from studenti
where exists(select Emri_Kursi from kursi
					where kursi.Kursi_id = studenti.Kursi_Id and vit=2) and studenti.Status_std='Kalues';
                    
                    
-- 8- Gjenero kursin qe ka marre max e pikeve
select kursi.Emri_Kursi
from kursi
where exists (select piket_prov from studenti
						where kursi.Kursi_id = studenti.Kursi_Id and piket_prov = 200);

-- ANY
-- select column_name
-- from table_name
-- where colmn_name operator ANY 
-- (select column_name from table-name
--  where cond)

select * from kursi
where kursi_id = any (select kursi_id from studenti
						where Piket_Prov>=180);
                        
-- ALL
-- Sinatksa e ALL
-- select column_name
-- from table_name
-- where colmn_name operator ALL 
-- (select column_name from table-name
--  where cond)
--  
--  operator =, >, < ...

select * from kursi
where kursi_id = all (select kursi_id from studenti
						where Piket_Prov=190);
                        
                        
-- IF
select if (1>2, 'Po', 'Jo') as FilterIf;

select Emri_Student, Mbiemri_Student,
if (strcmp (Emri_Student, Mbiemri_Student) = 0, 'Po', 'Jo') as KontEmrMb
from studenti;

-- IFNULL
-- ifnull(shprehja1, shprehja2) nqs shprehja =Null atehere kthen si vlere shprehja2

select student_id, Adresa, 
ifnull(Adresa, 'Nuk ka info') as AdrPLot
from studenti;

-- Nullif

select nullif('Python', 'Python');
select nullif('Python', '0');
                        
-- Offset limit
-- Vetem rreshti i 4 i te dhenave
select * from studenti
order by Student_ID limit 1 offset 3;

-- rreshti 5-10
select * from studenti
order by Student_ID limit 6 offset 4;