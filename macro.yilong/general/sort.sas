%macro sort(data,var);
proc sort data=&data;
	by &var;
run;
%mend sort;
