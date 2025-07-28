# dotnet-multisdk-docker

> 🐳 Dockerfile для разработки на нескольких версиях .NET SDK одновременно: .NET 5 (amd64), 6, 8, 9, 10.0-preview Подходит для CI/CD, миграций, тестирования и совместимости.

## Features

- В образ включены все необходимые SDK: 5.0 (amd64), 6.0, 8.0, 9.0, 10.0-preview
- Можно собирать и запускать проекты на любой из поддерживаемых версий
- Протестировано для CI/CD, Dev контейнеров, миграции и аудита старых проектов

## Включённые версии

| SDK версия        | Пути установки      |
|-------------------|---------------------|
| .NET 5.0 (amd64)  | `/usr/share/dotnet` |
| .NET 6.0          | `/usr/share/dotnet` |
| .NET 8.0          | `/usr/share/dotnet` |
| .NET 9.0          | `/usr/share/dotnet` |
| .NET 10.0-preview | `/usr/share/dotnet` |

## Использование

### Сборка Docker-образа

```bash

docker buildx build --platform linux/amd64 -t dotnet-multisdk.v5:latest --load -f v5.Dockerfile .

docker buildx build --platform linux/amd64 -t dotnet-multisdk:latest --load .
docker buildx build --platform linux/arm64 -t dotnet-multisdk:latest --load .

```