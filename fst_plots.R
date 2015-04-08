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

# Vamos ver como a diversidade nucleotidica esta distribuida no 
# cromossomo 15, em CEU (onde a nova variante aumentou de frequencia)

# Complete o item (2) do tutorial de VCFtools.

#--------------------------------------------------------------------#

# (3) Agora vamos plotar a diversidade nucleotidica ao longo do
# cromossomo 15, calculada com o VCFtools

nucdiv <- read.table("chr15_CEU_w500k_s250k.windowed.pi", header = TRUE)

head(nucdiv)

SNP<-c(1:(nrow(nucdiv)))
pidf<-data.frame(SNP,nucdiv)

manhattan(pidf,chr="CHROM",bp="BIN_START",p="PI",
          snp="SNP",logp=FALSE, ylab = "Pi", 
          main = "Nucleotide diversity in CEU", 
          ylim = c(0,0.0001), type = "l"
          #, xlim = c(40,60) # descomentar essa linha para dar um zoom
)
# inserir linha vertical no SNP que tem o maior FST (unidade em Mb)
abline(v = 48.426484, col = "red", lty= 2)

#--------------------------------------------------------------------#

# (4) Extra: 

# (4.1) Explore o FST entre os pares de populacao CEU-JPT e JPT-YRI

# (4.2) Veja a frequencia do SNP que identificamos em outras 
# populacoes do mundo em http://popgen.uchicago.edu/ggv/

