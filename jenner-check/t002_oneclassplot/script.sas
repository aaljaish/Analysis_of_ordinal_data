/*--------------------------------------------------------------------------
  OneClassPlot -- empirical cumulative logits by a CLASS covariate

  This is the author's %OneClassPlot macro (from "01_Ordinal Data Macros.sas"),
  the helper the EmpiricalLogitPlot machinery uses for covariates with fewer
  than CONTCUTOFF levels. It cross-tabulates the ordinal response against the
  covariate (PROC FREQ ... / sparse), transposes the counts, and computes the
  empirical cumulative logits c1..c(numy-1) within each level.

  Invoked here in data-set mode (plot=0) on a compact sample from the repo's
  own "Sample Data.csv": x=Group_Code (the treatment indicator), y=Outcome
  (the ordinal 0..10 score, numy=11). The sample is embedded inline so this
  script runs on its own. The resulting empirical-logit dataset is printed so
  the computation is visible.
--------------------------------------------------------------------------*/

/* Sample rows drawn from the repo's own "Sample Data.csv" (12 clusters, 6 per group). */
data DataSetName;
  length Group $1 Cluster $8 Patient_ID $12;
  input Group $ Cluster $ Patient_ID $ Outcome Group_Code Intercept;
  datalines;
A A_1 A_1_1 8 1 1.0
A A_1 A_1_2 4 1 1.0
A A_1 A_1_3 4 1 1.0
A A_1 A_1_4 10 1 1.0
A A_1 A_1_5 10 1 1.0
A A_1 A_1_6 6 1 1.0
A A_1 A_1_7 7 1 1.0
A A_1 A_1_8 8 1 1.0
A A_2 A_2_1 6 1 1.0
A A_2 A_2_2 8 1 1.0
A A_2 A_2_3 10 1 1.0
A A_2 A_2_4 2 1 1.0
A A_2 A_2_5 0 1 1.0
A A_2 A_2_6 6 1 1.0
A A_2 A_2_7 8 1 1.0
A A_2 A_2_8 4 1 1.0
A A_3 A_3_1 2 1 1.0
A A_3 A_3_2 4 1 1.0
A A_3 A_3_3 6 1 1.0
A A_3 A_3_4 8 1 1.0
A A_3 A_3_5 8 1 1.0
A A_3 A_3_6 4 1 1.0
A A_3 A_3_7 10 1 1.0
A A_3 A_3_8 4 1 1.0
A A_4 A_4_1 6 1 1.0
A A_4 A_4_2 0 1 1.0
A A_4 A_4_3 3 1 1.0
A A_4 A_4_4 8 1 1.0
A A_4 A_4_5 8 1 1.0
A A_4 A_4_6 3 1 1.0
A A_4 A_4_7 2 1 1.0
A A_4 A_4_8 4 1 1.0
A A_5 A_5_1 2 1 1.0
A A_5 A_5_2 0 1 1.0
A A_5 A_5_3 4 1 1.0
A A_5 A_5_4 2 1 1.0
A A_5 A_5_5 4 1 1.0
A A_5 A_5_6 9 1 1.0
A A_5 A_5_7 8 1 1.0
A A_5 A_5_8 3 1 1.0
A A_6 A_6_1 4 1 1.0
A A_6 A_6_2 2 1 1.0
A A_6 A_6_3 0 1 1.0
A A_6 A_6_4 7 1 1.0
A A_6 A_6_5 0 1 1.0
A A_6 A_6_6 8 1 1.0
A A_6 A_6_7 4 1 1.0
A A_6 A_6_8 10 1 1.0
B B_1 B_1_1 8 0 1.0
B B_1 B_1_2 2 0 1.0
B B_1 B_1_3 3 0 1.0
B B_1 B_1_4 5 0 1.0
B B_1 B_1_5 5 0 1.0
B B_1 B_1_6 2 0 1.0
B B_1 B_1_7 4 0 1.0
B B_1 B_1_8 6 0 1.0
B B_2 B_2_1 0 0 1.0
B B_2 B_2_2 3 0 1.0
B B_2 B_2_3 2 0 1.0
B B_2 B_2_4 1 0 1.0
B B_2 B_2_5 4 0 1.0
B B_2 B_2_6 8 0 1.0
B B_2 B_2_7 0 0 1.0
B B_2 B_2_8 5 0 1.0
B B_3 B_3_1 0 0 1.0
B B_3 B_3_2 6 0 1.0
B B_3 B_3_3 7 0 1.0
B B_3 B_3_4 1 0 1.0
B B_3 B_3_5 8 0 1.0
B B_3 B_3_6 2 0 1.0
B B_3 B_3_7 8 0 1.0
B B_3 B_3_8 7 0 1.0
B B_4 B_4_1 7 0 1.0
B B_4 B_4_2 0 0 1.0
B B_4 B_4_3 4 0 1.0
B B_4 B_4_4 0 0 1.0
B B_4 B_4_5 3 0 1.0
B B_4 B_4_6 0 0 1.0
B B_4 B_4_7 2 0 1.0
B B_4 B_4_8 7 0 1.0
B B_5 B_5_1 1 0 1.0
B B_5 B_5_2 3 0 1.0
B B_5 B_5_3 8 0 1.0
B B_5 B_5_4 4 0 1.0
B B_5 B_5_5 8 0 1.0
B B_5 B_5_6 5 0 1.0
B B_5 B_5_7 2 0 1.0
B B_5 B_5_8 5 0 1.0
B B_6 B_6_1 0 0 1.0
B B_6 B_6_2 2 0 1.0
B B_6 B_6_3 0 0 1.0
B B_6 B_6_4 2 0 1.0
B B_6 B_6_5 7 0 1.0
B B_6 B_6_6 8 0 1.0
B B_6 B_6_7 6 0 1.0
B B_6 B_6_8 7 0 1.0
;
run;

/* Globals that the parent %EmpiricalLogitPlot macro sets before calling
   %OneClassPlot: the cumulative-logit label and numy-1 (Outcome has 11
   ordered values, 0..10). */
%let lgtlabl=CLogit;
%let numym1=10;

%macro OneClassPlot(data=,x=,y=,numy=,const=0.5,plot=1);
/*--------------------------------------------------------------------------
  A macro version of SAS Usage Note 37944 for covariates with fewer than
  CONTCUTOFF levels. Computes and/or plots the empirical logits of Y against
  the levels of one X variable.  Called by the EmpiricalLogitPlot macro.

  data=    name of the input data set.
  x=       name of the single CLASS covariate.
  y=       name of the response variable.
  numy=    number of levels of the response.
  const=   small value in case of zero cells.
  plot=    1=create the plot, 0=create data set only
  --------------------------------------------------------------------------*/
%let numym1=%eval(&numy-1);
%let zerosum=0;
proc freq data=&data noprint;
   table &x*&y / sparse out=_temp2;
run;
proc sort data=_temp2;
   by &x;
run;
%let dsid=%sysfunc(open(_temp2));
%if &dsid %then %do;
  %let varnum=%sysfunc(varnum(&dsid,&x));
  %if %sysfunc(vartype(&dsid,&varnum))=C %then %do;
    %let rc=%sysfunc(close(&dsid));
    %CtoN(&version,data=_temp2,var=&x,out=_temp2,options=format nodatanote nonewcheck)
  %end;
  %let rc=%sysfunc(close(&dsid));
%end;
proc transpose data=_temp2 out=_temp;
   by &x;
   var count;
   run;
data _temp2 ;
   set _temp;
   length _group $ 32;
   if (_NAME_='COUNT');
   _group="&x";
   _x=&x;
   _const=%sysevalf(&const+0);
   %do i=1 %to &numym1; %let j=%eval(&i+1);
      _numsum=sum(of col1-col&i); _densum=sum(of col&j-col&numy);
      %if &const=0 %then %do;
        _const=0;
        if _numsum=0 or _densum=0 then do;
          _const=0.5; call symputx('zerosum',1);
        end;
      %end;
      c&i=log((_numsum + _const) / (_densum + _const));
   %end;
   keep c1-c&numym1 _group _x &x;
   run;
%if &zerosum %then %do;
  %if %index(&version,DEBUG)=0 %then options notes;;
  %put NOTE: Zero sum detected for &x.. CONST=0.5 used in affected logits.;
  %if %index(&version,DEBUG)=0 %then options nonotes;;
  %end;
%if &plot %then %do;
   proc sgplot;
      %do i=1 %to &numym1;
      series y=c&i x=&x /
             legendlabel="&lgtlabl(O.V.<=&i)" name="series&i"
             lineattrs=GraphData&i(thickness=3px);
      %end;
      yaxis label=
         %if &numy>2 %then "Empirical Cumulative Logits";
         %else "Empirical Logit";
      ;
      xaxis label="&x";
      xaxis integer label="&x";
      keylegend %do i=1 %to &numym1; "series&i" %end;;
      %if &numy>2 %then %str(title "Empirical Cumulative Logits";);
      %else %str(title "Empirical Logit";);
      title2;
      run;
%end;
%mend;

%OneClassPlot(data=DataSetName, x=Group_Code, y=Outcome, numy=11, const=0.5, plot=0)

title "Empirical cumulative logits by Group_Code (OneClassPlot output)";
proc print data=_temp2 noobs; run;
title;
