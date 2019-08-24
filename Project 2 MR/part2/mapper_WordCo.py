#!/usr/bin/env python3
import sys

def read_input(file):
	for line in file:
        # split the line into words
		return line.split()

def main(separator='\t'):
    # input comes from STDIN (standard input)
        #file = open(“/WCOP/outputWC.txt”, “r”) 
        #topWords  = file.readlines()
        #top10Words = []
        #for words in topWords
        #        top10Words.append(words.split('\t')[0])        
	data = read_input(sys.stdin)
	'''For NYT'''
	#top10Words = ['game','first','season','team','players','last','one','league','two','new'] #NY
	'''For Twitter'''
	#top10Words = ['mls','football','hockey','nba','mlb','game','team','de','like','la'] # twitter
	'''For CC'''
	top10Words = ['outlet','manual','jerseys','cheap','pandora','online','nike','shoes','nfl','ugg'] 
	
	for words in range(len(data)):
        # write the results to STDOUT (standard output);
        # what we output here will be the input for the
        # Reduce step, i.e. the input for reducer.py
        #
        # tab-delimited; the trivial word count is 1
                if data[words] in top10Words:
                        for nextWord in range(words,len(data)):
                                if data[words] != data[nextWord]: 
                                        print((data[words],data[nextWord]), separator, 1)

if __name__ == "__main__":
	main()

