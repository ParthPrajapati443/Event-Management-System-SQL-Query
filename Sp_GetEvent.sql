ALTER PROC Sp_GetEvent
@EventID BIGINT,
@EventCreatedBy BIGINT,
@Flag VARCHAR(20)
AS
BEGIN
	IF(@Flag = 'ViewWithoutPublish') --This block give the details of non-publish event which is add by perticular admin
		BEGIN
			SELECT EventID, EventName, EventStartDate, EventEndDate, EventDiscription, EventAddress, EventCreatedBy, EventImage, EventIsActive FROM EventDetails WHERE EventCreatedBy = @EventCreatedBy AND EventIsActive = 0 AND EventIsDelete = 0
		END

	ELSE IF(@Flag = 'ViewWithPublish')  --This block give the details of published event which is add by perticular admin
		BEGIN
			SELECT EventID, EventName, EventStartDate, EventEndDate, EventDiscription, EventAddress, EventCreatedBy, EventImage, EventIsActive FROM EventDetails WHERE EventCreatedBy = @EventCreatedBy AND EventIsActive = 1 AND EventIsDelete = 0
		END

	ELSE IF(@Flag = 'Published')  --This block give the details of published event which is add by all admin
		BEGIN
			SELECT EventID, EventName, EventStartDate, EventEndDate, EventDiscription, EventAddress, EventImage FROM EventDetails WHERE EventIsActive = 1 AND EventEndDate >= GETDATE() AND EventIsDelete = 0
		END

	ELSE IF(@Flag = 'GetEvent')  --This block give details of pearticular event
		BEGIN
			SELECT EventID, EventName, EventStartDate, EventEndDate, EventDiscription, EventAddress, EventImage FROM EventDetails WHERE EventID = @EventID 
		END

	ELSE IF(@Flag = 'GetEventForView')  --This block give details of pearticular event
		BEGIN
			SELECT EventID, EventName, EventStartDate, EventEndDate, EventDiscription, EventAddress, EventImage FROM EventDetails WHERE EventID = @EventID 
		END
END