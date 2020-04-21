

show dbs;

show collections;

show users;

show roles;

show profile;

show databases;

db.adminCommand( { listDatabases: 1 } );

db.getCollectionNames();

db.getUsers();

db.hostInfo();

db.printSlaveReplicationInfo();

rs.status();

db = db.getSiblingDB('admin');



//  ------------------------------------------------------------
// 
//  Citation(s)
// 
//    docs.mongodb.com  |  "mongo Shell Quick Reference — MongoDB Manual"  |  https://docs.mongodb.com/manual/reference/mongo-shell/
// 
//  ------------------------------------------------------------