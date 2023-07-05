begin  transaction;
select * from ingredient;
insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values (11, 'Краситель', 'Турция', 'мл', 50);
select * from ingredient;
insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values (12, 'Вишня', 'Россия', 'гр', 'пятьсот');
select * from ingredient;