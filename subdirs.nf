seqs = Channel.fromPath("$baseDir/data/p{1,2,3}.fa")

process foo {
    echo true
    
    input:
    file '/dir1/link_*.fasta' from seqs.toList() 
    
    output: 
    file '/dir2/*' into result mode flatten
    
    '''
    ls dir1 | sort
    mkdir dir2
    echo hello > dir2/alpha.txt
    echo world > dir2/beta.txt
    '''
}

result.println { it.name }