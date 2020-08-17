# Survey-Publishing
Publishes plots of Qualtrics survey data to RPubs as HTML

The following steps will allow you to publish data from your students’ Qualtrics surveys to RPubs using the R script ‘RMarkdown Publishing.R’. 

Survey Instructions:
These steps should be followed when creating the EMA surveys on Qualtrics for the course. 
1.	Make sure all surveys have the same name structure. For example, if the class is PSY 260, the survey_basename should be “PSY260”. The individual subjects’ file names should be PSY260_001, PSY260_002, etc. 
2.	Once the surveys are created, you’ll need to extract the survey link under “Distribute Survey” on Qualtrics. Select Anonymous link. Copy and paste this link into bit.ly to create a shorter link. Keep copies of both the long survey link and the bit.ly link for future reference. 
3.	Set up Filemaker experiment (see Filemaker instructions or ask Aaron). 

To publish data for real-time viewing:
•	You will need to create an account on RPubs.com. This is a free service that will allow you to upload Rmarkdown files. 

First Publication Instructions:
These steps only need to be followed the first time the survey data is published.

1.	Set qualtrics_api_key to your Qualtrics User API token.
•	To find your ID, log in to your Qualtrics account, click on the user profile on the top right of the browser, and go to Account Settings. Click on the “Qualtrics IDs” tab. Find the API token by looking in the second box in the right-hand column (it should be long and a series of letters and numbers). 
•	Copy your API token and paste into the designated location in the R script (to the right of the arrow pointing to qualtrics_api_key), making sure your API token is in quotations.

2.	Set survey_basename to the class name and number, which all the file names should start with. 
•	For example, if the class is PSY 260, the survey_basename should be “PSY260”. The individual subjects’ file names should be PSY260_001, PSY260_002, etc. 
•	Make sure the base name you picked is in quotations.

3.	Create two folders on your computer in the same location: “Surveys” and “New Surveys”. This is where the Qualtrics survey data will be downloaded and stored.

4.	Set output_dir as the file path that leads to your “Surveys” folder. All file paths should be in quotation marks.
•	To find any file path on a Mac, go to the file in Finder. Click ‘File’ on the top left of your desktop, then click ‘Get Info’. The ‘Where’ section shows the file path. When typed into the code the path sections should be separated by ‘/’ instead of arrows. Add the folder in question at the end; in this case the path should end with “/Surveys”.
•	To find any file path in Windows, go to the file in File Explorer. Right click the file and click ‘Properties’. The ‘Location’ section in the General tab shows the file path. When typed into the code the path sections should be separated by ‘/’ instead of arrows. Add the folder in question at the end; in this case the path should end with “/Surveys”.

5.	Set new_surveys as the file path that leads to your “New Surveys” folder. 

6.	Set r_mark as the file path that leads to the folder which contains the R Markdown files (.Rmd).

7.	Set w to the number of students who are participating in the surveys. No quotation marks are needed.

8.	Make sure lines __-___ do not have ‘#’s in front of them.

9.	Make sure the lines __-___ which include text have ‘#’s in front of them.

10.	Highlight the entire code and click the Run -> button on the top right.

11.	Many tabs will open on your browser window. Press the Continue button for each subject to officially publish them to RPubs. This will only happen the first time. 

12.	Check that the html documents appear on the screen. If it successfully appears, feel free to close the tab from your browser.

13.	Now delete the ‘#’s in lines __-___.

14.	Add ‘#’s to the beginning of the lines ___-___ that include text.

15.	Save the R script.

16.	The R script will output a table which will give you the RPub link for each survey. Send each student their corresponding RPub link so that they can look at their data. The data will always publish to this link, so students should bookmark it. 



Updating RPubs (each time after the first):

As students continue to answer survey questions on Qualtrics, their RPubs pages will have to be updated with the new data. If the steps in ‘First publication instructions’ were followed correctly, all you have to do to update them is run the code!

1.	Make sure lines __-__ do not have ‘#’ symbols in front of them.

2.	Make sure lines __-__ that include text have ‘#’ symbols in front of them.

3.	Highlight the entire code and press the Run -> button in the top right corner.


Tabs will not open in the browser window when updating the RPubs pages. To check if the pages updated successfully, you can go to ‘View profile’ on RPubs to see them. Your students can use the same link from the first publication to access their survey data.

