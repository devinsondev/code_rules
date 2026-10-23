# Code quality

## 1. Hard 377-line ceiling

No handwritten source file may exceed **377 lines**.

Exceptions:
- generated code;
- generated schemas/migrations;
- generated API clients.

Do not evade this with compressed formatting, multiple statements per line, giant regions, or moving unrelated code into nested objects.

At ~300 lines, actively evaluate whether the file has accumulated more than one responsibility.

## 2. Anti-god-file

A file/class/composable/ViewModel is a god object when unrelated responsibilities are forced through it.

Immediate refactor signals:
- UI + persistence logic;
- UI + networking;
- navigation + domain rules;
- parsing + storage + presentation;
- more than ~7 injected dependencies;
- many unrelated state flags;
- functions grouped only because “this is the main screen”;
- a `Utils.kt`, `Helpers.kt`, `Common.kt` or similar grab bag.

Split by responsibility and domain meaning, not by arbitrary line chunks.

Bad:
```text
utils/Utils.kt
ui/HomeScreen.kt     # 900 lines
MainViewModel.kt      # controls everything
```

Better:
```text
formatting/DateFormatter.kt
validation/NoteTitleValidator.kt
feature/notes/list/NotesScreen.kt
feature/notes/list/NotesViewModel.kt
feature/notes/list/components/NoteRow.kt
```

## 3. Functions

Prefer functions below ~40 lines.

A function above ~60 lines should normally be decomposed unless splitting would obscure a single linear algorithm.

Avoid:
- more than 5 unrelated parameters;
- boolean-flag APIs that radically change behavior;
- hidden side effects;
- deeply nested branches.

Prefer small named operations and parameter objects when several values form one concept.

## 4. Naming

Names describe intent, not implementation accidents.

Avoid vague nouns:
- Manager
- Processor
- Handler
- Thing
- Stuff
- Data
- Util

unless the responsibility is genuinely obvious from context.

Prefer:
- `QrCodeDecoder`
- `ReminderScheduler`
- `NoteRepository`
- `ImageCompressor`

## 5. Visibility and API surface

Default to `private` or `internal`.

Expose only what another module or layer genuinely needs.

Do not make properties mutable/public for convenience.

## 6. Abstractions

Do not create an interface for every class.

Create one when:
- multiple implementations exist;
- a platform boundary exists;
- an external system should be isolated;
- testing benefits materially;
- the architecture requires a stable boundary.

Do not abstract merely because two snippets look similar. Abstract when they represent the same concept.

## 7. Error handling

Never swallow exceptions silently.

Do not use exceptions as routine control flow.

Convert infrastructure failures into meaningful domain/application errors where useful. Surface actionable failures to UI and log unexpected failures at the appropriate boundary.

## 8. Comments

Comments explain:
- why;
- constraints;
- platform quirks;
- non-obvious tradeoffs.

Do not narrate syntax.

## 9. Constants

Avoid unexplained magic values.

Use named constants/tokens for values with semantic meaning. Do not extract every literal mechanically.

## 10. Dependency discipline

Before adding a dependency:
1. check the standard library/platform;
2. check existing project dependencies;
3. prefer mature maintained libraries;
4. avoid a package for trivial functionality.

One dependency should solve a real problem, not five lines of code.

## 11. No placeholder shipping

Do not leave:
- TODO implementation;
- FIXME as a substitute for completion;
- fake repositories;
- dead demo data;
- “implement later” branches;
- commented-out old code;

unless the user explicitly requested a prototype or scaffold.

## 12. Refactor trigger

Refactor before proceeding when:
- a file approaches 300+ lines and keeps growing;
- a function exceeds ~60 lines;
- a class has multiple unrelated responsibilities;
- business logic leaks into UI;
- platform APIs leak into shared/domain code;
- duplicated architecture appears across features;
- constructor dependencies become excessive;
- mutable state becomes hard to trace.

Every meaningful piece of code should have an obvious answer to:

> Why does this code live in this exact file?
