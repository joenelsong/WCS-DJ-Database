from __future__ import print_function
from datetime import date, datetime, timedelta
import mysql.connector


try:
    
    # Connect to Database
    cnx = mysql.connector.connect(user='radiologger', password='JuanitasAndsalsaSilvousplait',
                                host='mysql.joeynelson.net',
                                database='wcs_djbase')
    print("connected!")
    
    # Set Cursor
    cursor = cnx.cursor()
    
    # Prepare Query
    insert_test_record = ("INSERT INTO Track "
                        "(title, artist, genre, bpm) "
                        "VALUES (%s, %s, %s, %s)"
                        )
    # Bind Parameters to Query
    data = ('test_title', 'test_artist', 'test_genre', 89)
                    
    # Execute Query
    cursor.execute(insert_test_record, data)
    
    # Make sure diata is committed to the database
    cnx.commit()
    
    cursor.close()
    cnx.close()

    print("closed connection")
    
except mysql.connector.Error as err:
  print("Something went wrong: {}".format(err))
    
    

    
