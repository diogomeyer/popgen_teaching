# Install package to plot Manhattan plots
install.packages("qqman")

# Load package
library(qqman)

### CREATE MANHATTAN PLOT OF FST VALUES ALONG CHROMOSOME 15

# Read file with FST per SNP
fst<-read.table("CEU_YRI.weir.fst", header=TRUE)

# Select only complete lines 
fstsubset<-fst[complete.cases(fst),]

# Create numeric vector from 1 to the number of SNPs
SNP<-c(1:(nrow(fstsubset)))

# Include vector created above in the dataframe with FSTs per SNP
mydf<-data.frame(SNP,fstsubset)

# Create pdf file to plot figure
pdf("CEU_YRI_persnp.pdf")
manhattan(mydf,chr="CHROM",bp="POS",p="WEIR_AND_COCKERHAM_FST",
          snp="SNP",logp=FALSE, ylab = "Fst", 
          main = "CEU_YRI per SNP"
          )
# Create vertical line in the begining of SLC24A5
abline(v = 48.413, col = "red", lty= 2)
# Create vertical line in the end of SLC24A5
abline(v = 48.434, col = "red", lty= 2)
# Write file
dev.off()

### Now plot the Fst among CEU and JPT populations 

### The values of FST per SNP vary a lot, and there are a lot of very
### low values. Let's plot FST per window:

# Read file with FST per SNP
fst<-read.table("CEU_JPT_w10kb_s5kb.windowed.weir.fst", header=TRUE)
# Select only complete lines 
fstsubset<-fst[complete.cases(fst),]
# Create numeric vector from 1 to the number of SNPs
SNP<-c(1:(nrow(fstsubset)))
# Include vector created above in the dataframe with FSTs per SNP
mydf<-data.frame(SNP,fstsubset)

# Create pdf file to plot figure
pdf("CEU_JPT_w10kb_s5kb.pdf")
manhattan(mydf,chr="CHROM",bp="BIN_START",p="WEIGHTED_FST",
          snp="SNP",logp=FALSE, ylab = "Fst", 
          main = "CEU_JPT 10kb windows, 5kb step"
)
# Create vertical line in the begining of SLC24A5
abline(v = 48.413, col = "red", lty= 2)
# Create vertical line in the end of SLC24A5
abline(v = 48.434, col = "red", lty= 2)
# Write file
dev.off()