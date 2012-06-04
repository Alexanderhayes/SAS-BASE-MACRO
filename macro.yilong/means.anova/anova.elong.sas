/*********************************************************************
* program name          : means.elong.sas
* description           : macros for anova
* sponsor               : xxx
* protocol code         : xxx
* study drug            : xxx
* excel code            : xxx
* current programmer    : Zhang Yilong
* Email                 : elong.zhang@excel-cro.com
* sas version           : sas 9.1.3
/*********************************************************************/


%MACRO anovaElong(data,var,datset);

PROC GLM DATA=&data OUTSTAT=A&datset NOPRINT;
  CLASS grp cn;
   WHERE &datset=1;
     MODEL &var=grp cn;
RUN;

data datset;
	_TYPE_="SS3";
run;

DATA A&datset;
  LENGTH name 8. datset $8. p $6. chn_srce $8. eng_srce $10.;
   SET A&datset;
   IF _TYPE_="SS3";
         p = put(prob,6.3);
		 f0 = put(F,6.3);
         if prob<0.001 then p="<0.001";
     IF F^ = .;
      name = _n_ - 1;
    datset = "&datset";
    IF UPCASE(TRIM(LEFT(_SOURCE_)))="GRP"                        THEN DO;eng_srce="Treatment"; chn_srce="治疗分组"; END;
    IF UPCASE(TRIM(LEFT(_SOURCE_)))="CN"                         THEN DO;eng_srce="Center";    chn_srce="研究中心"; END;
   KEEP F0 p  _TYPE_ eng_srce chn_srce;
RUN;

/*DATA A&datset;*/
/*	set datset A&datset;*/
/*RUN;*/

proc datasets nolist nowarn;
delete Datset;
run;


%MEND anovaElong;

/*%anovaElong(analysis,psy1,itt);*/

