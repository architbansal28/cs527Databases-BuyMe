drop database if exists `buyme`;
create database `buyme` /*!40100 default character set latin1 */;
use `buyme`;

/*!40101 set @old_character_set_client=@@character_set_client */;
/*!40101 set @old_character_set_results=@@character_set_results */;
/*!40101 set @old_collation_connection=@@collation_connection */;
/*!40101 set names utf8 */;
/*!40103 set @old_time_zone=@@time_zone */;
/*!40103 set time_zone='+00:00' */;
/*!40014 set @old_unique_checks=@@unique_checks, unique_checks=0 */;
/*!40014 set @old_foreign_key_checks=@@foreign_key_checks, foreign_key_checks=0 */;
/*!40101 set @old_sql_mode=@@sql_mode, sql_mode='no_auto_value_on_zero' */;
/*!40111 set @old_sql_notes=@@sql_notes, sql_notes=0 */;

--
-- table structure for table `user`
--

drop table if exists `user`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `user` (
  `user_id` varchar(20) not null unique,
  `password` varchar(20) not null,
  `name` varchar(50) not null,
  `email` varchar(50) not null unique,
  primary key (`user_id`)
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- dumping data for table `user`
--

lock tables `user` write;
/*!40000 alter table `user` disable keys */;
insert into `user` values ('admin','admin','archit bansal','admin@buyme.com');
/*!40000 alter table `user` enable keys */;
unlock tables;

--
-- table structure for table `administrative_staff_member`
--

drop table if exists `administrative_staff_member`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `administrative_staff_member` (
  `user_id` varchar(20) not null unique,
  primary key (`user_id`),
  foreign key (`user_id`) references `user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- dumping data for table `administrative_staff_member`
--

lock tables `administrative_staff_member` write;
/*!40000 alter table `administrative_staff_member` disable keys */;
insert into `administrative_staff_member` values ('admin');
/*!40000 alter table `administrative_staff_member` enable keys */;
unlock tables;

--
-- table structure for table `customer_representative`
--

drop table if exists `customer_representative`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `customer_representative` (
  `user_id` varchar(20) not null unique,
  primary key (`user_id`),
  foreign key (`user_id`) references `user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `end_user`
--

drop table if exists `end_user`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `end_user` (
  `user_id` varchar(20) not null unique,
  `anonymize` bool not null default 0,
  primary key (`user_id`),
  foreign key (`user_id`) references `user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `alert`
--

drop table if exists `alert`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `alert` (
  `end_user_id` varchar(20) not null,
  `timestamp` datetime not null,
  `message` varchar(3000) not null,
  primary key (`end_user_id`,`message`),
  foreign key (`end_user_id`) references `end_user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `question`
--

drop table if exists `question`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `question` (
  `ques_id` int not null auto_increment,
  `ques_text` varchar(500) not null,
  `ans_text` varchar(500),
  `status` enum('pending','resolved') not null default 'pending',
  `timestamp_asked` datetime not null,
  `timestamp_resolved` datetime,
  `end_user_id` varchar(20) not null,
  `customer_rep_id` varchar(20),
  primary key (`ques_id`),
  foreign key (`end_user_id`) references `end_user` (`user_id`) on delete cascade on update cascade,
  foreign key (`customer_rep_id`) references `customer_representative` (`user_id`) on delete set null on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `category`
--

drop table if exists `category`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `category` (
  `cat_id` varchar(10) not null unique,
  `name` varchar(20) not null,
  primary key (`cat_id`)
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- dumping data for table `category`
--

lock tables `category` write;
/*!40000 alter table `category` disable keys */;
insert into `category` values ('veh','vehicle'),('clo','clothing'),('ele','electronics'),('fur','furniture');
/*!40000 alter table `category` enable keys */;
unlock tables;

--
-- table structure for table `subcategory`
--

drop table if exists `subcategory`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `subcategory` (
  `cat_id` varchar(10) not null,
  `subcat_id` varchar(10) not null,
  `name` varchar(20) not null,
  primary key (`cat_id`,`subcat_id`),
  foreign key (`cat_id`) references `category` (`cat_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- dumping data for table `subcategory`
--

lock tables `subcategory` write;
/*!40000 alter table `subcategory` disable keys */;
insert into `subcategory` values ('veh','tru','truck'),('veh','car','car'),('veh','bik','motorbike');
/*!40000 alter table `subcategory` enable keys */;
unlock tables;

--
-- table structure for table `item`
--

drop table if exists `item`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `item` (
  `cat_id` varchar(10) not null,
  `subcat_id` varchar(10) not null,
  `item_id` int not null auto_increment,
  `name` varchar(20) not null,
  `brand` varchar(20) not null,
  `year` year not null,
  `desc_1` varchar(100),
  `desc_2` varchar(100),
  `desc_3` varchar(100),
  `created_by` varchar(20) not null,
  primary key (`item_id`,`cat_id`,`subcat_id`),
  foreign key (`cat_id`,`subcat_id`) references `subcategory` (`cat_id`,`subcat_id`) on delete cascade on update cascade,
  foreign key (`created_by`) references `end_user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `auction`
--

drop table if exists `auction`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `auction` (
  `auction_id` int not null auto_increment,
  `cat_id` varchar(10) not null,
  `subcat_id` varchar(10) not null,
  `item_id` int not null,
  `starting_time` datetime not null,
  `closing_time` datetime not null,
  `initial_price` int not null,
  `increment_price` int not null,
  `minimum_price` int,
  `curr_winner` varchar(10),
  `curr_price` int,
  primary key (`auction_id`),
  foreign key (`item_id`,`cat_id`,`subcat_id`) references `item` (`item_id`,`cat_id`,`subcat_id`) on delete cascade on update cascade,
  foreign key (`curr_winner`) references `end_user` (`user_id`) on delete set null on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `bid`
--

drop table if exists `bid`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `bid` (
  `bid_id` int not null auto_increment,
  `user_id` varchar(20) not null,
  `auction_id` int not null,
  `timestamp` datetime not null,
  `amount` int not null,
  primary key (`bid_id`),
  foreign key (`auction_id`) references `auction` (`auction_id`) on delete cascade on update cascade,
  foreign key (`user_id`) references `end_user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `auto_bid`
--

drop table if exists `auto_bid`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `auto_bid` (
  `user_id` varchar(20) not null,
  `auction_id` int not null,
  `timestamp` datetime not null,
  `upper_limit` int not null,
  primary key (`user_id`,`auction_id`),
  foreign key (`auction_id`) references `auction` (`auction_id`) on delete cascade on update cascade,
  foreign key (`user_id`) references `end_user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;

--
-- table structure for table `wishlist`
--

drop table if exists `wishlist`;
/*!40101 set @saved_cs_client     = @@character_set_client */;
/*!40101 set character_set_client = utf8 */;
create table `wishlist` (
  `user_id` varchar(20) not null,
  `cat_id` varchar(10) not null,
  `subcat_id` varchar(10) not null,
  `item_id` int not null,
  primary key (`user_id`,`cat_id`,`subcat_id`,`item_id`),
  foreign key (`item_id`,`cat_id`,`subcat_id`) references `item` (`item_id`,`cat_id`,`subcat_id`) on delete cascade on update cascade,
  foreign key (`user_id`) references `end_user` (`user_id`) on delete cascade on update cascade
) engine=innodb default charset=latin1;
/*!40101 set character_set_client = @saved_cs_client */;
/*!40103 set time_zone=@old_time_zone */;

/*!40101 set sql_mode=@old_sql_mode */;
/*!40014 set foreign_key_checks=@old_foreign_key_checks */;
/*!40014 set unique_checks=@old_unique_checks */;
/*!40101 set character_set_client=@old_character_set_client */;
/*!40101 set character_set_results=@old_character_set_results */;
/*!40101 set collation_connection=@old_collation_connection */;
/*!40111 set sql_notes=@old_sql_notes */;

