/*--------------------------------------------------------------------------
  Ordinal_Cluster_Analysis -- win-fraction + mixed-model core

  This is the author's Ordinal_Cluster_Analysis macro (from
  "01_Ordinal Data Macros.sas"), exercised through its win-fraction
  computation, the PROC MIXED regression on those win fractions, and the
  win-probability confidence-interval calculation (the Yu (2023) core).

  The macro is invoked with the same parameters as the repo's own caller
  ("02_Analysis of Ordinal Data Macro.sas"):
      y=Outcome, group=Group_Code, cluster_id=Cluster
  on a compact sample drawn from the repo's own "Sample Data.csv"
  (12 clusters, 6 per group; loaded inline so the bundle is self-contained).

    Yu, Chengchun, "Nonparametric Methods for Analysis and Sizing of Cluster
    Randomization Trials with Baseline Measurements" (2023). Electronic Thesis
    and Dissertation Repository. 9697. https://ir.lib.uwo.ca/etd/9697
--------------------------------------------------------------------------*/

%Macro Ordinal_Cluster_Analysis(data=, y=, group=, cluster_id=);

	/* 1. Convert data to win fractions */
	proc sort data=&data;
		by descending &group;

		/* Obtain overall rank */
	proc rank data=&data out=overall;
		var &y;  /* Only the post-test score (y) is used */
		ranks overally;
	run;

	/* Obtain within-group rank */
	proc rank data=&data out=group;
		by descending &group;
		var &y;  /* Only the post-test score (y) is used */
		ranks groupy;
	run;

	ods listing close;

	proc freq data=&data;
		tables &group / out=size4other;
	run;

	data size4other;
		set size4other;
		&group = 1 - &group;
	run;

	data WinF;
		merge overall group size4other;
		by descending &group;
		winf = (overally - groupy)/count; /* Only calculate win fractions for post-test (y) */
		keep &cluster_id &group winf &y; /* Keep necessary variables */
	run;

	ods listing;

	proc print data=WinF (obs=10);  /* Print first 10 observations to check results */
	run;

	/* 2. Regression on win fractions using mixed model */
	proc mixed data=WinF method=reml;
		class &cluster_id &group / ref=FIRST;
		model winf = &group / ddfm=betwithin;  /* Only the post-test win fraction (no baseline) */
		random intercept / subject=&cluster_id(&group) type=cs;  /* Cluster-specific random effects */
		lsmeans &group / diff cl;
		ods output Diffs=est (keep=Estimate StdErr DF);  /* Output parameter estimates */
	run;

	/*3 Obtain confidence interval and point estiamtes */
	data results;
		set est;
		alpha = 0.05;
		point = (Estimate+1)/2;
		lgtPoint = log(point/(1-point));
		crit = tinv(1 - (alpha/2), DF);
		sel = StdErr/(point*(1 - point));
		l1 = lgtPoint - crit*sel;
		u1 = lgtPoint + crit*sel;
		logitlower = logistic(l1);
		logitupper = logistic(u1);
		l2 = lgtPoint - 2*arsinh(crit/(2*sel));
		u2 = lgtPoint + 2*arsinh(crit/(2*sel));
		asinelower = logistic(l2);
		asineupper = logistic(u2);
		ttest = (point - 0.5)/StdErr;
		pvalue = 2*(1-probt(abs(ttest), DF));
	run;

	title "Print the Win Probability estimates";

	proc print data= results;
		var point logitlower logitupper asinelower asineupper pvalue;
	run;

	title;

%mend;

%Ordinal_Cluster_Analysis(
    data=DataSetName,
    y=Outcome,
    group=Group_Code,
    cluster_id=Cluster
)
