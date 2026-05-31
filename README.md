# Flutter App Utilities

`flutter_app_utilities` is a zero-dependency Flutter package for reusable app building blocks: extensions, form presets, validators, UX guardrails, state helpers, feedback widgets, and common blocking screens.

The package is designed for production Flutter apps where the same small patterns appear again and again: login fields, loading states, empty states, retry screens, permission screens, safe mobile layouts, touch target rules, and basic app utilities.

## Features

- **Login and signup fields**: ready-made email, password, confirm password, name, phone, and OTP fields.
- **Validators**: reusable validation methods for custom form fields.
- **UX primitives**: spacing, radius, duration, breakpoint, and touch target tokens.
- **Interaction safety**: minimum touch targets, tap feedback, duplicate-submit guards, and keyboard dismissal.
- **Feedback patterns**: snackbars, banners, confirmation dialogs, retry views, and skeleton loading.
- **Common screens**: no internet, server connection failure, permission, and generic issue screens.
- **State helpers**: `ViewState<T>` and `StateView<T>` for loading/data/empty/error flows.
- **Accessibility helpers**: semantic buttons, accessible icon buttons, focus rings, and debug UX assertions.
- **General extensions**: helpers for `BuildContext`, `String`, nullable `String`, `Iterable`, `num`, and `DateTime`.

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_app_utilities: ^0.1.0
```

Import it:

```dart
import 'package:flutter_app_utilities/flutter_app_utilities.dart';
```

## Login And Signup Fields

Use `AppTextFormField` presets when you want the full text field ready with label, keyboard type, autofill hints, validation, and password visibility behavior.

```dart
final passwordController = TextEditingController();

Form(
  child: Column(
    children: [
      AppTextFormField.name(),
      AppTextFormField.email(),
      AppTextFormField.password(controller: passwordController),
      AppTextFormField.confirmPassword(
        passwordController: passwordController,
      ),
      AppTextFormField.phone(),
      AppTextFormField.otp(),
    ],
  ),
)
```

Available presets:

- `AppTextFormField.email()`
- `AppTextFormField.password()`
- `AppTextFormField.confirmPassword()`
- `AppTextFormField.name()`
- `AppTextFormField.phone()`
- `AppTextFormField.otp()`

## Validators

Use `AppFormValidators` when you already have your own text field but want consistent validation rules.

```dart
TextFormField(
  validator: AppFormValidators.email(),
)

TextFormField(
  obscureText: true,
  validator: AppFormValidators.password(
    minLength: 8,
    requireUppercase: true,
    requireLowercase: true,
    requireNumber: true,
  ),
)
```

You can compose validators:

```dart
TextFormField(
  validator: AppFormValidators.compose([
    AppFormValidators.required(),
    AppFormValidators.email(),
  ]),
)
```

## Common App Screens

Use reusable screens for blocking states that appear in almost every mobile app.

```dart
NoInternetScreen(
  onRetry: reloadData,
)

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

Use `wrapWithScaffold: false` when embedding these screens inside an existing page body.

```dart
NoInternetScreen(
  wrapWithScaffold: false,
  onRetry: reloadData,
)
```

For custom blocking states, use the base screen:

```dart
AppIssueScreen(
  title: 'Location unavailable',
  message: 'Enable location access to find nearby stores.',
  icon: Icons.location_off_rounded,
  primaryActionLabel: 'Enable location',
  onPrimaryAction: requestLocation,
)
```

## State Handling

`ViewState<T>` gives a simple shared shape for UI state:

```dart
const ViewState.loading();
const ViewState.data(items);
const ViewState.empty(message: 'No items found');
ViewState.failure(error);
```

Render the state with `StateView<T>`:

```dart
StateView<List<String>>(
  state: state,
  onRetry: loadItems,
  dataBuilder: (context, items) {
    return ListView(
      children: items.map(Text.new).toList(),
    );
  },
)
```

## UX Primitives

Use the built-in tokens to keep spacing, motion, breakpoints, and touch sizes consistent:

```dart
const SizedBox(height: AppSpacing.md)

AnimatedContainer(
  duration: AppDurations.normal,
  decoration: const BoxDecoration(
    borderRadius: AppRadius.medium,
  ),
)
```

Important tokens:

- `AppSpacing`: `xxs`, `xs`, `sm`, `md`, `lg`, `xl`
- `AppRadius`: `xs`, `sm`, `md`, `lg`, `pill`
- `AppDurations`: `instantFeedback`, `fast`, `normal`, `slow`
- `AppBreakpoints`: `mobile`, `tablet`, `desktop`
- `AppTouchTargets`: minimum accessible touch target size

## Interaction Helpers

Use these widgets to avoid common mobile UX mistakes:

```dart
MinTouchTarget(
  child: IconButton(
    onPressed: onClose,
    icon: const Icon(Icons.close),
  ),
)

BusyButtonGuard(
  onPressed: submitForm,
  builder: (context, isBusy, onPressed) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(isBusy ? 'Saving...' : 'Save'),
    );
  },
)

KeyboardDismissOnTap(
  child: formScreen,
)
```

## Feedback And Loading

Show consistent feedback across apps:

```dart
AppSnack.success(context, 'Saved successfully');
AppSnack.error(context, 'Something went wrong');
```

Use dialogs for destructive actions:

```dart
final confirmed = await ConfirmActionDialog.show(
  context,
  title: 'Delete item?',
  message: 'This action cannot be undone.',
  confirmLabel: 'Delete',
  isDestructive: true,
);
```

Use skeletons while content is loading:

```dart
const SkeletonList(itemCount: 6)
```

## Accessibility Helpers

Use accessible wrappers for icon-only or custom controls:

```dart
AccessibleIconButton(
  semanticLabel: 'Close dialog',
  onPressed: onClose,
  icon: const Icon(Icons.close),
)

SemanticsButton(
  label: 'Open profile',
  onTap: openProfile,
  child: avatar,
)
```

Use `FocusRing` when building custom interactive surfaces that need visible keyboard focus.

## Layout Helpers

`SafeScrollable` handles safe areas, keyboard insets, scroll behavior, and bottom actions:

```dart
SafeScrollable(
  bottomAction: StickyBottomActionBar(
    child: FilledButton(
      onPressed: submit,
      child: const Text('Continue'),
    ),
  ),
  child: formContent,
)
```

## Extensions

The package includes small extensions for common app code:

```dart
context.theme
context.colorScheme
context.textTheme
context.isMobile
context.hideKeyboard()

' hello   world '.normalizedSpaces
'john doe'.titleCased

[1, 2, 3].firstOrNull
[1, 2, 3].mapIndexed((index, value) => '$index:$value')

16.gapY
300.milliseconds

DateTime.now().startOfDay
```

## Example

See the `example/` directory for a small Flutter app that demonstrates:

- login/signup field presets
- validation
- safe scrolling
- sticky bottom actions
- common issue screens
- snackbar feedback

## Design Goals

- Keep the package dependency-free.
- Prefer small reusable primitives over a large app framework.
- Stay compatible with plain Flutter widgets.
- Let each app own its own theme and visual identity.
- Provide defaults that prevent common UX mistakes without forcing one brand style.

## License

MIT License. See `LICENSE` for details.
