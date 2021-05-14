/*
Author: Catherine Ackerson 
Date: 12/7/2017
Class: CIS276DB 26870
Final Project
Executes Stored Procedure spInsertLesson
*/

USE CSAMusicStudio
GO

/* Attempts to insert lesson information into the CSALessonInfo Table using spInsertLesson */
BEGIN TRY
	DECLARE @InvoiceID int;
	EXEC @InvoiceID = spInsertLesson
		@StudentID = 1, 
		@LessonDate = '2017-12-10',
		@Attended = 'Y',
		@Rescheduled = 'N',
		@RescheduledDate = NULL,
		@DaysPracticed = 5,
		@ActualLessonLength = '30 min',
		@TeacherNotes = 'Great Attitude!';
	PRINT 'Row was inserted.';
END TRY
BEGIN CATCH
	PRINT 'An error occurred. Row was not inserted.';
	PRINT 'Error number: ' + 
		CONVERT(varchar, ERROR_NUMBER());
	PRINT 'Error message: ' +
		CONVERT(varchar,ERROR_MESSAGE());
END CATCH;
