/*********************************************************************
* program name          : wilcoxon.elong.sas
* description           : macros for frequency by column
* sponsor               : xxx
* protocol code         : xxx
* study drug            : xxx
* excel code            : xxx
* current programmer    : Zhang Yilong
* Email                 : elong.zhang@excel-cro.com
* sas version           : sas 9.1.3
/*********************************************************************/
/*===================================================================*/
%MACRO freqElong(data,var,datset);
/*-------------------------------------------------------------------*/
PROC SORT DATA=&data;
	BY grp;
RUN;

PROC FREQ DATA=&data NOPRINT;
   WHERE &datset=1;
     BY grp;
   TABLES &var/ OUT=sfreq1;
RUN;

PROC FREQ DATA=&data NOPRINT;
   WHERE &datset=1;
   TABLES &var/ OUT=sfreq2;
RUN;

DATA sfreq;
  MERGE
        sfreq1(WHERE=(grp=1) RENAME=(COUNT=count1 PERCENT=pct1))
        sfreq1(WHERE=(grp=2) RENAME=(COUNT=count2 PERCENT=pct2))
        sfreq2(RENAME=(COUNT=count0 PERCENT=pct0));
    BY &var;
   RENAME &var=nclass;
  KEEP &var count0 pct0 count1 pct1 count2 pct2;
RUN;

/*-------------------------------------------------------------------*/
DATA freqsum;
  SET sfreq NOBS=last_obs;
    IF nclass^=. THEN DO;count_1+count1;pct_1=100;
                         count_2+count2;pct_2=100;
                         count_0+count0;pct_0=100;
                      END;
    nclass=8888;
    IF _N_=last_obs;
   RENAME count_1 = count1 pct_1 = pct1
          count_2 = count2 pct_2 = pct2
          count_0 = count0 pct_0 = pct0;
   DROP count0-count2 pct0-pct2;
RUN;

/*-------------------------------------------------------------------*/

DATA f&datset;
  SET sfreq freqsum;
   IF nclass=. THEN nclass=9999;
   IF nclass<8888 THEN DO;IF count0=. THEN DO;count0=0;pct0=0;END;
                          IF count1=. THEN DO;count1=0;pct1=0;END;
                          IF count2=. THEN DO;count2=0;pct2=0;END;
                       END;

   IF nclass<9999 THEN DO;col0=PUT(count0,5.)||' ('||PUT(pct0,5.1)||'%)';
                          col1=PUT(count1,5.)||' ('||PUT(pct1,5.1)||'%)';
                          col2=PUT(count2,5.)||' ('||PUT(pct2,5.1)||'%)';
                       END;
                  ELSE DO;col0=PUT(count0,4.);
                          col1=PUT(count1,4.);
                          col2=PUT(count2,4.);
                       END;
   KEEP nclass col0 col1 col2;
RUN;


Proc sort data=f&datset;
	by nclass;
run;

DATA f&datset;
	SET f&datset;
	RENAME nclass=id;
RUN;


proc datasets nolist nowarn;
delete datset greqsum sfreq sfreq1 sfreq2 freqsum;
run;

%MEND freqElong;
/*%freq.elong(Analysis,mha,itt,CHN);*/

