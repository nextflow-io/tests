process foo {
  errorStrategy { task.attempt==1 ? 'retry' : 'ignore' }

  'exit 1'
}