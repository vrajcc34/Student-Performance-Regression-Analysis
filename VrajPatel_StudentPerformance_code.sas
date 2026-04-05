*import data from file;
proc import datafile="StudentPerformance.csv" out=student replace;
delimiter=',';
getnames=yes;
run;

*creating dummy variables outside using DATA and SET command;
*SET --> tells which data file to use. Since data was written into churn dataset, use this;
*DATA --> tells which dataset to write into after creating the variables. Since dataset names are the same for;
*         DATA and SET commands, it is overwriting the existing datafile;
data student;
set student;
Extra =(ExtracurricularActivities = "Yes"); *dummy variable for extracurricular participation;
run;

*Print the Student Performance dataset;
TITLE "Preview of Student Performance Data";
proc print;
run;

*Analyze distribution of response variable;
title "Histogram for Performence Index";
proc univariate data=student;
var PerformanceIndex;
histogram / normal;
run;

*Create scatterplots to visualize relationships between Performance Index and numeric predictors;
title "GPLOTS for Performance Index and all independent variables";
proc gplot data=student;
plot PerformanceIndex*(HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed);
run;

*Create boxplot to compare Performance Index across extracurricular participation;
title "Boxplot for Performance Index by Extracurricular Activities";
proc sort data=student;
by Extra;
run;

proc boxplot data=student;
plot PerformanceIndex*Extra;
run;

*Full Regression Model for Performance Index with VIF;
title "Full Regression Model for Performance Index with VIF";
proc reg data=student;
model PerformanceIndex = HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra / vif;
run;

*Stepwise Selection Method for Performance Index";
title "Stepwise Selection Method for Performance Index";
proc reg data=student;
model PerformanceIndex = HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra / selection=stepwise;
run;

*Final Refined Regression Model for Performance Index;
title "Final Refined Model for Performance Index";
proc reg data=student;
model PerformanceIndex = HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra;
run;

*Check for outliers and influential points for the final model;  
title "Outlier and Influence Diagnostics for the Performance Index Model";  
proc reg data=student;  
model PerformanceIndex = HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra / influence r;  
plot student.*(HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra predicted.);  
plot npp.*student.;  
run;

*Compute predictions on new values;
title "Compute Predictions for Performance Index";

* STEP 1: create dataset with new value;
data pred;
input HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra;
datalines;
6 85 7 5 1
;
proc print;
run;

* STEP 2: join new dataset with main dataset;
data prediction;
set pred student;
run;
proc print;
run;

* STEP 3: compute regression analysis and confidence/prediction intervals;
proc reg data=prediction;
model PerformanceIndex = HoursStudied PreviousScores SleepHours SampleQuestionPapersPracticed Extra / p clm cli;
run;
