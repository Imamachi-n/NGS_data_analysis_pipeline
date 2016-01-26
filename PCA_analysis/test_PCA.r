#Title: test_PCA
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-10-05

testid <- seq(1,10,1)
sample1 <- c(86,71,42,62,96,39,50,78,51,89)
sample2 <- c(79,75,43,58,97,33,53,66,44,92)
sample3 <- c(67,78,39,98,61,45,64,52,76,93)
sample4 <- c(68,84,44,95,63,50,72,47,72,91)
sort(sample1)
sort(sample2)
sort(sample3)
sort(sample4)

test_table <- data.frame(TestId = testid, Sample1 = sample1, Sample2 = sample2, Sample3 = sample3, Sample4 = sample4,row.names=1)
test_table.matrix <- as.matrix(test_table)

pairs(test_table.matrix, pch=16, col="blue")
R_test <- cor(test_table.matrix)
spec_dec_test <- eigen(R_test)

result_test <- prcomp(t(test_table.matrix), scale=TRUE)
biplot(result_test, var.axes=FALSE, ylabs=NULL)

library(rgl)
plot3d(result_test$x,xlab="PC1",ylab="PC2",zlab="PC3",type="h")
spheres3d(result_test$x, radius=0.2,col=rainbow(length(result_test$x[,1])))
grid3d(side="z", at=list(z=0))
text3d(result_test$x, text=rownames(result_test$x), adj=1.3)

######################################

test2_table <- read.table("C:/Users/Naoto/Documents/github/NGS_data_analysis_pipeline/PCA_analysis/test_dataset.txt", header=T)
test2_table <- test2_table[,2:13]
colnames(test2_table) <- c(
  'con_A549_empty','con_A549_wt','con_A549_GFP',
  'con_MALATKO671','con_MALATKO752','con_MALATKO772',
  'HS_A549_empty','HS_A549_wt','HS_A549_GFP',
  'HS_MALAT_KO671','HS_MALAT_KO752','HS_MALAT_KO772'
)
test2_table.matrix <- as.matrix(test2_table)
result_test2 <- prcomp(t(test2_table.matrix), scale=TRUE)
biplot(result_test2, var.axes=FALSE, ylabs=NULL)

library(rgl)
plot3d(result_test2$x,xlab="PC1",ylab="PC2",zlab="PC3",type="h")
spheres3d(result_test2$x, radius=7,col=rainbow(length(result_test2$x[,1])))
grid3d(side="z", at=list(z=0))
text3d(result_test2$x, text=rownames(result_test2$x), adj=1.3)
