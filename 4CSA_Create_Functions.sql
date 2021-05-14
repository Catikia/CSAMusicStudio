/*
Author: Catikia
Create Functions
*/

USE CSAMusicStudio
GO

/* Checks for and drops the fnTotalPaid function if it already exists */
IF OBJECT_ID('fnTotalPaid') IS NOT NULL
	DROP FUNCTION fnTotalPaid;
GO

/* Creates the fnTotalPaid function which finds the total paid by student */
CREATE FUNCTION fnTotalPaid
	(@StudentID int)
	RETURNS money
BEGIN
	RETURN (SELECT SUM(PaymentAmount) 
			FROM CSAPaymentInfo
			WHERE StudentID = @StudentID)
END;
GO

/* Checks for and drops the fnStudentSummary function if it already exists */
IF OBJECT_ID('fnStudentSummary') IS NOT NULL
	DROP FUNCTION fnStudentSummary;
GO

/* Creates the fnStudentSummary function which Creates a table of summarizing info on students that took more 
		than the specified number of lessons */
CREATE FUNCTION fnStudentSummary
	(@NumberOfLessonsTaken int)
	RETURNS table
RETURN 
	SELECT CSAContactInfo.StudentID, FName, LName, FavoriteColor, FavoriteSong, FavoriteGenre, Birthday, Goal,
		IIF(SongName = NULL, NULL, COUNT(DISTINCT SongName)) AS TotalSongsLearned,
		IIF(AwardID = NULL, NULL, COUNT(DISTINCT AwardID)) AS TotalAwardsEarned, 
		IIF(TheoryName = NULL, NULL, COUNT(DISTINCT TheoryName)) AS TotalTheoryLearned, 
		COUNT(DISTINCT CSALessonInfo.LessonID) AS TotalLessonsTaken,
		COUNT(DISTINCT PaymentID) AS LessonsPaid, 
		((COUNT(DISTINCT CSALessonInfo.LessonID) - COUNT(DISTINCT PaymentID)) * LessonRate) AS TotalDue, DueWeeklyOrMonthly
	FROM CSAContactInfo JOIN CSAStudents
		ON CSAContactInfo.StudentID = CSAStudents.StudentID
		LEFT JOIN CSALessonInfo 
		ON CSALessonInfo.StudentID = CSAStudents.StudentID 
		LEFT JOIN CSAPaymentInfo
		ON CSAStudents.StudentID = CSAPaymentInfo.StudentID
		LEFT JOIN CSASongsLearned
		ON CSALessonInfo.LessonID = CSASongsLearned.LessonID
		LEFT JOIN CSATheoryLearned
		ON CSALessonInfo.LessonID = CSATheoryLearned.LessonID
		LEFT JOIN CSAAwardsEarned
		ON CSAStudents.StudentID = CSAAwardsEarned.StudentID
	WHERE StudentOrParentGuardian = 'Student'
	GROUP BY CSAContactInfo.StudentID, FName, LName, FavoriteColor, FavoriteSong, FavoriteGenre, Birthday, Goal, LessonRate, DueWeeklyOrMonthly
	HAVING COUNT(DISTINCT CSALessonInfo.LessonID) > @NumberOfLessonsTaken;
