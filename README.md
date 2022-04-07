# install_opencv
Inspired by https://github.com/Qengineering/Install-OpenCV-Raspberry-Pi-64-bits/

Usage:

```shell
sudo chmod 755 install_opencv.sh
bash install_opencv.sh
```
opencv==4.5.5

Change line [75-76](https://github.com/zhangwangwz/install_opencv/blob/3989276448ad505f299118dfc02b5cc06c77be1d/install_opencv.sh#L75) to disable Inference Engine (openvino)

If you want to add Inference Engine, please make sure that you have run setupvars.sh provided by openvino to initialize openvino environment
```shell
source /path/to/openvino/setupvars.sh
```
