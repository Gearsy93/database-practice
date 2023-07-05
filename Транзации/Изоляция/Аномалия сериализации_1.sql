begin transaction isolation level repeatable read;
do $$
declare w_1 integer;
begin
    select sum(weight) into w_1 from ingredient where measurement = 'кг';
    PERFORM pg_sleep(5);
    insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values(12, 'инг2', 'Россия', 'гр', w_1);
end $$;
commit transaction;