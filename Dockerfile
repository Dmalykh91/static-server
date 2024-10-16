# Используем базовый образ Ubuntu 24.04
FROM ubuntu:24.04

# Устанавливаем необходимые пакеты
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean

# Создаем необходимые директории для SSH
RUN mkdir /var/run/sshd

# Создаем пользователя для тестирования
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser:testpassword" | chpasswd && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Разрешаем аутентификацию по паролю для SSH
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#     sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Открываем порт 22 для SSH
EXPOSE 22

# Запуск SSH-сервера
CMD ["/usr/sbin/sshd", "-D"]