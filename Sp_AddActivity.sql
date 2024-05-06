ALTER PROC Sp_AddActivity
@ActivityID BIGINT,
@ActivityName VARCHAR(20),
@ActivityStartDate DATETIME,
@ActivityEndDate DATETIME,
@ActivityDiscription VARCHAR(300),
@ActivityPrice BIGINT,
@EventID BIGINT,
@Flag VARCHAR(20)
AS
BEGIN
	IF (@Flag = 'Insert') --In this block insert the activity detail in activityDetalis tabale
		BEGIN
			IF (@ActivityName != '' AND @ActivityStartDate != '' AND @ActivityEndDate != '' AND @ActivityDiscription != '' AND @EventID != 0 AND @ActivityPrice > 0) 
				BEGIN
					INSERT INTO ActivityDetails(ActivityName, ActivityStartDate, ActivityEndDate, ActivityDiscription, ActivityPrice, EventID, IsActive, ActivityIsDelete)
					VALUES (@ActivityName, @ActivityStartDate, @ActivityEndDate, @ActivityDiscription, @ActivityPrice, @EventID, 0, 0)
					SELECT '200' AS Code, '200|Activity successfully added' AS [Message]
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Activity not added' AS [Message]
				END
		END

	ELSE IF(@Flag = 'ViewActivity')  --This block give the details of non-publish activity of perticular event
		BEGIN
			SELECT ActivityID, ActivityName, ActivityStartDate, ActivityEndDate, ActivityDiscription, ActivityPrice, EventID FROM ActivityDetails WHERE EventID = @EventID AND IsActive = 0 AND ActivityIsDelete = 0
		END

	ELSE IF(@Flag = 'ViewWithPublish')  --This block give the details of publish activity of perticular event
		BEGIN
			SELECT ActivityID, ActivityName, ActivityStartDate, ActivityEndDate, ActivityDiscription, ActivityPrice, EventID FROM ActivityDetails WHERE EventID = @EventID AND IsActive = 1 AND ActivityIsDelete = 0
		END

	ELSE IF(@Flag = 'GetActivity')  --This block give the details of only one unpublish activity 
		BEGIN
			SELECT ActivityID, ActivityName, ActivityStartDate, ActivityEndDate, ActivityDiscription, ActivityPrice, EventID FROM ActivityDetails WHERE ActivityID = @ActivityID 
		END
	
	ELSE IF(@Flag = 'Update')  --This block delete activity of perticular event
		BEGIN
			IF (@ActivityID != 0)
				BEGIN
					DECLARE @ID BIGINT
					SET @ID = (SELECT EventID FROM ActivityDetails WHERE ActivityID = @ActivityID)
					UPDATE ActivityDetails
					SET ActivityName = @ActivityName, ActivityStartDate = @ActivityStartDate, ActivityEndDate = @ActivityEndDate, 
						ActivityDiscription = @ActivityDiscription, ActivityPrice = @ActivityPrice
					WHERE ActivityID = @ActivityID
					SELECT '200' AS Code, '200|Activity Updated' AS [Message], @ID AS EventID
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Activity not Updated' AS [Message]
				END
		END

	ELSE IF(@Flag = 'Delete')  --This block delete activity of perticular event
		BEGIN
			IF (@ActivityID != 0)
				BEGIN
					SET @ID = (SELECT EventID FROM ActivityDetails WHERE ActivityID = @ActivityID)
					UPDATE ActivityDetails
					SET ActivityIsDelete = 1
					WHERE ActivityID = @ActivityID
					SELECT '200' AS Code, '200|Activity Deleted' AS [Message], @ID AS EventID
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Activity not Deleted' AS [Message]
				END
		END
END