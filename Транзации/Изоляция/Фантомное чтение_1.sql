begin transaction isolation level read committed;
select * from ingredient where country_origin = 'Россия';
select pg_sleep(5);
select * from ingredient where country_origin = 'Россия';
commit transaction;