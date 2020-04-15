

/* Updates
1. Added a new Export permission
*/


USE HMR_DEV; -- uncomment appropriate instance
--USE HMR_TST;
--USE HMR_UAT;
--USE HMR_PRD;
GO



DECLARE @utcdate DATETIME = (SELECT getutcdate() AS utcdate)
DECLARE @app_guid UNIQUEIDENTIFIER = (SELECT CASE WHEN SUSER_SID() IS NOT NULL THEN SUSER_SID() ELSE (SELECT CONVERT(uniqueidentifier,STUFF(STUFF(STUFF(STUFF('B00D00A0AC0A0D0C00DD00F0D0C00000',9,0,'-'),14,0,'-'),19,0,'-'),24,0,'-'))) END AS  app_guid)
DECLARE @app_user VARCHAR(30) = (SELECT CASE WHEN SUBSTRING(SUSER_NAME(),CHARINDEX('\',SUSER_NAME())+1,LEN(SUSER_NAME())) IS NOT NULL THEN SUBSTRING(SUSER_NAME(),CHARINDEX('\',SUSER_NAME())+1,LEN(SUSER_NAME())) ELSE CURRENT_USER END AS app_user)
DECLARE @app_user_dir VARCHAR(12) = (SELECT CASE WHEN LEN(SUBSTRING(SUSER_NAME(),0,CHARINDEX('\',SUSER_NAME(),0)))>1 THEN SUBSTRING(SUSER_NAME(),0,CHARINDEX('\',SUSER_NAME(),0)) ELSE 'WIN AUTH' END AS app_user_dir)
BEGIN
	IF NOT EXISTS ( SELECT 1 FROM HMR_PERMISSION WHERE NAME = 'EXPORT' )
		INSERT INTO HMR_PERMISSION (NAME,DESCRIPTION,END_DATE, APP_CREATE_USERID, APP_CREATE_TIMESTAMP, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY) VALUES ('EXPORT','Export Report',NULL, @app_user, @utcdate,@app_guid, @app_user_dir ,@app_user, @utcdate, @app_guid, @app_user_dir)
END