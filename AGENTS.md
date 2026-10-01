# Agent bootstrap

Read `SKILL.md` first and follow every referenced rule file relevant to the task.

Hard constraints:
- handwritten source files: max 377 lines;
- no god files/classes/ViewModels/composables;
- feature-first organization;
- keep Android/desktop platform code thin;
- no business logic in Compose UI;
- build/test before claiming completion when tooling is available;
- on Windows, prefer the project's `.\gradlew.bat`; do not require global Gradle when a wrapper exists.

For Android UI work also read `rules/ANDROID.md`, `rules/COMPOSE.md`, and `rules/UI_UX.md`.
For build/tooling work also read `rules/GRADLE.md` and `rules/VERIFICATION.md`.
