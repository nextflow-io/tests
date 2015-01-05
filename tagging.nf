process foo {
  echo true 
  tag { barcode }

  input: 
  each barcode from 'alpha', 'delta', 'gamma', 'omega'
  
  """
  echo $barcode
  """

}