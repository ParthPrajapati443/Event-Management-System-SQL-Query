ALTER PROC Sp_PublishUnpublishEvent
@EventID BIGINT,
@Flag VARCHAR(20)
AS
BEGIN
	IF(@Flag = 'Publish')  --This block is publish event and it's activity by updating value of EventIsActive and IsActive
		BEGIN
			IF (@EventID != 0)
				BEGIN
					UPDATE EventDetails
					SET EventIsActive = 1
					WHERE EventID = @EventID

					UPDATE ActivityDetails
					SET IsActive = 1
					WHERE EventID = @EventID
					SELECT '200' AS Code, '200|Event published' AS [Message]
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Event not published' AS [Message]
				END
		END
	ELSE IF(@Flag = 'Unpublish')  --This block is Unpublish event and it's activity by updating value of EventIsActive and IsActive
		BEGIN
			IF (@EventID != 0)
				BEGIN
					UPDATE EventDetails
					SET EventIsActive = 0
					WHERE EventID = @EventID

					UPDATE ActivityDetails
					SET IsActive = 0
					WHERE EventID = @EventID
					SELECT '200' AS Code, '200|Event Unpublished' AS [Message]
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Event not Unpublished' AS [Message]
				END
		END
END