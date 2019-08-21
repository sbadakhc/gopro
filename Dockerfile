FROM alpine:latest
WORKDIR /root/
COPY /gopro .
CMD ["sh","./gopro"]
