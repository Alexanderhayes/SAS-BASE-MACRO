/*===================================================================*/
/* Purpose: Call project special macro                               */
/*===================================================================*/

/*********************************************************************
 Call macro.yilong
**********************************************************************/
%INCLUDE "&macpath\macro.variable.sas";

%INCLUDE "&macpath\means.anova\means.elong.sas";
%INCLUDE "&macpath\means.anova\anova.elong.sas";
%INCLUDE "&macpath\freq.chisq\mfisher.elong.sas";
%INCLUDE "&macpath\freq.chisq\rptfreq.sas";
%INCLUDE "&macpath\freq.chisq\wilcoxon.elong.sas";
%INCLUDE "&macpath\general\add.item.sas";
%INCLUDE "&macpath\general\merge.sas";
%INCLUDE "&macpath\general\delete.elong.sas";
%INCLUDE "&macpath\general\sort.sas";
%INCLUDE "&macpath\general\keep.sas";
%INCLUDE "&macpath\summary\summary.sas";
%INCLUDE "&macpath\summary\freq.sas";
%INCLUDE "&macpath\IO\IO.sas";

/**********************************************************************/
