FROM node:0.10.38

RUN apt-get update
RUN apt-get install -y vim python3

ADD . /app
WORKDIR /app
RUN npm install

RUN useradd -d /home/tcd -m -s /bin/bash tcd
RUN echo 'tcd:tcd' | chpasswd

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000", "--autouser", "tcd"]
