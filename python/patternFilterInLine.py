#!/usr/bin/env python3
import re, sys, os

def usage():
	scriptName = os.path.basename(sys.argv[0])
	print(scriptName +' -p pattern [-d delimiter(|) -od outDelimiter(|) -u(uniq)] file')

def usageAndExit(num):
	usage()
	exit(num)

def getOpts(optList):
	# Some default options
	inputFile, pattern, isUniq, blockDelimiter, outDelimiter = '', '', False, '|', '|'

	longOption = ''
	for i in optList:
		# Converting short option into long option:
		if longOption != '':
			i = longOption + '=' + i
			longOption = ''

		# Short options
		if i == '-p': longOption = '--pattern'
		elif i == '-d': longOption = '--blockDelimiter'
		elif i == '-od': longOption = '--outDelimiter'
		elif i == '-u': isUniq = True
		elif re.fullmatch('-[^-]*', i): usageAndExit(0)

		# Long options
		elif re.fullmatch('--pattern=.*', i):
			pattern = re.fullmatch('--pattern=(.*)', i).group(1)
		elif re.fullmatch('--blockDelimiter=.*', i):
			blockDelimiter = re.fullmatch('--blockDelimiter=(.*)', i).group(1)
		elif re.fullmatch('--outDelimiter=.*', i):
			outDelimiter = re.fullmatch('--outDelimiter=(.*)', i).group(1)
		elif re.fullmatch('--.*', i): usageAndExit(0)
		else: inputFile = i

	if len(pattern) == 0:
		print('Pattern should not be empty.')
		exit(1)
	return(inputFile, pattern, isUniq, blockDelimiter, outDelimiter)


def patternFilterInline(inputFile, pattern, isUniq = False, blockDelimiter = '|', outDelimiter = '|'):
	patternReg = re.compile(pattern)

	try:
		with open(inputFile) as f:
			for line in f:
				columnsInLine = line.strip().split(blockDelimiter)
				outputLine = ''

				for column in columnsInLine:
					matchs = patternReg.fullmatch(column.strip())
					if matchs:
						if isUniq and len(outputLine) > 0: continue
						outputLine += matchs.group(0) + outDelimiter

				print(outputLine.rstrip(outDelimiter))
	except:
		print('File error: [' + inputFile + ']')
		exit(1)

			

if __name__ == '__main__':
	#patternFilterInline('patterInput', '^ab.*', True)
	inputFile, pattern, isUniq, blockDelimiter, outDelimiter = getOpts(sys.argv[1:])
	patternFilterInline(inputFile, pattern, isUniq, blockDelimiter, outDelimiter)
