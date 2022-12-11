FROM ubuntu:18.04

# https://github.com/apptainer/singularity/blob/master/INSTALL.md

COPY 0_setup.sh /build/0_setup.sh

RUN bash /build/0_setup.sh

