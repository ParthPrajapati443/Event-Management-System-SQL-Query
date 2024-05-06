ALTER PROC Sp_Logout
@Email VARCHAR(30)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM UserDetails WHERE UserEmail = @Email )  --In this block update value of UserIsActive when user is logout
		BEGIN
			UPDATE UserDetails
			SET UserIsActive = 0
			WHERE UserEmail = @Email 
			SELECT '200' AS Code, '200|Successfull Logout as User' AS [Message]
		END

	ELSE IF EXISTS(SELECT 1 FROM AdminDetails WHERE AdminEmail = @Email )  --In this block update value of UserIsActive when admin is logout
		BEGIN
			UPDATE AdminDetails
			SET AdminIsActive = 0
			WHERE AdminEmail = @Email 
			SELECT '200' AS Code, '200|Successfull Logout as Admin' AS [Message]
		END
			
	ELSE
		BEGIN
			SELECT '400' AS Code, '400|Unsuccessfull Logout' AS [Message]
		END  
END