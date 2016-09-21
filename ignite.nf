#!/usr/bin/env nextflow

cheers = Channel.from 'Bonjour', 'Ciao', 'Hello', 'Hola', 'Γεια σου'

process sayHello {
  echo true

  input: 
  val x from cheers
  
  """
  echo '$x world!'
  """
}

process printHello {
  input: 
  val x from 1,2,3
  
  output: 
  val z into results
  
  exec:
  println "Native: $x"
  z = x*x
   
}

results.println { "Square: $it" }