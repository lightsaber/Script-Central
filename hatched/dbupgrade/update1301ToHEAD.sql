
--  configuration-goals.sql 
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
           ,1);;

--  EmpProd.sql 
-- rev1363


ALTER TABLE EmpProd ADD isPublicSiteEnabled bit NULL;
UPDATE EmpProd SET isPublicSiteEnabled = 'true';

--  registration.sql 
ALTER TABLE UBH_Registration ADD isMigratedUser bit NULL;
ALTER TABLE EmpProd ADD isCoachingEnabled bit NULL;
UPDATE EmpProd SET isCoachingEnabled = 'true'

-- ROLLBACK
;

--  sleepcoach_intakesurvey.sql 
-- SVN Rev #1337

CREATE TABLE [dbo].[SleepCoach_SurveyData](
	[sid] [bigint] NOT NULL,
	[userId] [bigint] NULL,
	[isSurveyTaken] [bit] NULL,
	[groupId] [bigint] NULL,
	[createDate] [datetime] NULL,
	[modifiedDate] [datetime] NULL,
	[A1] [varchar](2000) NULL,
	[A2] [varchar](2000) NULL,
	[A3] [varchar](2000) NULL,
	[A4] [varchar](2000) NULL,
	[A5] [varchar](2000) NULL,
	[A6] [varchar](2000) NULL,
	[A7] [varchar](2000) NULL,
	[A8] [varchar](2000) NULL,
	[A9a] [varchar](2000) NULL,
	[A9b] [varchar](2000) NULL,
	[A10a] [varchar](2000) NULL,
	[A10b] [varchar](2000) NULL,
	[A11] [varchar](2000) NULL,
	[A12a] [varchar](2000) NULL,
	[A12b] [varchar](2000) NULL,
	[A13] [varchar](2000) NULL,
	[A14] [varchar](2000) NULL,
	[A15a] [varchar](2000) NULL,
	[A15b] [varchar](2000) NULL,
	[A16a] [varchar](2000) NULL,
	[A16b] [varchar](2000) NULL,
	[A17] [varchar](2000) NULL,
	[A18] [varchar](2000) NULL,
	[A19] [varchar](2000) NULL,
	[A20] [varchar](2000) NULL,
	[A21] [varchar](2000) NULL,
	[A22] [varchar](2000) NULL,
	[A23] [varchar](2000) NULL,
	[A24a] [varchar](2000) NULL,
	[A24b] [varchar](2000) NULL,
	[A25] [varchar](2000) NULL,
	[A26] [varchar](2000) NULL,
	[A27] [varchar](2000) NULL,
	[A28] [varchar](2000) NULL,
	[A29] [varchar](2000) NULL,
	[A30] [varchar](2000) NULL,
	[A31] [varchar](2000) NULL,
	[A32] [varchar](2000) NULL,
	[A33] [varchar](2000) NULL,
	[A34] [varchar](2000) NULL,
	[A35] [varchar](2000) NULL,
	[A36] [varchar](2000) NULL,
	[A37] [varchar](2000) NULL,
	[A38a] [varchar](2000) NULL,
	[A38b] [varchar](2000) NULL,
	[A39] [varchar](2000) NULL,
	[A40] [varchar](2000) NULL,
	[A41] [varchar](2000) NULL,
	[A42] [varchar](2000) NULL,
	[A43a] [varchar](2000) NULL,
	[A43b] [varchar](2000) NULL,
	[A43c] [varchar](2000) NULL,
	[A43d] [varchar](2000) NULL,
	[takenByUserId] [bigint] NULL,
	[surveyType] [varchar](50) NULL
) ON [PRIMARY];

--  sleepdiaryday_add_date_columns.sql 
alter table insomniasleepdiaryday
add createdDate datetime;

alter table insomniasleepdiaryday
add modifiedDate datetime;

/* ROLLBACK
alter table insomniasleepdiaryday
drop column createdDate;

alter table insomniasleepdiaryday
drop column modifiedDate;
*/
;

--  user_state_add_date.sql 
DELETE FROM User_State;

ALTER TABLE User_State
ADD  Modified_Date datetime NOT NULL;

-- ROLLBACK
-- ALTER TABLE user_state DROP COLUMN modified_date;
;
