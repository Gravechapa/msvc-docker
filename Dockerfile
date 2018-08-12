FROM microsoft/windowsservercore
RUN powershell -Version 1.0 -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
SHELL ["powershell", "-Command"]
RUN choco install git 7zip cmake wget -y
RUN choco install visualcpp-build-tools --version 15.0.26228.20170424 -y
RUN Write-Host 'Waiting for Visual C++ Build Tools to finish'
RUN Wait-Process -Name vs_installer

WORKDIR C:\
RUN wget https://www.sfml-dev.org/files/SFML-2.5.0-windows-vc15-64-bit.zip
RUN 7z x -tzip SFML-2.5.0-windows-vc15-64-bit.zip
RUN Remove-Item SFML-2.5.0-windows-vc15-64-bit.zip
