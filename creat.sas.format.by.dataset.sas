data scale;                                                                                                                             
   input begin $ 1-2 end $ 5-8 amount $ 10-12;                                                                                          
   cards;                                                                                                                           
0   3    0%                                                                                                                             
4   6    3%                                                                                                                             
7   8    6%                                                                                                                             
9   10   8%                                                                                                                             
11  16   10%                                                                                                                            
;
 	
data ctrl;
   length label $ 11;
 	
   set scale(rename=(begin=start amount=label)) end=last;
 	
   retain fmtname 'PercentageFormat' type 'n';
 	
   output;
 	
   if last then do;
      hlo='O';
      label='***ERROR***';
      output;
   end;
run;
 	
proc print data=ctrl noobs;
 	
   title 'The CTRL Data Set';
run;

proc format library=work cntlin=ctrl;
run;

proc print data = test;
	format rate PercentageFormat2.;
run;