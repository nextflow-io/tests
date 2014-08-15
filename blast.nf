#!/usr/bin/env nextflow
import nextflow.Channel

params.db = "$baseDir/blast-db/tiny"
params.query = "$baseDir/data/sample.fa"
params.chunkSize = 1

DB = file(params.db)

seq = Channel .fromPath(params.query) .splitFasta( by: params.chunkSize )

process blast {
    input:
    file 'seq.fa' from seq

    output:
    file 'out' into blast_result

    """
    blastp -db $DB -query seq.fa -outfmt 6 > out
    """
}

process sort {
    input:
    file 'hits_*' from blast_result.toSortedList()

    output:
    stdout result

    """
    sort hits_*
    """
}


result.subscribe { println it }
