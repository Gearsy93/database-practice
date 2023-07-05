USE [view]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 20.04.2018 9:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


1)Таблица машины
CREATE TABLE [dbo].[Cars](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[model] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO






/****** Object:  Table [dbo].[Clients]    Script Date: 20.04.2018 9:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


2)Таблица клиенты
CREATE TABLE [dbo].[Clients](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO




/****** Object:  Table [dbo].[Rental]    Script Date: 20.04.2018 9:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


3)Таблица чееее
CREATE TABLE [dbo].[Rental](
	[idPerson] [int] NOT NULL,
	[idCar] [int] NOT NULL,
	[date] [date] NOT NULL
) ON [PRIMARY]


4)Заполнение
GO
SET IDENTITY_INSERT [dbo].[Cars] ON 
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (1, N'VAZ-2114')
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (2, N'Lada Kalina')
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (3, N'BMW X7')
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (4, N'TOYOTA Camry')
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (5, N'VAZ-2112')
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (6, N'TOYOTA RAV 4')
GO
INSERT [dbo].[Cars] ([id], [model]) VALUES (7, N'NISSAN Almera')
GO
SET IDENTITY_INSERT [dbo].[Cars] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (1, N'Alex')
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (2, N'Mark')
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (3, N'Will')
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (4, N'John')
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (5, N'Nick')
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (6, N'Cave')
GO
INSERT [dbo].[Clients] ([id], [name]) VALUES (7, N'Sam')
GO
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (3, 2, CAST(N'2010-11-10' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (3, 3, CAST(N'2010-11-04' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (3, 3, CAST(N'2011-11-20' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (3, 2, CAST(N'2010-11-10' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (6, 1, CAST(N'2011-12-13' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (7, 5, CAST(N'2005-02-02' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (3, 5, CAST(N'2010-11-04' AS Date))
GO
INSERT [dbo].[Rental] ([idPerson], [idCar], [date]) VALUES (3, 3, CAST(N'2011-11-20' AS Date))
GO

5)Представление
CREATE VIEW viewRental
AS
SELECT [Clients].[name] AS client, [Cars].[model] AS car, [Rental].[date] AS date
FROM [Rental] JOIN [Cars] ON [Rental].[idCar] = [Cars].[id]
     JOIN [Clients] ON [Rental].[idPerson] = [Clients].[id]
GO

6,7)Триггер INSERT, UPDATE
CREATE TRIGGER viewRentalTriggerInsertUpdate ON viewRental
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	MERGE INTO [Cars] AS T
	USING (
		SELECT car
		FROM inserted
	) AS S
	ON T.[model] = S.car
	WHEN NOT MATCHED THEN
		INSERT ([model]) VALUES (S.car);
	
	MERGE INTO [Clients] AS T
	USING (
		SELECT client
		FROM inserted
	) AS S
	ON T.[name] = S.client
	WHEN NOT MATCHED THEN
		INSERT ([name]) VALUES (S.client);

	MERGE INTO [Rental] AS T
	USING (
		SELECT [Cars].[id] AS id_car, [Clients].[id] AS id_client, [date]
		FROM inserted JOIN [Cars] ON inserted.car = [Cars].[model]
					JOIN [Clients] ON inserted.client = [Clients].[name]
	) AS S
	ON T.[idCar] = S.id_car AND T.[idPerson] = S.id_client
	WHEN MATCHED THEN
		UPDATE SET [date] = S.date
	WHEN NOT MATCHED THEN
		INSERT ([idCar], [idPerson], [date]) VALUES (S.id_car, S.id_client, S.date);
END
GO


8) Триггер DELETE
CREATE TRIGGER viewRentalTriggerDelete ON viewRental
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @car NVARCHAR(50)
	DECLARE @id_car INT
	DECLARE @id_deleteClient INT
	DECLARE @deleteClient NVARCHAR(50)

	DECLARE deleteCursor CURSOR
		FOR SELECT car, client FROM deleted
	OPEN deleteCursor
	FETCH NEXT FROM deleteCursor INTO @car, @deleteClient
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @id_car = (SELECT [Cars].[id] FROM [Cars] WHERE [Cars].[model] = @car)
		SET @id_deleteClient = (SELECT [Clients].[id] FROM [Clients] WHERE [Clients].[name] = @deleteClient)
		DELETE FROM [Rental] WHERE [idCar] = @id_car AND [idPerson] = @id_deleteClient
		FETCH NEXT FROM deleteCursor INTO @car, @deleteClient
	END
	CLOSE deleteCursor
	DEALLOCATE deleteCursor
END
GO

8)Тестирование 
--Исходное представление
SELECT * FROM viewRental

--INSERT
--Вставка одной строки
INSERT INTO viewRental(car, client, date) VALUES ('VAZ-2112','Nick', CAST(N'2010-12-20' AS Date))
SELECT * FROM viewRental

--Вставка нескольких строк
INSERT INTO viewRental(car, client, date) VALUES ('TOYOTA RAV 4','Cave', CAST(N'2011-12-13' AS Date)), ('NISSAN Almera','Sam', CAST(N'2005-02-02' AS DATE))
SELECT * FROM viewRental

--UPDATE
--В представлении есть машина и есть клиент
UPDATE viewRental SET date = CAST(N'2018-04-17' AS Date) WHERE car = 'VAZ-2112' AND client = 'Nick'
SELECT * FROM viewRental

--В представлении нет машины, но есть клиент
UPDATE viewRental SET date = CAST(N'2018-03-18' AS Date) WHERE car = 'Perfect Car' AND client = 'Nick'
SELECT * FROM viewRental

--В представлении есть машина, но нет клиента
UPDATE viewRental SET date = CAST(N'2018-02-18' AS Date) WHERE car = 'VAZ-2114' AND client = 'Perfect Client'
SELECT * FROM viewRental

--Обновление нескольких полей
UPDATE viewRental SET date = CONVERT(date,DATEADD(DAY,1,date)) WHERE car = 'VAZ-2112'
SELECT * FROM viewRental
GO

--DELETE
--Удаление одной записи 
DELETE FROM viewRental WHERE car = 'VAZ-2112' AND client = 'Nick'
SELECT * FROM viewRental

--Удаление нескольких записей
DELETE FROM viewRental WHERE car = 'VAZ-2112'
SELECT * FROM viewRental

-- Создание ключей
ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_Rental_Cars] FOREIGN KEY([idCar])
REFERENCES [dbo].[Cars] ([id])
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_Rental_Cars]
GO
ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_Rental_Clients] FOREIGN KEY([idPerson])
REFERENCES [dbo].[Clients] ([id])
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_Rental_Clients]
GO

DROP TABLE [Rental]
GO
DROP TABLE [Cars]
GO
DROP TABLE [Clients]
GO
DROP VIEW viewRental
GO
