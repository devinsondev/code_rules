# code_rules — coding standards for AI agents

Библиотека профильных инструкций для разработки качественного кода. Выберите стандарт под конкретный проект: **не применяйте Android-правила к браузерным расширениям**.

| Проект | Каноническая инструкция |
| --- | --- |
| Android / Kotlin / Compose | [SKILL.md](SKILL.md) |
| Расширения Chrome + Firefox | [browser-extensions/SKILL.md](browser-extensions/SKILL.md) |

## Готовый промпт для ИИ: браузерные расширения

> Прочитай https://github.com/devinsondev/code_rules/blob/main/browser-extensions/SKILL.md и соблюдай его как основной стандарт. Проверь проект, реализуй задачу, запусти доступные тесты и честно укажи, прошли ли проверки Chrome и Firefox.

## Готовый промпт для ИИ: Android

> Read https://github.com/devinsondev/code_rules/blob/main/SKILL.md and follow it as the single source of truth. Modify the target GitHub repository until it satisfies READY FOR USER PULL.

## Профили

- [Android SKILL.md](SKILL.md) — прежний, неизменный стандарт: Kotlin/Compose, Gradle Wrapper, SHA-256, Windows BAT, READY FOR USER PULL.
- [Browser extensions](browser-extensions/README.md) — Manifest V3, WebExtensions, безопасная архитектура, Chrome/Firefox, проверка и публикация.

## Расширение библиотеки

Каждый новый стек помещать в отдельную папку `<profile>/SKILL.md` с проверяемым Definition of Done, вспомогательными `rules/` и ссылками на официальную документацию. В существующих профилях `SKILL.md` остается единственным главным источником правил.

**Правило:** тестируемый, безопасный, сопровождаемый код важнее красивых обещаний.
