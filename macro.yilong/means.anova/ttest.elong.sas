DATA efftest;
  SET efficacy;       /*È±Ê§Öµ¾ù·ÅÆú*/
  IF grp^ = . & grp^= 0;
RUN;




ODS SELECT none;
PROC TTEST DATA = efftest alpha=0.1;
  CLASS grp;
  VAR panss1;
  ods output "T-Tests" = TTEST  "Equality of Variances"=equality;
RUN;

ODS SELECT all;
