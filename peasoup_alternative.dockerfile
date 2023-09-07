FROM nvidia/cuda:11.0.3-devel-ubuntu16.04

RUN apt-get update && \
    apt-get install -y software-properties-common
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    build-essential \
    git \
    gdb \
    make

WORKDIR /usr/local/software/

RUN git clone https://github.com/ewanbarr/dedisp.git && \
    cd dedisp &&\
    git checkout arch61 &&\
    make -j 32 && \
    make install

RUN ldconfig /usr/local/lib

RUN git clone https://github.com/ewanbarr/peasoup.git && \
    cd peasoup && \
    git checkout accel_plan_fix &&\
    make -j 32 && \
    make install

RUN ldconfig /usr/local/lib