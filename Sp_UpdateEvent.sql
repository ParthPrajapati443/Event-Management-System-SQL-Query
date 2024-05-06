ALTER PROC Sp_UpdateEvent
@EventID BIGINT,
@EventName VARCHAR(20),
@EventStartDate DATETIME,
@EventEndDate DATETIME,
@EventDiscription VARCHAR(300),
@EventAddress VARCHAR(200),
@EventImage VARCHAR(MAX),
@Flag VARCHAR(20)
AS
BEGIN
	IF (@Flag = 'Update' AND @EventID != 0) --In this block update the event detail in EventDetalis tabale
		BEGIN
			UPDATE ActivityDetails
			SET ActivityIsDelete = 1
			WHERE EventID = @EventID
			IF(@EventImage = '')
				BEGIN
					SET @EventImage = NULL;
				END
			UPDATE EventDetails
			SET EventName = @EventName, 
				EventStartDate = @EventStartDate, 
				EventEndDate = @EventStartDate, 
				EventDiscription = @EventDiscription, 
				EventAddress = @EventAddress, 
				EventImage = isnull(@EventImage, EventImage)
			WHERE EventID = @EventID
			SELECT '200' AS Code, '200|Event successfully updated' AS [Message]
		END
	ELSE
		BEGIN
			SELECT '400' AS Code, '400|Event not updated' AS [Message]
		END
END