process foo {
  validExitStatus 100
  output:
  val( task.exitStatus ) into ch1
  set val( record.foo ), val( record.bar ) into ch2

  script:
  record = [foo:'aaa', bar: 'bbb'] 
  """
  exit 100
  """ 
} 

ch1.println { "exit_status=$it" }
ch2.println { "record=${it[0]}_${it[1]}" }
