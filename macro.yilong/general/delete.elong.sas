/*delete dataset */

%Macro DelElong(setlist);
proc datasets nolist nowarn;
delete &setlist;
run;
%Mend DelElong;
