/*
Author: Catherine Ackerson 
Date: 12/7/2017
Class: CIS276DB 26870
Final Project
Call Functions 1
*/

USE CSAMusicStudio
GO

PRINT 'Results for the function "fnTotalPaid": ';
PRINT 'The total amount paid for lessons for this Student is $' + CONVERT(varchar, dbo.fnTotalPaid('1')) + '.';
PRINT ' ';
PRINT 'Results for the function "fnStudentSummary:"';
SELECT *
FROM fnStudentSummary(1);
