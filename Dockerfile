FROM ubuntu

MAINTAINER Paolo Di Tommaso <paolo.ditommaso@gmail.com>

RUN mkdir -p /root
ENV HOME /root

#
# BLAST
#
RUN wget -q ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.2.29+-x64-linux.tar.gz; \
    tar xf ncbi-blast-2.2.29+-x64-linux.tar.gz; \
    mv ncbi-blast-2.2.29+ /opt/; \
    rm -rf ncbi-blast-2.2.29+-x64-linux.tar.gz; \
    ln -s /opt/ncbi-blast-2.2.29+/ /opt/blast;

#
# Update PERL modules
# 
RUN apt-get install -y cpanm; \
  cpanm Math::CDF Math::Round;

ADD bin/AMPA.pl /usr/local/bin/