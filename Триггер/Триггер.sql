-- 1. Cоздание спец. таблицы.
CREATE TABLE spec
(
	id int,
	TableName nvarchar(50),
	ColumnName nvarchar(50),
	MaxValue int
);
--2. Добавление в спец. таблицу записи (1, spec, id, 1). 
INSERT INTO spec(id, TableName, ColumnName, MaxValue)
VALUES (1, 'spec', 'id',1)

--3. Cоздание хранимой процедуры 'prIcrMaxValue'.
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE IncrMaxValue
				@TableName nvarchar(50),
				@ColumnName nvarchar(50),
				@TablValue int OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @idInSpec int 
	SELECT @idInSpec = id
	FROM spec
	WHERE @TableName = TableName AND @ColumnName = ColumnName

	IF(@idInSpec IS NOT NULL)
		BEGIN
			UPDATE spec SET MaxValue+=1, @TablValue = (MaxValue+1) WHERE id = @idInSpec
		END
	ELSE
		BEGIN
			DECLARE @Query nvarchar(256)
			SET @Query = 'SELECT @MaxValue = ( max (' + QUOTENAME(@ColumnName) + ') + 1 ) 
						  FROM ' + QUOTENAME(@TableName)
		    EXECUTE sp_executesql @Query, N'@MaxValue INT OUTPUT', @MaxValue = @TablValue OUTPUT

			IF (@TablValue IS NULL)
				SET @TablValue = 1

			DECLARE @nextId int
			EXECUTE IncrMaxValue'spec', 'id', @nextId OUT

			INSERT INTO spec (id, TableName, ColumnName, MaxValue) 
			    VALUES (@nextId, @TableName, @ColumnName, @TablValue)

				DECLARE @guid nvarchar(50) = CONVERT(nvarchar(50), NEWID())

		        DECLARE @statement nvarchar(max) = '
					CREATE TRIGGER ' + quotename('Trigger' + @TableName + @ColumnName + @guid) + 
					' ON ' + quotename(@TableName) + '
					AFTER INSERT, UPDATE AS 
					BEGIN
						SET NOCOUNT ON;
						DECLARE @maxInsertedVal INT
						SELECT @maxInsertedVal = 
							MAX(inserted.' + quotename(@ColumnName) + ')
								FROM inserted
						UPDATE spec SET MaxValue = @maxInsertedVal
							WHERE id = ' + CONVERT(nvarchar(50), @nextId) + ' AND @maxInsertedVal > MaxValue
					END'

			EXECUTE sp_executesql @stmt = @statement
		END
END
GO

--8. Создание таблицы 'unemptyTable' со столбцом 'id'.
CREATE TABLE unemptyTable 
(
	id int
);

--9. Добавление в таблицу 'unemptyTable' записи (10).
INSERT INTO unemptyTable
VALUES (10)

--10. Вызов ХП с параметрами 'unemptyTable', 'id'. функция должна вернуть `11`. 
DECLARE @id11 int
EXECUTE IncrMaxValue 'unemptyTable', 'id', @id11 OUTPUT
SELECT @id11 AS 'id11'

--11. Создание таблицы 'emptyTable' с полем 'num'.
CREATE TABLE emptyTable
(
	num int
);

--12. Вызов ХП с параметрами 'emptyTable', 'id'. функция должна вернуть `1`.
DECLARE @id1 int
EXECUTE IncrMaxValue 'emptyTable', 'num', @id1 OUTPUT
SELECT @id1 AS 'id1'

--13. Вызов ХП с параметрами 'unemptyTable', 'id'. функция должна вернуть `12`.
DECLARE @id12 int
EXECUTE IncrMaxValue 'unemptyTable', 'id', @id12 OUTPUT
SELECT @id12 AS 'id12'

--14. Вывод содержимого таблицы 'spec'
SELECT 'До срабатывания триггера', * FROM spec

--15. Добавление в таблицу 'emptyTable' (9), (11)
INSERT INTO emptyTable
VALUES (9),(11)

--16. Вывод содержимого таблицы 'spec'
SELECT 'После INSERT инъекции', * FROM spec

--17. Обновляем значение 'id' в таблице, не вызывая ХП напрямую
UPDATE emptyTable SET num += 20

--18. Вывод содержимого таблицы 'spec'
SELECT 'После UPDATE инъекции', * FROM spec

--19. Удаление всех данных
DROP PROCEDURE IncrMaxValue
GO

DROP TABLE spec
GO

DROP TABLE unemptyTable
GO

DROP TABLE emptyTable
GO

