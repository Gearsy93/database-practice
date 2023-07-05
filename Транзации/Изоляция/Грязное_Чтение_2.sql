begin transaction isolation level read uncommitted;
select * from ingredient;
commit transaction;