#!/usr/bin/python

import MySQLdb
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

def attrib_DateTime(timestamp): # import datetime
    d = datetime.datetime.fromtimestamp(int(timestamp)).strftime('%Y-%m-%d %H:%M:%S')
    # returns string of format: yyyy-mm-dd hh:mm:ss ; compatiable with sqlite3 DATETIME
    return d
    
# Database Functions

def db_AddRecordTo_RadioStation_has_Tracks(RS_id, datetime, title, artist):
    print 'db_AddRecordTo_RadioStation_has_Tracks()'
    try:
        cur.execute(''' INSERT INTO RadioStation_has_Tracks VALUES (%s, %s, %s, %s)''', (RS_id, datetime, title, artist) )

        con.commit()
        print '--ADDED to WCS.RadioStation_has_Tracks'
    except MySQLdb.Error, e:
        try:
            print "MySQL Error [%d]: %s" % (e.args[0], e.args[1])
        except IndexError:
            print "MySQL Error: %s" % str(e)
            
def db_AddRecordTo_Track(title, artist, genre, bpm):
    try:
        cur.execute(''' INSERT INTO Track VALUES (%s, %s, %s, %s, %s, %s)''', (title, artist, genre, '', bpm, '') )

        con.commit()
        print '--ADDED to WCS.Track'
    except MySQLdb.Error, e:
        try:
            print "MySQL Error [%d]: %s" % (e.args[0], e.args[1])
        except IndexError:
            print "MySQL Error: %s" % str(e)
            
    '''
    try:
        con.commit()
    except:
        # Rollback in case there is any error
        print('EXCEPTION')
        con.rollback()
    '''
    
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
                print 'We failed to reach a server.'
                print 'Reason: ', e.reason
                time.sleep(60)
                continue
            elif hasattr(e, 'code'):
                print 'The server couldn\'t fulfill the request.'
                print 'Error code: ', e.code
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
    for i in trackList:
        newTrackString = (i["artist"]+" - "+i["title"])
             
        # Ignore Tracks that were recently added (this should avoid seeing a duplicate error message)
        if newTrackString not in recentlyAdded:
            # Add track data to database
            print "Found: "+newTrackString, i["genre"], i["bpm"] ,"@ "+attrib_DateTime(i["date"])
            db_AddRecordTo_RadioStation_has_Tracks("1", attrib_DateTime(i["date"]), i["title"], i["artist"])
            db_AddRecordTo_Track( i["title"], i["artist"], i["genre"], i["bpm"] )
            
    con.close()
    print 'db connection closed.'
            
            
if __name__ == "__main__":
    #print(len(sys.argv))
    for i in sys.argv:
        print i
    if len(sys.argv) > 1:
        URL = str(sys.argv[1])
    else:
        URL = "http://anchorstep.radiowcs.com/cast/"
    if len(sys.argv) > 2:
        QUERYDELAY = float(sys.argv[2])
    else:
        #QUERYDELAY = float(9*60*2.5) # 10 tracks * 60 seconds * 3 minutes per track
        QUERYDELAY = float((random.random()*10+3)*60) # check every 1 to 10 minutes -> Just incase they might be tracking cyclic activity from 1 ip address
        
    #Define and Connect to Database
    table = 'RadioStation_has_Tracks'
    #table = sys.argv[???]
    db = 'WCS'
    
    # Comment this out if recovering from a restart
    recentlyAdded=['']*10    # This ensures we don't added the same track multiple times when trying to discover new tracks at too quickly (9 = tracks/querry)

    while True:

        # Open database connection
        con = MySQLdb.connect("ix.cs.uoregon.edu","guest","guest","WCS")
        con.text_factory = str
        
        # prepare a cur object using cur() method
        cur = con.cursor()
        
        # execute SQL query using execute() method.
        cur.execute("SELECT VERSION()")
        
        # Fetch a single row using fetchone() method.
        data = cur.fetchone()
        print "Database version : %s " % data
        
        #cur.execute('SELECT * FROM '+table)
        #print cur.fetchall()
        #db_AddRecordTo_RadioStation_has_Tracks("1", "2000-01-02 01:02:03", "title", "artist", "RadioStation_has_Tracks")

        main(URL) # MAIN
        print 'sleeping . . .'
        time.sleep(QUERYDELAY) # sleeps for sleepDuration which is Minutes*Tracks per Query
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        