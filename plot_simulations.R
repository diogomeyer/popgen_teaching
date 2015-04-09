# Variable names:
vars <- c("pi", "ss", "D")

# get all file names starting with 'pop.t'
files <- list.files(pattern = "pop\\.t*")

# read all files in a list
all_files <- lapply(files, read.table, col.names = vars)

# get the 'times' from the file names
times <- gsub("^.*t(.*)\\.stats\\.out$", "\\1", files)

# first file doesn't have the 'time' in the name, but it corresponds to time = 0
times[times==""] <- 0
names(all_files) <- paste0("t", times)
  
# Plot option 1 -------------------------------------------------------------- #

# Open plot device (pdf)
pdf(paste0("all_plots.pdf"), height = 12)

# Set how plots are arrange in plot window (given odd or even number of plots)
if (length(all_files) %% 2 == 0) { 
  layout(matrix(1:length(all_files), ncol = 2, byrow = TRUE))
} else {
  layout(matrix(c(1:length(all_files), 0), ncol = 2, byrow = TRUE))
}

# plot a given variable in 'vars' and plot it for all files (different times)
for(var in vars) {
  
  sapply(seq_along(all_files), function(x) {
	 hist(all_files[[x]][var][[1]], 
	      main = paste(var, sprintf("t = %s", times[x])), 
	      xlab = colnames(all_files[[x]])[var], col = 'cornflowerblue')
  })
}

# close pdf device
dev.off()

# Plot option 2 -------------------------------------------------------------- #

# We're going to use 3 packages: magrittr, dplyr, ggplot2.
# If you don't those packages installed, first execute the follow line:

# install.packages(c("magrittr", "dplyr", "ggplot2"))

# Attach the packages
library(magrittr)
library(dplyr)
library(ggplot2)

# A bit of parsing: 
# for data from each file (different elements in all_files list), add a column
# named 'time' for the corresponding time:
for (i in seq_along(all_files)) 
  all_files[[i]] %<>% mutate(time = names(all_files[i]))

# transform the all_files list in a single data.frame
all_files_df <- rbind_all(all_files)

# create a list of plots
plot_list <- vector("list", length(vars))
names(plot_list) <- vars

# make a plot for each variable and store as an element of plot_list
for (var in vars) 
  plot_list[[var]] <- ggplot(all_files_df, aes_string(var)) + 
                    geom_histogram() + 
		    facet_grid(. ~ time, as.table = FALSE)

# open the pdf device and save plots
pdf("all_plots.pdf", width = 12)
plot_list
dev.off()
