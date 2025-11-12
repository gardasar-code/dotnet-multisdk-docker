FROM mcr.microsoft.com/dotnet/sdk:5.0 AS sdk5
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS sdk6
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS sdk8
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS sdk9
FROM mcr.microsoft.com/dotnet/sdk:10.0

COPY --from=sdk5 /usr/share/dotnet /usr/share/dotnet
COPY --from=sdk6 /usr/share/dotnet /usr/share/dotnet
COPY --from=sdk8 /usr/share/dotnet /usr/share/dotnet
COPY --from=sdk9 /usr/share/dotnet /usr/share/dotnet

COPY --from=sdk5 /usr/lib/x86_64-linux-gnu/libssl.so.1.1 /usr/lib/x86_64-linux-gnu/
COPY --from=sdk5 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/
RUN echo "/usr/lib/x86_64-linux-gnu" > /etc/ld.so.conf.d/openssl1.1.conf && ldconfig
RUN ldconfig

RUN dotnet --list-sdks && dotnet --info

WORKDIR /app

CMD ["dotnet", "--info"]
