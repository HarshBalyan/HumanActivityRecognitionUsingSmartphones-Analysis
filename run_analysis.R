a<-read.table("test/subject_test.txt",stringsAsFactors=F) ##reading the test files
b<-read.table("test/X_test.txt",stringsAsFactors=F)
c<-read.table("test/y_test.txt",stringsAsFactors=F)
a<-cbind(a,b)   ##Binding the test files
a<-cbind(a,c)   
a2<-read.table("train/subject_train.txt",stringsAsFactors=F)## reading the train files
b<-read.table("train/X_train.txt",stringsAsFactors=F)
c<-read.table("train/y_train.txt",stringsAsFactors=F)
a2<-cbind(a2,b) ##Binding the test and train files
a2<-cbind(a2,c)
a<-rbind(a,a2)
b<-read.table("features.txt",stringsAsFactors=F)
b<-rbind(c(1,"Subject"),b)
b<-rbind(b,c(1,"Result"))
##Providing column names to the data set using the a data frame feature's name ,subject and result
colnames(a)<-b$V2
a<-a[,grep("std\\(\\)|mean\\(\\)",b$V2)]##Filtering the data to have only the mean and std deviation measurements

##Re adding the activity and subject columns which were filtered out
c1<-read.table("test/y_test.txt",stringsAsFactors=F)
c2<-read.table("train/y_train.txt",stringsAsFactors=F)
c1<-rbind(c1,c2)
colnames(c1)<-c("Activity")
a<-cbind(a,c1)
c2<-read.table("test/subject_test.txt",stringsAsFactors=F)
a2<-read.table("train/subject_train.txt",stringsAsFactors=F)
c2<-rbind(c2,a2)
colnames(c2)<-c("Subject")
a<-cbind(c2,a)

#Replacing the activity ID with the activity description
a$Activity[a$Activity==1]<-"WALKING"
a$Activity[a$Activity==2]<-"WALKING_UPSTAIRS"
a$Activity[a$Activity==3]<-"WALKING_DOWNSTAIRS"
a$Activity[a$Activity==4]<-"SITTING"
a$Activity[a$Activity==5]<-"STANDING"
a$Activity[a$Activity==6]<-"LAYING"

# Splitting the data based on each person and each activity
d<-split(a,list(a$Activity,a$Subject))
#Calculating the average of each of the features for all the groupings of previous statement
d<-sapply(d,FUN=function(X){temp=X[2:67]  
                            colMeans(temp)
                            })
#writing the output to file
write.table(d,"FinalOutput.txt",row.names=F)
