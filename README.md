# docker-wine-ida

![Docker IDA](docker-ida-logo.png)
---

Dockerized Windows IDA running on Wine, with Xvfb/X11/Xrdp support builtin!

with prebuilt leaked IDA version available at [nyamisty/docker-wine-ida](https://hub.docker.com/r/nyamisty/docker-wine-ida)

## Installation

```
docker pull nyamisty/docker-wine-ida:7.6sp1

docker pull nyamisty/docker-wine-ida:7.5sp3

docker pull nyamisty/docker-wine-ida:7.0
```


## Usage

docker-wine-ida is based on scottyhardy/docker-wine, but without its `./docker-wine` wrapper script, so the usage is in [the manual-running part](https://github.com/scottyhardy/docker-wine#manually-running-with-docker-run-commands)

- Run with Xvfb:
    ```
    docker run --name docker-ida -it nyamisty/docker-wine-ida:7.6sp1 wine C:\\IDA\\ida.exe
    ```

- Run with X11 forward:
    ```
    docker run --name docker-ida --hostname="$(hostname)" --env="USE_XVFB=no" --env="DISPLAY" --volume="${XAUTHORITY:-${HOME}/.Xauthority}:/root/.Xauthority:ro" --volume="/tmp/.X11-unix:/tmp/.X11-unix:ro" -it nyamisty/docker-wine-ida:7.6sp1 wine C:\\IDA\\ida.exe
    ```

- Run with Xrdp:
    ```
    docker run --name docker-ida --hostname="$(hostname)" --env="RDP_SERVER=yes" --publish="3389:3389/tcp" -it nyamisty/docker-wine-ida:7.6sp1 wine C:\\IDA\\ida.exe
    ```

## Credits
- Prebuilted versions are leaked IDA Pro 7.0/7.5sp3/7.6sp1
    - IDA 7.0: https://down.52pojie.cn/Tools/Disassemblers/IDA.txt
    - IDA 7.5 & 7.6: https://fuckilfakp5d6a5t.onion (now migrated to https://fckilfkscwusoopguhi7i6yg3l6tknaz7lrumvlhg5mvtxzxbbxlimid.onion)
- Thanks scottyhardy/docker-wine for Wine's docker image
- Thanks other projects for referencing:
    - https://github.com/intezer/docker-ida
    - https://github.com/thawsystems/docker-ida
    - https://gist.github.com/williballenthin/1c6ae0fbeabae075f1a4
    - https://github.com/nicolaipre/idapro-docker

