find . -name stdout | xrgs rm
find . -name .stdout | xrgs rm
find . -name checks.out | xargs rm
find . -name .cache | xargs rm -rf
find . -name .nextflow* | xargs rm 
