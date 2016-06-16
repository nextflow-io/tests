process foo {
  errorStrategy { task.exitStatus==1 && task.attempt==1 ? 'retry' : 'ignore' }

  'exit 1'
}