docker build -t sing .

mkdir -p sing_deploy
rm -rf sing_deploy/* 
    
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

docker run --rm \
    -v $(pwd)/sing_deploy:/app sing \
    bash -c "git clone https://github.com/hpcng/singularity.git && \
    cd singularity && git checkout $sin_version && \
    export PATH=$PATH:/usr/local/go/bin && \
    ./mconfig --prefix=/app --without-suid && \
    cd ./builddir && \
    make && \
    make install && \
    chown -R $HOST_UID:$HOST_GID /app"

# Setup squashfs-tools
mkdir -p squashfs-tools
rm -rf squashfs-tools/*
wget -c http://launchpadlibrarian.net/439651704/squashfs-tools_4.4-1_amd64.deb
dpkg -x squashfs-tools_4.4-1_amd64.deb squashfs-tools
mv squashfs-tools/usr/bin/* sing_deploy/bin/

# package singularity
tar cvzf sing_deploy.tar.gz sing_deploy/
rm -rf sing_deploy
