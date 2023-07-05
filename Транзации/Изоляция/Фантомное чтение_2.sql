begin transaction isolation level read committed;
update ingredient set country_origin = 'Словения' where weight < 1000;
commit transaction;