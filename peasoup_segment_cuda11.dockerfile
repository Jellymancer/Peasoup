FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

LABEL Author="Jedrzej Jawor" \
      Email="jjawor@mpifr-bonn.mpg.de"

      
      # Install dependencies
      RUN apt-get update -y && \
      apt-get --no-install-recommends -y install \
      build-essential \
      git \
      gdb \
      make \
      ca-certificates
      
      # Define software directory
# ENV PATH="/usr/local/cuda-11.2.2/bin:$PATH"
# ENV LD_LIBRARY_PATH="/usr/local/cuda-11.2.2/lib64:$LD_LIBRARY_PATH"
# ENV CUDA_PATH="/usr/local/cuda-11.2.2"
WORKDIR /usr/local/software/
ENV SOFTWARE=/usr/local/software/
RUN ldconfig /usr/local/lib

RUN git clone -b master https://github.com/ewanbarr/dedisp.git && \
    cd $SOFTWARE/dedisp && \
    git checkout 3aaa448 && \
    make -j 32 && \
    make install

    # Clone and build peasoup
RUN git clone -b master https://github.com/vishnubk/peasoup.git && \
    cd $SOFTWARE/peasoup && \
    git checkout 1fa2a86 && \
    make -j 32 && \
    make install --

RUN ldconfig /usr/local/lib