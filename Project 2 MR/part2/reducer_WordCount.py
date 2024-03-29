#!/usr/bin/env python3

from itertools import groupby
from operator import itemgetter
import collections

topNList = collections.Counter()
import sys

def read_mapper_output(file, separator='\t'):
	for line in file:
		yield line.rstrip().split(separator, 1)

def main(separator='\t'):
	# input comes from STDIN (standard input)
	data = read_mapper_output(sys.stdin, separator=separator)
	# groupby groups multiple word-count pairs by word,
	# and creates an iterator that returns consecutive keys and their group:
	#   current_word - string containing a word (the key)
	#   group - iterator yielding all ["&lt;current_word&gt;", "&lt;count&gt;"] items
	for current_word, group in groupby(data, itemgetter(0)):
		try:
			total_count = sum(int(count) for current_word, count in group)
			#print(current_word + separator + str(total_count))
			topNList[current_word] = total_count
		except ValueError:
		# count was not a number, so silently discard this item
			pass
		topNList[current_word] = total_count
	for val in topNList.most_common(10):
                print (val[0], "\t",val[1])


if __name__ == "__main__":
	main()

