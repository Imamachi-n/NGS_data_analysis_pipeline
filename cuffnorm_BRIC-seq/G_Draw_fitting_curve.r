####################################
#Draw fitting curve
#var1.1_R
#update: 2015.9.29
####################################

#Time############################
#args <- commandArgs(trailingOnly = T)
#hour_list <- args[1] 
#filename_ctrl_plot <- args[2]
#filename_kd_plot <- args[3]
#filename_ctrl_model <- args[4]
#filename_kd_model <- args[5]
#save_directory <- args[6]
#hour <- unlist(strsplit(hour_list,","))
#hour <- as.numeric(hour)

#save_directory
#setwd(save_directory)
setwd("C:/Users/Naoto/Documents/github/PUM_study/fig/test")
hour <- c(0,1,2,4,8,12)

#open_data
#ctrl_plot <- paste(filename_ctrl_plot,sep="")
#kd_plot <- paste(filename_kd_plot,sep="")
#ctrl_model <- paste(filename_ctrl_model,sep="")
#kd_model <- paste(filename_kd_model,sep="")
ctrl_plot <- paste("C:/Users/Naoto/Documents/github/PUM_study/fig/siCTRL_genes_RefSeq_result_mRNA_rel_normalized.fpkm_table",sep="")
kd_plot <- paste("C:/Users/Naoto/Documents/github/PUM_study/fig/siStealth_genes_RefSeq_result_mRNA_rel_normalized.fpkm_table",sep="")
ctrl_model <- paste("C:/Users/Naoto/Documents/github/PUM_study/fig/siCTRL_genes_RefSeq_result_mRNA_rel_normalized_cal_model_selection_for_fig.fpkm_table",sep="")
kd_model <- paste("C:/Users/Naoto/Documents/github/PUM_study/fig/siStealth_genes_RefSeq_result_mRNA_rel_normalized_cal_model_selection_for_fig.fpkm_table",sep="")

data_ctrl_plot <- read.table(ctrl_plot,row.names=1,header=T)
data_kd_plot <- read.table(kd_plot,row.names=1,header=T)
data_ctrl_model <- read.table(ctrl_model,row.names=1,header=T)
data_kd_model <- read.table(kd_model,row.names=1,header=T)

#merge_deta_table
all_data_plot <- cbind(data_ctrl_plot[4:9],data_kd_plot[4:9])
all_data_model<-cbind(data_ctrl_model,data_kd_model)
sample_id <- as.vector(rep(data_ctrl_plot[,1]))

 for(x in 1:length(sample_id)){
   #save_fig
   for_x<-as.character(sample_id[x])
   file_name<-sprintf("%1$s.png",for_x)
   png(filename=file_name,width = 640, height = 640)
   
   #count_samples
   sample_number <- length(as.vector(rep(all_data_plot)))/length(hour)
   
   #plotting&model_fitting
   count_plot = 0
   for(y in 1:sample_number){
     if(count_plot == 0){
       model <- as.vector(as.matrix(all_data_model[x,]))[1:10]
       model_type <- model[1]
       model1_a <- as.numeric(model[5])
       model2_a <- as.numeric(model[6])
       model2_b <- as.numeric(model[7])
       model3_a <- as.numeric(model[8])
       model3_b <- as.numeric(model[9])
       model3_c <- as.numeric(model[10])
       if(model_type == "model1"){
         model1_curve<-function(t){exp(-model1_a*t)}
         plot(model1_curve,xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",lwd = 6,col="black")
         par(new=T)
       }
       else if(model_type == "model2"){
         model2_curve<-function(t){(1-model2_b)*exp(-model2_a*t)+model2_b}
         plot(model2_curve,xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",lwd = 6,col="black")
         par(new=T)
       }
       else if(model_type == "model3"){
         model3_curve<-function(t){model3_c*exp(-model3_a*t)+(1-model3_c)*exp(-model3_b*t)}
         plot(model3_curve,xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",lwd = 6,col="black")
         par(new=T)
       }
       else{
         par(new=T)
       }
       mRNA <- as.vector(as.matrix(all_data_plot[x,]))[1:length(hour)]
       fig_data_plot <- data.frame(hour,mRNA)
       plot(fig_data_plot[,"hour"],fig_data_plot[,"mRNA"],xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",pch=16,cex=2.5, main=sprintf("%1$s",for_x),col="black")
       par(new=T)
       count_plot = 1
     }
     if(count_plot == 1){
       model <- as.vector(as.matrix(all_data_model[x,]))[11:20]
       model_type <- model[1]
       model1_a <- as.numeric(model[5])
       model2_a <- as.numeric(model[6])
       model2_b <- as.numeric(model[7])
       model3_a <- as.numeric(model[8])
       model3_b <- as.numeric(model[9])
       model3_c <- as.numeric(model[10])
       if(model_type == "model1"){
         model1_curve<-function(t){exp(-model1_a*t)}
         plot(model1_curve,xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",lwd = 6,col="red")
         par(new=T)
       }
       else if(model_type == "model2"){
         model2_curve<-function(t){(1-model2_b)*exp(-model2_a*t)+model2_b}
         plot(model2_curve,xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",lwd = 6,col="red")
         par(new=T)
       }
       else if(model_type == "model3"){
         model3_curve<-function(t){model3_c*exp(-model3_a*t)+(1-model3_c)*exp(-model3_b*t)}
         plot(model3_curve,xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",lwd = 6,col="red")
         par(new=T)
       }
       else{
         par(new=T)
       }
       mRNA <- as.vector(as.matrix(all_data_plot[x,]))[7:12]
       fig_data_plot <- data.frame(hour,mRNA)
       plot(fig_data_plot[,"hour"],fig_data_plot[,"mRNA"],xlim=c(0,12),ylim=c(0.01,1.5),log="y",xlab="",ylab="",pch=16,cex=2.5, main=sprintf("%1$s",for_x),col="red")
       par(new=T)
       count_plot = 2
     }
   }
   
   
   #close_fig
   dev.off()
   plot.new()
}

