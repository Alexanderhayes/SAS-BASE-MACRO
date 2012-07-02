%MACRO WORDS(STRING);

    %LOCAL COUNT WORD;
    %LET COUNT=1 ;
    %LET WORD=%QSCAN(&STRING,&COUNT,%STR( ));

    %DO %WHILE(&WORD NE) ;

    %LET COUNT=%EVAL(&COUNT+1);

    %LET WORD=%QSCAN(&STRING,&COUNT,%STR( ));

    %END;

     %EVAL(&COUNT-1)
%MEND WORDS;

/** Example **/

/*%let num = %words(a b c d);*/
/*%put &num;*/
