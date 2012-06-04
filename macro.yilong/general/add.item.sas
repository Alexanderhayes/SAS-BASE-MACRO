%macro add8(data,datset);

data datset;
	datset="&datset";
run;

data &data;
	set datset &data;
run;
%mend add8; 
