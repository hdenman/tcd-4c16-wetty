FROM node:0.10.38

RUN echo "deb http://ftp.us.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
RUN apt-get update && \
    apt-get remove -y binutils && \
    apt-get install -y vim python3 python3-pip git

RUN pip3 install numpy

ADD . /app
WORKDIR /app
RUN npm install

RUN useradd -d /home/tcd -m -s /bin/bash tcd -u 2000
RUN echo 'tcd:tcd' | chpasswd

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["app.js", "-p", "3000", "--autouser", "tcd"]
