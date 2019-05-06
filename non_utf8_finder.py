# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import logging, os


def setLogger():
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    # create a file handler
    handler = logging.FileHandler('utf8.log')
    handler.setLevel(logging.INFO)
    # create a logging format
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    # add the handlers to the logger
    logger.addHandler(handler)
    return logger

def search_import_file(b):
    liste,liste2 = [], []
    for i in os.listdir(os.path.curdir):
        liste.append(i)
    for file in liste:
        if file.endswith(b):
            curdir = os.path.abspath(os.path.curdir)
            path_to_file = os.path.join(curdir, file)
            liste2.append(path_to_file)
    return liste2


for item in search_import_file(".py"):
    with open(item,'r') as file:
        logger = setLogger()
        logger.info("Timer started")
        for line in file:
            # find non-utf8 characters 
            ''.join([x for x in line if ord(x) < 128])
            l = [(f"Found a non utf8 char {x} in file {file.name}") for x in line if (ord(x) > 128)]
            if len(l)>0:
                print(l)
            [logger.info(f"Found a non utf8 char {x}") for x in line if ord(x) > 128]
