FROM ubuntu

MAINTAINER Paolo Di Tommaso <paolo.ditommaso@gmail.com>

RUN mkdir -p /root
ENV HOME /root

#
# Update minimal stuff 
#
RUN apt-get update -qq --fix-missing; \
  apt-get install -qq -y wget nano curl unzip make gcc gnuplot python;

RUN wget -q cpanmin.us -O /usr/local/bin/cpanm; \
  chmod +x /usr/local/bin/cpanm 

RUN cpanm Math::CDF Math::Round;

#
# BLAST
#
RUN wget -q ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.2.29+-x64-linux.tar.gz; \
    tar xf ncbi-blast-2.2.29+-x64-linux.tar.gz; \
    mv ncbi-blast-2.2.29+ /opt/; \
    rm -rf ncbi-blast-2.2.29+-x64-linux.tar.gz; \
    ln -s /opt/ncbi-blast-2.2.29+/ /opt/blast;

# 
# install T-Coffee 
#
RUN wget -q http://tcoffee.org/Packages/Stable/Version_11.00.8cbe486/linux/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz; \
  tar xf T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz -C /opt; \
  mv /opt/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64 /opt/tcoffee; \
  rm -rf /opt/tcoffee/plugins/linux/*  \
  rm T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz; 

#
# Add AMPA script to bin folder 
#
ADD bin/AMPA.pl /usr/local/bin/

#
# RNA-Seq stuff 
# 
RUN apt-get install -qq -y samtools

RUN wget -q -O bowtie.zip http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.3/bowtie2-2.2.3-linux-x86_64.zip/download; \
  unzip bowtie.zip -d /opt/; \
  ln -s /opt/bowtie2-2.2.3/ /opt/bowtie; \
  rm bowtie.zip 
  
RUN wget -q http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.12.Linux_x86_64.tar.gz; \
  tar xf tophat-2.0.12.Linux_x86_64.tar.gz -C /opt/; \
  ln -s /opt/tophat-2.0.12.Linux_x86_64/ /opt/tophat; \
  rm tophat-2.0.12.Linux_x86_64.tar.gz
  
RUN wget -q http://cufflinks.cbcb.umd.edu/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz; \
  tar xf cufflinks-2.2.1.Linux_x86_64.tar.gz -C /opt/; \
  ln -s /opt/cufflinks-2.2.1.Linux_x86_64/ /opt/cufflinks; \
  rm cufflinks-2.2.1.Linux_x86_64.tar.gz 
  

#
# Configure the env
#
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/ncbi-blast-2.2.29+/bin:/opt/tcoffee/bin:/opt/bowtie:/opt/tophat:/opt/cufflinks

