echo "Configuring and building opencv"
cd Prerequisites/opencv
mkdir build
cd build
cmake -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ../
make -j4
sudo make install

cd ../../eigen

echo "Configuring and building eigen"

mkdir build
cd build
cmake ../
make
sudo make install

cd ../../Pangolin

echo "Configuring and building pangolin"

git submodule update --init --recursive
./scripts/install_prerequisites.sh recommended
cmake -B build
cmake --build build
cmake --build build -t pypangolin_pip_install

cd ../..

echo "Configuring and building Thirdparty/DBoW2 ..."

cd Thirdparty/DBoW2
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j

cd ../../g2o

echo "Configuring and building Thirdparty/g2o ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j

cd ../../../

echo "Uncompress vocabulary ..."

cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "Configuring and building ORB_SLAM2 ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
cd ..

echo "Converting vocabulary to binary"
./tools/bin_vocabulary
