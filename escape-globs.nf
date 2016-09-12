_in1 = Channel.fromPath("$baseDir/data/file\\[a-b\\].txt")

process foo {

  input: 
  file x from _in1
  
  output: 
  file x into _out1
  file 'file-\\*.txt' into _out2
  file 'file-?.txt' glob false into _out3
  
  '''
  touch file-\\*.txt
  touch file-\\?.txt
  '''
  
}

_out1.println { "match: ${it.name}" }
_out2.println { "match: ${it.name}" }
_out3.println { "match: ${it.name}" }