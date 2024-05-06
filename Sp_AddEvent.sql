ALTER PROC Sp_AddEvent
@EventName VARCHAR(20),
@EventStartDate DATETIME,
@EventEndDate DATETIME,
@EventDiscription VARCHAR(300),
@EventAddress VARCHAR(200),
@EventCreatedBy BIGINT,
@EventImage VARCHAR(MAX),
@Flag VARCHAR(20)
AS
BEGIN
	IF (@Flag = 'Insert') --In this block insert the event detail in EventDetalis tabale
		BEGIN
			IF (@EventName != '' AND @EventStartDate != '' AND @EventEndDate != '' AND @EventDiscription != '' AND @EventAddress != '' AND @EventCreatedBy != 0) 
				BEGIN
					INSERT INTO EventDetails(EventName, EventStartDate, EventEndDate, EventDiscription, EventAddress, EventCreatedBy, EventIsActive, EventImage, EventIsDelete)
					VALUES (@EventName, @EventStartDate, @EventEndDate, @EventDiscription, @EventAddress, @EventCreatedBy, 0, @EventImage, 0)
					SELECT '200' AS Code, '200|Event successfully added' AS [Message]
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Event not added' AS [Message]
				END
		END
END