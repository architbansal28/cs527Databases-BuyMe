# BuyMe - Online Auction System #
## Description ##
In this project, we have designed and implemented a relational database system to support the operations of an online auction system similar to eBay. We have used HTML for the user interface, MySQL for the database server, and Java, Javascript, and JDBC for connectivity between the user interface and database server.

## Needed tools and installation ##
* JRE, IDE (JAVA, Eclipse for EE developers)
* MySQL
* Apache Tomcat (install it locally in your computer for development purposes)
* JDBC

0. Install MySQL Server 8.0.21 or above on your personal computer. Download MySQL Installer from https://dev.mysql.com/downloads/mysql/. Launch MySQL workbench to establish a connection to your local MySQL server.
1. Import schema BuyMe in your DB instance using the provided script "BuyMe.sql". Open the script and run it in your MySqlWorkbench (File &rarr; Open SQL script).
2. Download Eclipse IDE for Java EE Developers from https://eclipse.org/downloads/eclipse-packages/.
3. Open Eclipse and import the template project (cs527). <br> (File - Import - General - Existing Projects)
4. Set your Tomcat server in Eclipse
    * If you don’t have Tomcat yet go to: https://tomcat.apache.org/download-80.cgi and download the binary distribution for your OS.
    * After that go back to Eclipse: <br>
      Windows - Preference - Server - Runtime Environment - Add - Apache Tomcat v8.0 or <br>
      Eclipse - Preferences - Server - Runtime Environments - Add - Apache Tomcat v8.0
5. Connect to your own db instance in Project
    * In order to interact with db instance (add, delete, update, select), you need to set your own database address in the project.
    * At the same time, the database username and password are both essential.
    * Replace the database information with your own database information in ApplicationDB.java file.
6. Run the project based on Tomcat 8 
   (Right click on the project - Run as - Run on Server - Apache - Tomcat8). <br>
   Now you can see your project home page, login.jsp page.
   
## Features of our project ##
Create accounts of users; login, logout.

**I. Auctions**
- [x] seller creates auctions and posts items for sale
    - [x] set all the characteristics of the item
    - [x] set closing date and time
    - [x] set a hidden minimum price (reserve)
- [x] a buyer should be able to bid
    - [x] let the buyer set a new bid
    - [x] in case of automatic bidding set secret upper limit and bid increment
    - [x] alert other buyers of the item that a higher bid has been placed (manual)
    - [x] alert buyers in case someone bids more than their upper limit (automatic)
- [x] define the winner of the auction
    - [x] when the closing time has come, check if the seller has set a reserve
    - [x] if yes: if the reserve is higher than the last bid none is the winner.
    - [x] if no: whoever has the higher bid is the winner
    - [x] alert the winner that they won the auction

**II. Browsing and advanced search functionality**
- [x] let people browse on the items and see the status of the current bidding
- [x] sort by different criteria (by type, bidding price etc.)
- [x] search the list of items by various criteria.
- [ ] a user should be able to:
    - [x] view all the history of bids for any specific auction
    - [x] view the list of all auctions a specific buyer or seller has participated in
    - [ ] view the list of "similar" items on auctions in the preceding month (and auction information about them)
- [x] let user set an alert for specific items s/he is interested
    - [x] get an alert when the item becomes available
- [ ] users browse questions and answers
- [ ] users search questions by keywords

**III. Admin and customer rep functions**
- [ ] Admin (create an admin account ahead of time)
    - [x] creates accounts for customer representatives
    - [ ] generates sales reports for:
        - [ ] total earnings
        - [ ] earnings per:
            - [ ] item
            - [ ] item type
            - [ ] end-user
        - [ ] best-selling items
        - [ ] best buyers
- [ ] Customer representative functions:
    - [x] users post questions to the customer representatives (i.e. customer service)
    - [x] reps reply to user questions
    - [x] edits and deletes account information
    - [ ] removes bids
    - [ ] removes auctions
