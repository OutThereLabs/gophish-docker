FROM debian:jessie



RUN apt-get update && \
apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/gophish-v0.6.0-linux-64bit

RUN groupadd -g 1001 usergp && \
    useradd -r -u 1001 -g usergp user

RUN chown -R user:usergp /opt/gophish-v0.6.0-linux-64bit
USER 1001


RUN wget -nv https://github.com/gophish/gophish/releases/download/v0.6.0/gophish-v0.6.0-linux-64bit.zip && \
unzip gophish-v0.6.0-linux-64bit.zip && \
rm -f gophish-v0.6.0-linux-64bit.zip

RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json && \
sed -i "s|0.0.0.0:80|0.0.0.0:8080|g" config.json && \
chmod +x gophish

EXPOSE 3333 8080
ENTRYPOINT ["./gophish"]
