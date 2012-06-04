%macro leftjoin(a,b,a_var,b_var=&a_var);
proc sql ;
	create table tmp as
	select * from &a as a
    left join    &b as b
    on a.&a_var = b.&b_var;
quit;
%mend leftjoin;

%macro rightjoin(a,b,a_var,b_var=&a_var);
proc sql ;
	create table tmp as
	select * from &a as a
    right join    &b as b
    on a.&a_var = b.&b_var;
quit;
%mend rightjoin;

%macro innerjoin(a,b,a_var,b_var=&a_var);
proc sql ;
	create table tmp as
	select * from &a as a
    inner join    &b as b
    on a.&a_var = b.&b_var;
quit;
%mend innerjoin;

%macro fulljoin(a,b,a_var,b_var=&a_var);
proc sql ;
	create table tmp as
	select * from &a as a
    inner join    &b as b
    on a.&a_var = b.&b_var;
quit;
%mend fulljoin;
