git clone https://github.com/hpcng/singularity.git
cd singularity
git checkout v3.8.4

export PATH=$PATH:/usr/local/go/bin

./mconfig
cd ./builddir
make
make install

singularity --version