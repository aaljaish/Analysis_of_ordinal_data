# Analysis_of_ordinal_data<br>
This macro performs an ordinal cluster analysis on a given dataset. It processes   the data to compute win fractions, conducts a mixed model regression on these    win fractions, and fits a proportional odds model to analyze the relationship between the response variable and predictor groups within clusters.<br><br>

Ordinal_Cluster_Analysis Macro<br><br>
  
  This macro performs an ordinal cluster analysis on a given dataset. It processes the data to compute win fractions, conducts a mixed model regression on these 
  win fractions, and fits a proportional odds model to analyze the relationship between the response variable and predictor groups within clusters.<br><br>
  
  The macro executes the following main steps:<br><br>

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
  
  **Parameters:**<br>
    - `data=`       : **(Required)** Name of the input dataset.<br>
    - `y=`          : **(Required)** Name of the response variable (post-test score).<br>
    - `group=`      : **(Required)** Name of the grouping variable.<br>
    - `cluster_id=` : **(Required)** Identifier for clustering (e.g., subject ID).<br>

  
  **Usage Instructions:**<br>
    1. **Prepare Your Data**:<br>
       - Ensure your dataset includes the response variable (`y`), grouping variable (`group`), and a cluster identifier (`cluster_id`).<br>
    
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
  
  **Example Usage:**<br>
    Suppose you have a dataset `clinical_trial` with the following variables:<br>
      - `patient_id` : Unique identifier for each patient (cluster ID).<br>
      - `treatment`  : Treatment group indicator (e.g., 0 = Control, 1 = Treatment).<br>
      - `score`      : Post-treatment score (ordinal response).<br><br>
        
  **Notes:**<br>
    - Ensure that the response variable (`y`) is appropriately scaled and ordinal.<br>
    - The macro assumes that higher values of `y` indicate better outcomes. If lower values are of interest, consider modifying the `DESCENDING` option within the macro as needed.<br>
    - The macro includes internal plotting (`%EmpiricalLogitPlot`) for diagnostic checks.<br>
	  Ensure that the `EmpiricalLogitPlot` macro is available in your SAS environment.<br><br>
    
  **Dependencies:**<br>
    - `%EmpiricalLogitPlot` Macro: This macro is called within `Ordinal_Cluster_Analysis` for plotting empirical logits. Ensure it is defined and available in your SAS session.<br><br>
    
  **Author:** Ahmed Al-Jaishi<br>
  **Version:** 1.0<br>
  **Date:** 2024-10-04<br>
