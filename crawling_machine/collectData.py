import os

file = open("./candidate_data.csv","r")
file.readline()
for line in file:
    values = line.split(',')
    pageID = values[3]
    collected = values[9]
    if values[9]=='Yes' or pageID=='' or pageID=='n/a':
        continue
    command = "scrapy crawl fb -a email='lmgray16@earlham.edu' -a password='3@rLham2016' -a page={0} -a date='2019-01-01' -a lang='en' -o {0}.csv".format(pageID)
    os.system(command)
        
file.close()
