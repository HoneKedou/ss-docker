FROM daocloud.io/library/debian:jessie
LABEL maintainer="beilunyang <786220806@qq.com>"

ADD ./run.sh /
ADD ./install.sh /
ADD ./ss-config.json /
ADD ./kt-config.json / 
WORKDIR /
RUN ["./install.sh"]  
ENTRYPOINT [ "./run.sh"]
EXPOSE 23333:8388






