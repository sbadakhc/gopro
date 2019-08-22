FROM golang:latest 
RUN mkdir /app 
ADD gopro /app/ 
WORKDIR /app 
CMD ["/app/gopro"]
