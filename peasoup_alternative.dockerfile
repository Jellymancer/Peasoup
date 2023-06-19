FROM nvidia/cuda:10.2-devel-ubuntu16.04

# Python3.6 stuff
RUN apt-get update && \
  apt-get install -y software-properties-common
RUN apt-get update

RUN apt-get install -y build-essential git gdb

WORKDIR /usr/local/software/

RUN git clone https://github.com/ewanbarr/dedisp.git && \
    cd dedisp &&\
    git checkout arch61 &&\
    make -j 32 && \
    make install

RUN ldconfig /usr/local/lib

RUN git clone https://github.com/ewanbarr/peasoup.git && \
    cd peasoup && \
    git checkout dedisp_gulping &&\
    make -j 32 && \
    make install

RUN ldconfig /usr/local/lib