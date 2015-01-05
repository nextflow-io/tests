params.prefix = 'my' 

data = 'Hello\n'

process foo {

  storeDir { "cache/$x" }

  input: 
  each x from 'alpha', 'delta', 'gamma', 'omega'
  file 'result.txt' from data
  
  output: 
  set x, file('result.txt') into result
  
  """
  echo World >> result.txt
  """

}

result.subscribe { code, file -> 
  println "~ Result ${file}"
  file.copyTo("my_${code}.txt")
}