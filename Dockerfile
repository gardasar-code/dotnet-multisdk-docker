FROM mcr.microsoft.com/dotnet/sdk:6.0 AS sdk6
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS sdk8
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS sdk9
FROM mcr.microsoft.com/dotnet/sdk:10.0-preview

COPY --from=sdk6 /usr/share/dotnet /usr/share/dotnet
COPY --from=sdk8 /usr/share/dotnet /usr/share/dotnet
COPY --from=sdk9 /usr/share/dotnet /usr/share/dotnet

RUN dotnet --list-sdks && dotnet --info

WORKDIR /app

CMD ["dotnet", "--info"]
