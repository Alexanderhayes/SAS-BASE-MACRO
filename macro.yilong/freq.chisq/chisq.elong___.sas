%MACRO mchisq(data,var,output,datset);

PROC FREQ DATA=&data NOPRINT;
   WHERE &datset=1 /* AND cn=&cncode*/;  /*不明白被注释处什么意思*/
    TABLES grp*&var/CHISQ NOWARN;
   OUTPUT OUT=&output CHISQ EXACT;
RUN;

DATA &output;
 LENGTH method $18.;
  SET &output;
      chisq  = put(_pchi_,6.3);
      p      = put(p_pchi,6.3);
	  		if p_pchi<0.001 then p_pchi="<0.001";
      method = "CHISQ";
   KEEP chisq method p;
RUN;

data datset;
	datset="&datset";
run;

data &output;
	set datset &output;
run;


%MEND mchisq;

/*%mchisq(analysis,gender,chisq,itt);*/
