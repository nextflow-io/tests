FROM ubuntu

MAINTAINER Paolo Di Tommaso <paolo.ditommaso@gmail.com>

RUN mkdir -p /root
ENV HOME /root

#
# Update minimal stuff 
#
RUN apt-get update -qq --fix-missing; \
  apt-get install -qq -y wget nano curl unzip make gcc gnuplot;

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

ADD bin/AMPA.pl /usr/local/bin/

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/ncbi-blast-2.2.29+/bin
