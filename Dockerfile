# Multi-SDK .NET образ: 6.0 / 8.0 / 9.0 / 10.0 в одном контейнере.
# Базовый слой — 10.0 (его host/fxr резолвит и запускает младшие рантаймы).
# Патч-версии запиннены для воспроизводимости сборки.
FROM mcr.microsoft.com/dotnet/sdk:10.0.301 AS base

FROM mcr.microsoft.com/dotnet/sdk:6.0.425 AS sdk6
FROM mcr.microsoft.com/dotnet/sdk:8.0.422 AS sdk8
FROM mcr.microsoft.com/dotnet/sdk:9.0.315 AS sdk9

FROM base AS final

# Копируем и SDK, и shared-рантаймы каждой версии.
# Версионные подпапки не конфликтуют с базой 10.0, host/fxr остаётся от базового образа.
COPY --from=sdk6 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk6 /usr/share/dotnet/shared /usr/share/dotnet/shared
COPY --from=sdk8 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk8 /usr/share/dotnet/shared /usr/share/dotnet/shared
COPY --from=sdk9 /usr/share/dotnet/sdk    /usr/share/dotnet/sdk
COPY --from=sdk9 /usr/share/dotnet/shared /usr/share/dotnet/shared

RUN dotnet --list-sdks && dotnet --list-runtimes

WORKDIR /app

CMD ["dotnet", "--info"]
