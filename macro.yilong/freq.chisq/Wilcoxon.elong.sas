/*********************************************************************
* program name          : wilcoxon.elong.sas
* description           : macros for wilcoxon test
* sponsor               : xxx
* protocol code         : xxx
* study drug            : xxx
* excel code            : xxx
* current programmer    : Zhang Yilong
* Email                 : elong.zhang@excel-cro.com
* sas version           : sas 9.1.3
/*********************************************************************/
%MACRO wkElong(data,var,datset,cncode=100);

%if &cncode=100 %then                     /* cncode = 100 means ignore cn */
	%do;
		PROC NPAR1WAY DATA=&data NOPRINT WILCOXON;
   			WHERE &datset=1;
   			 CLASS grp;
   			   VAR &var;
   			OUTPUT OUT=chisqdat;
		RUN;
	%end;
%else
	%do;
		PROC NPAR1WAY DATA=&data NOPRINT WILCOXON;
   			WHERE &datset=1  AND cn=&cncode;
   			 CLASS grp;
   			   VAR &var;
   			OUTPUT OUT=chisqdat;
		RUN;
	%end;	

DATA WK&datset;
 LENGTH method $18.;
  SET chisqdat;
      chisq  = put(_KW_,6.3);
      p      = put(P_KW,6.3);
	  	   if P_KW<0.001 then p="<0.001";
      method = "WILCOXON";
   KEEP chisq method p;
RUN;

proc datasets nolist nowarn;
	delete chisqdat;
run;

%MEND wkElong;

/*%wkelong(analysis,psy1,itt);*/

