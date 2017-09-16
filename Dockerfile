FROM node:0.10.38

RUN apt-get update
RUN apt-get install -y vim python3

RUN echo "deb http://ftp.us.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list \
         &&      apt-get update              \
         &&      apt-get install -y git

ADD . /app
WORKDIR /app
RUN npm install

RUN useradd -d /home/tcd -m -s /bin/bash tcd -u 2000
RUN echo 'tcd:tcd' | chpasswd

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000", "--autouser", "tcd"]
