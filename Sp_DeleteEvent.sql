ALTER PROC Sp_DeleteEvent
@EventID BIGINT,
@Flag VARCHAR(20)
AS
BEGIN
	IF(@Flag = 'Delete' AND @EventID != 0)  --This block delete activity of perticular event
		BEGIN
			UPDATE EventDetails
			SET EventIsDelete = 1
			WHERE EventID = @EventID

			UPDATE ActivityDetails
			SET ActivityIsDelete = 1
			WHERE EventID = @EventID
			SELECT '200' AS Code, '200|Event Deleted' AS [Message]
		END
	ELSE
		BEGIN
			SELECT '400' AS Code, '400|Event not Deleted' AS [Message]
		END
END