PROC GLM DATA=work_dat OUTSTAT=test NOPRINT;
     CLASS grp cn;
/*     WHERE &datset=1 AND cn=&cncode;*/
     MODEL panss2=grp cn panss1  /SS3;
RUN;
data;
Run;
