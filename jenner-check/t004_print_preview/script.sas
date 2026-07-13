/* Student performance sample (rows drawn from the repo's student_performance.csv) */
data student;
  length ExtracurricularActivities $3;
  input HoursStudied PreviousScores ExtracurricularActivities $ SleepHours
        SampleQuestionPapersPracticed PerformanceIndex;
  Extra = (ExtracurricularActivities = "Yes");  /* dummy variable for extracurricular participation */
  datalines;
7 99 Yes 9 1 91
4 82 No 4 2 65
8 51 Yes 7 2 45
5 52 Yes 5 2 36
7 75 No 8 5 66
3 78 No 9 6 61
7 73 Yes 5 6 63
8 45 Yes 4 6 42
5 77 No 8 2 61
4 89 No 4 0 69
8 91 No 4 5 84
8 79 No 6 2 73
3 47 No 9 2 27
6 47 No 4 2 33
5 79 No 7 8 68
2 72 No 4 3 43
8 73 Yes 8 4 67
6 83 Yes 7 2 70
2 54 Yes 4 9 30
5 75 No 7 0 63
1 99 Yes 4 3 71
6 96 No 9 0 85
9 74 Yes 7 6 73
1 85 No 5 6 57
3 61 No 6 3 35
7 62 Yes 7 4 49
4 79 No 8 9 66
9 84 Yes 6 6 83
3 94 Yes 6 5 74
5 90 Yes 4 3 74
3 61 Yes 7 3 39
7 44 Yes 9 1 36
5 70 Yes 6 9 58
9 52 Yes 8 1 47
7 67 Yes 9 3 60
2 97 Yes 9 4 74
4 59 No 8 3 42
9 72 No 8 2 68
2 55 Yes 4 1 32
9 68 No 5 3 64
;
run;

title "Preview of Student Performance Data";
proc print data=student;
run;
