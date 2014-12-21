#!/bin/bash 
set -u 


NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function echo_red() {
    echo -e "$RED$*$NORMAL"
}

function echo_green() {
    echo -e "$GREEN$*$NORMAL"
}

function echo_yellow() {
    echo -e "$YELLOW$*$NORMAL"
}


#
# Some vars 
#
NXF_CMD=${NXF_CMD:-nextflow}
REPORT=$PWD/.report
WITH_DOCKER=${WITH_DOCKER:=''}

#
# Clean scratch dir 
#
export NXF_WORK=$PWD/scratch
rm -rf $NXF_WORK


function run() {
  NXF_SCRIPT="../../$1"
  NXF_RUN="$NXF_CMD -q run $NXF_SCRIPT"
  [[ $WITH_DOCKER ]] && NXF_RUN="$NXF_RUN -with-docker" 
  set +e             
  if [ -f .checks ]; then 
     export NXF_SCRIPT
     export NXF_CMD
     export NXF_RUN
     bash -ex .checks &> checks.out
  else 
     $NXF_CMD run $NXF_SCRIPT > checks.out
  fi
  ret=$?
  set -e
  if [[ $ret != 0 ]]; then 
    echo "~ Test '$1' run failed" >> $REPORT
    [[ -s checks.out ]] && cat checks.out | sed 's/^/   /'>> $REPORT  
    echo '' >> $REPORT   
    exit 1
  fi  
}


rm -rf $REPORT

list=${1:-'../*.nf'}

for x in $list; do
  basename=$(basename $x)
  if [ -d $basename ]; then
    echo "> Launching test: $basename"
    ( set -e; 
      cd $basename; 
      rm -rf *
      run $basename 
      )
  else 
    echo_yellow "WARN: No test for '$basename'"
  fi
  
done

if [[ -s $REPORT ]]; then
  echo -e "$RED"
  cat $REPORT
  echo -e "$NORMAL"
  exit 1
fi 
