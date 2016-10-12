process foo {
  output: file 'missing.txt' optional true into result
  
  '''
  echo miao 
  '''
}

process bar {
	input: file x from result 
	
	'''
	echo bau
	'''
}