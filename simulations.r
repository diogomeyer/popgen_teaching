###################################################################################
## Bárbara Bitarello    ###########################################################
## Last modified: 7.4.2015  #######################################################
## R script to read in 'MS' simulations summary statistics and visualize results.###
####################################################################################

#Read in files

path.1<- '/Users/barbarabitarello/bio5789/'   #replace with the path for where YOUR files are

#Copy and paste the entire block below to read in the sample_stats outputs#

read.table (paste0(path.1,'pop.t0.01.stats.out'))->pop.t0.01.stats
read.table (paste0(path.1,'pop.t0.05.stats.out'))->pop.t0.05.stats
read.table (paste0(path.1,'pop.t0.12.stats.out'))->pop.t0.12.stats
read.table (paste0(path.1,'pop.t0.5.stats.out'))->pop.t0.5.stats
read.table (paste0(path.1,'pop.t1.stats.out'))->pop.t1.stats
read.table (paste0(path.1,'pop.t4.stats.out'))->pop.t4.stats
