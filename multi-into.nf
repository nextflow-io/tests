process foo {
  output: 
  file 'x' into A,B,C
  val 2 into baz
  
  """
  echo Ciao > x
  """
}

baz.println { "Hello $it" }  

process bar1 {
  echo true
  input: 
  file x from A
  
  """
  printf "\$(cat $x) A"
  """
}

process bar2 {
  echo true
  input: 
  file x from B
  
  """
  printf "\$(cat $x) B"
  """
}

process bar3 {
  echo true
  input: 
  file x from C
  
  """
  printf "\$(cat $x) C"
  """
}