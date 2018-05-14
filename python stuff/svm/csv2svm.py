# Converte .csv para formato libsvm

import csv
import sys

outputfile = open(sys.argv[2], "w")

with open(sys.argv[1], "rb") as csvfile:
    for row in csv.reader(csvfile):
        # Write label
        outputfile.write(row[0])
        
        # Write features
        column_index = 1
        for column in row[1:]:
            if column != "0":
                outputfile.write(" %d:%s" % (column_index, column))
            column_index += 1
            
        outputfile.write("\n")
    
outputfile.close()