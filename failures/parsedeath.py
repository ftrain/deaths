#!/usr/bin/env python3.4
from fixedwidth import fixedwidth
import datetime
import sqlite3

fw_config = {
    'acd': {
        'type': 'string',
        'start_pos': 1,
        'length': 1,
        'required':False,
        'alignment':'left',
        'padding':' '
    },
    'ssn': {
        'type': 'string',
        'start_pos': 2,
        'length': 9,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'name_last': {
        'type': 'string',
        'start_pos': 11,
        'length': 20,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'name_suffix': {
        'type': 'string',
        'start_pos': 31,
        'length': 4,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'name_first': {
        'type': 'string',
        'start_pos': 35,
        'length': 15,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'name_middle': {
        'type': 'string',
        'start_pos': 50,
        'length': 15,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'vp': {
        'type': 'string',
        'start_pos': 65,
        'length': 1,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'date_death_month': {
        'type': 'integer',
        'start_pos': 66,
        'length': 2,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'date_death_day': {
        'type': 'integer',
        'start_pos': 68,
        'length': 2,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'date_death_year': {
        'type': 'integer',
        'start_pos': 70,
        'length': 4,
        'required':False,
        'alignment':'left',
        'padding':' '
    }, 
    'date_birth_month': {
        'type': 'integer',
        'start_pos': 74,
        'length': 2,
        'required':False,
        'alignment':'left',
        'padding':' '
    },
    'date_birth_day': {
        'type': 'integer',
        'start_pos': 76,
        'length': 2,
        'required':False,
        'alignment':'left',
        'padding':' '
    },
    'date_birth_year': {
        'type': 'integer',
        'start_pos': 78,
        'length': 4,
        'required':False,
        'alignment':'left',
        'padding':' '
    }
}

class DeadPerson(object):
    def __init__(self, data):
        # dob = data['date_birth_day']
        # if (dob == 0):
        #     dob = 1
        # dod = data['date_death_day']
        # if (dod == 0):
        #     dod = 1

        # try:
        #     self.date_death = datetime.datetime(data['date_death_year'],
        #                                         data['date_death_month'],
        #                                         dod)
        # except ValueError:
        #     self.date_death = None

        # try:
        #     self.date_birth = datetime.datetime(data['date_birth_year'],
        #                                         data['date_birth_month'],
        #                                         dob)
        # except ValueError:
        #   self.date_birth = None

        self.yob = data['date_birth_year']
        self.yod = data['date_death_year']        
        self.name = data['name_last'] + ", " + data['name_first']
        if data['name_middle'] is not "":
            self.name = self.name + " " + data['name_middle']
        self.ssn = data['ssn']

    def to_string(self):
        return "{0.yob}-{0.yod} {0.ssn} {0.name}".format(self)

    def to_sql(self):
        statement = "INSERT INTO ss (name, yob, yod) VALUES ('{0.name}', {0.yob}, {0.yod});".format(self)
        return statement

    def save(self, cursor):
        try:
            cursor.execute(self.to_sql())
        except sqlite3.OperationalError:
            print(self.to_sql())
        

if __name__ == '__main__':
    conn = sqlite3.connect('example.db')
    conn.text_factory = lambda x: unicode(x, 'utf-8', 'ignore')
    c = conn.cursor()

    
    c.execute('''DROP TABLE IF EXISTS ss''')
    c.execute('''CREATE TABLE IF NOT EXISTS ss (yob INT, yod INT, name TEXT)''')
    file_name = 'data/ssdm1'
    fw = fixedwidth.FixedWidth(fw_config)    
    f = open(file_name)
    i = 0
    for line in f:
        fw.line = line
        d = DeadPerson(fw.data)
        d.save(c)
        conn.commit()            
        if (0 == i % 1000):
            print(i) 
        i = i + 1

    

        
