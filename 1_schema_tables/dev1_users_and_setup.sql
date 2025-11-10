CREATE TABLE Roles (
    RoleID INT NOT NULL,
    RoleName VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Roles PRIMARY KEY (RoleID)
);

CREATE TABLE Users (
    UserID INT NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Users PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Email UNIQUE (Email)
);

CREATE TABLE UserRoles (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    CONSTRAINT PK_UserRoles PRIMARY KEY (UserID, RoleID)
);

CREATE TABLE FacultyDetails (
    FacultyDetailID VARCHAR(10) NOT NULL,
    UserID INT NOT NULL,
    FacultyType VARCHAR(20) NULL,
    CONSTRAINT PK_FacultyDetails PRIMARY KEY (FacultyDetailID)
);

CREATE TABLE Courses (
    CourseID VARCHAR(10) NOT NULL,
    CourseName VARCHAR(50) NOT NULL,
    PrerequisiteCourseID VARCHAR(10) NULL,
    CONSTRAINT PK_Courses PRIMARY KEY (CourseID)
);