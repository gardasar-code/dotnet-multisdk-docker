# dotnet-multisdk-docker

> 🐳 Docker-образы для разработки сразу на нескольких версиях .NET SDK. Подходят для CI/CD, миграций, тестирования и проверки совместимости старых проектов.

## Два образа

| Образ | Dockerfile | Версии SDK | Платформы |
|-------|-----------|------------|-----------|
| `*.v6min` | `Dockerfile` | 6.0, 8.0, 9.0, 10.0 | linux/amd64, linux/arm64 |
| `*.v5min.amd64` | `v5.Dockerfile` | 5.0, 6.0, 8.0, 9.0, 10.0 | linux/amd64 |

Базовый слой — .NET 10.0 (его host/fxr запускает и младшие рантаймы). В каждый образ включены **и SDK, и shared-рантаймы** каждой версии, поэтому проекты можно не только собирать, но и запускать.

> ⚠️ .NET 5.0 и 6.0 сняты с поддержки, .NET 9.0 — STS. Образы предназначены для миграции/аудита legacy-проектов, а не для production-нагрузки.

## Проверка

```bash
docker run --rm dotnet-multisdk:latest dotnet --list-sdks
docker run --rm dotnet-multisdk:latest dotnet --list-runtimes
```

## Использование

### Сборка образа

```bash
# Основной образ (6/8/9/10), multi-arch
docker buildx build --platform linux/amd64 -t dotnet-multisdk:latest --load .
docker buildx build --platform linux/arm64 -t dotnet-multisdk:latest --load .

# Образ с .NET 5 (только amd64)
docker buildx build --platform linux/amd64 -t dotnet-multisdk.v5:latest --load -f v5.Dockerfile .
```

### Сборка чужого проекта через volume-mount

```bash
docker run --rm -v "$PWD":/app -w /app dotnet-multisdk:latest dotnet build -c Release
```

## CI/CD

Workflow `.github/workflows/docker-multiarch.yml` при публикации GitHub Release
собирает оба образа и пушит в GHCR с semver-тегами (`1.2.3`, `1.2`, `latest`, `sha-…`).
Сборка кэшируется через GitHub Actions cache.
