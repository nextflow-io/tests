Channel.fromPath("$baseDir/data/p{1,2,3}.fa").set { data_ch }


process foo {
  echo true
  
  tag "$x"
  
  input: 
  each file(x) from data_ch 
  
  """
  grep '>' $x
  """

}