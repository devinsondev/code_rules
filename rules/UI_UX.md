# UI / UX and anti-generic design rules

The goal is not “make everything fancy.” The goal is a coherent product that looks intentional, reads clearly and feels native.

## 1. Read the product before choosing a style

Infer:
- product type;
- audience;
- context of use;
- existing brand;
- density needs;
- trust/safety expectations;
- user-provided references.

Do not impose one house aesthetic on every app.

## 2. Anti-AI-slop defaults

Do not default to:
- purple/blue startup gradients;
- glassmorphism everywhere;
- cards nested inside cards;
- excessive pills/chips;
- random glowing borders;
- giant centered headings for ordinary utility screens;
- fake analytics/charts;
- tiny gray text;
- one icon tile above every heading;
- decorative motion on every interaction;
- iOS-like UI on Android.

If one of these actually fits the brief, use it deliberately rather than reflexively.

## 3. Hierarchy

Every screen should make these obvious:
1. where am I;
2. what matters now;
3. what can I do;
4. what changed after I acted.

Prefer one strong primary action over five equal CTAs.

## 4. Density

Utility/productivity apps often benefit from useful density.

Do not confuse premium with empty.

Whitespace should clarify grouping and hierarchy, not waste the viewport.

## 5. Cards

A card is a grouping mechanism, not the default container for everything.

Prefer flatter hierarchy when section spacing, dividers, typography or background surfaces are enough.

Avoid box-in-box-in-box layouts.

## 6. Typography

Use a small coherent type system.

Prioritize readability and large-text resilience over decorative typography.

Do not make body/helper text tiny to achieve a “clean” screenshot.

## 7. Color

Use a controlled palette with semantic roles.

Color should communicate hierarchy/state or brand identity.

Do not spray unrelated accents across screens.

Never rely on color alone for critical state.

## 8. Icons

Use one coherent icon family where possible.

Icons should support recognition, not decorate empty space.

Avoid emojis as generic UI icons unless the product intentionally uses emoji as content/language.

## 9. Motion

Motion should explain:
- state change;
- spatial relationship;
- entrance/exit;
- feedback.

Avoid animation merely to prove the UI is animated.

Respect reduced-motion preferences and keep interaction latency low.

## 10. Mobile-native composition

A mobile app is not a desktop/web page scaled down.

Use:
- appropriate top bars;
- bottom/rail navigation where suitable;
- sheets;
- reachable controls;
- safe-area awareness;
- concise screen-level hierarchy.

## 11. Screen families

When designing multiple screens, lock a consistent product language:
- palette;
- type scale;
- spacing rhythm;
- radii;
- icon family;
- navigation model;
- component behavior;
- motion language.

Screens may vary in composition without drifting into different design systems.

## 12. States are part of design

Design and implement:
- loading;
- empty;
- error;
- offline where relevant;
- disabled;
- selected;
- permission denied;
- destructive confirmation;
- long content.

A pretty happy-path screenshot is not a finished product.

## 13. Accessibility floor

At minimum:
- adequate text contrast;
- readable font sizing;
- 48dp Android touch targets;
- screen-reader semantics;
- no critical hover-only behavior;
- meaningful focus order;
- large text does not clip;
- motion is not required to understand state.

## 14. Polish pass

Before completion ask:
- does this look like the specific product or a template?
- are there unnecessary containers?
- is the primary action obvious?
- are labels concise?
- does dark mode still have hierarchy?
- do long strings break layout?
- does the UI feel Android-native?
- are loading/error/empty states coherent?
