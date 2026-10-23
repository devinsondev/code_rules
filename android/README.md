# Android — Kotlin / Jetpack Compose / KMP

**Канонический стандарт:** [SKILL.md](SKILL.md). Все Android-инструкции, примеры и источники находятся в этой папке.

## Промпт для ИИ

> Прочитай https://github.com/devinsondev/code_rules/blob/main/android/SKILL.md и соблюдай его как единственный стандарт Android-разработки. Измени целевой репозиторий до состояния READY FOR USER PULL. Не заявляй об успешных тестах или сборке, если они не запускались.

## Файлы

- [SKILL.md](SKILL.md) — основной стандарт Kotlin/Compose, архитектура, безопасность, Gradle, Windows build и проверки.
- [SOURCES.md](SOURCES.md) — источники и атрибуция.
- [rules/CODE_QUALITY.md](rules/CODE_QUALITY.md) — качество кода.
- [rules/ARCHITECTURE.md](rules/ARCHITECTURE.md) — архитектура.
- [rules/ANDROID.md](rules/ANDROID.md) — Android-специфика.
- [rules/COMPOSE.md](rules/COMPOSE.md) — Jetpack Compose.
- [rules/UI_UX.md](rules/UI_UX.md) — UX и интерфейсы.
- [rules/GRADLE.md](rules/GRADLE.md) — безопасность сборки.
- [rules/LOCAL_WINDOWS.md](rules/LOCAL_WINDOWS.md) — локальная среда Windows.
- [rules/VERIFICATION.md](rules/VERIFICATION.md) — проверка готовности.
- [templates/build-debug.bat](templates/build-debug.bat) — шаблон защищённой debug-сборки.
- [templates/install-debug.bat](templates/install-debug.bat) — шаблон установки APK.

## Локальный Android workflow

```powershell
cd D:\ORDERED_CODE\PHONE\APPS\<repo>
git pull --ff-only
.\build-debug.bat
```

- JBR: `D:\TOOLS\andrstdio\jbr`
- Android SDK: `%LOCALAPPDATA%\Android\Sdk`
- В целевом проекте обязательны проверенный Gradle Wrapper, официальный SHA-256, dependency verification metadata и fail-closed `build-debug.bat`. Подробности — в [SKILL.md](SKILL.md).

**При переносе оригинальные Android-файлы не изменены:** ранее корневые `SKILL.md`, `SOURCES.md`, `rules/` и `templates/` теперь находятся внутри `android/`. Старый URL корневого SKILL.md следует заменить на `android/SKILL.md`.
