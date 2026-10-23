# AI agent router — code_rules

This repository contains **separate platform-specific coding standards**. Select the profile matching the target repository.

- **Android / Kotlin / Jetpack Compose / Kotlin Multiplatform:** read [android/SKILL.md](android/SKILL.md). Android-only reference files are in `android/rules/`, `android/templates/` and `android/SOURCES.md`. Its completion definition is READY FOR USER PULL.
- **Chrome / Firefox WebExtensions:** read [browser-extensions/SKILL.md](browser-extensions/SKILL.md). Its references are in `browser-extensions/rules/`. Its completion definition is READY TO RELEASE.
- **Mixed product:** apply each standard only to its corresponding component.
- **Other technology:** no official profile yet; do not substitute an unrelated standard.

Within each profile, that profile's SKILL.md is the single canonical contract. Supporting files never override it. Keep version-sensitive browser/platform behavior aligned with official documentation. Never claim test, build or publishing success without actually performing the check.

When modifying code_rules itself, keep platform rules in their own directories. Root README.md and AGENTS.md provide navigation only; they are not platform-specific engineering contracts.
