# Use Microsoft's official build .NET image.
# https://hub.docker.com/_/microsoft-dotnet-framework-sdk/
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019 AS build

WORKDIR /app

# # Install WebPI - no longer available
# RUN powershell -Command \
#     Invoke-WebRequest -Uri https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi -OutFile webpi.msi; \
#     Start-Process msiexec.exe -ArgumentList '/i', 'webpi.msi', '/quiet', '/norestart' -NoNewWindow -Wait;

# # Install ASP.NET MVC3
# RUN "%ProgramFiles%\Microsoft\Web Platform Installer\WebpiCmd.exe" /Install /Products:"MVC3" /AcceptEula /SuppressReboot

COPY ./packages/AspNetMVC3Setup.exe ./AspNetMVC3Setup.exe

# Install ASP.NET MVC3
RUN .\AspNetMVC3Setup.exe /q

# # Copy project files.
COPY . ./

# Restore packages.
RUN nuget restore

# Build the project.
RUN msbuild /p:Configuration=Release

# Use Microsoft's official runtime ASP.NET image.
# https://hub.docker.com/_/microsoft-dotnet-framework-aspnet/
# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019 AS runtime

WORKDIR /inetpub/wwwroot

# Copy the build output from the build image.
COPY --from=build /app/MvcMusicStore/. ./
COPY --from=build /app/MvcMusicStore/web.prod.config ./web.config


# Configure IIS (only required for aspnet:4.8 image, not aspent:4.8-windowsservercore-ltsc2019).
# RUN powershell -NoProfile -Command \
#     Import-module IISAdministration; \
#     New-IISSite -Name "Site" -PhysicalPath C:\inetpub\wwwroot -BindingInformation "*:80:"
