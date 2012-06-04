%macro summary(data,var,by,out_set,format_minmax=5.2,format_mean=5.2,format_std=6.3,format_N=5.,format_NMISS=3.);
%sort(&data,&by);
proc univariate data=&data noprint;
    var &var;
    by &by;
    output out=&out_set n=n0 mean=mean1 median=median std=std NMISS=NMISS min=min max=max sum=sum;
run;
data &out_set;
    set &out_set;
    if n0 ne 0 then range='('||put(min,&format_minmax)||','||put(max,&format_minmax)||')';
    if mean1 ne . then mean=put(mean1,&format_mean)||'('||put(std,&format_std)||')';
    n = put(n0,&format_N) ||'(' || PUT(NMISS,&format_NMISS) || ')';
run;
%mend summary;

