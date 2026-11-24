# dotnet-multi-sdk

> 🐳 Docker-образ для разработки сразу на нескольких версиях .NET SDK. Подходит для CI/CD мультитаргетных проектов, миграций, тестирования и проверки совместимости legacy-проектов.

**Исходники и Dockerfile:** [github.com/gardasar-code/dotnet-multisdk-docker](https://github.com/gardasar-code/dotnet-multisdk-docker)

## Что внутри

| SDK | Платформы |
|-----|-----------|
| .NET 6.0, 8.0, 9.0, 10.0, 11.0 | `linux/amd64`, `linux/arm64` |

Базовый слой — .NET SDK 11.0 (Ubuntu 26.04 LTS); его host/fxr запускает и младшие рантаймы. Включены **и SDK, и shared-рантаймы** (`Microsoft.NETCore.App`, `Microsoft.AspNetCore.App`) каждой версии — проекты можно собирать, тестировать и запускать под любым из этих TFM в одном контейнере.

Версии в `0.0.7`:

| SDK | Рантайм |
|-----|---------|
| 11.0.100 | 11.0.0 |
| 10.0.404 | 10.0.15 |
| 9.0.321 | 9.0.23 |
| 8.0.428 | 8.0.34 |
| 6.0.425 | 6.0.33 |

> Нужен ещё и .NET 5.0? Используйте образ [`smartles/dotnet-multi-sdk.v5`](https://hub.docker.com/r/smartles/dotnet-multi-sdk.v5) (только `linux/amd64`).

> ⚠️ .NET 5.0 и 6.0 сняты с поддержки, 9.0 — STS. Образы предназначены для сборки, тестирования, миграции и аудита, а не для production-нагрузки.

## Быстрый старт

```bash
docker pull smartles/dotnet-multi-sdk:0.0.7

docker run --rm smartles/dotnet-multi-sdk:0.0.7 dotnet --list-sdks
docker run --rm smartles/dotnet-multi-sdk:0.0.7 dotnet --list-runtimes
```

## Сборка чужого проекта через volume-mount

```bash
docker run --rm -v "$PWD":/app -w /app smartles/dotnet-multi-sdk:0.0.7 dotnet build -c Release
```

`global.json` проекта выбирает SDK как обычно: в образе есть SDK 6/8/9/10/11, а проект с `net8.0;net10.0;net11.0` собирается и тестируется под каждым TFM.

## Теги

- `X.Y.Z` — конкретная версия (semver); для CI закрепляйте именно её
- `latest` — актуальная сборка, двигается с каждым релизом

| Тег | База | SDK |
|-----|------|-----|
| `0.0.7` | .NET SDK 11.0 | 6, 8, 9, 10, 11 |
| `0.0.6` | .NET SDK 10.0 | 6, 8, 9, 10 |

Полная документация и CI/CD — в [репозитории на GitHub](https://github.com/gardasar-code/dotnet-multisdk-docker).
