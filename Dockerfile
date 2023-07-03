# Используем образ Ubuntu последней версии
FROM ubuntu:latest

# Обновляем индекс пакетов в системе и устанавливаем необходимые зависимости
RUN apt-get update && \
    apt-get install -y \
        git python3 build-essential libtool autotools-dev automake pkg-config \
        libssl-dev libevent-dev bsdmainutils libdb++-dev \
        libboost-system-dev libboost-filesystem-dev libboost-chrono-dev \
        libboost-program-options-dev libboost-test-dev libboost-thread-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Клонируем репозиторий Dogecoin
RUN git clone https://github.com/dogecoin/dogecoin.git

# Переходим в рабочую директорию проекта и выполним сборку проекта
WORKDIR /dogecoin
RUN ./autogen.sh && \
    ./configure && \
    make

# Открываем порт для сетевых соединений
EXPOSE 22556
EXPOSE 22555

# Запускаем dogecoind при старте контейнера
CMD ["./src/dogecoind"]
