welcome_html <- function(){
    tagList(
        h1("Welcome to ICDPIC-R"),
        p(" Programs for Injury Categorization, using the International Classification of Diseases (ICD) and R statistical software (ICDPIC-R), are intended to provide inexpensive methods for translating ICD-9 or ICD-10 injury diagnosis codes into standard categories and/or scores.  The user is expected to have a knowledge of ICD coding, the Abbreviated Injury Scale (AIS), and the Injury Severity Score (ISS)."),
        p("These programs are based upon a previous version implemented as a command for the Stata statistical software (StataCorp, College Station TX).  The Stata version was limited to data coded using ICD-9."),
        p("This web application (WebApp) runs the latest R version, but does not require any programming or other software.  The user only needs to click on the navigation buttons to the left of the screen and follow directions.  The only limitation is that the programs may not allow file sizes larger than 10,000 observations, so that a larger file may have to be split into parts."),
        p("We hope ICDPIC-R will facilitate the use of ICD-9 and ICD-10 codes for epidemiologic or health services research about injured persons.")
    
    )
}



instructions_html <- function(){
    tagList(
        h1("Instructions"),
        p("The input data file must be in CSV (comma-separated variables) format with each row corresponding to one person.  The names for the fields containing diagnosis codes (ICD-9 and/or ICD-10) must begin with the same prefix (e.g., dx1, dx2, ...).  There is no maximum number of diagnosis codes per person.  External Cause of Injury codes should be included in this set; in ICD-9, these must begin with a capital 'E'."),
        p("Two methods for calculation of ISS are allowed:  1) If any AIS score has a value of 6, the ISS is automatically calculated as 75; or 2) If any AIS score has a value of 6, the value is changed to 5 and calculation of ISS proceeds normally."),
        p("Three methods for translating ICD-10 codes to AIS are allowed:  ROCmax is an empirical method based upon observed mortality in the American College of Surgeons National Trauma Data Bank.  GEMmax first maps ICD-10 to ICD-9 using the General Equivalency Matrix (GEM) provided by the U.S. Centers for Medicare and Medicaid Services (CMS); it then maps ICD-9 codes to AIS using the original Stata tables, and resolves ambiguities by selecting the largest possible AIS score.  GEMmin is similar but resolves ambiguities by selecting the smallest possible AIS score."),
        p("External Cause of Injury codes in ICD-9 or ICD-10 are mapped to categories recommended or suggested by the U.S. Centers for Disease Control and Prevention (CDC).")
    )
}


help_html <- function(){
      tagList(
            h1("Help"),
            p("If you would like to use the ICDPICR package in R please see instructions here:", a("http://github.com/ablack3/icdpicr")),
            p("The original ICDPIC Stata programs can be accessed here:", a("http://ideas.repec.org/c/boc/bocode/s457028.html")),
            p("If the user is interested in viewing the tables used for mapping, they may be found at ", a("https://github.com/ablack3/icdpicr/tree/master/lookup_tables"),".  Users may wish to copy them for use with another program if they find that easier than working in R."),
            p("The programming code and associated tables for ICDPIC-R and this WebApp are completely open-source, are provided as a public service, and may be used without charge.  Questions or suggestions may be directed to the authors listed below:"),
            p(strong("Adam W. Black (awblack@mmc.org)")),
            p(strong("David E. Clark (clarkd@mmc.org)")),
            p(strong("Maine Medical Center, Center for Outcomes Research and Evaluation")),
            p(strong("509 Forest Avenue, Portland, Maine USA")),
            
            h2("Acknowledgements"),
            p("The authors are grateful to the American College of Surgeons (ACS) and the many hospitals that have contributed data to the National Trauma Data Bank.  The content reproduced from the NTDB remains the full and exclusive copyrighted property of the ACS.  The ACS is not responsible for any claims arising from works based on the original data, text, tables, or figures."),
            p("The authors are likewise grateful to the U.S. CMS and CDC for their leadership and providing resources for injury research.")
      )
}




