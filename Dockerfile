FROM nvidia/cuda:12.5.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive LANG=C TZ=UTC
ENV TERM linux

# Установка необходимых пакетов
RUN apt-get update && apt upgrade -y && apt-get install -y \
    curl \
    wget \
    bzip2 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    nano \
    htop \
    python3 \
    python3-pip && \
    apt install nvidia-driver-470 -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

WORKDIR /stablediff

COPY ./app/ /stablediff/
RUN chmod +x start.sh


EXPOSE 9000

CMD [ "bash", "./start.sh" ]