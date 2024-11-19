# Penguins Data Analysis Application

Author: Alex Pieters \| Last modified: November 18, 2024

## STAT 545 UBC (2024 Winter 1)

### Overview

Welcome to the **Penguins data analysis application**!

The aim of the project is to develop a shiny app which uses the `penguins` data from the `palmerpenguins` package in R with the following features:

\- [x] Allows for the user to search multiple entries simultaneously.

\- [x] Displays the output as a plot and table in separate tabs.

\- [x] Notifies the user about the number of results after filtering by species and/or island.

\- [x] Generates an interactive table for the user to view the output.

### File Directory Description

-   **README.md**: Provide distinctions for this project and instructions.

-   **PenguinsDataAnalysisApp**: This folder contains the source code file PenguinsApp.R for running the application.

### How to Run the App

1.  The easiest option to run the app is via the shinyapps.io server by following this [link](https://stat545-apieters.shinyapps.io/PenguinsDataAnalysisApp/) (or copy/paste in your browser: <https://stat545-apieters.shinyapps.io/PenguinsDataAnalysisApp/>).
2.  Alternatively, you can clone the [git repository](https://github.com/stat545ubc-2024/assignment-b3-apieters1) (copy/paste: <https://github.com/stat545ubc-2024/assignment-b3-apieters1>) on R Studio and run the app from there. You will first need to install the following packages:
    1.  `shiny`
    2.  `palmerpenguins`
    3.  `tidyverse`

### Acknowledgement

The `palmerpenguins` packages is freely available in R. The data was collected and released by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER.
