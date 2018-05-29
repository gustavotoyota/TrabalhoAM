# Converte .csv para formato libsvm

import csv
import sys

outputfile = open(sys.argv[2], "w")

with open(sys.argv[1], "rb") as csvfile:
    i = 0
    
    for row in csv.reader(csvfile):
        if i > 20:
            # Write label
            if row[0] == "neg":
                outputfile.write("0")
            else:
                outputfile.write("1")
		    
            # Write features
            column_index = 1
            for column in row[1:]:
                if column != "na":
                    outputfile.write(" %d:%s" % (column_index, column))
                else:
                    outputfile.write(" %d:0" % (column_index))
                column_index += 1

            outputfile.write("\n")
            
        i = i+1

outputfile.close()
