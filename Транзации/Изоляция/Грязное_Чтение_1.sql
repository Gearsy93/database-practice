begin transaction isolation level read uncommitted;
insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values(1, 'Вишня', 'Россия', 'гр', 500);
select pg_sleep(5);
rollback transaction;