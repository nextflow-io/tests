echo true 
items = [0,1,2,3,4]
decode = ['zero','one','two','three','fourth']

process foo {
    tag "${decode[x]}"
    
    input: 
    val x from items 
    
    when: 
    x >= 3

  	script: 
  	"""
  	echo Foo $x
  	"""
}


process bar {
    tag "${decode[x]}"
    
    input: 
    val x from items 
    
    when:
    x < 3

  	script: 
  	"""
  	echo Bar $x
  	"""
}
