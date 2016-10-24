FROM ubuntu:16.04

# Install.
RUN \
    apt-get update && \
    apt-get install sudo && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common && \
    apt-get install -y byobu curl git htop man unzip vim wget && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
    sudo apt-get install -y libnss3 && \
    sudo apt-get install -y libgtk2.0-0 libgdk-pixbuf2.0-0 libfontconfig1 libxrender1 libx11-6 libglib2.0-0 libxft2 libfreetype6 libc6 zlib1g libpng12-0 libstdc++6-4.8-dbg-arm64-cross libgcc1

COPY ./node_modules /root/export-app/node_modules
ADD ./app.js /root/export-app/app.js
ADD ./package.json /root/export-app/package.json
ADD ./08-05-2016_Chromium-Headless-5.tar.gz /root/export-app

WORKDIR /root/export-app

EXPOSE 8080 3000

CMD ["node", "app.js", "/root/export-app/chromium/src/out/Debug/headless_shell"]