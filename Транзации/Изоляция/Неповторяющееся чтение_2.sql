begin transaction isolation level read uncommitted;
insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values(11, 'Вишня', 'Россия', 'гр', 500);
commit transaction;