%macro log(log=log);
PROC PRINTTO LOG=&log NEW;
RUN;
%mend;
