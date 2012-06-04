/*===================================================================*/
/* Macro Name: anova npard                                           */
/* Purpose: do anova or non parametric test for continuous variables */
/* Arguments:                                                        */
/* Example: %anova   %npard                                          */
/*===================================================================*/

/*********************************************************************
 Get p value from anova
**********************************************************************/
%MACRO anov;

PROC GLM DATA=&data OUTSTAT=anov NOPRINT;
  CLASS grp cn;
   WHERE &datset=1 AND cn=&cncode;
     MODEL &var=grp cn &co_var/SS3;
RUN;

DATA anov;
  LENGTH name 8. datset $8. p $6. chn_srce $8. eng_srce $10.;
   SET anov;
         p = put(prob,6.3);
         if prob<0.001 then p="<0.001";
     IF F^ = .;
      name = _n_ - 1;
    datset = "&datset";
    IF UPCASE(TRIM(LEFT(_SOURCE_)))=upcase(trim(left("&covar"))) THEN DO;eng_srce="Baseline";  chn_srce="基线";     END;
    IF UPCASE(TRIM(LEFT(_SOURCE_)))="GRP"                        THEN DO;eng_srce="Treatment"; chn_srce="治疗分组"; END;
    IF UPCASE(TRIM(LEFT(_SOURCE_)))="CN"                         THEN DO;eng_srce="Center";    chn_srce="研究中心"; END;
   KEEP F p name datset eng_srce chn_srce prob;
RUN;

%MEND anov;


/*********************************************************************
 Get p value from non-parametric test
**********************************************************************/
%MACRO npard;

%IF &npar=1 and &ancova=2 %THEN %DO; %LET npardon=;  %LET npardoff=*;%END;
                          %ELSE %DO; %LET npardon=*; %LET npardoff=; %END;

PROC NPAR1WAY DATA=&data NOPRINT WILCOXON;
   WHERE &datset=1 AND cn=&cncode;
    CLASS grp;
       &npardoff    VAR &var;
       &npardon     VAR d&var;
    OUTPUT OUT=anov;
RUN;

DATA anov;
  LENGTH name 8. datset $8. p $6. chn_srce $8. eng_srce $10.;
  SET anov;
    eng_srce = ' ';
    chn_srce = ' ';
    datset= "&datset";
    name=_N_;
    p=put(P2_WIL,6.3);
    IF P2_WIL<0.001 THEN p="<0.001";
    RENAME Z_WIL=F P2_WIL=prob;
  KEEP Z_WIL p name datset eng_srce chn_srce P2_WIL;
RUN;

%MEND npard;
/*===================================================================*/