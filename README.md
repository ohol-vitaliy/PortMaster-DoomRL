![DoomRL Logo](logo.png)

Dockerfile to easily build [DoomRL](https://github.com/ohol-vitaliy/doomrl) game files
for the [PortMaster](https://github.com/PortsMaster/PortMaster-New/tree/main/ports/littlegptracker)

### Steps
```bash
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker build . --platform linux/arm64 --rm -t drl_build
docker run --rm drl_build cat /root/drl.zip > drl.zip
```

Put the contents from the resulting `drl.zip` archive in the port directory
