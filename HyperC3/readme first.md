# Emory Instructions
- [HyperC3 SharePoint site](https://emory.sharepoint.com/sites/HyPER/SitePages/Community-Cloud-Cluster-Cirrostratus.aspx)
- [User Guide](https://emory.sharepoint.com/sites/HyPER/SitePages/Community-Cloud-Cluster-Cirrostratus.aspx#user-guides) - The User Guide gives login information
- [OnDemand Site](https://ondemand.it.emory.edu/) for File Upload and Download

# Learnings
R packages can be installed by entering the terminal via Mobaxterm, and then typing R, followed by Enter key. That will take you to the R terminal, which can then be used to install via install.packages("dplyr"). 

**tidyverse**: I faced issues in installing the whole tidyverse, but was able to install the main packages easily (dplyr, readr, lubridate)

**arrow**: This was also tricky because the arrow installation for Linux is different from Windows/Mac. Use the [Arrow documentation](https://arrow.apache.org/docs/r/articles/install.html#r-source-package-with-libarrow-binary).

**VSCode, RStudio vs Notepad++ for .sh files**: The carriage return caused a lot of problems. Make sure that you find and replace the 'CR' in your .sh files for them to work properly. This can be done via VSCode using View >> Show Symbol >> End of Line on Notepad++. 
- If carriage returns are present, use Ctrl + H, Find: \r and Replace: blank (don't enter anything)

# Common commands
I have added some useful reference commands under 'common commands.txt'