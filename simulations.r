###################################################################################
## Bárbara Bitarello    ###########################################################
## Last modified: 7.4.2015  #######################################################
## R script to read in 'MS' simulations summary statistics and visualize results.###
####################################################################################

#Read in files

path.1<- '/Users/barbarabitarello/bio5789/'   #replace with the path for where YOUR files are

#BLOCK 1: read in the data
#Copy and paste the entire block below to read in the sample_stats outputs#
read.table(paste0(path.1,'pop.t0.01.stats.out'))->pop.t0.01.stats   #reads in this file 
colnames(pop.t0.01.stats)<-c('pi', 'ss', 'D')  #adds names to collumns
read.table(paste0(path.1,'pop.t0.05.stats.out'))->pop.t0.05.stats
colnames(pop.t0.05.stats)<-c('pi', 'ss', 'D')
read.table(paste0(path.1,'pop.t0.12.stats.out'))->pop.t0.12.stats
colnames(pop.t0.12.stats)<-c('pi', 'ss', 'D')
read.table(paste0(path.1,'pop.t0.5.stats.out'))->pop.t0.5.stats
colnames(pop.t0.5.stats)<-c('pi', 'ss', 'D')
read.table(paste0(path.1,'pop.t1.stats.out'))->pop.t1.stats
colnames(pop.t1.stats)<-c('pi', 'ss', 'D')
read.table(paste0(path.1,'pop.t4.stats.out'))->pop.t4.stats
colnames(pop.t4.stats)<-c('pi', 'ss', 'D')
read.table(paste0(path.1,'pop.const.stats.out'))->pop.const.stats
colnames(pop.const.stats)<-c('pi', 'ss', 'D')
###End of Block#################################
################################################

#BLOCK 2: summarize ##############################
#run
apply(pop.const.stats, 2, mean)  #mean of pi, SS and D for the simulations with constant N

#Now, run this enormous command to generate one data.frame with all simualtion results

all.stats.sum<-rbind(
apply(pop.const.stats, 2, mean),
apply(pop.t0.01.stats, 2, mean),
apply(pop.t0.05.stats,2,mean),
apply(pop.t0.12.stats,2,mean),
apply(pop.t0.5.stats,2, mean),
apply(pop.t1.stats,2, mean),
apply(pop.t4.stats,2,mean)
)
all.stats.sum  #check the object
#add rownames
rownames(all.stats.sum)<-c('t.const','t0.01','t0.05','t0.12','t0.5','t1','t4')
############END OF BLOCK ###################
############################################


###PLOTS #############

#Run this to check var, SS and TajD for the constant pop size simulations.

par(mfrow=c(3,1)) #this allows the plots to be in 3x1 (row, col) configuration.
sapply(1:3, function(x) hist(pop.const.stats[,x], main='Constant pop size', 
xlab=colnames(pop.const.stats)[x], nclass=100, col='cornflowerblue'))  #this plots pi, SS, and D, sequentially, on the same page.

#check again where the means of these histograms fall
all.stats.sum #check first line

#Now, let's make one big pdf file with all of these plots, for all simulations.
#######Block 3: Plot #####################
##########################################
##Copy the entire block####################
pdf('all.stats.plots.pdf')
par(mfrow=c(3,1))
sapply(1:3, function(x) hist(pop.const.stats[,x], main='Constant pop size', 
xlab=colnames(pop.const.stats)[x], nclass=100, col='cornflowerblue')) #histogram is not super appropriate for SS (discrete)
#
sapply(1:3, function(x) hist(pop.t0.01.stats[,x], main='Expansion at t=0.01', 
xlab=colnames(pop.t0.01.stats)[x], nclass=20, col='cornflowerblue'))  
#
sapply(1:3, function(x) hist(pop.t0.05.stats[,x], main='Expansion at t=0.05', 
xlab=colnames(pop.t0.05.stats)[x], nclass=30, col='cornflowerblue'))
#
sapply(1:3, function(x) hist(pop.t0.12.stats[,x], main='Expansion at t=0.12', 
xlab=colnames(pop.t0.12.stats)[x], nclass=30, col='cornflowerblue'))
#
sapply(1:3, function(x) hist(pop.t0.5.stats[,x], main='Expansion at t=0.5', 
xlab=colnames(pop.t0.5.stats)[x], nclass=30, col='cornflowerblue'))
#
sapply(1:3, function(x) hist(pop.t4.stats[,x], main='Expansion at t=4', 
xlab=colnames(pop.t4.stats)[x], nclass=30, col='cornflowerblue'))
#
dev.off()

# Plot alternative 2
var <- "pi"
pdf(paste0("all.times.", var, ".pdf"), height = 12)
par(mfrow = c(4, 2))
files <- list.files(pattern = "pop\\.t*")
all_files <- lapply(files, read.table, col.names = c("pi", "ss", "D"))

times <- gsub("[^0-9]", "", files)
times[times==""] <- 0

sapply(1:length(all_files), function(x) {
       hist(all_files[[x]][var][[1]], 
	    main=paste(var, sprintf("t = %s", times[x])), 
	    xlab=colnames(all_files[[x]])[var], 
	    col='cornflowerblue')
})
dev.off()

# Plot alternative 3
hist(pop.const.stats[,1], main=paste(var, "(t = 0)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
hist(pop.t0.01.stats[,1], main=paste(var, "(t = 0.01)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
hist(pop.t0.05.stats[,1], main=paste(var, "(t = 0.05)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
hist(pop.t0.12.stats[,1], main=paste(var, "(t = 0.12)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
hist(pop.t0.5.stats[,1], main=paste(var, "(t = 0.5)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
hist(pop.t1.stats[,1], main=paste(var, "(t = 1)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
hist(pop.t4.stats[,1], main=paste(var, "(t = 4)"), 
     xlab=colnames(pop.const.stats)[var], 
     col='cornflowerblue') 
dev.off()

############################
##The END (of the R code)###
############################
##Discussion
#open the pdf and see how 'pi' and look at object all.stats.sum in R, and note that

#when expansion occured a long time ago (4*4*N generations ago), pi is very close to the theta parameter we simulated. Population has
#is in equilibrium again.
#for constant size simulations, it is very close as well. 
#for all the other times in between, what we see is a recovery of pi (which is very low for a very recent expansion)
#tajima's D is very close to 0 (neutrality) for the constant pop size simulations, and for large time since expansion (t=4). 
#for very recent expansion, D is very negative and moves steadily closer to zero as time since expasion increases until a quasi-
#equilibrium state.
#


