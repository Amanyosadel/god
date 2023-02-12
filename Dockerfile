FROM anasty17/mltb:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
    python3 python3-dev python3-pip python3-venv 

RUN apt-get install wget ffmpeg unzip p7zip-full curl busybox -y
ARG USER=root
USER $USER
RUN python3 -m venv venv
COPY . /app
WORKDIR /app
RUN chmod 777 /app
RUN pip3 install -r requirements.txt
RUN set -uex; \
    echo "nameserver 8.8.8.8" > /etc/resolv.conf; \
    cat /etc/resolv.conf
RUN apt -qq install -y mediainfo
EXPOSE 5000
RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
