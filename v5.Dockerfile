# Multi-SDK .NET образ с добавленным .NET 5.0 (только linux/amd64).
# .NET 5 требует OpenSSL 1.1, которого нет в базовом образе 11.0,
# поэтому libssl/libcrypto 1.1 подкладываются из образа sdk5 (Debian buster).
FROM mcr.microsoft.com/dotnet/sdk:11.0.100 AS base

FROM mcr.microsoft.com/dotnet/sdk:5.0.408 AS sdk5
FROM mcr.microsoft.com/dotnet/sdk:6.0.425 AS sdk6
FROM mcr.microsoft.com/dotnet/sdk:8.0.428 AS sdk8
FROM mcr.microsoft.com/dotnet/sdk:9.0.321 AS sdk9
FROM mcr.microsoft.com/dotnet/sdk:10.0.404 AS sdk10

FROM base AS final

# SDK + shared-рантаймы каждой версии (версионные подпапки не конфликтуют).
COPY --from=sdk5 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk5 /usr/share/dotnet/shared /usr/share/dotnet/shared
COPY --from=sdk6 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk6 /usr/share/dotnet/shared /usr/share/dotnet/shared
COPY --from=sdk8 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk8 /usr/share/dotnet/shared /usr/share/dotnet/shared
COPY --from=sdk9 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk9 /usr/share/dotnet/shared /usr/share/dotnet/shared
COPY --from=sdk10 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk10 /usr/share/dotnet/shared /usr/share/dotnet/shared

# OpenSSL 1.1 для рантайма .NET 5.0.
COPY --from=sdk5 /usr/lib/x86_64-linux-gnu/libssl.so.1.1    /usr/lib/x86_64-linux-gnu/
COPY --from=sdk5 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/
RUN echo "/usr/lib/x86_64-linux-gnu" > /etc/ld.so.conf.d/openssl1.1.conf && ldconfig

RUN dotnet --list-sdks && dotnet --list-runtimes

WORKDIR /app

CMD ["dotnet", "--info"]
