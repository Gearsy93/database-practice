-- 1.
--Создание спец. таблицы.
CREATE table spec (
	id int,
	table_name nvarchar(50),
	column_name nvarchar(50),
	cur_max int
);

--2.
INSERT INTO spec (id, table_name, column_name, cur_max)
	VALUES (1, 'spec', 'id', 1)

--3.
--Создание хранимой процедуры (ХП)
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IncreaseValue]
	@table_name nvarchar(50),
	@column_name nvarchar(50),
	@next_int int output
AS
BEGIN

	DECLARE @spec_id int 
	SELECT @spec_id = id FROM spec 
		WHERE table_name = @table_name and column_name = @column_name

	IF (@spec_id IS NOT NULL)
	BEGIN
		SELECT @next_int = (cur_max + 1) FROM spec
			WHERE id = @spec_id
		UPDATE spec SET cur_max = @next_int WHERE id = @spec_id
	END
	ELSE
	BEGIN
		DECLARE @query nvarchar(max)
		SET @query = 'SELECT @max_value = (max(' + QUOTENAME(@column_name) + ')+1) FROM ' + QUOTENAME(@table_name)
		EXECUTE sp_EXECUTEsql @query, N'@max_value INT OUTPUT', @max_value = @next_int OUTPUT
		
		IF (@next_int is null)
			SET @next_int = 1

		DECLARE @next_id int
		EXECUTE [dbo].[IncreaseValue] 'spec', 'id', @next_id OUT

		INSERT INTO spec (id, table_name, column_name, cur_max) 
			VALUES (@next_id, @table_name, @column_name, @next_int)
	END
END
GO


--4.
--Вызов вашей ХП с параметрами 'spec', 'id'. Функция должна вернуть `2`.
DECLARE @nextID int
EXECUTE [dbo].[IncreaseValue] 'spec', 'id', @nextID output
SELECT @nextID

--5.
--Распечатка содержимого спец. таблицы. Должна быть 1 строка "(1, spec, id, 2)".
SELECT * FROM spec

--6.
--Вызов вашей ХП с параметрами 'spec', 'id'. Функция должна вернуть `3`
DECLARE @nextID_2 int
EXECUTE [dbo].[IncreaseValue] 'spec', 'id', @nextID_2 OUTPUT
SELECT @nextID_2

--7. 
--Распечатка содержимого спец. таблицы. Должна быть 1 строка "(1, spec, id, 3)".
SELECT * FROM spec

--8. 
--Создание новой таблицы с одним столбцом 'id'. Назовём её test.
CREATE table test(
	id int
);

--9. 
--Добавление в таблицу test записи (10).
INSERT INTO test (id) VALUES (10)

--10. 
--Вызов вашей ХП с параметрами 'test', 'id'. Функция должна вернуть `11`. // место для рекурсии
DECLARE @nextID_3 int
EXECUTE [dbo].[IncreaseValue] 'test', 'id', @nextID_3 OUTPUT
SELECT @nextID_3

--11.
-- Распечатка содержимого спец. таблицы. Должно быть 2 строки "(1, spec, id, 4)" "(4, test, id, 11)".
SELECT * FROM spec

--12. 
--Вызов вашей ХП с параметрами 'test', 'id'. Функция должна вернуть `12`.
DECLARE @nextID_4 int
EXECUTE [dbo].[IncreaseValue] 'test', 'id', @nextID_4 OUTPUT
SELECT @nextID_4

--13. 
--Распечатка содержимого спец. таблицы. Должно быть 2 строки "(1, spec, id, 4)" "(4, test, id, 12)".
SELECT * FROM spec

--14. 
--Создание таблицы 'test2' с столбцами 'numValue1', 'numValue2'.
CREATE table test2(
	numValue1 int,
	numValue2 int
)

--15. 
--Вызов вашей ХП с параметрами 'test2', 'numValue1'. Функция должна вернуть `1`.
DECLARE @nextID_5 int
EXECUTE [dbo].[IncreaseValue] 'test2', 'numValue1', @nextID_5 output
SELECT @nextID_5

--16. 
--Распечатка содержимого спец. таблицы. Должно быть 3 строки "(1, spec, id, 5)" "(4, test, id, 12), (5, test2, numValue1, 1)".
SELECT * FROM spec

--17. 
--Вызов вашей ХП с параметрами 'test2', 'numValue1'. Функция должна вернуть `2`.
DECLARE @nextID_6 int
EXECUTE [dbo].[IncreaseValue] 'test2', 'numValue1', @nextID_6 output
SELECT @nextID_6

--18. 
--Распечатка содержимого спец. таблицы. Должно быть 3 строки "(1, spec, id, 5)" "(4, test, id, 12), (5, test2, numValue1, 2)".
SELECT * FROM spec

--19. 
--Добавление в таблицу 'test2'(numValue1, numValue2) записи (2, 13).
INSERT INTO test2(numValue1, numValue2)
	VALUES (2,13)

--20. 
--Вызов вашей ХП с параметрами 'test2', 'numValue2'. Функция должна вернуть `14`.
DECLARE @nextID_7 int
EXECUTE [dbo].[IncreaseValue] 'test2', 'numValue2', @nextID_7 output
SELECT @nextID_7

--21. 
--Распечатка содержимого спец. таблицы. Должно быть 4 строки "(1, spec, id, 6)" "(4, test, id, 12), (5, test2, numValue1, 2), (6, test2, numValue2, 14)".
SELECT * FROM spec

DROP PROCEDURE [dbo].[IncreaseValue]
GO

DROP table spec
GO

DROP table test
GO

DROP table test2
GO

