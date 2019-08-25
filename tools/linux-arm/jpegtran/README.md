Followed https://github.com/libjpeg-turbo/libjpeg-turbo/blob/master/BUILDING.md

```sh
sudo apt install yasm cmake build-essential
cd ~/src/libjepg-turbo
cmake -G"Unix Makefiles"
make
cp jpegtran-static ~/src/photostructure/tools/linux-arm/jpegtran/jpegtran
cd ~/src/photostructure/tools/linux-arm/jpegtran/
strip jpegtran
```