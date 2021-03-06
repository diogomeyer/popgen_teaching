# Variables names:
variable_names <- c("pi", "ss", "D")

# get all file names starting with 'pop.t' in your working directory,
# assuming that the output files from the simulations are in your wd:
files <- list.files(pattern = "pop\\.t*")

# read all files in a list
all_files <- lapply(files, read.table, col.names = variable_names)

# get the 'times' from the file names
times <- gsub("^.*t(.*)\\.stats\\.out$", "\\1", files)

# first file doesn't have the 'time' in the name
# this is the file from the simulation with 'constant time' 
times[times==""] <- "constant"
names(all_files) <- paste("t =", times)
  
# Plot
# We're going to use 3 packages: magrittr, dplyr and ggplot2.
# If you don't have these packages installed, first execute the following line:

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

# transform the all_files list into a single data.frame
all_files_df <- rbind_all(all_files)

# create a list of plots
plot_list <- vector("list", length(variable_names))
names(plot_list) <- variable_names

# make a plot for each variable and store as an element of plot_list
for (var in variable_names) 
  plot_list[[var]] <- ggplot(all_files_df, aes_string(var)) + 
                    geom_histogram(aes(fill = time)) + 
		    facet_wrap(~ time, ncol = 1)

# open the pdf device and save plots
pdf("plots_simulations.pdf", width = 12)
plot_list
dev.off()
