# Flutter Tool Kit

Reusable Flutter building blocks for app projects: extensions, common view states, UX primitives, form presets, validators, and app state screens that remove repeated boilerplate.

## Installation

After publishing, add the package from pub.dev:

```yaml
dependencies:
  flutter_tool_kit: ^0.1.0
```

Then import the public barrel file:

```dart
import 'package:flutter_tool_kit/flutter_tool_kit.dart';
```

For local development before publishing, use a path dependency:

```yaml
dependencies:
  flutter_tool_kit:
    path: ../Flutter Tool Box
```

## What is included

- Extensions for `BuildContext`, `String`, nullable `String`, `Iterable`, `num`, and `DateTime`.
- `ViewState<T>` for idle, loading, data, empty, and failure UI flows.
- Common widgets like `AppGap`, `StateView`, `EmptyState`, `LoadingState`, `ResponsiveBuilder`, and `TapScale`.
- Mobile UX primitives for spacing, touch targets, feedback, forms, accessibility, skeleton loading, safe scrolling, and sticky bottom actions.

## UX Layer

Use these primitives in every app to avoid common mobile UX misses:

- `AppSpacing`, `AppRadius`, `AppDurations`, `AppBreakpoints`, and `AppTouchTargets` for shared UX tokens.
- `MinTouchTarget`, `AppTapFeedback`, `BusyButtonGuard`, and `KeyboardDismissOnTap` for safer interactions.
- `AppSnack`, `AppBanner`, `ConfirmActionDialog`, `RetryView`, `SkeletonBox`, and `SkeletonList` for mandatory user feedback.
- `AppTextFieldShell`, `FormSubmitScope`, and `ValidationMessage` for consistent form UX.
- `AccessibleIconButton`, `SemanticsButton`, `FocusRing`, and `UxAssert` for accessibility guardrails.
- `SafeScrollable` and `StickyBottomActionBar` for reliable mobile screen structure.
- `NoInternetScreen`, `NoServerConnectionScreen`, and `PermissionScreen` for common blocking states.
- `AppTextFormField.email`, `.password`, `.confirmPassword`, `.name`, `.phone`, and `.otp` for login/signup-ready fields.

## Common Screens

Use the ready-made issue screens for mandatory app states:

```dart
NoInternetScreen(onRetry: reloadData)

NoServerConnectionScreen(
  onRetry: retryRequest,
  contactSupportLabel: 'Contact support',
  onContactSupport: openSupport,
)

PermissionScreen(
  permissionName: 'Camera',
  onPrimaryAction: requestCameraPermission,
  onOpenSettings: openAppSettings,
)
```

Set `wrapWithScaffold: false` when placing these inside an existing screen body.

## Login And Signup Fields

Use preset text fields when a screen needs standard form behavior without repeating validation, keyboard type, autofill, and password visibility code:

```dart
final passwordController = TextEditingController();

Form(
  child: Column(
    children: [
      AppTextFormField.email(),
      AppTextFormField.password(controller: passwordController),
      AppTextFormField.confirmPassword(
        passwordController: passwordController,
      ),
      AppTextFormField.phone(),
    ],
  ),
)
```

Use `AppFormValidators.email()`, `AppFormValidators.password()`, and the other validator helpers when you need the validation rules with your own custom fields.

## Suggested Repo Rules

- Keep app-specific code out of this package.
- Prefer tiny, composable helpers over large framework abstractions.
- Add tests for reusable logic before using it in multiple apps.
- Export stable APIs only through `lib/flutter_tool_kit.dart`.

## Publishing

Before the first public release, add the real GitHub repository URL to `pubspec.yaml`:

```yaml
repository: https://github.com/<owner>/flutter_tool_kit
issue_tracker: https://github.com/<owner>/flutter_tool_kit/issues
```

Before publishing a new version:

```bash
flutter analyze
flutter test
flutter pub publish --dry-run
```

Publish only after the dry run reports no warnings or errors.
