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
 
params.in = "$baseDir/data/sample.fa"
fasta = file(params.in)

process tcoffee {
  container true 
  
  input:
  file fasta 
  
  output: 
  file 'result.fa' into result
  
  """
  # define box inputs
  CONT_INPUT_FASTA=$fasta
  CONT_OUTPUT_FILE=result.fa
  # launch box run
  nextflow/tcoffee
  """

}

result.println { it.text } 