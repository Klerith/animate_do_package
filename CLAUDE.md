# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter test                    # Run all tests
flutter test test/some_test.dart # Run a single test file
flutter analyze                 # Lint
```

## Architecture

**animate_do** is a Flutter animation package (v4.2.0) inspired by Animate.css. Zero external dependencies — Flutter SDK only.

### Core Pattern

All animation widgets follow the same structure:
1. `StatefulWidget` subclass with the public API
2. State class mixes in `AnimateDoState` (`lib/src/types/animate_do_mixins.dart`) + `SingleTickerProviderStateMixin`
3. The mixin handles: `AnimationController` lifecycle, delay, infinite loops, `manualTrigger`, `onFinish` callbacks

Every animation widget exposes these common properties:
- `child`, `duration` (default 500ms), `delay`, `curve`
- `animate` (bool to trigger/reverse), `infinite`, `manualTrigger`, `controller` callback, `onFinish`

### Dual Syntax

Every animation supports two equivalent styles:
- **Class syntax:** `FadeIn(child: widget)`
- **Extension/sugar syntax:** `widget.fadeIn()`

Extension methods live alongside their widget counterparts and simply wrap them.

### File Organization

```
lib/src/
  types/
    animate_do_mixins.dart   # AnimateDoState mixin — core logic
    animate_do_types.dart    # AnimateDoDirection enum
  animations/
    attention_seekers/       # Loopable animations (Bounce, Flash, Pulse, Wobble, etc.)
    fade_ins/ fade_outs/
    back_ins/ back_outs/
    bounces/ elastics/ slides/ flips/
    zoom_ins/ zoom_outs/
  custom_animation/          # MoveTo, MoveToArc (Transform-based positioning)
```

Each category directory has an `index.dart` barrel export. The top-level `lib/animate_do.dart` re-exports everything.

### Adding a New Animation

1. Create file in the appropriate category subdirectory
2. Define `StatefulWidget` + state mixing in `AnimateDoState`
3. Add Widget extension method for sugar syntax
4. Export from the category's `index.dart`
