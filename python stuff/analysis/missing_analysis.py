import csv

def imprimir(texto, arquivo):
	print(texto)
	arquivo.write(texto + "\n")

with open('aps_failure_training_set.csv', 'rb') as csvfile:
	numRows = 0
	numMissingValues = 0
	numRowsWithMissingValues = 0
	numColumns = len(csv.reader(csvfile).next())
	
	numMissingValuesPerColumn = [0 for i in range(numColumns)]
	
	csvfile.seek(0)
	for row in csv.reader(csvfile):
		numRows += 1
		hasMissingValues = False
		columnNumber = 0
		
		for column in row:	
			if column == "na":
				numMissingValuesPerColumn[columnNumber] += 1
					
				numMissingValues += 1
				
				if not hasMissingValues:
					numRowsWithMissingValues += 1
					hasMissingValues = True
				
			columnNumber += 1
				
	with open('missing.txt', 'w') as outputfile:
		imprimir("Number of rows: %d" % numRows, outputfile)
		imprimir("Number of columns: %d" % numColumns, outputfile)
		imprimir("Number of missing values: %d" % numMissingValues, outputfile)
		imprimir("Percentage of rows with missing values: %.4f%%" % (100.0 * numRowsWithMissingValues / numRows), outputfile)
		imprimir("Average percentage of missing values per row: %.4f%%" % (100.0 * numMissingValues / (numRows * numColumns)), outputfile)
		imprimir("Percentages of missing values per column: " + ", ".join(("%.2f%%" % (100.0 * x / numRows)) for x in numMissingValuesPerColumn), outputfile)