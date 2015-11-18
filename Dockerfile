############################################################
# Dockerfile to build DiscoSNP++ tool container image
# Based on debian wheezy
############################################################

# Set the base image to debian wheezy
FROM debian:wheezy

# Set noninterative mode
ENV DEBIAN_FRONTEND noninteractive
ENV PACKAGES wget make cmake gcc g++ zlib1g-dev bwa python

ENV TAR http://gatb-tools.gforge.inria.fr/versions/src/DiscoSNP++-2.1.7-Source.tar.gz
ENV SOURCE DiscoSNP++-2.1.7-Source
ENV DIR /opt

################## DEPENDENCIES INSTALLATION ######################

RUN apt-get update -y
RUN apt-get install -y ${PACKAGES}

################## DISCOSNP INSTALLATION ######################

WORKDIR ${DIR}
RUN wget ${TAR} -O - | tar xvzf -
WORKDIR ${DIR}/${SOURCE}
RUN /bin/bash compile_discoSnp++.sh

ADD bbric_disco.py /usr/local/bin/bbric_disco.py
RUN chmod 755 /usr/local/bin/bbric_disco.py

#ENTRYPOINT ["./run_discoSnp++.sh"]
#CMD ["-help"]

##################### Maintainer #####################

MAINTAINER Monjeaud Cyril <Cyril.Monjeaud@irisa.fr>

#################### Example ########################
# docker run -it --rm cmonjeau/discosnppp
# docker run -it --rm -v /home/user/discoSNP_data:/data cmonjeau/discosnppp -r "/data/reads_sequence1.fasta.gz /data/reads_sequence2.fasta.gz" -G /data/reference_genome.fa -p /data/results/discoRes

