begin transaction isolation level repeatable read;
do $$
declare w_1 integer;
begin
    select sum(weight) into w_1 from ingredient where measurement = 'гр';
    PERFORM pg_sleep(5);
    insert into ingredient(ingredient_id, ingredient, country_origin, measurement, weight) values(11, 'инг1', 'Россия', 'кг', w_1);
end $$;
commit transaction;