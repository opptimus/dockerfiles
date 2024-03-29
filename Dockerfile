FROM ubuntu:18.04
MAINTAINER Victor Melo <victorhcmelo@gmail.com>

# Built using PyImageSearch guide: 
# http://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/

# Install dependencies
RUN \ 
    apt-get -qq update && apt-get -qq upgrade -y && \
    apt-get -qq install -y \
        wget \
        unzip \
        libtbb2 \
        software-properties-common \
        libtbb-dev && \
    add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt-get -qq update -y && \ 
    apt-get -qq install -y \
        libjasper1 libjasper-dev && \
    apt-get -qq install -y \
        build-essential \ 
        cmake \
        git \
        pkg-config \
        libjpeg8-dev \
        libtiff5-dev \
        libpng-dev \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libatlas-base-dev \
        gfortran \
        libhdf5-dev \
        python3-pip && \

    pip3 install --upgrade pip && \
    apt-get -qq install python3.7-dev -y && \
    pip3 install numpy && \

    apt-get autoclean && apt-get clean && \

    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Download OpenCV 3.4.8 and install
# step 10 
RUN \
    cd ~ && \
    wget https://github.com/opencv/opencv/archive/3.4.8.zip && \
    unzip 3.4.8.zip && \
    mv ~/opencv-3.4.8/ ~/opencv/ && \
    rm -rf ~/3.4.8.zip && \

    cd ~ && \
    wget https://github.com/opencv/opencv_contrib/archive/3.4.8.zip -O 3.4.8-contrib.zip && \
    unzip 3.4.8-contrib.zip && \
    mv opencv_contrib-3.4.8 opencv_contrib && \
    rm -rf ~/3.4.8-contrib.zip && \

    cd /root/opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON .. && \

    cd ~/opencv/build && \
    make -j $(nproc) && \
    make install && \
    ldconfig && \

    # clean opencv repos
    rm -rf ~/opencv/build && \
    rm -rf ~/opencv/3rdparty && \
    rm -rf ~/opencv/doc && \
    rm -rf ~/opencv/include && \
    rm -rf ~/opencv/platforms && \
    rm -rf ~/opencv/modules && \
    rm -rf ~/opencv_contrib/build && \
    rm -rf ~/opencv_contrib/doc