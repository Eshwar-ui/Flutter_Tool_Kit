import 'package:flutter/widgets.dart';

/// A set of ready-made [FormFieldValidator]s for common input types such as
/// email, password, phone, and one-time codes.
///
/// Each factory returns a validator that yields an error message string when
/// the value is invalid, or `null` when it is valid.
abstract final class AppFormValidators {
  /// Combines [validators] into a single validator that returns the first
  /// non-null error. Null entries are ignored.
  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>?> validators,
  ) {
    return (String? value) {
      for (final FormFieldValidator<String>? validator in validators) {
        final String? error = validator?.call(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Validates that a value is present and not blank.
  static FormFieldValidator<String> required({
    String message = 'This field is required',
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    };
  }

  /// Validates that a value is a well-formed email address.
  static FormFieldValidator<String> email({
    String requiredMessage = 'Email is required',
    String invalidMessage = 'Enter a valid email address',
  }) {
    return compose(<FormFieldValidator<String>>[
      required(message: requiredMessage),
      (String? value) {
        final String email = value!.trim();
        final bool isValid = RegExp(
          r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$',
          caseSensitive: false,
        ).hasMatch(email);

        return isValid ? null : invalidMessage;
      },
    ]);
  }

  /// Validates a password against configurable strength rules such as minimum
  /// length and required character classes.
  static FormFieldValidator<String> password({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialCharacter = false,
    String requiredMessage = 'Password is required',
  }) {
    return compose(<FormFieldValidator<String>>[
      required(message: requiredMessage),
      (String? value) {
        final String password = value ?? '';
        if (password.length < minLength) {
          return 'Password must be at least $minLength characters';
        }
        if (requireUppercase && !RegExp('[A-Z]').hasMatch(password)) {
          return 'Password must include an uppercase letter';
        }
        if (requireLowercase && !RegExp('[a-z]').hasMatch(password)) {
          return 'Password must include a lowercase letter';
        }
        if (requireNumber && !RegExp(r'\d').hasMatch(password)) {
          return 'Password must include a number';
        }
        if (requireSpecialCharacter &&
            !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
          return 'Password must include a special character';
        }
        return null;
      },
    ]);
  }

  /// Validates that a value matches the password returned by [password].
  ///
  /// Pass a closure (e.g. `() => controller.text`) so the comparison always
  /// uses the latest password value.
  static FormFieldValidator<String> confirmPassword({
    required String Function() password,
    String requiredMessage = 'Confirm your password',
    String mismatchMessage = 'Passwords do not match',
  }) {
    return compose(<FormFieldValidator<String>>[
      required(message: requiredMessage),
      (String? value) {
        return value == password() ? null : mismatchMessage;
      },
    ]);
  }

  /// Validates that a name is present and at least [minLength] characters long.
  static FormFieldValidator<String> name({
    String requiredMessage = 'Name is required',
    int minLength = 2,
  }) {
    return compose(<FormFieldValidator<String>>[
      required(message: requiredMessage),
      (String? value) {
        final String name = value!.trim();
        if (name.length < minLength) {
          return 'Name must be at least $minLength characters';
        }
        return null;
      },
    ]);
  }

  /// Validates that a value is a plausible phone number (7–15 digits, with an
  /// optional leading `+`).
  static FormFieldValidator<String> phone({
    String requiredMessage = 'Phone number is required',
    String invalidMessage = 'Enter a valid phone number',
  }) {
    return compose(<FormFieldValidator<String>>[
      required(message: requiredMessage),
      (String? value) {
        final String phone = value!.replaceAll(RegExp(r'[\s\-()]'), '');
        final bool isValid = RegExp(r'^\+?\d{7,15}$').hasMatch(phone);

        return isValid ? null : invalidMessage;
      },
    ]);
  }

  /// Validates that a value is a numeric one-time code of exactly [length]
  /// digits.
  static FormFieldValidator<String> otp({
    int length = 6,
    String requiredMessage = 'Code is required',
  }) {
    return compose(<FormFieldValidator<String>>[
      required(message: requiredMessage),
      (String? value) {
        final String code = value!.trim();
        if (!RegExp('^\\d{$length}\$').hasMatch(code)) {
          return 'Enter the $length digit code';
        }
        return null;
      },
    ]);
  }
}
