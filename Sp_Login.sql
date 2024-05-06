ALTER PROC Sp_Login
@EmailID VARCHAR(30),
@Password VARCHAR(15),
@Role VARCHAR(15)
AS
BEGIN
	IF (@Role = 'User') --This block is check the Email-Id and Password of user for login
		BEGIN
			IF EXISTS(SELECT 1 FROM UserDetails WHERE UserEmail = @EmailID AND UserPassword = @Password)
				BEGIN
					UPDATE UserDetails
					SET UserIsActive = 1
					WHERE UserEmail = @EmailID AND UserPassword = @Password
					DECLARE @id INT
					SET @id = (SELECT UserID FROM UserDetails WHERE UserEmail = @EmailID) 
					SELECT '200' AS Code, '200|Successfull Login as User' AS [Message], @EmailID AS Email, @id AS ID
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|User does not exist' AS [Message]
				END
		END
		
	ELSE IF (@Role = 'Admin') --This block is check the Email-Id and Password of admin for login
		BEGIN
			IF EXISTS(SELECT 1 FROM AdminDetails WHERE AdminEmail = @EmailID AND AdminPassword = @Password)
				BEGIN
					UPDATE AdminDetails
					SET AdminIsActive = 1
					WHERE AdminEmail = @EmailID AND AdminPassword = @Password
					--DECLARE @id INT
					SET @id = (SELECT AdminID FROM AdminDetails WHERE AdminEmail = @EmailID) 
					SELECT '200' AS Code, '200|Successfull Login as Admin' AS [Message], @EmailID AS Email, @id AS ID
				END
			ELSE
				BEGIN
					SELECT '400' AS Code, '400|Admin does not exist' AS [Message]
				END
		END
	ELSE
		BEGIN
			SELECT '400' AS Code, 'Unsuccessfull' AS [Message]
		END  
END