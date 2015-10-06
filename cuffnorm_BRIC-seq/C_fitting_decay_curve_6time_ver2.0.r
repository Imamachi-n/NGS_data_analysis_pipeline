#Title: Fitting decay curve 6time
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2014-08-29

#Time############################
args <- commandArgs(trailingOnly = T)
filename <- args[1]
hour_list <- args[2] 
#hour_list <- "0,1,2,4,8,12"
hour <- unlist(strsplit(hour_list,","))
hour <- as.numeric(hour)
first_sample <- 5 - 1
last_sample <- 5 + length(hour) - 1 - 1

fitting_optim_siRNA <- function(i){
fname <- paste(i,"_rel_normalized.fpkm_table",sep="")
output <- paste(i,"_rel_normalized_cal.fpkm_table",sep="")
all_data <- read.table(fname,row.names=1,header=T,sep="\t")
sample_id <- row.names(all_data)

cat("id","value","model1","cor1","a_1","half1_1","half1_2","AIC1","model2","cor2","a_2","b_2","half2",
      "AIC2","model3","cor3","a_3","b_3","c_3","half3","AIC3",sep="\t",file=output)
cat("\n",file=output,append=T)

for(x in sample_id){
	mRNA <- all_data[x,]
	mRNA <- as.numeric(mRNA)
	mRNA <- mRNA[first_sample:last_sample]   
	dat <- data.frame(hour,mRNA)
	dat <- dat[dat$mRNA >= 0.1,] #modified
	dat_point <- length(dat$mRNA)
	cat(x,"\t",sep="",file=output,append=T)
  
   if(mRNA[1] >= 1){
	if(dat_point >= 3){
		cat("ok","\t",sep="",file=output,append=T)
		size <- length(dat[,"mRNA"])
       
		#model1:y = exp(-a * t)
		optim1 <- function(x){
			mRNA_exp <- exp(-x * dat[,"hour"])
			sum((dat[,"mRNA"]-mRNA_exp)^2)
		}

		out1 <- optim(1,optim1)
		min1 <- out1$value
		a_1 <- out1$par[1]
		half1_1 <- log(2) / a_1
 
		model1_pred <- function(x){
			mRNA_exp <- exp(-x * dat[,"hour"])
			(cor(mRNA_exp,dat[,"mRNA"],method="pearson"))^2
		}
		cor1 <- model1_pred(a_1)

		model1_half <- function(x){
			mRNA_half <-  exp(- a_1 * x)
			(mRNA_half - 0.5)^2
		}
		
		out1 <- optim(1,model1_half)
		half1_2 <- out1$par
		mRNA_pred <- exp(- a_1 * dat[,"hour"])
		s2 <-  sum((dat[,"mRNA"] - mRNA_pred )^2 )/ size
		AIC1 <- size * log(s2)+ 2 * 0
    
		cat(min1,cor1,a_1,half1_1,half1_2,AIC1,sep="\t",file=output,append=T)
		cat("\t",file=output,append=T)
 
		#model2:y = A * exp(-b * t) + c
		optim2 <- function(x){
			mRNA_exp <- (1.0 - x[2]) * exp(-x[1] * dat[,"hour"]) + x[2]
			sum((dat[,"mRNA"]-mRNA_exp)^2)
		}

		out2 <- optim(c(1,0),optim2)
		min2 <- out2$value
		a_2 <-  out2$par[1]
		b_2 <-  out2$par[2]

		model2_pred <- function(a,b){
			mRNA_exp <- (1- b) * exp(-a * dat[,"hour"]) + b
			(cor(mRNA_exp,dat[,"mRNA"],method="pearson"))^2
		}

		cor2 <- model2_pred(a_2,b_2)

		model2_half <- function(x){
			mRNA_half <-  (1 - b_2) * exp(- a_2 * x) + b_2
			(mRNA_half - 0.5)^2
		}
		
		out2 <- optim(1,model2_half)
		half2 <- out2$par
        
        if(b_2 >= 0.5){
         half2 <- Inf
        }
   
        mRNA_pred <- (1 - b_2) * exp(- a_2 * dat[,"hour"]) + b_2
        s2 <-  sum((dat[,"mRNA"] - mRNA_pred )^2 )/ size
        AIC2 <- size * log(s2)+ 2 * 1

		cat(min2,cor2,a_2,b_2,half2,AIC2,sep="\t",file=output,append=T)
		cat("\t",file=output,append=T)

		#model3:y = A * exp(-b * t) + (1 - A) * exp (-c * t)

		optim3 <- function(x){
			mRNA_exp <- x[3] * exp(-x[1] * dat[,"hour"]) + (1 - x[3]) * exp(- x[2] * dat[,"hour"])
			sum((dat[,"mRNA"]-mRNA_exp)^2)
		}

		out3 <- optim(c(1,1,0.1),optim3)
		min3 <- out3$value
		a_3 <- out3$par[1]
		b_3 <- out3$par[2]
		c_3 <- out3$par[3]

		model3_pred <- function(a,b,c){
			mRNA_exp <- c * exp(-a * dat[,"hour"]) + (1 - c) * exp(- b * dat[,"hour"])
			(cor(mRNA_exp,dat[,"mRNA"],method="pearson"))^2
		}

		cor3 <- model3_pred(a_3,b_3,c_3)

		model3_half <- function(x){
			mRNA_half <- c_3 * exp(- a_3 * x) +(1 - c_3) * exp(- b_3  * x)
			(mRNA_half - 0.5)^2
		}
		
		out3 <- optim(1,model3_half)
		half3 <- out3$par
		mRNA_pred <- c_3 * exp(- a_3 * dat[,"hour"]) + (1 - c_3) * exp(- b_3 * dat[,"hour"]) 
		s2 <-  sum((dat[,"mRNA"] - mRNA_pred )^2 )/ size
		AIC3 <- size * log(s2)+ 2 * 2

		cat(min3,cor3,a_3,b_3,c_3,half3,AIC3,sep="\t",file=output,append=T)
		cat("\n",file=output,append=T)
 
		} else {
			cat("few_data","\n",sep="",file=output,append=T)
			next
		}
		}else{
			cat("low_expresion","\n",sep="",file=output,append=T)
			next;
		}

}

}

fitting_optim_siRNA(filename) 
