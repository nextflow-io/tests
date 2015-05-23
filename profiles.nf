echo true 

process foo {

	"""
	echo cpus: ${task.cpus} memory: ${task.memory}
	"""
}