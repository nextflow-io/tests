/*
 * Pipeline parameters that can be ovverride by the command line parameter
 */
params.db = "$baseDir/blast-db/tiny"
params.query = "$baseDir/data/sample.fa"
params.out = "./result.txt"
params.chunkSize = 1

 
db = file(params.db)
fasta = Channel
            .fromPath(params.query)
            .splitFasta(by: params.chunkSize)
 
 
process blast {
    input:
    file 'query.fa' from fasta
 
    output:
    file 'top_hits'
 
    """
    blastp -db ${db} -query query.fa -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}
 
 
process extract {
    input:
    file top_hits
 
    output:
    file 'sequences'
 
    "blastdbcmd -db ${db} -entry_batch top_hits | head -n 10 > sequences"
}
 
 
sequences
    .collectFile(name: params.out)
    .subscribe { println "Result saved at file: $it" }
    
    