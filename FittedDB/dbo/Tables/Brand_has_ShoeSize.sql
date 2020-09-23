CREATE TABLE [dbo].[Brand_has_ShoeSize] (
    [ShoeSizeUID] UNIQUEIDENTIFIER NOT NULL,
    [BrandUID]    UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_Brand_has_ShoeSize_Brand] FOREIGN KEY ([BrandUID]) REFERENCES [dbo].[Brand] ([UID]),
    CONSTRAINT [FK_Brand_has_ShoeSize_ShoeSize] FOREIGN KEY ([ShoeSizeUID]) REFERENCES [dbo].[ShoeSize] ([UID])
);



