FROM alpine:latest

RUN apk add --no-cache graphviz ttf-freefont font-noto \
    && addgroup -S graphvizgroup \
    && adduser -S graphvizuser -G graphvizgroup

WORKDIR /workspace
USER graphvizuser

ENTRYPOINT ["dot"]
