%macro keep(data,keep,out=&data);
 
data &out;
    set &data;
    keep &keep;
run;

%mend keep;

