# Android platform rules

Android UI should behave like Android, not like an iOS/web design wearing Material colors.

## 1. Material 3 is the structural baseline

Use Material 3 conventions for navigation, controls, states, sheets, dialogs and interaction behavior unless the product has a justified custom system.

Brand expression should mainly come through:
- color roles;
- typography;
- shape;
- imagery;
- spacing;
- motion;
- composition.

Do not replace familiar platform behavior simply to look different.

## 2. Navigation by window size

Compact layouts:
- bottom navigation is appropriate for ~3-5 top-level destinations.

Expanded layouts:
- consider navigation rail/drawer and richer multi-pane structures.

Do not stretch a phone UI unchanged across tablets/desktop.

## 3. System Back

Android Back must work.

Respect predictive back and standard back-stack expectations. Never trap the user behind a custom back affordance.

## 4. Edge-to-edge and insets

Handle:
- status bar;
- navigation bar;
- cutouts;
- gesture area;
- IME/keyboard.

Important controls/content must not hide behind system UI.

## 5. Touch targets

Interactive targets should be at least **48 x 48 dp**.

Provide reasonable spacing between adjacent controls. Do not make tiny icon hitboxes just because the glyph is small.

## 6. Typography

Use semantic type roles and `sp` for text.

Support system font scaling. Never design only for 1.0 font scale.

Avoid hand-picking unrelated text sizes on every screen.

## 7. Color

Use semantic theme roles rather than raw colors throughout feature code.

Dark theme is first-class, not an inverted afterthought.

Dynamic Color can be supported where appropriate, but always provide a coherent fallback brand scheme.

## 8. Components

Prefer standard Android/Material interaction patterns:
- buttons;
- FAB;
- switches;
- chips;
- snackbars;
- sheets;
- dialogs;
- navigation bar/rail/drawer;
- top app bars.

Do not port Cupertino-looking switches, dialogs or navigation behavior onto Android without a strong product reason.

## 9. Feedback

Use:
- snackbar for transient/actionable feedback;
- dialog for genuinely interruptive decisions;
- progress/disabled state for ongoing operations.

Avoid silent taps and mysterious state changes.

## 10. Adaptivity

Consider:
- portrait and landscape;
- compact/medium/expanded windows;
- multi-window;
- tablets;
- foldables when relevant;
- keyboard/IME resizing.

Adapt composition rather than merely scaling dimensions.

## 11. Accessibility

Check:
- TalkBack labels and roles;
- logical focus order;
- content descriptions where meaningful;
- sufficient contrast;
- touch target size;
- large text;
- reduced motion where applicable.

Decorative imagery/icons should not create noisy accessibility output.

## 12. Verification

When a device/emulator is available, verify real Android rendering rather than trusting preview alone.

Useful checks include:
- light/dark;
- larger font scale;
- keyboard open;
- back gesture;
- rotation/window resize;
- slow/empty/error/loading states.
