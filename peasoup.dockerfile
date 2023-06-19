FROM nvidia/cuda:10.2-devel-ubuntu18.04

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    git \
    make \
    gdb \
    build-essential 

WORKDIR /usr/local/software/

RUN git clone -b master https://github.com/ewanbarr/dedisp.git &&\
cd dedisp &&\
make -j 32 &&\
make install

RUN git clone -b accel_plan_fix https://github.com/ewanbarr/peasoup.git &&\
cd peasoup &&\
make -j 32 &&\
make install

RUN ldconfig /usr/local/lib

