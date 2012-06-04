/* Solve bug of jet Engine */
%macro delexcel(file,sheet);
libname myexcel excel "&file";
proc sql;
drop table myexcel.&sheet;
run;
libname myexcel clear;
%mend;
************************************************;

%macro export_csv(data,file);
proc export data=&data 
   outfile="&file"
   dbms=csv
   replace;
run;
%mend export_csv;

%macro export_xls(data,file,sheet);
%delexcel(&file, &sheet);
PROC EXPORT DATA= &data 
            OUTFILE= "&file"
            DBMS=EXCEL REPLACE;
     SHEET= "&sheet"; 
RUN;
%mend export_xls;

%macro export_access(data,file,sheet);
PROC EXPORT DATA= &data 
            OUTTABLE= "&sheet" 
            DBMS=ACCESS REPLACE;
     DATABASE="&file"; 
RUN; 
%mend export_access;

%macro output_xpt(data, out = tmp);

%let path = %sysfunc(getoption(work));  /* Save data in SAS temp folder */

libname x xport "&path\&out..xpt";
PROC COPY IN=work OUT=x;
    SELECT &data;
RUN;

%mend output_xpt;

%macro import_csv(data,file);
PROC IMPORT OUT= &data 
            DATAFILE= "&file"
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
%mend import_csv;


%macro import_xls(data,file,sheet);
PROC IMPORT OUT= &data 
            DATAFILE= "&file"
            DBMS=EXCEL REPLACE;
     SHEET="&sheet"; /*example: sheet = 'HCAHPS Measures$'*/
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
%mend import_xls;

%macro import_access(data,file,sheet);
%mend import_access;

/********************** example *********************************/
