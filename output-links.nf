process foo {
  output: 
  file 'link.txt'
  
  '''
  echo Hello > file.txt
  ln -s file.txt link.txt
  '''	
}