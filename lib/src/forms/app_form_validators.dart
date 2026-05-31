import 'package:flutter/widgets.dart';

abstract final class AppFormValidators {
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
