#Summer Geeks
I have Built an Application for Entry Management.

Steps:
Visitor's Entry:
1.When the Visitor enter's the office he fills the form which include's name phone and mail-is
2.After clicking the entry button the details of the user are stored in the database.
        --The details of the visitor are sent to visitor in the form of email and sms
            details include:
            name,email,phone,in-time.
3.The Time-Stamp when the user has entered is recorded and stored in the database.
4.After that he gets a screen which says that he is a meeting,he is provided an Exit Button which he can hit after completion of meeting.
5.When the user clicks exit meeting button he gets an email and sma regarding the meeting
    the details include
        name,phone,check-in time,check-out time,host name,address visited
        Note:No where the visitor enters the in-time and out-time it is done accordingly by tracking visitor's data.



Host's Entry:
1.The host has to fill the details of the form which include 
    name,phon,email,addresss
2.He will be notified when the visitor comes to the company.


Technologies and Platforms used:
1.Apllication Development:
    -Flutter.
2.Database:
    -SQlite.
3.Sending email:
    -Mailer Package of Flutter.
4.Sending Message:  
    -API of way2sms.