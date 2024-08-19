FROM nvidia/cuda:12.5.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive LANG=C TZ=UTC

# Установка необходимых пакетов
RUN apt-get update && apt upgrade -y && apt-get install -y \
    nginx \
    curl \
    wget \
    bzip2 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3 \
    python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Установка pip и обновление
RUN pip3 install --upgrade pip

# Загрузка и установка micromamba
RUN curl -L https://micro.mamba.pm/api/micromamba/linux-64/latest -o micromamba.tar.bz2 && \
    tar -xvjf micromamba.tar.bz2 -C /usr/local/bin/ && \
    rm micromamba.tar.bz2

WORKDIR /stablediff

# Копирование приложения
COPY ./app/ /stablediff/

# Настройка прав
RUN chmod +x start.sh
RUN chmod +x scripts/bootstrap.sh

# Копирование настроек Nginx
COPY nginx.conf /etc/nginx/sites-available/my_app

# Создание символической ссылки для настроек Nginx
RUN ln -s /etc/nginx/sites-available/my_app /etc/nginx/sites-enabled/

EXPOSE 8080

# Команда по умолчанию
CMD ["bash"]
