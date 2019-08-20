{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # TestApp\
\
This is a test application and it has no real use, it was created to test and improve skills.\
\
### Info:\
Deployment target: iOS 11\
\
Development language: Swift\
\
Pods was used: [RealmSwift](https://github.com/realm/realm-cocoa), [SDWebImage](https://github.com/SDWebImage/SDWebImage), [lottie-ios](https://github.com/airbnb/lottie-ios), \
 [Presentr](https://github.com/IcaliaLabs/Presentr), [FacebookCore, FacebookLogin, FacebookShare](https://github.com/facebook/facebook-swift-sdk).\
\
###### About:\
Application takes data from the json file, and fills the database with these data. The main screen of the application is the UITableViewController which takes data from the database and fills UITableViewCell with it. \
The UITableViewCell contains information such as: Image, Title, Description, Date, Author. \
When the user clicks on a UITableViewCell he goes to a new screen with WKWebView. \
WKWebView displays the news page, animation is displayed during loading, ProgressView also displays downloadable progress, at the end of the page loading, these items disappear. Main screen navigation bar also has two buttons: user and search. \
When the user click on the user\'92s button, a menu for selecting the social network appears in which you can select the authorization method (only Facebook works). When the user is logged in, pressing the button switches to UserInfoViewController. \
UserInfoViewController contains the username, user image, and logout button. \
\uc0\u1057 licking on the search button shows a UISearchController which filters news by title and description.\
\
## Installation\
\
To run this application, just clone the project or download a ZIP file and run TestApp.xcworkspace\
\
### To clone\
\
```bash\
$ git clone https://github.com/PantsuShooter/TestApp.git\
```\
\
## Possible problems\
\
Sometimes launching an application can cause problems with [Cocoapods](https://cocoapods.org/). To work correctly, you need to update them. You can find pods installation instructions at this [link](https://cocoapods.org/).\
\
### To update\
\
\
###### Select project folder\
```bash\
$ cd [project folder]\
```\
\
###### Update pods\
```bash\
$ pod update\
```\
###### And now you can open the project\
```bash\
$ open TestApp.xcworkspace\
```\
\
}