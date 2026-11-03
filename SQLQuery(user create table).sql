USE DocVerifyDb;
GO

CREATE TABLE dbo.[User]
(
    user_id INT IDENTITY(1,1) PRIMARY KEY,

    username NVARCHAR(100) NOT NULL,

    email NVARCHAR(255) NOT NULL,

    hashed_password NVARCHAR(255) NOT NULL,

    created_at DATETIME2 NOT NULL
        DEFAULT SYSDATETIME(),

    CONSTRAINT UQ_User_Username UNIQUE (username),

    CONSTRAINT UQ_User_Email UNIQUE (email)
);
GO