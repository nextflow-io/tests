/* 
 * Command line input parameter 
 */
params.in = "$baseDir/data/sample.fa"

/* 
 * Define the input file 
 */
sequences = file(params.in)


/* 
 * split a fasta file in multiple files 
 */
process splitSequences {

    input:
    file 'input.fa' from sequences

    output:
    file 'seq_*' into records

    """
    awk '/^>/{f="seq_"++d} {print > f}' < input.fa
    """

}

/* 
 * Simple reverse the sequences 
 */
process reverse {

    input:
    file x from records
    
    output:
    stdout result

    """
    cat $x | rev
    """
}

/* 
 * print the channel content 
 */
result.subscribe { println it }
