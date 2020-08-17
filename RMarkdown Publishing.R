#################################################################################
##Downloading Qualtrics Survey Data
install.packages("httr")
install.packages("rmarkdown")
install.packages("rsconnect")

library(httr)

#set api key to your Qualtrics User API token
qualtrics_api_key <- "11bPtsJ3Eo3plIBGZufXGbuYJAWYcIa1jfHmH9LD"
survey_basename <- "PSY260"
#set output_dir to path on your computer where the surveys will be held
output_dir <- "~/Downloads/Docs/UM/Research/MANATEE/R_project_with_Brittany/Surveys"
#set new_surveys to path on your computer where the new surveys will be held
new_surveys <- "~/Downloads/Docs/UM/Research/MANATEE/R_project_with_Brittany/New Surveys"
#set ren to the path on your computer where the R Markdown (.Rmd) is held
ren <- "~/Downloads/Docs/UM/Research/MANATEE/R_project_with_Brittany/Heller_Survey.Rmd"
setwd(output_dir)

#set w equal to the number of students in the class
w = 3

#get first 100 surveys info#
r <- GET(url = "https://umiami.qualtrics.com/API/v3/surveys", add_headers(.headers = c(
  "X-API-TOKEN"=qualtrics_api_key
)))

#get next 100 surveys info#
s <- GET(url = "https://umiami.qualtrics.com/API/v3/surveys?offset=100", add_headers(.headers = c(
  "X-API-TOKEN"=qualtrics_api_key
)))

#get survey names and ids for surveys contianing basename#
survey_ids <- vector(mode="character", length=61)
survey_names <- vector(mode="character", length=61)
a <- 1

#for loop for every 100 surveys#
for(i in 1:length(content(r, "parsed", "application/json")$result$elements)){
  if(grepl(survey_basename,content(r, "parsed", "application/json")$result$elements[[i]]$name)){
    survey_ids[a] <-  content(r, "parsed", "application/json")$result$elements[[i]]$id
    survey_names[a] <- content(r, "parsed", "application/json")$result$elements[[i]]$name
    a <- a+1
  }
}

for(j in 1:length(content(s, "parsed", "application/json")$result$elements)){
  if(grepl(survey_basename,content(s, "parsed", "application/json")$result$elements[[j]]$name)){
    survey_ids[a] <-  content(s, "parsed", "application/json")$result$elements[[j]]$id
    survey_names[a] <-  content(s, "parsed", "application/json")$result$elements[[j]]$name
    a <- a+1
  }
}


#download each survey and save it to output_dir#
for(k in 1:length(survey_ids)){
  current_id <- survey_ids[k]
  progressStatus <- "inProgress"
  baseurl <- paste0("https://umiami.qualtrics.com/API/v3/surveys/",current_id,"/export-responses/")
  
  t <- POST(url = baseurl, body = '{\n"format": "csv",\n"includeDisplayOrder": true,\n"timeZone": "America/New_York"\n}', add_headers(.headers = c(
    "Content-Type"="application/json",
    "X-API-TOKEN"=qualtrics_api_key
  )))
  progressId  <- content(t, "parsed", "application/json")$result$progressId
  
  while(!grepl("complete",progressStatus) && !grepl("failed",progressStatus)){
    requestCheckURl <- paste0(baseurl,progressId)
    u <- GET(url = requestCheckURl, add_headers(.headers = c(
      "Content-Type"="application/json",
      "X-API-TOKEN"=qualtrics_api_key
    )))
    progressStatus <- content(u, "parsed", "application/json")$result$status
  }
  if(grepl("failed",progressStatus)){
    print(paste(survey_names[k],"export failed"))
  }
  else{
    fileID <- content(u, "parsed", "application/json")$result$fileId
    requestDownloadURl <- paste0(baseurl,fileID,"/file")
    v <- GET(url = requestDownloadURl,add_headers(.headers = c(
      "Content-Type"="application/json",
      "X-API-TOKEN"=qualtrics_api_key
    )),write_disk(paste0(output_dir,survey_names[k],".zip"), overwrite = TRUE))
    unzip(paste0(output_dir,survey_names[k],".zip"))
    invisible(file.remove(paste0(output_dir,survey_names[k],".zip")))
  }
}


#cleaning the data to make it ready for analysis
#set list.files and File_length to path to Surveys folder
list.files(output_dir)
File_length <- length(list.files(output_dir))

for (i in 1:File_length) {
  file_name <- list.files(output_dir)[i]
  file_var <- read.csv(file_name)
  aa <- file_var[3:nrow(file_var),]
  colnames(aa)[colnames(aa)== "Q9_1"] <- "Happy"
  colnames(aa)[colnames(aa)== "Q11_1"] <- "Sad"
  colnames(aa)[colnames(aa)== "Q12_1"] <- "Stressed"
  colnames(aa)[colnames(aa)== "Q13_1"] <- "Relaxed"
  colnames(aa)[colnames(aa)== "Q14_1"] <- "Overthinking"
  colnames(aa)[colnames(aa)== "Q15_1"] <- "Optimistic"
  colnames(aa)[colnames(aa)== "Q16_1"] <- "Self-Conscious"
  colnames(aa)[colnames(aa)== "Q17_1"] <- "Past"
  colnames(aa)[colnames(aa)== "Q18_1"] <- "Socializing"
  colnames(aa)[colnames(aa)== "Q19_1"] <- "WorkingOut"
  colnames(aa)[colnames(aa)== "Q20_1"] <- "Laughing"
  colnames(aa)[colnames(aa)== "Q21_1"] <- "Procrastinating"
  write.csv(aa, file = paste0(new_surveys,"/",file_name))
}




#################################################################################

#RPubs Code Set Up

library(rmarkdown)
library(rsconnect)
setwd(ren)



#################################################################################

###First Upload
#This section of code only needs to be used during the first upload.
#This section should be commented out using the '#' symbol for all updates afterward.

#loops through subjects: renders Rmd file to html file, uploads html to RPubs 
#and stores id in pub dataframe.


sub = NA
id[1:w] = NA
pub <- data.frame(sub, id)


for (i in 1:w){
  ipath <- paste(new_surveys, "/", survey_basename, "_00", i, ".csv", sep = "" )
  
  subject <- paste("PSY260_00",i, sep = "")
  
  html <- render(ren, "html_document", output_dir = new_surveys)
  
  result <- rpubsUpload(subject, html, NULL)
  if (!is.null(result$continueUrl))
    browseURL(result$continueUrl)
    print(i)
  
  pub$sub[i] <- subject
  pub$id[i] <- result$id
}

for (i in 1:w){
  cat("Subject ", i, "'s survey link is: ", pub$id[i], sep = "", "\n", "\n") 
}


#################################################################################

###Update Publications
#This section of code should be commented out using the '#' symbol only
#during the first publishing. For all future updates, lines 175-185 should not 
#include the '#' symbol.

##loops through subjects: renders updated Rmd file to html, publishes html to
#existing RPubs page using the ids previously stored in pub dataframe.

for (i in 1:w){
  ipath <- paste(new_surveys, "/", survey_basename, "_00", i, ".csv", sep = "" )
  
  subject <- paste("PSY260_00",i, sep = "")
  
  html <- render(ren, "html_document", output_dir = new_surveys)
  
  upresult <- rpubsUpload(subject, html, NULL, id = pub$id[i])
    if (!is.null(upresult$continueUrl))
      print(i)
}  

#################################################################################