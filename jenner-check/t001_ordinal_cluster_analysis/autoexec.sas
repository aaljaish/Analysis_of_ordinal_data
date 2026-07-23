/* cap input rows for the captured run */
options obs=100;

/* Sample rows drawn from the repo's own "Sample Data.csv" (12 clusters, 6 per group).
   Loaded inline so the bundle needs no external file -- equivalent to the repo's
   Step 1 PROC IMPORT of Sample Data.csv into DataSetName. */
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
