begin transaction isolation level read uncommitted;
select * from ingredient;
select pg_sleep(5);
select * from ingredient;
commit transaction;