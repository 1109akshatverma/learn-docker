FROM ubuntu

RUN apt update

RUN apt install -y curl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

COPY ready.sh /app/ready.sh

RUN chmod +x /app/ready.sh

ENTRYPOINT [ "/app/ready.sh" ]