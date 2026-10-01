# Sources and attribution

This repository contains an original, condensed ruleset informed by several public projects and Android platform guidance. It does not require their CLIs or runtimes.

## UI/UX Pro Max

Repository:
https://github.com/nextlevelbuilder/ui-ux-pro-max-skill

Useful upstream material:
- `.claude/skills/ui-ux-pro-max/SKILL.md`
- `.claude/skills/ui-ux-pro-max/data/stacks/jetpack-compose.csv`

Ideas incorporated in rewritten form include:
- stateless/pure composables;
- state hoisting and single source of truth;
- lifecycle-aware collection;
- lazy-list keys;
- stable/immutable state;
- theme tokens;
- flatter Compose layouts;
- accessibility and testing checks.

License: MIT.

## Impeccable

Repository:
https://github.com/pbakaus/impeccable

Useful upstream material:
- `skill/reference/android.md`
- `skill/reference/audit.native.md`
- `skill/reference/adapt.native.md`

Ideas incorporated in rewritten form include:
- Android-native platform behavior;
- Material 3 structure;
- predictive/system Back;
- edge-to-edge/insets;
- 48dp touch targets;
- semantic theming;
- native accessibility/performance/adaptivity review.

License: Apache-2.0.

## Taste Skill

Repository:
https://github.com/Leonxlnx/taste-skill

Useful upstream material:
- `skills/taste-skill/SKILL.md`
- `skills/imagegen-frontend-mobile/SKILL.md`

Ideas incorporated in rewritten form include:
- anti-generic/anti-template design discipline;
- reading the product brief before choosing an aesthetic;
- avoiding common AI visual clichés;
- multi-screen consistency;
- platform-aware mobile composition.

License: MIT.

## Android guidance

Where platform rules matter, prefer current official Android/Material documentation over frozen copies in this repository.

This repository intentionally keeps the rules concise so an AI agent can load them cheaply and then consult upstream/current platform docs when a task requires deeper verification.
