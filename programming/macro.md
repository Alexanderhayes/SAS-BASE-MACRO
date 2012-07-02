## Macro Variables

### Date and Time

System Date and Time macro variables

```sas
%Let StDate = &SysDate.;                                *07JUN12
%let Time      = %sysfunc(time(),time8.0)     ;         *12:30:34
%let Time_HH   = %scan(&Time.,1,:)            ;         *12
%let Time_MM   = %scan(&Time.,2,:)            ;         *30
%let Time_SS   = %scan(&Time.,3,:)            ;         *34
%let StDateTime = &SysDate&Time_HH&Time_MM&Time_SS;     *07JUN12123034
```

Reference
* [Format](http://www.uni.edu/sasdoc/lrcon/zenid-63.htm)
* [Other date time related variables](http://www.sascommunity.org/wiki/Macro_Variables_of_Date_and_Time)
* [Data Step Function](http://support.sas.com/documentation/cdl/en/etsug/60372/HTML/default/viewer.htm#etsug_intervals_sect014.htm)

### System Variables


* `%sysget(SAS_EXECFILENAME);` give the filename
* `%sysget(SAS_EXECFILEPATH);` give full path of the file 
* `%sysfunc(getoption(work));` work library path

### Programming Variables
* The default variables [#byline and #byvariable](www2.sas.com/proceedings/sugi23/Coders/p75.pdf) can help customize title with By statement.

### System Commond

use `x` or `%sysexec` to call system command from SAS. `%sysexec` is easier to combine with macro variables. 

```sas
options noxwait; 
x 'del "c:\path\my file.txt"'; 
options noxwait; 
%sysexec del "c:\path\my file.txt"; 
```
### Current Folder

Current folder can be changed by using system commond `cd` to change.

### Format and label
Two most important default dataset in SAS is `format` and `contents`.

```sas
* Format Dictionary `PROC FORMAT CNTLOUT=format; RUN;`
* Data Dictionary `proc contents data = &data out = contents; run;`
```

## Macro Programming

### Get words from a string
```sas
%macro get_words(ivars); 
    %do i = 1 %to %words(&ivars);
   	  %let ivar =%qscan(&ivars,&i,%STR( ));
	  %put &ivar;
  	%end;
  %mend get_words;
%get_words(x1 x2 x3);
```