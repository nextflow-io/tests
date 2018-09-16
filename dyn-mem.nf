
process foo {
  memory { x.size() < 10  ? '100MB' : '200MB' }
  
  input: 
  file x from Channel.fromPath(['.small.txt','.big.txt'])
  
  script:
  """
  echo task=$x mem=$task.memory 
  """
}