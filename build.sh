docker build -t sing .

mkdir -p sing_deploy
rm -rf sing_deploy/* 

docker run --rm -v $(pwd)/sing_deploy:/home/u85490/workspace/sing_deploy sing \
    bash -c "git clone https://github.com/hpcng/singularity.git && \
    cd singularity && \
    git checkout v3.8.4 && \
    export PATH=$PATH:/usr/local/go/bin && \
    ./mconfig --prefix=/home/u85490/workspace/sing_deploy --without-suid && \
    cd ./builddir && \
    make && \
    make install && \
    chown -R 1000:1000 /home/u85490/workspace/sing_deploy
    "

wget -c http://launchpadlibrarian.net/439651704/squashfs-tools_4.4-1_amd64.deb

mkdir -p squashfs-tools
rm -rf squashfs-tools/*

dpkg -x squashfs-tools_4.4-1_amd64.deb squashfs-tools
mv squashfs-tools/usr/bin/* sing_deploy/bin/

tar cvzf sing_deploy.tar.gz sing_deploy/
