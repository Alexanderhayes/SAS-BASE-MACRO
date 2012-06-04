/*********************************************************************
* program name          : mfisher.elong.sas
* description           : macros for fisher exact test
* sponsor               : xxx
* protocol code         : xxx
* study drug            : xxx
* excel code            : xxx
* current programmer    : Zhang Yilong
* Email                 : elong.zhang@excel-cro.com
* sas version           : sas 9.1.3
/*********************************************************************/
%MACRO fisherElong(data,var,datset,method,cncode=100);

%if &cncode=100 %then 
	%do;
		PROC FREQ DATA=&data NOPRINT;
   			WHERE &datset=1;
    		TABLES grp*&var/EXACT CHISQ NOWARN;
    		EXACT FISHER/MAXTIME=2;
   			OUTPUT OUT=chisqdat EXACT CHISQ;
		RUN;
	%end;
%else
	%do;
		PROC FREQ DATA=&data NOPRINT;
   			WHERE &datset=1AND cn=&cncode;
    		TABLES grp*&var/EXACT CHISQ NOWARN;
    		EXACT FISHER/MAXTIME=2;
   			OUTPUT OUT=chisqdat EXACT CHISQ;
		RUN;
	%end;

%If &method="FISHER" %then
	%do;
DATA fisher&datset;
 LENGTH method $18.;
  SET chisqdat;
      chisq  = .;
      prob   = xp2_fish;
      method = "FISHER";
     /*--------------------------------------------------------------*/
     /*  if fisher runtime too long (>2 second) then do chisq        */
     IF prob =. THEN DO;chisq  = _pchi_;
                        prob   = p_pchi;
                        method = "CHISQ";
                     END;
     /*--------------------------------------------------------------*/
	  
	 chisq =put(chisq,6.3);
	 p     =put(prob,6.3);
	 		if prob<0.001 then p="<0.001";
  	 KEEP chisq method p;
RUN;
	%end;
%IF &method="CHISQ" %then
	%do;
DATA fisher&datset;
 LENGTH method $18.;
  SET chisqdat;
      method = "CHISQ";	  
	 chisq =put(_pchi_,6.3);
	 p     =put(p_pchi,6.3);
	 		if prob<0.001 then p="<0.001";
  	 KEEP chisq method p;
RUN;
	%end;


proc datasets nolist nowarn;
	delete chisqdat;
run;

%MEND fisherElong;

/*%fisherElong(analysis,gender,itt,"CHISQ");*/
