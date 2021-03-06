#!/bin/bash
set -e
echo "Installing OpenCV 4.5.5 on your Raspberry Pi 64-bit OS"
echo "It will take minimal 2.0 hour !"
cd ~
# install the dependencies
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y build-essential cmake git unzip pkg-config default-jdk cmake-curses-gui yasm meson git-all \
libjpeg-dev libtiff-dev libpng-dev \
libavcodec-dev libavformat-dev libswscale-dev \
libgtk2.0-dev libcanberra-gtk* libgtk-3-dev \
libgstreamer1.0-dev gstreamer1.0-gtk3 \
libgstreamer-plugins-base1.0-dev gstreamer1.0-gl libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
libxvidcore-dev libtbb2 libtbb-dev libdc1394-22-dev \
libv4l-dev v4l-utils libopenblas-dev libatlas-base-dev libblas-dev \
liblapack-dev gfortran libhdf5-dev libprotobuf-dev libgoogle-glog-dev libgflags-dev python3-dev \
protobuf-compiler libngraph0 libngraph0-dev ngraph-gtk ngraph-gtk-addins* \
qtcreator libqt5serialport5-dev qtmultimedia5-dev libeigen3-dev libvtkgdcm-dev \
libopenblas-dev libtbb-dev libxcb-xinerama0 libxkbcommon-dev \
libxkbcommon-x11-dev libxkbcommon-x11-0 libxkbcommon0 libxmp4 libgavl-dev libgmp-dev \
ladspa-sdk libaom-dev libaribb24-dev lv2-dev libsndfile-dev libiec61883-dev libavc1394-dev \
libass-dev libbluray-dev libbs2b-dev libcaca-dev libcodec2-dev dav1d libdrm-dev libfdk-aac-dev \
flite libgme-dev libjack-dev spirv-tools liblensfun-dev libmodplug-dev libmp3lame-dev \
libopencore-amrnb-dev libopencore-amrwb-dev libopenmpt-dev libpulse-dev \
libwebp-dev libzstd-dev librabbitmq-dev libmysofa-dev librist* librsvg* librubberband* \
librtmp-dev libshine-dev libsmbclient-dev libsnappy-dev libsoxr-dev libspeex-dev \
libsrt-openssl-dev libssh-dev libtheora-dev libtlsh-dev libtwolame-dev libvidstab-dev \
libvo-amrwbenc-dev libvpx-dev libxcb* libzimg* libzmq3-dev libzvbi-dev 

# download the latest version of opencv
cd ~ 
sudo rm -rf opencv*
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.5.zip 
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.5.zip 
#cp /mnt/share/opencv-4.5.5.zip .
#cp /mnt/share/opencv_contrib-4.5.5.zip .
mv opencv-4.5.5.zip opencv.zip
mv opencv_contrib-4.5.5.zip opencv_contrib.zip
# unpack
unzip opencv.zip 
unzip opencv_contrib.zip 
# some administration to make live easier later on
# clean up the zip files
rm opencv.zip
rm opencv_contrib.zip
mv opencv-4.5.5 opencv
mv opencv_contrib-4.5.5 opencv_contrib

pip install --upgrade pip
pip install cython numpy networkx defusedxml protobuf test-generator keras --upgrade

# set install dir
cd ~/opencv
mkdir build
cd build

# run cmake
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D ENABLE_NEON=ON \
-D WITH_OPENMP=ON \
-D WITH_OPENCL=OFF \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D WITH_GSTREAMER=ON \
-D BUILD_TESTS=ON \
-D WITH_EIGEN=ON \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D WITH_VTK=ON \
-D WITH_QT=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_ENABLE_PKG_CONFIG=ON \
-D PYTHON3_INCLUDE_PATH=/usr/include/python3.9 \
-D PKG_CONFIG_EXECUTABLE=/usr/bin/arm-linux-gnueabihf-pkg-config \
-D WITH_INF_ENGINE=ON \
-D INF_ENGINE_RELEASE=2022020000 \
-D WITH_NGRAPH=ON \
-D WITH_GPHOTO2=ON \
-D BUILD_EXAMPLES=ON ..

# run make
make --jobs=$(nproc --all)
sudo make install
sudo ldconfig

# cleaning (frees 300 MB)
#make clean
sudo apt-get update

python -c "import cv2"
if [ $? -ne 0 ];then
	echo "Failed to install OpenCV, aborting."
else
	echo "Congratulations!"
	echo "You've successfully installed OpenCV 4.5.5 on your Raspberry Pi 64-bit OS"
fi