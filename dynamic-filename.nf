params.prefix = 'my' 

data = 'Hello\n'

process foo {

  input: 
  each x from 'alpha', 'delta', 'gamma', 'omega'
  file { "${params.prefix}_${x}.txt" } from data
  
  output: 
  file { "${params.prefix}_${x}.txt" } into result
  
  """
  echo World >>  ${params.prefix}_${x}.txt
  """

}

result.subscribe {
  println "~ Saving ${it.name}"
  it.copyTo('.')
}