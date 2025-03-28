# ShinyApp_Regression
ShinyApp_Regression Explorer

EnhancedLinearRegression_Pitch
========================================================
author: Jbob92
date: Mar 2025
autosize: true


========================================================

# **Introduction**
- This Shiny app allows users to explore simple linear regression models interactively.
- Users can choose a dataset, select predictor and response variables, and view regression results.



========================================================

# **How It Works**
1. **User Inputs:**  
   - Select dataset (`mtcars`, `iris`).  
   - Choose predictor (`x`) and response (`y`) variables.  
   - Optionally display model summary.

2. **Server Processing:**  
   - Fits a **linear regression model** dynamically.  
   - Computes regression coefficients.  
   - Generates a scatter plot with a **fitted regression line**.


========================================================
# **Key Features**
- **Dynamic UI:** Select variables from chosen dataset.
- **Real-Time Model Updates:** Regression updates instantly.
- **Graphical Output:** Scatter plot with **regression line**.
  
```{r}
library(ggplot2)
ggplot(mtcars, aes(x=hp, y=mpg)) + geom_point() + geom_smooth(method="lm", col="red")
```


========================================================
# **Demo**
- The app is deployed on **ShinyApps.io**.
- Try it here: **https://jbob92.shinyapps.io/NewRegression/**
- Source code available on **GitHub**: **https://github.com/JBob92/ShinyApp_Regression**.



========================================================
# **Summary & Next Steps**
- **Improvements:**  
   - Allow multiple regression models.  
   - Enhance UI with interactive plots.  
   - Expand dataset selection.

- View the full implementation at **https://github.com/JBob92/ShinyApp_Regression**.
