vars <- c("pi", "ss", "D")

files <- list.files(pattern = "pop\\.t*")
all_files <- lapply(files, read.table, col.names = vars)

times <- gsub("^.*t(.*)\\.stats\\.out$", "\\1", files)
times[times==""] <- 0
names(all_files) <- paste0("t", times)
  
# Option 1
pdf(paste0("all_plots.pdf"), height = 12)

if (length(all_files) %% 2 == 0) { 
  layout(matrix(1:length(all_files), ncol = 2, byrow = TRUE))
} else {
  layout(matrix(c(1:length(all_files), 0), ncol = 2, byrow = TRUE))
}

for(var in vars) {
  
  sapply(seq_along(all_files), function(x) {
	 hist(all_files[[x]][var][[1]], 
	      main = paste(var, sprintf("t = %s", times[x])), 
	      xlab = colnames(all_files[[x]])[var], col = 'cornflowerblue')
  })
}

dev.off()

# Option 2
library(magrittr)
library(dplyr)
library(ggplot2)

for (i in seq_along(all_files)) 
  all_files[[i]] %<>% mutate(time = names(all_files[i]))

all_files_df <- rbind_all(all_files)

plot_list <- vector("list", length(vars))
names(plot_list) <- vars

for (var in vars) 
  plot_list[[var]] <- ggplot(all_files_df, aes_string(var)) + 
                    geom_histogram() + 
		    facet_wrap(~time, scales = "free")

pdf("all_plots.pdf")
plot_list
dev.off()
