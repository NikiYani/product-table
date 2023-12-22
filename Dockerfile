# syntax=docker/dockerfile:1

FROM golang:1.21

# Установить место назначения для копирования
WORKDIR /app

# Скачать модули Go
COPY go.mod go.sum ./
RUN go mod download

# Скопируйте исходный код. Обратите внимание на косую черту в конце, как описано в
# https://docs.docker.com/engine/reference/builder/#copy
COPY *.go ./

# Сборка
RUN CGO_ENABLED=0 GOOS=linux go build -o /product_server

# Опционально:
# Для привязки к TCP-порту в команду docker необходимо указать параметры времени выполнения.
# Но мы можем задокументировать в Dockerfile, какие порты
# Приложение будет прослушивать по умолчанию.
# https://docs.docker.com/engine/reference/builder/#expose
EXPOSE 8080

# Запуск нашего ПО
CMD ["/product_server"]
