CREATE TABLE [dbo].[Config_Goals](
	[configId] [int] NOT NULL,
	[goalProcessType] [smallint] NULL,
	CONSTRAINT [PK_Config-Goals] PRIMARY KEY CLUSTERED 
(
	[configId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY];


INSERT INTO [Config_Goals]
           ([configId]
           ,[goalProcessType])
     VALUES
           (1
           ,1);ALTER TABLE UBH_Registration ADD isMigratedUser bit NULL;
ALTER TABLE EmpProd ADD isCoachingEnabled bit NULL;
UPDATE EmpProd SET isCoachingEnabled = 'true'

-- ROLLBACK
DELETE FROM User_State;

ALTER TABLE User_State
ADD  Modified_Date datetime NOT NULL;

-- ROLLBACK
-- ALTER TABLE user_state DROP COLUMN modified_date;
