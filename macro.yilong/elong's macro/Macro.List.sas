/*===================================================================*/
/* Purpose: Call project special macro                               */
/*===================================================================*/

/*********************************************************************
 Call elong's macro
**********************************************************************/
%let macpath=H:\Nursing\Programs;
%INCLUDE "&macpath\elong's macro\means.anova\means.elong.sas";
%INCLUDE "&macpath\elong's macro\means.anova\anova.elong.sas";
%INCLUDE "&macpath\elong's macro\freq.chisq\mfisher.elong.sas";
%INCLUDE "&macpath\elong's macro\freq.chisq\rptfreq.sas";
%INCLUDE "&macpath\elong's macro\freq.chisq\wilcoxon.elong.sas";
%INCLUDE "&macpath\elong's macro\general\add.item.sas";
%INCLUDE "&macpath\elong's macro\general\delete.elong.sas";
%INCLUDE "&macpath\elong's macro\general\sort.sas";



