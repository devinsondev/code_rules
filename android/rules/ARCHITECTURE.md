# Architecture

## 1. Feature-first by default

Prefer feature-first organization with clear layer boundaries.

Example:

```text
app/
core/
  database/
  network/
  navigation/
  platform/
  design/
  common/

feature/
  notes/
    domain/
    data/
    ui/
  scanner/
    domain/
    data/
    ui/
  settings/
    domain/
    data/
    ui/
```

Do not create folder forests that contain one meaningless file each. Directories must encode useful boundaries.

## 2. Dependency direction

UI depends on application/domain contracts.

Infrastructure implements those contracts.

Typical direction:

```text
UI -> domain/application contracts <- data/platform implementations
```

Domain code should not depend on Android APIs.

UI must not talk directly to SQL, HTTP clients, filesystem primitives, CameraX internals, etc.

## 3. Kotlin Multiplatform

When Android and Windows/Desktop share the same product, maximize meaningful shared code, not shared code percentage for its own sake.

Good candidates for `commonMain`:
- domain models;
- validation;
- use cases;
- state reducers;
- repository contracts;
- serialization;
- shared persistence abstractions;
- shared Compose UI when the interaction model is genuinely common.

Keep in platform source sets:
- Android intents;
- permissions;
- notifications;
- CameraX;
- Android lifecycle integration;
- desktop file dialogs;
- desktop OS integration;
- platform-specific window behavior.

Platform code should be thin adapters around shared contracts.

## 4. Platform services

Represent OS capabilities explicitly, e.g.:

```text
CameraController
ClipboardService
FilePicker
ShareService
PermissionGateway
NotificationScheduler
```

Do not pass `Context` or desktop window objects through the business layer.

## 5. Repositories

Repository interfaces describe product capabilities, not database tables.

Example:

```text
domain/NoteRepository.kt
data/RoomNoteRepository.kt
```

Do not expose persistence entities directly to UI when persistence shape and product model differ.

## 6. ViewModels / presenters

A ViewModel coordinates screen state and application actions.

It should not contain:
- SQL;
- raw HTTP plumbing;
- large JSON parsers;
- filesystem implementation details;
- reusable formatting libraries;
- Android service implementation;
- navigation framework internals.

Move those concerns behind focused collaborators.

## 7. Navigation

Navigation configuration contains routing, not business decisions.

Prefer typed destinations/arguments where supported.

Pass stable IDs or lightweight arguments between screens, not giant mutable objects or ViewModels.

Screen code emits an intent/event; navigation is handled at the appropriate UI boundary.

## 8. State flow

Prefer unidirectional data flow:

```text
user action -> event/action -> ViewModel/controller -> new immutable state -> UI
```

Avoid two-way mutable binding between layers.

## 9. Models

Use separate models when boundaries have different needs:
- API DTO;
- persistence entity;
- domain model;
- UI model.

Do not create mapping layers mechanically when models are truly identical and stable; avoid ceremony without value.

## 10. Scope

Architecture should fit the product size.

A tiny calculator does not need enterprise hexagonal architecture. A multi-feature offline app should not be one Activity + one 2000-line ViewModel.

Use the smallest architecture that preserves clear boundaries as the project grows.
