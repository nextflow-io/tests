echo true

process foo {
  input: 
    each x from 'alpha','omega'

  shell: 
    '''
    echo Home: $HOME - Input: !{x}
    '''
}