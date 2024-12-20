CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15)
);


CREATE TABLE Teachers (
    TeacherID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Department VARCHAR(100)
);


CREATE TABLE Courses (
    CourseID SERIAL PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    TeacherID INT NOT NULL,
    Description TEXT,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);


CREATE TABLE Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    UNIQUE (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


CREATE TABLE Grades (
    GradeID SERIAL PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    Grade SMALLINT NOT NULL CHECK (Grade BETWEEN 1 AND 5),
    DateAssigned DATE NOT NULL,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);



INSERT INTO Students (FirstName, LastName, DateOfBirth, Email, PhoneNumber)
VALUES (
    'Алексей', 
    'Смирнов', 
    '2003-09-20', 
    'alexey.smirnov@example.com', 
    '+79995552211'
);



-- Обновление электронной почты преподавателя по ID
UPDATE Teachers
SET Email = 'new.email@example.com'
WHERE TeacherID = 5;

-- Обновление электронной почты преподавателя по ФИО (имя и фамилия)
UPDATE Teachers
SET Email = 'new.email@example.com'
WHERE FirstName = 'Иван' AND LastName = 'Петров';


DELETE FROM Grades
WHERE EnrollmentID IN (
    SELECT EnrollmentID
    FROM Enrollments
    WHERE CourseID = 3
);

-- Удаление зачислений студентов на данный курс
DELETE FROM Enrollments
WHERE CourseID = 3;

-- Удаление записи о самом курсе из таблицы Courses
DELETE FROM Courses
WHERE CourseID = 3;

