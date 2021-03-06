
DROP TABLE IF EXISTS tbl_questions;
CREATE TABLE tbl_questions (
  str_pkid VARCHAR(40) NOT NULL,
  str_question TEXT NOT NULL,
  PRIMARY KEY (str_pkid)
);


/* API/
- Show list of active sessions!
// Button Start New Game
// Client ask for UserSessionName and perhaps PW (if closed group)
//        ask min and max user
API/startjson?SessionID="hGASjsd6"&SessionName="Franks Game"&SessionPW=""&MinUser=4&MaxUser=6
// Result is {SessionID:"hGASjsd6"}
// new Entry in Gamebase */

DROP TABLE IF EXISTS `tbl_gamebase`;
CREATE TABLE  `tbl_gamebase` (
  `PKID` VARCHAR(40) NOT NULL,
  `Running` tinyint(1) NOT NULL,  
  `SessionName` varchar(45) NOT NULL,
  `SessionPW` varchar(45) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  `MinUser` int(10) unsigned NOT NULL,
  `MaxUser` int(10) unsigned NOT NULL,
  `Position_In_QDeck` int(10) unsigned NOT NULL,
  `Position_In_ADeck` int(10) unsigned NOT NULL,
  `Act_Master` varchar(45) NOT NULL,
  `Acc_QDeckID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/* 
API/Run?SessionID="hGASjsd6"
// Question and Answer DESK is created with SessionID shuffled
// Session set to Running
// Assign 10 Cards to All Users
// Result should be the First Quetion for Display. (Acc_QDeckID)
*/

DROP TABLE IF EXISTS `developer`.`questionbase`;
CREATE TABLE  `developer`.`questionbase` (
  `PKID` VARCHAR(40) NOT NULL,
  `URL` tinyint(1) NOT NULL,
  `Question` varchar(250) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  `MinAnswerCards` int(10) unsigned NOT NULL,
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `developer`.`answerbase`;
CREATE TABLE  `developer`.`answerbase` (
  `PKID` VARCHAR(40) NOT NULL,
  `URL` tinyint(1) NOT NULL,
  `Answer` varchar(250) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `developer`.`deckQbase`;
CREATE TABLE  `developer`.`deckbase` (
  `PKID` VARCHAR(40) NOT NULL,
  `SessionID` varchar(8) NOT NULL,
  `Quertion` int(10) unsigned NOT NULL,  // Pointer to QuetionBaseID
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `developer`.`deckAbase`;
CREATE TABLE  `developer`.`deckbase` (
  `PKID` VARCHAR(40) NOT NULL,
  `SessionID` varchar(8) NOT NULL,
  `Answer` int(10) unsigned NOT NULL,  // Pointer to AnswerBaseID
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*
API/JoinGame?SessionID="hGASjsd6"&SessionName="Glenn"&SessionPW=""
// Result UserToken
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=2
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=4
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=2
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=6
// Result Selected_1=2
// Result Selected_2=4                            {EAC84404-8A36-4839-ADE0-BE9B14278315}
// Result Selected_1=-1
// Result Selected_1=6

API/Pullanswers?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Result Not Ready | Selection Result from all Users
API/FinalPull?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Selection Result from all Users that have done the selection in time

// Show results to Master

API/SelectResult?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Collect Points
// Redraw from deck
// Select next Master

*/
DROP TABLE IF EXISTS `developer`.`userbase`;
CREATE TABLE  `developer`.`userbase` (
  `PKID` VARCHAR(40) NOT NULL,
  `SessionID` varchar(8) NOT NULL,
  `UserToken` varchar(42) DEFAULT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Points` int(10) unsigned NOT NULL,
  `Card_0` int(10) unsigned NOT NULL,
  `Card_1` int(10) unsigned NOT NULL,
  `Card_2` int(10) unsigned NOT NULL,
  `Card_3` int(10) unsigned NOT NULL,
  `Card_4` int(10) unsigned NOT NULL,
  `Card_5` int(10) unsigned NOT NULL,
  `Card_6` int(10) unsigned NOT NULL,
  `Card_7` int(10) unsigned NOT NULL,
  `Selected_1` int(10) unsigned NOT NULL,
  `Selected_2` int(10) unsigned NOT NULL,
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
