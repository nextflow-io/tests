# Examples

This repository contains a collection a Nextflow scripts showing basic languages features. 


## Dependencies 

* POSIX compatible system (Linux, Solaris, OS X, etc)
* Java 7 or 8 
* Docker container (optionally)


## Get started

Install Nextflow by copying and pasting the following snippet in your shell terminal: 

    curl -fsSL get.nextflow.io | bash

It will download the in your working directory the `nextflow` launcher application. 

Then, you can run the scripts in this repository by entering the command: 

    nextflow run examples/<script name> 
    
Some of them depends on binary tools deployed with a Docker container available 
thought the Docker registry at this link: 

https://registry.hub.docker.com/u/nextflow/examples/

In order to use it add the option `-with-docker` to Nextflow run command line, for example:

    nextflow run examples/blast.nf -with-docker 
    
    
## Other examples 

More comprehensive examples are avaible in the following repositories: 

* [RNA-toy](https://github.com/nextflow-io/rnatoy) A basic RNA-Seq pipeline
* [Piper-nf](https://github.com/cbcrg/piper-nf) A RNA mapping pipeline 
* [MTA-nf](https://github.com/cbcrg/mta-nf) A method for best alignment of evaluation trees
* [Ampa-nf](https://github.com/cbcrg/ampa-nf) An automated prediction of protein antimicrobial regions
* [Grape-nf](https://github.com/cbcrg/grape-nf) Yet another RNA-Seq pipeline
    

