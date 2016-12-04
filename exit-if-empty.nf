Channel
	.fromPath( 'missing/*' )
	.ifEmpty { error "Channel empty terminating" }
	.println { "Done" }