/*
Author: Catherine Ackerson 
Date: 12/7/2017
Class: CIS276DB 26870
Final Project
Create Views
*/

USE CSAMusicStudio
GO

/* Checks for and drops the StudentSummary View if it already exists */
IF OBJECT_ID('CSAStudentSummary') IS NOT NULL
	DROP VIEW CSAStudentSummary;
GO

/* Creates the StudentSummary View */
CREATE VIEW CSAStudentSummary
AS
SELECT TOP (100) PERCENT CSAStudents.StudentID, CSAContactInfo.FName, CSAContactInfo.Lname, CSAContactInfo.Phone1, CSAStudents.LessonRate, CSAStudents.DueWeeklyOrMonthly, 
	(PaymentDate) AS LastPaymentDate, (PaymentAmount) AS LastPaymentAmount, Birthday, (Max(LessonDate)) AS LastLesson, (SongName) AS LastSongPlayed, (TheoryName) AS LastTheoryLearned, 
	(ImprovName) AS LastImprovLearned, (GameName) AS LastGamePlayed, GameLevel, (AwardName) AS LastAwardEarned
FROM CSAStudents JOIN CSAContactInfo
	ON CSAContactInfo.StudentID = CSAStudents.StudentID
	JOIN CSALessonInfo 
	ON CSALessonInfo.StudentID = CSAStudents.StudentID 
	JOIN CSASongsLearned
	ON CSALessonInfo.LessonID = CSASongsLearned.LessonID
	JOIN CSATheoryLearned
	ON CSALessonInfo.LessonID = CSATheoryLearned.LessonID
	JOIN CSAImprovLearned
	ON CSALessonInfo.LessonID = CSAImprovLearned.LessonID
	JOIN CSAGames
	ON CSALessonInfo.LessonID = CSAGames.LessonID
	JOIN CSAAwardsEarned
	ON CSAStudents.StudentID = CSAAwardsEarned.StudentID
	JOIN CSAPaymentInfo
	ON CSAStudents.StudentID = CSAPaymentInfo.StudentID
WHERE StudentOrParentGuardian = 'Student'
   AND SongID IN 
			(
			SELECT MAX(CSASongsLearned.SongID) AS SongID
			FROM CSASongsLearned, CSALessonInfo
			WHERE CSASongsLearned.LessonID = CSALessonInfo.LessonID
			GROUP BY StudentID
			)
	AND TheoryID IN
			(
			SELECT MAX(CSATheoryLearned.TheoryID) AS TheoryID
			FROM CSATheoryLearned, CSALessonInfo
			WHERE CSATheoryLearned.LessonID = CSALessonInfo.LessonID
			GROUP BY StudentID
			)
	AND ImprovID IN
			(
			SELECT MAX(CSAImprovLearned.ImprovID) AS ImprovID
			FROM CSAImprovLearned, CSALessonInfo
			WHERE CSAImprovLearned.LessonID = CSALessonInfo.LessonID
			GROUP BY StudentID
			)
	AND GameID IN
			(
			SELECT MAX(CSAGames.GameID) AS GameID
			FROM CSAGames, CSALessonInfo
			WHERE CSAGames.LessonID = CSALessonInfo.LessonID
			GROUP BY StudentID
			)
	AND AwardID IN
			(
			SELECT MAX(CSAAwardsEarned.AwardID) AS AwardID
			FROM CSAAwardsEarned, CSAStudents
			WHERE CSAAwardsEarned.StudentID = CSAStudents.StudentID
			GROUP BY CSAStudents.StudentID
			)
	AND PaymentID IN
			(
			SELECT MAX(CSAPaymentInfo.PaymentID) AS PaymentID
			FROM CSAPaymentInfo, CSAStudents
			WHERE CSAPaymentInfo.StudentID = CSAStudents.StudentID
			GROUP BY CSAStudents.StudentID
			)
GROUP BY CSAStudents.StudentID, CSAContactInfo.FName, CSAContactInfo.Lname, CSAContactInfo.Phone1, CSAStudents.LessonRate, CSAStudents.DueWeeklyOrMonthly, 
	PaymentDate, PaymentAmount, Birthday, SongName, TheoryName, ImprovName, GameName, GameLevel, AwardName
ORDER BY StudentID;
GO

/* Checks for and drops the PaymentSummary View if it already exists */
IF OBJECT_ID('CSAPaymentSummary') IS NOT NULL
	DROP VIEW CSAPaymentSummary;
GO

/* Creates the PaymentSummary View */
CREATE VIEW CSAPaymentSummary
AS
SELECT CSAStudents.StudentID, CSAContactInfo.FName, CSAContactInfo.Lname, (CSAStudents.LessonRate) AS WeeklyLessonRate, 
	CSAStudents.DueWeeklyOrMonthly, COUNT(DISTINCT PaymentID) AS NumberOfPaymentsMade, COUNT(DISTINCT LessonDate) AS NumberOfLessonsTaken, 
	(COUNT(DISTINCT PaymentID) - COUNT(DISTINCT LessonDate)) AS NumberOfPaidLessonsLeft
FROM CSAStudents JOIN CSAContactInfo
	ON CSAContactInfo.StudentID = CSAStudents.StudentID
	JOIN CSALessonInfo 
	ON CSALessonInfo.StudentID = CSAStudents.StudentID 
	JOIN CSAPaymentInfo
	ON CSAStudents.StudentID = CSAPaymentInfo.StudentID
WHERE StudentOrParentGuardian = 'Student'
GROUP BY CSAStudents.StudentID, FName, LName,LessonRate, DueWeeklyOrMonthly;
GO

/* Checks for and drops the Top5PayingStudents View if it already exists */
IF OBJECT_ID('Top5PayingStudents') IS NOT NULL
	DROP VIEW Top5PayingStudents;
GO

/* Creates the Top5PayingStudents View */
CREATE VIEW Top5PayingStudents
AS
SELECT CSAPaymentInfo.StudentID, CSAContactInfo.FName, CSAContactInfo.Lname, MAX(PaymentDate) AS LatestPayment, AVG(PaymentAmount) AS AvgPayment
FROM CSAPaymentInfo JOIN
	(SELECT TOP 5 StudentID, AVG(PaymentAmount) AS AvgPayment
	FROM CSAPaymentInfo
	GROUP BY StudentID
	ORDER BY AvgPayment DESC) AS TopPayingStudent
	ON CSAPaymentInfo.StudentID = TopPayingStudent.StudentID
	JOIN CSAContactInfo
	ON CSAPaymentInfo.StudentID = CSAContactInfo.StudentID
WHERE StudentOrParentGuardian = 'Student'
GROUP BY CSAPaymentInfo.StudentID, FName, Lname;
GO

/* Checks for and drops the StudentSummary View if it already exists */
IF OBJECT_ID('GameScores') IS NOT NULL
	DROP VIEW GameScores;
GO

/* Creates View of all games played with scores */
CREATE VIEW GameScores
AS
SELECT DISTINCT CSAContactInfo.StudentID, (FName + ' ' + LName) AS StudentName, GameName, 
		(DATENAME(month, DatePlayed) + ' ' + DATENAME(year,DatePlayed)) AS MonthPlayed, GameLevel, GameScore
FROM CSAContactInfo LEFT JOIN CSALessonInfo
	ON CSAContactInfo.StudentID = CSALessonInfo.StudentID
	LEFT JOIN CSAGames
	ON CSALessonInfo.LessonID = CSAGames.LessonID
WHERE StudentOrParentGuardian = 'Student'
GROUP BY CSAContactInfo.StudentID, FName, LName, GameName, DatePlayed, GameLevel, GameScore 
GO