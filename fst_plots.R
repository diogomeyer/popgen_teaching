#--------------------------------------------------------------------#

# (1) Outliers de Fst: histograma

# Ler output do VCFtools
fst <- read.table("CEU_YRI.weir.fst", header = TRUE)

# Plotar histograma de FST
hist(fst$WEIR_AND_COCKERHAM_FST,
     main = "FST CEU-YRI", xlab = "FST", nclass = 100)

# Qual o SNP com FST mais extremo?
fst[which.max(fst$WEIR_AND_COCKERHAM_FST), ]

# Pesquisar: em qual gene está esse SNP?
# Sugestão para a pesquisa: https://genome.ucsc.edu/cgi-bin/hgGateway

#--------------------------------------------------------------------#

# (2) Outliers de Fst: Manhattan plot

# Instalar pacote
install.packages("qqman")

# Carregar o pacote
library(qqman)

# Preparar o input da funcao manhattan:

## Selecionar apenas as linhas completas (sem NA) 
fstsubset<-fst[complete.cases(fst),]
## Criar um vetor numérico que vai de 1 ate o numero de SNPs
SNP<-c(1:(nrow(fstsubset)))
## Incluir o vetor criado como uma nova coluna no dataframe
fstdf<-data.frame(SNP,fstsubset)

# Plotar
manhattan(fstdf,chr="CHROM",bp="POS",p="WEIR_AND_COCKERHAM_FST",
          snp="SNP",logp=FALSE, ylab = "Fst", 
          main = "FST CEU-YRI"
          )
# inserir linha vertical no SNP que tem o maior FST (unidade em Mb)
abline(v = 48.426484, col = "red", lty= 2)

#--------------------------------------------------------------------#

# (3) 2D-SFS

# Ler output do VCFtools
CEUfrq <- read.table("CEU.frq", header = TRUE,
                     as.is = TRUE, fill = TRUE,
                     col.names = c("CHROM", "POS", "N_ALLELES", "N_CHR",
                                   "ALLELE:FREQ_1", "ALLELE:FREQ_2"))
head(CEUfrq)

# Extrair so a frequencia do alelo alternativo 1
CEU_AF <- sapply(strsplit(x=CEUfrq$ALLELE.FREQ_1, ":"), "[", 2)
head(CEU_AF)

# Idem para YRI
# Ler output do VCFtools
YRIfrq <- read.table("YRI.frq", header = TRUE,
                     as.is = TRUE, fill = TRUE, 
                     col.names = c("CHROM", "POS", "N_ALLELES", "N_CHR",
                                   "ALLELE:FREQ_1", "ALLELE:FREQ_2"))
head(YRIfrq)

# Extrair so a frequencia do alelo alternativo 1
YRI_AF <- sapply(strsplit(x=YRIfrq$ALLELE.FREQ_1, ":"), "[", 2)
head(YRI_AF)

# Plotar as frequencias do alelo alternativo de uma populacao contra
# a outra
plot(CEU_AF, YRI_AF, cex = 0.5)

# Plotar as frequencias no SNP em SLC24A5

# coordenada do SNP com FST maximo
posSLC<-fst[which.max(fst$WEIR_AND_COCKERHAM_FST), "POS"]
posSLC

# Extraindo a linha desse SNP nas tabelas de frequencia
CEUfrq[ CEUfrq$POS == posSLC,]
YRIfrq[ YRIfrq$POS == posSLC,]

# Extraindo a frequencia do alelo alternativo nesse SNP
CEU_SLC <- CEU_AF[ CEUfrq$POS == posSLC]
YRI_SLC <- YRI_AF[ YRIfrq$POS == posSLC]

points(CEU_SLC, YRI_SLC, col= "red", pch = "*", cex = 4)
#--------------------------------------------------------------------#

# (4) Extra: 

# (4.1) Explore o FST entre os pares de populacao CEU-JPT e JPT-YRI

# (4.2) Veja a frequencia do SNP que identificamos em outras 
# populacoes do mundo em http://popgen.uchicago.edu/ggv/

