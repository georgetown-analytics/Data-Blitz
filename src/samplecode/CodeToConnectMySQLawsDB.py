import mysql.connector
from mysql.connector import errorcode
 
config = {
'user': 'db_gtown_2018',
'password': '*****',
'port': '3306',
'host': 'db-gtown-data-science-nfl.cm2t8p4umjff.us-east-2.rds.amazonaws.com',
'database': 'db_nfl',
'raise_on_warnings': True,
}
 
try:
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor()
    #Let's read all the rows in the table
    readContactPerson = "select date, season from db_nfl.nfl_elo"
    cursor.execute(readContactPerson)
    #specify the attributes that you want to display
    for (date, season) in cursor:
        print("{}, {}".format(date,season))
    cnx.commit()
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
else:
    cursor.close()
    cnx.close()
