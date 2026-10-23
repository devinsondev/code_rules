# code_rules — стандарты разработки с ИИ

Библиотека независимых инструкций для качественного кода. **Каждая платформа — в своей папке** и со своим основным `SKILL.md`.

| Платформа | Основная инструкция | Дополнительно |
| --- | --- | --- |
| Android / Kotlin / Jetpack Compose / KMP | [android/SKILL.md](android/SKILL.md) | [Правила и шаблоны](android/README.md) |
| Chrome + Firefox WebExtensions | [browser-extensions/SKILL.md](browser-extensions/SKILL.md) | [Правила и пример](browser-extensions/README.md) |

## Готовые промпты для ИИ

**Android:**

> Прочитай https://github.com/devinsondev/code_rules/blob/main/android/SKILL.md и соблюдай этот стандарт при разработке Android-приложений. Доработай целевой репозиторий до состояния READY FOR USER PULL, сообщив о реально выполненных проверках.

**Chrome / Firefox:**

> Прочитай https://github.com/devinsondev/code_rules/blob/main/browser-extensions/SKILL.md и соблюдай этот стандарт при разработке расширений браузеров. Проверяй заявленные браузеры и сообщи, достигнут ли статус READY TO RELEASE.

## Структура

```text
README.md                           # общий каталог
AGENTS.md                           # выбор стандарта
android/
  README.md
  AGENTS.md
  SKILL.md                          # главный Android-стандарт
  SOURCES.md
  rules/                            # Android / Compose / архитектура / UX / Gradle
  templates/                        # build-debug.bat / install-debug.bat
browser-extensions/
  README.md
  SKILL.md                          # главный стандарт Chrome + Firefox
  SOURCES.md
  rules/
  examples/minimal-mv3/
```

Android-специфичные настройки Gradle, JBR, SDK и BAT относятся **только** к `android/`. Для нового стека создайте `<profile>/SKILL.md`, собственные `rules/` и источники, затем дополните этот индекс и `AGENTS.md`.
