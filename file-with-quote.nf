process foo {
  input: 
  file 'a b.txt' from file("$baseDir/data/data'3.txt") 
  output: 
  file 'x z.txt' into result
  '''
  cat 'a b.txt' > 'x z.txt'
  '''
}

result.println { it.text } 

