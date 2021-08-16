# syntax=docker/dockerfile:1.3-labs
FROM nyamisty/docker-wine-dotnet
MAINTAINER NyaMisty

ARG PYTHON_VER=3.9.6
ARG USE_IDAPYSWITCH=1

ADD . /root/.wine64/drive_c/IDA

SHELL ["/bin/bash", "-c"]

WORKDIR /root
ENV WINEARCH win64
ENV WINEPREFIX /root/.wine64

RUN --security=insecure true \
    && (entrypoint true; sleep 0.5; wineboot --init) \
    && (entrypoint true; sleep 0.5; winetricks -q win10) \
    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
    && if [[ $PYTHON_VER == 2* ]]; then \
           wget "https://www.python.org/ftp/python/${PYTHON_VER}/python-${PYTHON_VER}.amd64.msi" \
           && (wine cmd /c msiexec /i python-2.7.18.amd64.msi /qn /L*V! python_inst.log; ret=$?; cat python_inst.log; rm python_inst.log; exit $ret); \
       else \
           wget "https://www.python.org/ftp/python/${PYTHON_VER}/python-${PYTHON_VER}-amd64.exe" \
           && (wine cmd /c python*.* /quiet /log python_inst.log InstallAllUsers=1 PrependPath=1; ret=$?; cat python_inst.log; rm python_inst.log; exit $ret); \
       fi \
    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
    && if [ "$USE_IDAPYSWITCH" = "1" ]; then (echo 0 | wine 'C:\IDA\idapyswitch.exe'); fi \
    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
    && winetricks -q win7 \
    && while pgrep wineserver >/dev/null; do echo "Waiting for wineserver"; sleep 1; done \
    && rm -rf $HOME/.cache/winetricks && rm python*