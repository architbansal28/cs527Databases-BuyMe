# BuyMe - Online Auction System #
## Description ##
In this project, we have designed and implemented a relational database system to support the operations of an online auction system similar to <a href="http://www.ebay.com">eBay</a>. We have used HTML for the user interface, MySQL for the database server, and Java, Javascript, and JDBC for connectivity between the user interface and database server.

## Needed tools and installation ##
* JRE, IDE (JAVA, Eclipse for EE developers)
* MySQL
* Apache Tomcat (install it locally in your computer for development purposes)
* JDBC

0. Install MySQL Server 8.0.21 or above on your personal computer. Download MySQL Installer from https://dev.mysql.com/downloads/mysql/. Launch MySQL workbench to establish a connection to your local MySQL server.
1. Import schema BuyMe in your DB instance using the provided script "BuyMe.sql". Open the script and run it in your MySqlWorkbench (File &rarr; Open SQL script).
2. Download Eclipse IDE for Java EE Developers from https://eclipse.org/downloads/eclipse-packages/.
3. Open Eclipse and import the template project (cs527). <br> (File &rarr; Import &rarr; General &rarr; Existing Projects)
4. Set your Tomcat server in Eclipse
    * If you don’t have Tomcat yet go to: https://tomcat.apache.org/download-80.cgi and download the binary distribution for your OS.
    * After that go back to Eclipse: <br>
      Windows &rarr; Preference &rarr; Server &rarr; Runtime Environment &rarr; Add &rarr; Apache Tomcat v8.0 or <br>
      Eclipse &rarr; Preferences &rarr; Server &rarr; Runtime Environments &rarr; Add &rarr; Apache Tomcat v8.0
5. Connect to your own db instance in Project
    * In order to interact with db instance (add, delete, update, select), you need to set your own database address in the project.
    * At the same time, the database username and password are both essential.
    * Replace the database information with your own database information in ApplicationDB.java file.
6. Run the project based on Tomcat 8 
   (Right click on the project &rarr; Run as &rarr; Run on Server &rarr; Apache &rarr; Tomcat8). <br>
   Now you can see your project home page, login.jsp page.
   
## Features of the project ##
Create accounts of users; login, logout

**I. Auctions**
- seller posts items for sale and creates auctions
- a buyer sets a new bid or starts automatic bidding with secret upper limit
- alert other buyers of the item that a higher bid has been placed (manual)
- alert buyers in case someone bids more than their upper limit (automatic)
- when the closing time has come, check if the seller has set a reserve:
    - if yes: if the reserve is higher than the last bid no one is the winner
    - if no: whoever has the higher bid is the winner
- alert the winner that they won the auction

**II. Browsing and advanced search functionality**
- let people browse on the items and see the status of the current bidding
- search the list of items by various criteria
- a user is able to:
    - view all the history of bids for any specific auction
    - view the list of all auctions a specific buyer or seller has participated in
    - view the list of similar items on auctions in the preceding months
- let user get an alert for specific items s/he is interested when the item becomes available

**III. Admin and customer rep functions**
- Admin functions:
    - creates accounts for customer representatives
    - generates sales reports for total earnings, earnings per (item, item type, end-user), best-selling items, best buyers
- Customer representative functions:
    - users post questions to the customer representatives (i.e. customer service) and reps reply to user questions
    - removes auctions or bids
