#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2014, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2014, Paolo Di Tommaso and the respective authors.
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

params.db = "$baseDir/blast-db/tiny"

params.query = "$baseDir/data/sample.fa"

db = file(params.db)
query = file(params.query)

process blast {
    input:
    file query
    
    output:
    file 'top_hits'

    """
    blastp -db $db -query $query -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}


process extractTopHits {
    input:
    file top_hits

    output:
    file 'sequences'

    "blastdbcmd -db ${db} -entry_batch $top_hits > sequences"
}

process align {
    echo true

    input:
    file sequences

    "t_coffee $sequences 2>/dev/null | tee align_result"
}
