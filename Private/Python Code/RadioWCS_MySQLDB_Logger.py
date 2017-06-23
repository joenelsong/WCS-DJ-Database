from __future__ import print_function

# Author: Joey M Nelson
# 10/12/2014
# Runtime Environment: Python 2.7

#Working Directory = C:\\Users\\Jnelson\\dropbox\\dj\\RadioLogger2.0

#PC# cd C:\Users\Jnelson\dropbox\dj\RadioLogger
#MAC# cd /Users/joe/Dropbox/DJ/RadioLogger


''' 
This Program will query RadioWCS.com every few minutes and copy the list of tracks that have been played recently.
These tracks will be written to a text file

Syntax: python RadioTrackGrabber.py <TextFilePath> <URL> <QUERYDELAY>
<URL> = URL of radio track data source
<QUERYDELAY> delay in seconds between queries

e.g. python RadioTrackGrabber.py http://manager4.icreo.fr/js.php/radiowestcoastswing/recenttracks/rnd0 120
'''


''' SQL DATABASE CREATION '''
# Sqlite3 dateformat: yyyy-mm-dd hh:mm:ss
# create table RadioWCS(title VARCHAR(100), artist VARCHAR(100), date DATETIME, PRIMARY KEY(title, artist));
# insert into RadioWCS values('A Night to Remember', 'MARY J BLEIGE', '2014-10-14 23:10:08');
# insert into RadioWCS values('Try', 'PINK', '2014-10-14 23:12:04');
# insert into RadioWCS values('I Heard It Through The Grapevine', 'MARVIN GAYE', '2014-08-12 23:12:11');
# insert into RadioWCS values(4,'Maps', 'MAROON 5', '2014-05-20 10:00:20');
# select max(trackid) from radiowcs;

# .save RadioLogger.db

from datetime import date, datetime, timedelta
import mysql.connector

import urllib, json
import urllib2
import time
import sys
import os
import datetime
import random
import httplib




def artistStrip(s):
    stripString = "\,,\'"
    return s.strip(stripString)
    
def titleStrip(s):
    stripString = "\,,\'"
    return s.strip(stripString)
    
def newlineStrip(s):
    stripString ="\\n"
    return s.strip(stripString)
    
def path():
    pathname = os.path.dirname(sys.argv[0])        
    asbPath = os.path.abspath(pathname)
    return str(asbPath)
    
def attrib_DateTime(timestamp): # import datetime
    d = datetime.datetime.fromtimestamp(int(timestamp)).strftime('%Y-%m-%d %H:%M:%S')
    # returns string of format: yyyy-mm-dd hh:mm:ss ; compatiable with sqlite3 DATETIME
    return d
    
   
def db_AddTrackRecord(title, artist, genre, bpm):
    # Prepare Query
    insert_stmt = ("INSERT INTO Track "
                        "(title, artist, genre, bpm) "
                        "VALUES (%s, %s, %s, %s)"
                        )
    # Bind Parameters to Query
    data = (title, artist, genre, bpm)
    
    try:
        # Execute Query
        cursor.execute(insert_stmt, data)
        
        # Make sure diata is committed to the database
        cnx.commit()
    except mysql.connector.OperationalError as err:
        print("Something went wrong: {}".format(err))
        
def db_AddRadioStationHasTracksRecord(id, timestamp, title, artist):
    
    # Prepare Query
    insert_stmt = ("INSERT INTO RadioStation_has_Tracks "
                        "(timestamp, RadioStation_id, Track_title, Track_artist) "
                        "VALUES (%s, %s, %s, %s)"
                        )
    # Bind Parameters to Query
    print(timestamp)
    data = (timestamp, id, title, artist)
    
    try:
        # Execute Query
        cursor.execute(insert_stmt, data)
        
        # Make sure diata is committed to the database
        cnx.commit()
    except mysql.connector.OperationalError as err:
        print("Something went wrong: {}".format(err))
    
    # add RadioStation_has_Tracks record
        
def db_AddRadioStation(name, url):
    
    # Prepare Query
    insert_stmt = ("INSERT INTO RadioStation "
                        "(name, url) "
                        "VALUES (%s, %s)"
                        )
    # Bind Parameters to Query
    data = (name, url)
    
    try:
        # Execute Query
        cursor.execute(insert_stmt, data)
        
        # Make sure diata is committed to the database
        cnx.commit()
        print(name + "Added to RatioStation Table")
    except mysql.connector.OperationalError as err:
        print("Something went wrong: {}".format(err))
    
    
def attrib_trackId(table):
    cur.execute("""SELECT max(id) FROM radiowcs""")
    returnID = 1
    maxID = cur.fetchone()
    if (maxID[0] != None):
        returnID = maxID[0]+1
    else:
        returnID = 1
    return returnID  # Returns the int from the tuple + 1 for the new entry

def main(URL):
    # Set to global for easier debugging in event of a crash
    global html 
    global z1
    global z2
    global z3

    url = URL
    while True:
        try:
            response = urllib2.urlopen(url)
            html = response.read()
        except (urllib2.URLError, httplib.BadStatusLine) as e: # { BadStatusLine(2 days)}
            if hasattr(e, 'reason'):
                print ('We failed to reach a server.')
                print ('Reason: ', e.reason)
                time.sleep(60)
                continue
            elif hasattr(e, 'code'):
                print ('The server couldn\'t fulfill the request.')
                print ('Error code: ', e.code)
                time.sleep(60)
                continue
            else:
                pass
                
        # Restructuring HTML read
        z=html.split(" = ") 
        
        try:
            z1=z[1]
            z2 = z1.split(";")
            z3 = newlineStrip(z2[0]) # Strip newline character, for some reason it was causing issues in rare circumstances, never figured out why
            exec "trackList ="+z3
            break
        except:
            print("exec trackList ='+z3'Failed", "...retrying")
            time.sleep(60)
            continue


    # parses each of the elements of a and writes it to a text file neatly
    #print(trackList)
    for i in trackList:
            
        #===========================================
        # Add to Tracks Table
        #===========================================
        try:
            #db_AddTrackRecord(attrib_DateTime(i["date"]), i["title"], i["artist"], i["genre"], i["bpm"], table)
            db_AddTrackRecord( i["title"], i["artist"], i["genre"], i["bpm"] )
            print("{-NEW TRACK DISCOVERED- `Tracks`} " + i['title'] + ' by: ' + i['artist'] )
        except mysql.connector.IntegrityError as err:
            print("DUPLICATE TRACK - Error: {}".format(err))
            

        #===========================================
        # Add to RadioStation_has_Tracks Table
        #===========================================
        try :
            db_AddRadioStationHasTracksRecord( RADIO_STATION_ID, attrib_DateTime(i["date"]), i["title"], i["artist"] )
            print("{-ADDED- `RadioStation_has_Tracks`} "+ i['title'] + ' by: ' + i['artist'], i["genre"], i["bpm"] ,"@ "+attrib_DateTime(i["date"]))
        except mysql.connector.IntegrityError as err:
            print("Error: {}".format(err))
                
            
    cnx.close()
            
        
if __name__ == "__main__":

    URL = "http://anchorstep.radiowcs.com/cast/"
    QUERYDELAY = float((random.random()*10+3)*60) # check every 1 to 10 minutes -> To avoid being blocked
    RADIO_STATION_ID = 2
    
    # Comment this out if recovering from a restart
    recentlyAdded=['']*10    # This ensures we don't added the same track multiple times when trying to discover new tracks at too quickly (9 = tracks/querry)
    
    # Get Database Credentials
    
    path = os.path.join(os.path.realpath(''),'config.txt')
    print(path)
    with open(path) as f:
        credentials = [x.strip().split(':') for x in f.readlines()]
    print(credentials)
    db_user = credentials[0][0]
    db_pwd = credentials[0][1]

        
    while True:
        try:
            # Connect to Database
            cnx = mysql.connector.connect(user=db_user, password=db_pwd,
                                        host='mysql.joeynelson.net',
                                        database='wcs_djbase')
            print("connected!")
            
            # Set Cursor
            cursor = cnx.cursor()
        except mysql.connector.Error as err:
            print("Something went wrong: {}".format(err))
            
        #db_AddRadioStation('RadioWCS', 'RadioWCS.com') # only run if Radio Statio doesn't exist
        
        
        #con.text_factory = str

        main(URL) # MAIN
        time.sleep(QUERYDELAY) # sleeps for sleepDuration which is Minutes*Tracks per Query