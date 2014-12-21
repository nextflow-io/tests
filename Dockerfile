FROM debian:wheezy
MAINTAINER Paolo Di Tommaso <paolo.ditommaso@gmail.com>

RUN apt-get update --fix-missing && \
  apt-get install -q -y bc wget curl vim nano unzip make gcc g++ gfortran gnuplot python && \
  apt-get clean 

#
# Create the home folder 
#
RUN mkdir -p /root
ENV HOME /root

RUN wget -q cpanmin.us -O /usr/local/bin/cpanm && \
  chmod +x /usr/local/bin/cpanm 

RUN cpanm Math::CDF Math::Round;

#
# BLAST
#
RUN wget -q ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.29/ncbi-blast-2.2.29+-x64-linux.tar.gz && \
    tar xf ncbi-blast-2.2.29+-x64-linux.tar.gz && \
    mv ncbi-blast-2.2.29+ /opt/ && \
    rm -rf ncbi-blast-2.2.29+-x64-linux.tar.gz && \
    ln -s /opt/ncbi-blast-2.2.29+/ /opt/blast

# 
# install T-Coffee 
#
RUN wget -q http://tcoffee.org/Packages/Stable/Version_11.00.8cbe486/linux/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz && \
  tar xf T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz -C /opt && \
  mv /opt/T-COFFEE_installer_Version_11.00.8cbe486_linux_x64 /opt/tcoffee && \
  rm -rf /opt/tcoffee/plugins/linux/*  && \
  rm T-COFFEE_installer_Version_11.00.8cbe486_linux_x64.tar.gz 

#
# Add AMPA script to bin folder 
#
ADD bin/AMPA.pl /usr/local/bin/


#
# Configure the env
#
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/ncbi-blast-2.2.29+/bin:/opt/tcoffee/bin

