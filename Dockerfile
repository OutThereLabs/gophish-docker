FROM debian:jessie

RUN apt-get update && \
apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/gophish-v0.6.0-linux-64bit

RUN chown -R 1001:0 /opt/gophish-v0.6.0-linux-64bit && \
    chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME
    
USER 1001

RUN wget -nv https://github.com/gophish/gophish/releases/download/v0.6.0/gophish-v0.6.0-linux-64bit.zip && \
unzip gophish-v0.6.0-linux-64bit.zip && \
rm -f gophish-v0.6.0-linux-64bit.zip

RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json && \
sed -i "s|0.0.0.0:80|0.0.0.0:8080|g" config.json && \
chmod +x gophish

EXPOSE 3333 8080
ENTRYPOINT ["./gophish"]