/*
 * Copyright (c) 2013-2016, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2016, Paolo Di Tommaso and the respective authors.
 *
 *   This file is part of 'Nextflow'.
 *
 *   Nextflow is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Nextflow is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Nextflow.  If not, see <http://www.gnu.org/licenses/>.
 */
 
 
/*
 * Defines some parameters in order to specify the refence genomes
 * and read pairs by using the command line options
 */
params.pairs = "$baseDir/data/ggal/*_{1,2}.fq"
params.genome = "$baseDir/data/ggal/ggal_1_48850000_49020000.Ggal71.500bpflank.fa"
  
/*
 * the reference genome file
 */
genome_file = file(params.genome) 
 
/*
 * emits all reads ending with "_1" suffix and map them to pair containing the common
 * part of the name
 */
Channel
    .fromPath( params.pairs )
    .ifEmpty { error "Cannot find any reads matching: ${params.pairs}" }
    .map {  path -> tuple(path.baseName[0..-2], path) }
    .groupTuple(size: 2, sort: true)
    .map { id, files -> tuple(id, files[0], files[1])}
    .set { read_pairs } 

 
/*
 * Step 1. Builds the genome index required by the mapping process
 */
process buildIndex {
    input:
    file genome_file
     
    output:
    file 'genome.index*' into genome_index
       
    """
    bowtie2-build ${genome_file} genome.index
    """
 
}
 
/*
 * Step 2. Maps each read-pair by using Tophat2 mapper tool
 */
process mapping {
     
    input:
    file genome_file
    file genome_index from genome_index.first()
    set pair_id, file(read1), file(read2) from read_pairs
 
    output:
    set pair_id, "tophat_out/accepted_hits.bam" into bam
 
    """
    tophat2 genome.index ${read1} ${read2}
    """
}
 
/*
 * Step 3. Assemples the transcript by using the "cufflinks" 
 */
process makeTranscript {
    input:
    set pair_id, bam_file from bam
     
    output:
    set pair_id, 'transcripts.gtf' into transcripts
 
    """
    cufflinks ${bam_file}
    """
}
 
/*
 * Step 4. Collects the trabscripts files and print them
 */
transcripts
  .collectFile { tuple("${it[0]}transcript", it[1]) }
  .println { "Transcript model: $it" }
  