process foo {
  output: 
  file x into foo_ch 
  
  '''
  echo -n Hello > x 
  '''
}

process bar {
  input: 
  file x from foo_ch 
  val y from (1,2,3)
  
  """
  cat $x
  echo $y 
  """ 

}