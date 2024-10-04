/*--------------------------------------------------------------------------
  Step 1: If Appliciable, Import Your CSV Data File
--------------------------------------------------------------------------*/

/* Replace the file path with the location of your CSV file */
proc import datafile="C:\PATH to Data\Sample Data.csv" 
    out=DataSetName       /* Specify the desired SAS dataset name */
    dbms=csv
    replace;
    getnames=yes;
run;

/*--------------------------------------------------------------------------
  Step 2: Invoke the Ordinal_Cluster_Analysis Macro
--------------------------------------------------------------------------*/

/*
  Replace the macro parameters as follows:
  - data=DataSetName       : Name of the imported SAS dataset
  - y=OutcomeVariable      : Name of the outcome (response) variable in your dataset
  - group=TreatmentGroup   : Name of the exposure or treatment group variable
  - cluster_id=ClusterVar  : Name of the cluster identifier variable
*/

%Ordinal_Cluster_Analysis(
    data=DataSetName,           /* SAS dataset name */
    y=Outcome,          /* Outcome variable */
    group=Group_Code,       /* Exposure or treatment group */
    cluster_id=Cluster       /* Cluster identifier */
)

/*----------------------------------------------------------------------


----------Example Ouput Using "Sample Data.CSV"----------

----------Print the Win Probability estimates----------
Obs	point		logitlower	logitupper	asinelower		asineupper	pvalue
1	0.63337		0.57612		0.68708		0.004868513		0.99836		0.000112175


----------Print the odds ratio estimates----------										
Obs	Group_Code	_Group_Code	Estimate	DF		Alpha	Lower	Upper
1	0			1			2.322		3973	0.05	1.633	3.3
	
	
----------Print the cumulative probabilities----------													
Obs	Group_Code	Estimate	CumulativeProb				
1	0			2.322		0.69894				

----------------------------------------------------------------------*/
