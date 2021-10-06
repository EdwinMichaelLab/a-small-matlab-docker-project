# docker build --no-cache --tag testing --force .
# docker run testing hello
# Line 1: Use dotnet-framework base image
FROM mcr.microsoft.com/dotnet/framework/runtime:4.8
# Previously downloaded and unzipped installer:
COPY ["/matlab-runtime-r2021b", "/MATLAB_Runtime_win64"]
# Several programs I may wish to execute:
COPY /for_testing .
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
# Takes about 10 minutes to install:
RUN Start-Process C:\MATLAB_Runtime_win64\setup.exe -ArgumentList '-mode silent', '-agreeToLicense yes' -Wait
# Line 6: Installation folder after setup is complete
RUN Remove-Item -Force -Recurse C:\\MATLAB_Runtime_win64