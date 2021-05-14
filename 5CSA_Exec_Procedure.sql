/*
Author: Catherine Ackerson 
Date: 12/7/2017
Class: CIS276DB 26870
Final Project
Executes Stored Procedure spStudentPractice
*/

USE CSAMusicStudio
GO

/* Create a stored procedure that tells how much a student practice since the year specified */


DECLARE @TotalDaysPracticed int, @StudentID int, @Year int;
SET @Year = 2008;
SET @StudentID = 1;
EXEC spStudentPractice @StudentID, @Year, @TotalDaysPracticed OUTPUT;

	PRINT 'This Student Practiced ' + CONVERT(varchar,@TotalDaysPracticed)
		 + ' days since ' + CONVERT(varchar,@Year) + '.';
