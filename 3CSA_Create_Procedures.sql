/*
Author: Catikia
Create Stored Procedures
*/

USE CSAMusicStudio
GO

/* Checks for and drops the fnTotalPaid function if it already exists */
IF OBJECT_ID('spStudentPractice') IS NOT NULL
	DROP PROC spStudentPractice;
GO

/* Create a stored procedure that tells how much a student practice since the year specified */
CREATE PROC spStudentPractice
	@StudentID int,
	@Year int, 
	@DaysPracticed int OUTPUT
AS
SELECT @DaysPracticed = SUM(DaysPracticed)
FROM CSALessonInfo
WHERE StudentID = @StudentID 
	AND YEAR(LessonDate) >= @Year;
GO

/* Checks for and drops the spInsertLesson function if it already exists */
IF OBJECT_ID('spInsertLesson') IS NOT NULL
	DROP PROC spInsertLesson;
GO

/* Create a stored procedure that inserts lesson info into the table */
CREATE PROC spInsertLesson
	@StudentID		int = NULL, 
	@LessonDate		date = NULL,
	@Attended		varchar(1) = NULL,
	@Rescheduled	varchar(1) = NULL,
	@RescheduledDate	date = NULL,
	@DaysPracticed	int = NULL,
	@ActualLessonLength	varchar(25) = NULL,
	@TeacherNotes	varchar(200) = NULL
AS
IF @StudentID IS NULL
		THROW 50001, 'Invalid StudentID.', 1;
IF @LessonDate IS NULL OR @LessonDate > GETDATE()
		OR DATEDIFF(dd, @LessonDate, GETDATE()) > 30
	THROW 50001, 'Invalid LessonDate.', 1;
IF @Attended IS NULL
	THROW 50001, 'Invalid Attendance designation.', 1;
IF @Rescheduled IS NULL
	THROW 50001, 'Invalid Rescheduled designation.', 1;
IF @RescheduledDate IS NOT NULL AND @LessonDate < GETDATE()
		OR DATEDIFF(dd, @LessonDate, GETDATE()) > 30
	THROW 50001, 'Invalid RescheduledDate.', 1;
IF @DaysPracticed IS NULL
	THROW 50001, 'Invalid DaysPracticed.', 1;
IF @ActualLessonLength IS NULL
	THROW 50001, 'Invalid Lesson Length.', 1;
IF @TeacherNotes IS NULL
	THROW 50001, 'Invalid Lesson Length.', 1;
INSERT CSALessonInfo
VALUES (@StudentID, @LessonDate, @Attended, @Rescheduled, @RescheduledDate, 
		@DaysPracticed, @ActualLessonLength, @TeacherNotes);
RETURN @@IDENTITY;
