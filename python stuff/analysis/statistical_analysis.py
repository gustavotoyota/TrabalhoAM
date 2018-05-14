import csv
import numpy as np

def imprimir(texto, arquivo):
	print(texto)
	arquivo.write(texto + "\n")

with open('aps_failure_training_set.csv', 'rb') as csvfile:
	numRows = 0
	numColumns = len(csv.reader(csvfile).next())
	
	columnValues = [[] for i in range(numColumns)]
	numMissingValuesPerColumn = [0 for i in range(numColumns)]
	
	csvfile.seek(0)
	for row in csv.reader(csvfile):
		numRows += 1
		columnNumber = 0
		
		for column in row:
			if column == "na":
				numMissingValuesPerColumn[columnNumber] += 1
			elif column != "na" and column != "neg" and column != "pos":
				columnValues[columnNumber].append(float(column))
				
			columnNumber += 1
		
	columnValues = [np.array(i) for i in columnValues]
			
	columnMins = [(np.amin(i) if len(i) > 0 else float('nan')) for i in columnValues]
	columnMeans = [np.mean(i) for i in columnValues]
	columnMedian = [np.median(i) for i in columnValues]
	columnStds = [np.std(i) for i in columnValues]
	columnMaxs = [(np.amax(i) if len(i) > 0 else float('nan')) for i in columnValues]
			
	with open('statistics.txt', 'w') as outputfile:
		imprimir("% Missing values / Min / Mean / Median / Std / Max per column:\n", outputfile)
		imprimir("\n".join("%d: %.2f%% / %.2f / %.2f / %.2f / %.2f / %.2f" % (i + 1, 100.0 * numMissingValuesPerColumn[i] / numRows, columnMins[i], columnMeans[i], columnMedian[i], columnStds[i], columnMaxs[i]) for i in range(numColumns)), outputfile)