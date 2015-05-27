/*
 * Copyright (c) 2013-2015, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2015, Paolo Di Tommaso and the respective authors.
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
 * Verify that variable defined in the configuration file
 * context can be accessed in the process script
 *
 * author Emilio Palumbo
 */

echo true

process foo {
 
  echo true
 
  script:
  t = task.ext.out.join(',')
  """
  echo foo ${t}
  """
 
}

process bar {
 
  echo true
 
  shell:
  t = task.ext.out.join(',')
  
  '''
  echo bar !{t}
  '''
 
}