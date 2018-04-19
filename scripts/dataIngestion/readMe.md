#CSV to mySQLDB import

##The pipeline definition is used to import CSV data from files in aws S3 to aws RDS mySQLDB.

##Running the pipeline

User needs to provide:

Input csv file: The csv file in S3 whose data will be imported
Data connection properties: URL, User, password are needed to connect to DB
Create statement: create statement needed to create table
insert statement: insert statement needed to insert data in table
