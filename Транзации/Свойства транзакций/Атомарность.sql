begin  transaction;
select * from ingredient;
insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values (11, 'Краситель', 'Турция', 'мл', 50);
update ingredient set weight = 500 where ingredient_id = 11;
select * from ingredient;
rollback transaction;
select * from ingredient;