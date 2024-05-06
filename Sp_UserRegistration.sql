ALTER PROC Sp_UserRegistration
@Flag VARCHAR(20),
@UserName VARCHAR(20),
@UserEmail VARCHAR(30),
@UserPassword VARCHAR(20),
@UserMobile VARCHAR(15)
AS
BEGIN
	IF (@Flag = 'INSERT')
		BEGIN
			IF (@UserEmail != '' AND @UserPassword != '')
				BEGIN
					IF EXISTS(SELECT 1 FROM UserDetails WHERE UserEmail = @UserEmail)
						BEGIN
							SELECT '400' AS Code, '400|Already Exist' AS [Message]
						END
					ELSE
						BEGIN
							INSERT INTO UserDetails (UserName, UserEmail, UserPassword, UserMobile, UserIsActive)
							VALUES(@UserName, @UserEmail, @UserPassword, @UserMobile, 0) 
							UPDATE UserDetails
							SET UserIsActive = 1
							WHERE UserEmail = @UserEmail AND UserPassword = @UserPassword
							DECLARE @id INT
							SET @id = (SELECT UserID FROM UserDetails WHERE UserEmail = @UserEmail AND UserPassword = @UserPassword) 
							SELECT '200' AS Code, '200|Insertes Successfully' AS [Message], @UserEmail AS Email, @id AS ID
						END
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Enter your email properly.' AS [Message]
				END
		END
	ELSE IF (@Flag = 'GET')
		BEGIN
			IF (@UserEmail IS NULL OR @UserEmail = '')
				BEGIN
					SELECT  UserID,UserName, UserEmail, UserPassword, UserEmail, UserIsActive 
					FROM UserDetails
				END		
			ELSE IF (@UserEmail IS NOT NULL OR @UserEmail != '')
				BEGIN
					IF NOT EXISTS(SELECT 1 FROM UserDetails WHERE UserEmail = @UserEmail)
						BEGIN
							SELECT '400' AS Code, '400|User does not Exist.' AS [Message]
						END
					ELSE
						BEGIN
							SELECT  UserID,UserName, UserEmail, UserPassword, UserEmail, UserIsActive 
							FROM UserDetails 
							WHERE UserEmail = @UserEmail
						END
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Data not found.' AS [Message]
				END
					
			END
END
