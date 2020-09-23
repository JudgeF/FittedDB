CREATE TABLE [dbo].[ShoeSize] (
    [UID]        UNIQUEIDENTIFIER NOT NULL,
    [US_Size]    FLOAT (53)       NOT NULL,
    [UK_Size]    FLOAT (53)       NOT NULL,
    [EU_SIze]    FLOAT (53)       NOT NULL,
    [FootLength] FLOAT (53)       NOT NULL,
    [GenderID]   INT              DEFAULT ((0)) NOT NULL,
    [Comment]    VARCHAR (50)     NULL,
    PRIMARY KEY CLUSTERED ([UID] ASC)
);


