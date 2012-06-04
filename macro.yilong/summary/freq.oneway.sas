
%macro freq_one(data,var,out);
%let f_count=3.;
%let f_per  =4.1;
proc freq data=&data;
	table &var / out=tmp;
run;
data tmp1;
	set tmp;
	id =1;
	where &var ne .;
run;
%summary(tmp1, count, id, tmp1);
data tmp1;
	set tmp1;
	&var = 8888;
	per = put(sum,&f_count)||"( 100%)";
	keep &var per;
run;
data tmp;
	set tmp;
	length per $20.;
	if &var = . then do;
		&var = 9999;
		per  = put(count,&f_count);
	end; else do;
		per = put(count,&f_count)||"("|| put(percent,&f_per) ||"%)" ;
	end;
	keep &var per;
run;
data tmp;
	set tmp tmp1;
run;
%sort(tmp,&var);

%mend freq_one;

