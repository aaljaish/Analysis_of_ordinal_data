# Analysis_of_ordinal_data
This macro performs an ordinal cluster analysis on a given dataset. It processes   the data to compute win fractions, conducts a mixed model regression on these    win fractions, and fits a proportional odds model to analyze the relationship    between the response variable and predictor groups within clusters.

rdinal_Cluster_Analysis Macro
  
  This macro performs an ordinal cluster analysis on a given dataset. It processes
  the data to compute win fractions, conducts a mixed model regression on these 
  win fractions, and fits a proportional odds model to analyze the relationship 
  between the response variable and predictor groups within clusters.
  
  The macro executes the following main steps :

    1. **Convert Data to Win Fractions**:
	   - Using code provided by Yu (2023)
       - Sorts the data by the specified grouping variable.
       - Calculates overall and within-group ranks based on the response variable.
       - Computes win fractions for each observation.
       - Displays the first 10 observations of the win fractions for verification.

		Yu, Chengchun, "Nonparametric Methods for Analysis and Sizing of Cluster Randomization 
		Trials with Baseline Measurements" (2023). Electronic Thesis and Dissertation Repository. 9697.
		https://ir.lib.uwo.ca/etd/9697
 
    2. **Regression on Win Fractions Using Mixed Model**:
	   - Using code provided by Yu (2023)
       - Fits a mixed-effects model using the win fractions.
       - Includes random intercepts for each cluster to account for within-cluster correlation.
       - Outputs parameter estimates and calculates confidence intervals and p-values.
  
		Yu, Chengchun, "Nonparametric Methods for Analysis and Sizing of Cluster Randomization 
		Trials with Baseline Measurements" (2023). Electronic Thesis and Dissertation Repository. 9697.
		https://ir.lib.uwo.ca/etd/9697

    3. **Visually assess proportional odds assumption using Empirical Logit Plot
       - The empirical logit plot is produced using EmpiricalLogitPlot macro provided by Derr (2013).

    Derr, R.E. (2013), "Ordinal Response Modeling with the LOGISTIC Procedure." Proceedings of 
    the SAS Global Forum 2013 Conference, Cary, NC: SAS Institute Inc.

    4. **Proportional Odds Model**:
       - Generates empirical logit plots to check the proportional odds assumption.
       - Fits a cumulative logit model (proportional odds model) using `PROC GLIMMIX`.
       - Calculates and displays odds ratios and their cumulative probabilities.
  
  **Parameters:**
    - `data=`       : **(Required)** Name of the input dataset.
    - `y=`          : **(Required)** Name of the response variable (post-test score).
    - `group=`      : **(Required)** Name of the grouping variable.
    - `cluster_id=` : **(Required)** Identifier for clustering (e.g., subject ID).

  
  **Usage Instructions:**
    1. **Prepare Your Data**:
       - Ensure your dataset includes the response variable (`y`), grouping variable (`group`), and a cluster identifier (`cluster_id`).
    
    2. **Invoke the Macro**:
       - Call the macro with the appropriate parameters. For example:
         ```sas
         %Ordinal_Cluster_Analysis(
             data=study_data,
             y=post_test_score,
             group=intervention_group,
             cluster_id=subject_id
         );
         ```
    
    3. **Review the Outputs**:
       - **Win Fractions**: The macro prints the first 10 observations of the computed win fractions for a quick verification.
       - **Regression Results**: Parameter estimates, confidence intervals, and p-values are printed to assess the significance of the grouping variable.
       - **Proportional Odds Model**: Empirical logit plots are generated for assumption checking, and odds ratios with cumulative probabilities are displayed.
    
    4. **Interpret the Results**:
       - **Win Fractions**: Higher win fractions indicate better performance in the post-test relative to peers within the same group.
       - **Mixed Model Regression**: Evaluates the effect of the grouping variable on win fractions while accounting for cluster-level variability.
       - **Proportional Odds Model**: Assesses the association between the grouping variable and the ordinal response, providing odds ratios that reflect the likelihood of higher versus lower categories of the response variable.
  
  **Example Usage:**
    Suppose you have a dataset `clinical_trial` with the following variables:
      - `patient_id` : Unique identifier for each patient (cluster ID).
      - `treatment`  : Treatment group indicator (e.g., 0 = Control, 1 = Treatment).
      - `score`      : Post-treatment score (ordinal response).
        
  **Notes:**
    - Ensure that the response variable (`y`) is appropriately scaled and ordinal.
    - The macro assumes that higher values of `y` indicate better outcomes. If lower 
	  values are of interest, consider modifying the `DESCENDING` option within the macro as needed.
    - The macro includes internal plotting (`%EmpiricalLogitPlot`) for diagnostic checks. 
	  Ensure that the `EmpiricalLogitPlot` macro is available in your SAS environment.
    
  **Dependencies:**
    - `%EmpiricalLogitPlot` Macro: This macro is called within `Ordinal_Cluster_Analysis` 
	  for plotting empirical logits. Ensure it is defined and available in your SAS session.
    
  **Author:** Ahmed Al-Jaishi
  **Version:** 1.0
  **Date:** 2024-10-04
