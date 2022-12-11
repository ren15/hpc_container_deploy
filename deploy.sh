


singularity config global --set "mksquashfs path" /home/u85490/workspace/sing_deploy/bin/


singularity build --sandbox sin_root/ docker://rust:1.65.0

singularity shell --writable sin_root/
singularity run --writable sin_root/ cat /etc/os-release