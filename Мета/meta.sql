DROP TABLE IF EXISTS spec;
DROP TABLE IF EXISTS test;

-- Создание специальной таблицы
create table spec
(
	id int,
	table_name varchar(15),
	column_name varchar(15),
	cur_max int
);

-- Добавление записи  (1, spec, id, 1)
insert into spec (id, table_name, column_name, cur_max) values (1, 'spec', 'id', 1);

-- Создание хранимой процедуры
create or replace function increments(table_name_ text, column_name_ text) returns int
language plpgsql
as $$
declare 
	id_ int;
	new_max int;
	trigger_count int;
	trigger_name_ text;
	column_type text;
begin

	--Проверка наличия таблицы
		if not exists(select * from pg_stat_user_tables where relname = table_name_)
		then raise exception 'Таблица % не найдена', table_name_;
		end if;
	
	--Проверка наличия столбца
		select data_type from information_schema.columns where table_name = table_name_ and column_name = column_name_ into column_type;
		if column_type is NULL then
			raise exception 'Стоблец % не существует', column_name_;
		elseif column_type <> 'integer' then
			raise exception 'Тип столбца % таблицы % не целочисленный', column_name_, table_name_;
		end if;

	select id into id_ from spec
	where table_name = table_name_
	and
	column_name = column_name_;
	if (id_ is not null) then
		select (cur_max + 1) into new_max from spec
		where id = id_;
		 
		update spec set cur_max = new_max where id = id_;
	else 
	declare
		max_value int;
	begin

		execute format('SELECT (max(%s) + 1)  from %s', column_name_, table_name_)
		into max_value;
		if max_value is null then
			new_max:= 1;
		else 
			new_max = max_value;
		end if;	
			declare 
				next_id int;
				guid varchar(50);
				dyn_statement varchar(1000);
			begin
				next_id:= increments('spec', 'id');
				insert into spec (id, table_name, column_name, cur_max) values (next_id, table_name_, trigger_count, new_max);
				
--Получаем количество имеющихся триггеров в таблице
				select count(distinct trigger_name) + 1 from information_schema.triggers
				where event_object_table = table_name_ into trigger_count;
--Создание имени триггера на основе существующих				
				trigger_name_ = table_name_ || '_' || column_name_ || '_';
--Проверка наличия триггера с таким именем				
				if not exists(select * from information_schema.triggers where trigger_name = (trigger_name_ || trigger_count)) then
					trigger_name_ = trigger_name_ || trigger_count;
				else
					guid = gen_random_uuid();
					guid = replace(guid,'-','_');
					trigger_name_ = trigger_name_ || guid;
				end if;
				
				
				dyn_statement = format('
									   create or replace function %s() returns trigger
									   language plpgsql as $trig$
									   declare max_val int;
									   begin 
									   	   select max(%s.%s) from %s into max_val;
									       update spec set cur_max = max_val
									  	   where id = %s and max_val > cur_max;
									   		return new;
									   end; $trig$;
									   create trigger %s after insert or update
									   on %s execute procedure %s(%s);
									   ', trigger_name_, table_name_, column_name_, table_name_, next_id, trigger_name_, table_name_, trigger_name_,table_name_);
				execute dyn_statement;					  				   
			end;
				
	end;
	end if;
	return new_max;
end;
$$;

--Тестирование

--1. Создание таблицы 'test' со столбцом 'id'.
create table test 
(
	id int,
	num int,
	third int,
	st text
);


--2. Добавление в таблицу 'test' записи (10).
--INSERT INTO test (id, num, third, st) VALUES (10, 5, 6, 'st');

--3. Проверка несуществующей таблицы.
--select increments('tess','id');

--4.Проверка несуществующего столбцы.
--select increments('test','ids');

--5.Проверка нецелочисленного столбца.
--select increments('test','st');

--6.Проверка существующего столбца существующей таблицы

--Создать триггер на поле num
--select increments('test','num');
--select * from spec;

--Обновить значение вне процедуры
--update test set num = 9;
--select * from spec;

--6.Попытка создания существующего триггера:

--Создаем триггер на поле id, присвоится номер 2
--select increments('test','id');

--Создаем функцию
/*
create or replace function test_third_3() returns trigger language plpgsql as $trig$
begin
	return new;
end;
$trig$;
*/
--Создаем триггер

/*
create trigger test_third_3 after insert or update on spec
	for each row
execute function test_third_3();
*/

--Проверяем, что создается триггер с UUID
--select increments('test', 'third');









