FROM alpine:3.15

RUN apk update && apk upgrade
RUN addgroup appusr && adduser -D -G appusr appusr
RUN mkdir /app && chown appusr:appusr /app
RUN apk add --no-cache python3 py3-pip curl \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir awscli \
    && aws --version \
RUN cd /tmp && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \ 
    && kubectl version --client
WORKDIR /app
USER appusr
