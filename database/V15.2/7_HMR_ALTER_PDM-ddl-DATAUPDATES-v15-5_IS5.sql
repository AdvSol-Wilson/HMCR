/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases 11.1.0                     */
/* Target DBMS:           MS SQL Server 2017                              */
/* Project file:          APP_HMR.dez                                     */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Alter database script                           */
/* Created on:            2020-02-10 17:11                                */
/* ---------------------------------------------------------------------- */

-- =============================================
-- Author:		Ben Driver
-- Create date: 2020-02-10
-- Updates: 
--	
-- 
-- Description:	Incremnetal DML in support of sprint 5.
--  - Revised data lengths and precisions per changes to Maintenance Services Reporting Manual
--
--
-- =============================================

USE HMR_DEV; -- uncomment appropriate instance
--USE HMR_TST;
--USE HMR_UAT;
--USE HMR_PRD;
GO


/* ---------------------------------------------------------------------- */
/* Drop triggers                                                          */
/* ---------------------------------------------------------------------- */

GO


DROP TRIGGER [dbo].[HMR_RCKFL_RPT_A_S_IUD_TR]
GO


DROP TRIGGER [dbo].[HMR_RCKFL_RPT_I_S_I_TR]
GO


DROP TRIGGER [dbo].[HMR_RCKFL_RPT_I_S_U_TR]
GO


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] DROP CONSTRAINT [HMR_RCKFL_RPT_SUBM_OBJ_FK]
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] DROP CONSTRAINT [HMR_RKFLL_RRT_SUBM_STAT_FK]
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] DROP CONSTRAINT [HMR_RCKFL_RPT_HMR_SRV_ARA_FK]
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] DROP CONSTRAINT [HMR_WRK_RRT_SUBM_STAT_FK]
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] DROP CONSTRAINT [HMR_WRK_RRT_SRV_ARA_FK]
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] DROP CONSTRAINT [HMR_WRK_RRT_SUBM_OBJ_FK]
GO


/* ---------------------------------------------------------------------- */
/* Alter table "dbo.HMR_ROCKFALL_REPORT"                                  */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] ALTER COLUMN [REPORTER_NAME] VARCHAR(1024)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] ALTER COLUMN [MC_PHONE_NUMBER] VARCHAR(30)
GO



/* ---------------------------------------------------------------------- */
/* Alter table "dbo.HMR_ROCKFALL_REPORT_HIST"                             */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [START_LATITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [START_LONGITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [END_LATITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [END_LONGITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [START_OFFSET] NUMERIC(7,3)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [END_OFFSET] NUMERIC(7,3)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [REPORTER_NAME] VARCHAR(1024)
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT_HIST] ALTER COLUMN [MC_PHONE_NUMBER] VARCHAR(30)
GO


/* ---------------------------------------------------------------------- */
/* Alter table "dbo.HMR_WILDLIFE_REPORT_HIST"                             */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] ALTER COLUMN [LATITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] ALTER COLUMN [LONGITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WILDLIFE_REPORT_HIST] ALTER COLUMN [START_OFFSET] NUMERIC(7,3)
GO


/* ---------------------------------------------------------------------- */
/* Alter table "dbo.HMR_WORK_REPORT"                                      */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ALTER COLUMN [RECORD_NUMBER] VARCHAR(30)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ALTER COLUMN [TASK_NUMBER] VARCHAR(30)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ALTER COLUMN [ACTIVITY_NUMBER] VARCHAR(30)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ALTER COLUMN [ACCOMPLISHMENT] NUMERIC(9,2)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ALTER COLUMN [VALUE_OF_WORK] NUMERIC(9,2)
GO


/* ---------------------------------------------------------------------- */
/* Alter table "dbo.HMR_WORK_REPORT_HIST"                                 */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [RECORD_NUMBER] VARCHAR(30)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [TASK_NUMBER] VARCHAR(30)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [ACTIVITY_NUMBER] VARCHAR(30)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [ACCOMPLISHMENT] NUMERIC(9,2)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [START_OFFSET] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [END_OFFSET] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [START_LATITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [START_LONGITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [END_LATITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [END_LONGITUDE] NUMERIC(16,8)
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT_HIST] ALTER COLUMN [VALUE_OF_WORK] NUMERIC(9,2)
GO


/* ---------------------------------------------------------------------- */
/* Add foreign key constraints                                            */
/* ---------------------------------------------------------------------- */

GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] ADD CONSTRAINT [HMR_RCKFL_RPT_SUBM_OBJ_FK] 
    FOREIGN KEY ([SUBMISSION_OBJECT_ID]) REFERENCES [dbo].[HMR_SUBMISSION_OBJECT] ([SUBMISSION_OBJECT_ID])
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] ADD CONSTRAINT [HMR_RKFLL_RRT_SUBM_STAT_FK] 
    FOREIGN KEY ([VALIDATION_STATUS_ID]) REFERENCES [dbo].[HMR_SUBMISSION_STATUS] ([STATUS_ID])
GO


ALTER TABLE [dbo].[HMR_ROCKFALL_REPORT] ADD CONSTRAINT [HMR_RCKFL_RPT_HMR_SRV_ARA_FK] 
    FOREIGN KEY ([SERVICE_AREA]) REFERENCES [dbo].[HMR_SERVICE_AREA] ([SERVICE_AREA_NUMBER])
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ADD CONSTRAINT [HMR_WRK_RRT_SUBM_STAT_FK] 
    FOREIGN KEY ([VALIDATION_STATUS_ID]) REFERENCES [dbo].[HMR_SUBMISSION_STATUS] ([STATUS_ID])
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ADD CONSTRAINT [HMR_WRK_RRT_SUBM_OBJ_FK] 
    FOREIGN KEY ([SUBMISSION_OBJECT_ID]) REFERENCES [dbo].[HMR_SUBMISSION_OBJECT] ([SUBMISSION_OBJECT_ID])
GO


ALTER TABLE [dbo].[HMR_WORK_REPORT] ADD CONSTRAINT [HMR_WRK_RRT_SRV_ARA_FK] 
    FOREIGN KEY ([SERVICE_AREA]) REFERENCES [dbo].[HMR_SERVICE_AREA] ([SERVICE_AREA_NUMBER])
GO


/* ---------------------------------------------------------------------- */
/* Repair/add triggers                                                    */
/* ---------------------------------------------------------------------- */

GO


CREATE TRIGGER [dbo].[HMR_RCKFL_RPT_A_S_IUD_TR] ON HMR_ROCKFALL_REPORT FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update HMR_ROCKFALL_REPORT_HIST set END_DATE_HIST = @curr_date where ROCKFALL_REPORT_ID in (select ROCKFALL_REPORT_ID from deleted) and END_DATE_HIST is null;

  IF EXISTS(SELECT * FROM inserted)
    insert into HMR_ROCKFALL_REPORT_HIST ([ROCKFALL_REPORT_ID], [SUBMISSION_OBJECT_ID], [ROW_NUM], [VALIDATION_STATUS_ID], [MCRR_INCIDENT_NUMBER], [RECORD_TYPE], [SERVICE_AREA], [ESTIMATED_ROCKFALL_DATE], [ESTIMATED_ROCKFALL_TIME], [START_LATITUDE], [START_LONGITUDE], [END_LATITUDE], [END_LONGITUDE], [HIGHWAY_UNIQUE], [HIGHWAY_UNIQUE_NAME], [LANDMARK], [LANDMARK_NAME], [START_OFFSET], [END_OFFSET], [DIRECTION_FROM_LANDMARK], [LOCATION_DESCRIPTION], [DITCH_VOLUME], [TRAVELLED_LANES_VOLUME], [OTHER_TRAVELLED_LANES_VOLUME], [OTHER_DITCH_VOLUME], [HEAVY_PRECIP], [FREEZE_THAW], [DITCH_SNOW_ICE], [VEHICLE_DAMAGE], [COMMENTS], [REPORTER_NAME], [MC_PHONE_NUMBER], [REPORT_DATE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_USERID], [APP_CREATE_TIMESTAMP], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_AUDIT_CREATE_USERID], [DB_AUDIT_CREATE_TIMESTAMP], [DB_AUDIT_LAST_UPDATE_USERID], [DB_AUDIT_LAST_UPDATE_TIMESTAMP], ROCKFALL_REPORT_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [ROCKFALL_REPORT_ID], [SUBMISSION_OBJECT_ID], [ROW_NUM], [VALIDATION_STATUS_ID], [MCRR_INCIDENT_NUMBER], [RECORD_TYPE], [SERVICE_AREA], [ESTIMATED_ROCKFALL_DATE], [ESTIMATED_ROCKFALL_TIME], [START_LATITUDE], [START_LONGITUDE], [END_LATITUDE], [END_LONGITUDE], [HIGHWAY_UNIQUE], [HIGHWAY_UNIQUE_NAME], [LANDMARK], [LANDMARK_NAME], [START_OFFSET], [END_OFFSET], [DIRECTION_FROM_LANDMARK], [LOCATION_DESCRIPTION], [DITCH_VOLUME], [TRAVELLED_LANES_VOLUME], [OTHER_TRAVELLED_LANES_VOLUME], [OTHER_DITCH_VOLUME], [HEAVY_PRECIP], [FREEZE_THAW], [DITCH_SNOW_ICE], [VEHICLE_DAMAGE], [COMMENTS], [REPORTER_NAME], [MC_PHONE_NUMBER], [REPORT_DATE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_USERID], [APP_CREATE_TIMESTAMP], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_AUDIT_CREATE_USERID], [DB_AUDIT_CREATE_TIMESTAMP], [DB_AUDIT_LAST_UPDATE_USERID], [DB_AUDIT_LAST_UPDATE_TIMESTAMP], (next value for [dbo].[HMR_ROCKFALL_REPORT_H_ID_SEQ]) as [ROCKFALL_REPORT_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC hmr_error_handling
END CATCH;
GO


CREATE TRIGGER [dbo].[HMR_RCKFL_RPT_I_S_I_TR] ON HMR_ROCKFALL_REPORT INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted)
    RETURN;


  insert into HMR_ROCKFALL_REPORT ("ROCKFALL_REPORT_ID",
      "SUBMISSION_OBJECT_ID",
      "VALIDATION_STATUS_ID",
      "MCRR_INCIDENT_NUMBER",
      "RECORD_TYPE", 
      "SERVICE_AREA",
      "ESTIMATED_ROCKFALL_DATE",
      "ESTIMATED_ROCKFALL_TIME",
      "START_LATITUDE",
      "START_LONGITUDE",
      "END_LATITUDE",
      "END_LONGITUDE",
      "HIGHWAY_UNIQUE",
      "HIGHWAY_UNIQUE_NAME",
      "LANDMARK",
      "LANDMARK_NAME",
      "START_OFFSET",
      "END_OFFSET",
      "DIRECTION_FROM_LANDMARK",
      "LOCATION_DESCRIPTION",
      "DITCH_VOLUME",
      "TRAVELLED_LANES_VOLUME",
      "OTHER_TRAVELLED_LANES_VOLUME",
      "OTHER_DITCH_VOLUME",
      "HEAVY_PRECIP",
      "FREEZE_THAW",
      "DITCH_SNOW_ICE",
      "VEHICLE_DAMAGE",
      "COMMENTS",
      "REPORTER_NAME",
      "MC_PHONE_NUMBER",
      "REPORT_DATE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_USERID",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "ROCKFALL_REPORT_ID",
      "SUBMISSION_OBJECT_ID",
      "VALIDATION_STATUS_ID",
      "MCRR_INCIDENT_NUMBER", 
      "RECORD_TYPE", 
      "SERVICE_AREA",
      "ESTIMATED_ROCKFALL_DATE",
      "ESTIMATED_ROCKFALL_TIME",
      "START_LATITUDE",
      "START_LONGITUDE",
      "END_LATITUDE",
      "END_LONGITUDE",
      "HIGHWAY_UNIQUE",
      "HIGHWAY_UNIQUE_NAME",
      "LANDMARK",
      "LANDMARK_NAME",
      "START_OFFSET",
      "END_OFFSET",
      "DIRECTION_FROM_LANDMARK",
      "LOCATION_DESCRIPTION",
      "DITCH_VOLUME",
      "TRAVELLED_LANES_VOLUME",
      "OTHER_TRAVELLED_LANES_VOLUME",
      "OTHER_DITCH_VOLUME",
      "HEAVY_PRECIP",
      "FREEZE_THAW",
      "DITCH_SNOW_ICE",
      "VEHICLE_DAMAGE",
      "COMMENTS",
      "REPORTER_NAME",
      "MC_PHONE_NUMBER",
      "REPORT_DATE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_USERID",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC hmr_error_handling
END CATCH;
GO


CREATE TRIGGER [dbo].[HMR_RCKFL_RPT_I_S_U_TR] ON HMR_ROCKFALL_REPORT INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted)
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.ROCKFALL_REPORT_ID = deleted.ROCKFALL_REPORT_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update HMR_ROCKFALL_REPORT
    set "ROCKFALL_REPORT_ID" = inserted."ROCKFALL_REPORT_ID",
      "SUBMISSION_OBJECT_ID" = inserted."SUBMISSION_OBJECT_ID",
      "VALIDATION_STATUS_ID" = inserted."VALIDATION_STATUS_ID",
      "MCRR_INCIDENT_NUMBER" = inserted."MCRR_INCIDENT_NUMBER",
      "RECORD_TYPE" = inserted."RECORD_TYPE",  
      "SERVICE_AREA" = inserted."SERVICE_AREA",
      "ESTIMATED_ROCKFALL_DATE" = inserted."ESTIMATED_ROCKFALL_DATE",
      "ESTIMATED_ROCKFALL_TIME" = inserted."ESTIMATED_ROCKFALL_TIME",
      "START_LATITUDE" = inserted."START_LATITUDE",
      "START_LONGITUDE" = inserted."START_LONGITUDE",
      "END_LATITUDE" = inserted."END_LATITUDE",
      "END_LONGITUDE" = inserted."END_LONGITUDE",
      "HIGHWAY_UNIQUE" = inserted."HIGHWAY_UNIQUE",
      "HIGHWAY_UNIQUE_NAME" = inserted."HIGHWAY_UNIQUE_NAME",
      "LANDMARK" = inserted."LANDMARK",
      "LANDMARK_NAME" = inserted."LANDMARK_NAME",
      "START_OFFSET" = inserted."START_OFFSET",
      "END_OFFSET" = inserted."END_OFFSET",
      "DIRECTION_FROM_LANDMARK" = inserted."DIRECTION_FROM_LANDMARK",
      "LOCATION_DESCRIPTION" = inserted."LOCATION_DESCRIPTION",
      "DITCH_VOLUME" = inserted."DITCH_VOLUME",
      "TRAVELLED_LANES_VOLUME" = inserted."TRAVELLED_LANES_VOLUME",
      "OTHER_TRAVELLED_LANES_VOLUME" = inserted."OTHER_TRAVELLED_LANES_VOLUME",
      "OTHER_DITCH_VOLUME" = inserted."OTHER_DITCH_VOLUME",
      "HEAVY_PRECIP" = inserted."HEAVY_PRECIP",
      "FREEZE_THAW" = inserted."FREEZE_THAW",
      "DITCH_SNOW_ICE" = inserted."DITCH_SNOW_ICE",
      "VEHICLE_DAMAGE" = inserted."VEHICLE_DAMAGE",
      "COMMENTS" = inserted."COMMENTS",
      "REPORTER_NAME" = inserted."REPORTER_NAME",
      "MC_PHONE_NUMBER" = inserted."MC_PHONE_NUMBER",
      "REPORT_DATE" = inserted."REPORT_DATE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_AUDIT_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_AUDIT_LAST_UPDATE_USERID = user_name()
    from HMR_ROCKFALL_REPORT
    inner join inserted
    on (HMR_ROCKFALL_REPORT.ROCKFALL_REPORT_ID = inserted.ROCKFALL_REPORT_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC hmr_error_handling
END CATCH;
GO

