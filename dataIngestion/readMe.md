# CSV to mySQLDB import

The pipeline definition is used to import CSV data from files in aws S3 to aws RDS mySQLDB.

## Running the pipeline

User needs to provide:

Input csv file: The csv file in S3 whose data will be imported<br/>
Data connection properties: URL, User, password are needed to connect to DB<br/>
Create statement: create statement needed to create table if not exists<br/>
Insert statement: insert statement needed to insert data in table

As mentione din UploadActivatePipelineDefinition.md, we need to create pipeline first in AWS, then can use json to upload pipeline and activate using AWS CLI.
