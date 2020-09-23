-- =============================================
-- Author:		FD
-- Create date: 2020-09-21
-- Description:	Adds new Size
-- =============================================
CREATE PROCEDURE [dbo].[AddShoeSize] 
	@BrandName VARCHAR(50),
	@USSize float,
	@UKSize float,
	@EUSize float,
	@FootLength float,
	@GenderID int

AS
BEGIN
	/*--*/
	SET NOCOUNT ON;
	
	DECLARE @BrandUID uniqueidentifier
	DECLARE @BrandExists bit = 
		CASE WHEN (SELECT COUNT(*) FROM dbo.Brand WHERE Name = @BrandName) = 0 THEN 0
			ELSE 1
		END
	
	--If the brand doesn't exist in the database, it will be added
	IF @BrandExists = 0
		BEGIN
			SET @BrandUID = NEWID()
			INSERT INTO Brand (UID, Name)
			VALUES (NEWID(), @BrandName)
		END
	ELSE
		SET @BrandUID =
			(SELECT TOP(1) UID FROM dbo.Brand
			WHERE Name = @BrandName)


	DECLARE @ShoeSizeExists bit = 
		CASE WHEN (SELECT COUNT(*)
					FROM dbo.ShoeSize ss	JOIN dbo.Brand_has_ShoeSize bhss ON ss.UID = bhss.ShoeSizeUID 
											JOIN dbo.Brand b ON b.UID = bhss.BrandUID
					WHERE	bhss.BrandUID = @BrandUID AND
						(	ss.UK_Size = @UKSize
						OR	ss.US_Size = @USSize
						OR	ss.EU_Size = @EUSize)) = 0 THEN 0
			ELSE 1
		END

	IF @ShoeSizeExists > 0
		BEGIN
			RAISERROR ('The US/UK or EU shoe size exists already for that brand.',1,1)
		END
	ELSE
		BEGIN

		DECLARE @ShoeSizeUID uniqueidentifier = NEWID()
		INSERT INTO Shoe_Size (
			ShoeSizeUID,
			US_Size,
			UK_Size,
			EU_Size,
			FootLength_CM,
			GenderID
		)
			VALUES (
			@ShoeSizeUID,
			@USSize,
			@UKSize,
			@EUSize,
			@FootLength,
			@GenderID
			)

		INSERT INTO Brand_has_ShoeSize (
			ShoeSizeUID,
			BrandUID
		)
			VALUES (
			@ShoeSizeUID,
			@BrandUID )
		END
END