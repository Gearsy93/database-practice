begin  transaction;
select  * from ingredient;
insert into ingredient values(11, 'Краситель', 'Турция', 'мл', 50);
commit transaction;