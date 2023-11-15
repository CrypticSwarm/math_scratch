FROM alpine:latest

RUN apk add --no-cache graphviz ttf-freefont font-noto \
    && addgroup -S workgroup \
    && adduser -S worker -G workgroup

WORKDIR /workspace
USER worker

ENTRYPOINT ["dot"]
