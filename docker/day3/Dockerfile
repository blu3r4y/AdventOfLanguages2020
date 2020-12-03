FROM mcr.microsoft.com/powershell:alpine-3.12

WORKDIR /home

COPY data/day3.txt data/
COPY src/day3.ps1 src/

# ensure that we have LF line endings
RUN dos2unix data/day3.txt

CMD [ "pwsh", "/home/src/day3.ps1" ]
