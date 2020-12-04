FROM mcr.microsoft.com/powershell:alpine-3.12

WORKDIR /home

COPY data/day3.txt data/
COPY src/day3.ps1 src/

CMD [ "pwsh", "/home/src/day3.ps1" ]
