/*********************************************************************
* program name          : means.elong.sas
* description           : macros for means
* sponsor               : xxx
* protocol code         : xxx
* study drug            : xxx
* excel code            : xxx
* current programmer    : Zhang Yilong
* Email                 : elong.zhang@excel-cro.com
* sas version           : sas 9.1.3
/*********************************************************************/

%macro meansElong(data,var,dot_format,datset);

proc means data=&data noprint;
	var &var;
	where &datset=1;
	output out=tot mean=mean std=std min=min max=max median=median n=n nmiss=m; /*参考输出变量表*/
run;

data tot;
 	set tot;
 	 n1=trim(left(n))||"("||trim(left(m))||")";
 	 mean1=trim(left(put(mean,&dot_format)))||"±"||trim(left(put(std,&dot_format))); /*均值估计*/
  	 median1=left(put(median,&dot_format));              /*中位数*/
 	 ev=trim(left(put(min,&dot_format)))||" , "||trim(left(put(max,&dot_format)));    /*极值*/
	keep n1 mean1 median1 ev;
	rename n1=n mean1=mean median1=median;
run;

proc transpose data=tot out=tot;
	var n mean median ev;
run;

data tot;
 	set tot;
 	rename _name_=statistics col1=tot;
run;

proc sort data=&data out=project;
	by grp;
run;

proc means data=project noprint;
	var &var;
	by grp;
	output out=group mean=mean std=std min=min max=max median=median n=n nmiss=m;
run;

data group;
	set group;
 	 n1=trim(left(n))||"("||trim(left(m))||")";
 	 mean1=trim(left(put(mean,&dot_format)))||"±"||trim(left(put(std,&dot_format))); /*均值估计*/
 	 median1=left(put(median,&dot_format));              /*中位数*/
 	 ev=trim(left(put(min,&dot_format)))||" , "||trim(left(put(max,&dot_format)));    /*极值*/
	keep n1 mean1 median1 ev grp;
	rename n1=n mean1=mean median1=median;
run;

proc transpose data=group out=group;
	var n mean median ev;
	id grp;
run;

data group;
	set group;
	rename _name_=statistics;
run;

data M&datset;
merge group tot;
class="&var";
run;

/*************** add datset row******************/
/*data datset;*/
/*	datset="&datset";*/
/*run;*/
/**/

/*data &outdata;*/
/*	set datset M&datset;*/
/*run;*/
/*******************************************************/

proc datasets nolist nowarn;
delete group tot project;
run;

%mend meansElong;

/*%meansElong(analysis,psy1,8.2,itt);*/


