from flask import Flask
from flask import render_template
from flask import request
from flask import json
import pandas as pd
import numpy as np
from pandas import DataFrame
from flask_mysqldb import MySQL

mysql = MySQL()
app = Flask(__name__)

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'db_gtown_2018'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Gtown2018'
app.config['MYSQL_DATABASE_DB'] = 'db_nfl'
app.config['MYSQL_DATABASE_HOST'] = 'nflnumbers.czuayagz62va.us-east-1.rds.amazonaws.com'
mysql.init_app(app)

@app.route('/')
def main():
    return render_template('index.html')

@app.route('/showSignUp')
def showSignUp():

    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        readContactPerson = """SELECT * FROM PLAYER;"""
        cursor.execute(readContactPerson)
        data = cursor.fetchall()
        if len(data) is 0:
            conn.commit()
            return json.dumps({'message':'User created successfully !'})
        else:
            return json.dumps({'error':str(data[0])})

    except Exception as e:
        return json.dumps({'error':str(e)})
    finally:
        cursor.close() 
        conn.close()

if __name__ == "__main__":
    app.run(port=5002)