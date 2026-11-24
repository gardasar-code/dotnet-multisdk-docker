# dotnet-multi-sdk.v5

> 🐳 Docker-образ с .NET SDK 5.0 / 6.0 / 8.0 / 9.0 / 10.0 в одном контейнере. Только `linux/amd64`. Для миграции и аудита самых старых legacy-проектов.

**Исходники и Dockerfile:** [github.com/gardasar-code/dotnet-multisdk-docker](https://github.com/gardasar-code/dotnet-multisdk-docker)

## Что внутри

| SDK | Платформы |
|-----|-----------|
| .NET 5.0, 6.0, 8.0, 9.0, 10.0 | `linux/amd64` |

Базовый слой — .NET 10.0. Включены **и SDK, и shared-рантаймы** каждой версии. Для .NET 5.0 в образ добавлены библиотеки OpenSSL 1.1 (их нет в базовом Debian trixie), поэтому рантайм 5.0 работает.

> Не нужен .NET 5.0 и хотите ARM64? Возьмите основной образ [`smartles/dotnet-multi-sdk`](https://hub.docker.com/r/smartles/dotnet-multi-sdk) (6/8/9/10/11, `amd64` + `arm64`).

> ⚠️ .NET 5.0 и 6.0 сняты с поддержки, 9.0 — STS. Образ предназначен для миграции/аудита legacy-проектов, а не для production-нагрузки.

## Быстрый старт

```bash
docker pull smartles/dotnet-multi-sdk.v5:latest

docker run --rm smartles/dotnet-multi-sdk.v5:latest dotnet --list-sdks
docker run --rm smartles/dotnet-multi-sdk.v5:latest dotnet --list-runtimes
```

## Сборка чужого проекта через volume-mount

```bash
docker run --rm -v "$PWD":/app -w /app smartles/dotnet-multi-sdk.v5:latest dotnet build -c Release
```

## Теги

- `latest` — актуальная сборка
- `X.Y.Z` — конкретная версия (semver)

Полная документация и CI/CD — в [репозитории на GitHub](https://github.com/gardasar-code/dotnet-multisdk-docker).

