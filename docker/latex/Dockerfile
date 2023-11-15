FROM alpine:latest

RUN apk add --no-cache texlive biber \
    && addgroup -S workgroup \
    && adduser -S worker -G workgroup

WORKDIR /workspace
USER worker

ENTRYPOINT ["pdflatex"]
