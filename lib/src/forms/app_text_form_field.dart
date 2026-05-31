import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_form_validators.dart';

/// A themed [TextFormField] with a built-in required-field marker, optional
/// password visibility toggle, and convenience factories for common field
/// types (email, password, confirm password, name, phone, OTP).
final class AppTextFormField extends StatefulWidget {
  /// Creates a customizable text form field.
  const AppTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.hintText,
    this.helperText,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.enablePasswordVisibilityToggle = false,
    this.maxLength,
    this.maxLines = 1,
    this.isRequired = false,
  });

  /// Creates a field preconfigured for email input with email validation.
  factory AppTextFormField.email({
    Key? key,
    TextEditingController? controller,
    String label = 'Email',
    String hintText = 'name@example.com',
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldValidator<String>? additionalValidator,
    bool enabled = true,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.email],
      autocorrect: false,
      enableSuggestions: false,
      isRequired: true,
      validator: AppFormValidators.compose(<FormFieldValidator<String>?>[
        AppFormValidators.email(),
        additionalValidator,
      ]),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }

  /// Creates an obscured field preconfigured for password input with strength
  /// validation and a visibility toggle.
  factory AppTextFormField.password({
    Key? key,
    TextEditingController? controller,
    String label = 'Password',
    String? hintText,
    String? helperText = 'Use at least 8 characters with letters and a number.',
    TextInputAction textInputAction = TextInputAction.done,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldValidator<String>? additionalValidator,
    bool enabled = true,
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialCharacter = false,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      helperText: helperText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.password],
      autocorrect: false,
      enableSuggestions: false,
      obscureText: true,
      enablePasswordVisibilityToggle: true,
      isRequired: true,
      validator: AppFormValidators.compose(<FormFieldValidator<String>?>[
        AppFormValidators.password(
          minLength: minLength,
          requireUppercase: requireUppercase,
          requireLowercase: requireLowercase,
          requireNumber: requireNumber,
          requireSpecialCharacter: requireSpecialCharacter,
        ),
        additionalValidator,
      ]),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }

  /// Creates a field that validates its value matches [passwordController].
  factory AppTextFormField.confirmPassword({
    Key? key,
    required TextEditingController passwordController,
    TextEditingController? controller,
    String label = 'Confirm password',
    String? hintText,
    TextInputAction textInputAction = TextInputAction.done,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldValidator<String>? additionalValidator,
    bool enabled = true,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.newPassword],
      autocorrect: false,
      enableSuggestions: false,
      obscureText: true,
      enablePasswordVisibilityToggle: true,
      isRequired: true,
      validator: AppFormValidators.compose(<FormFieldValidator<String>?>[
        AppFormValidators.confirmPassword(
          password: () => passwordController.text,
        ),
        additionalValidator,
      ]),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }

  /// Creates a field preconfigured for person-name input with word
  /// capitalization and name validation.
  factory AppTextFormField.name({
    Key? key,
    TextEditingController? controller,
    String label = 'Name',
    String? hintText,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldValidator<String>? additionalValidator,
    bool enabled = true,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      keyboardType: TextInputType.name,
      textInputAction: textInputAction,
      textCapitalization: TextCapitalization.words,
      autofillHints: const <String>[AutofillHints.name],
      isRequired: true,
      validator: AppFormValidators.compose(<FormFieldValidator<String>?>[
        AppFormValidators.name(),
        additionalValidator,
      ]),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }

  /// Creates a field preconfigured for phone-number input with phone
  /// validation.
  factory AppTextFormField.phone({
    Key? key,
    TextEditingController? controller,
    String label = 'Phone number',
    String? hintText,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldValidator<String>? additionalValidator,
    bool enabled = true,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.telephoneNumber],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-()+]')),
      ],
      isRequired: true,
      validator: AppFormValidators.compose(<FormFieldValidator<String>?>[
        AppFormValidators.phone(),
        additionalValidator,
      ]),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }

  /// Creates a field preconfigured for a numeric one-time code of [length]
  /// digits.
  factory AppTextFormField.otp({
    Key? key,
    TextEditingController? controller,
    String label = 'Verification code',
    String? hintText,
    int length = 6,
    TextInputAction textInputAction = TextInputAction.done,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldValidator<String>? additionalValidator,
    bool enabled = true,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      label: label,
      hintText: hintText,
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
      autofillHints: const <String>[AutofillHints.oneTimeCode],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(length),
      ],
      maxLength: length,
      isRequired: true,
      validator: AppFormValidators.compose(<FormFieldValidator<String>?>[
        AppFormValidators.otp(length: length),
        additionalValidator,
      ]),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
    );
  }

  /// The field label shown above the input.
  final String label;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The initial value used when no [controller] is supplied.
  final String? initialValue;

  /// Placeholder text shown when the field is empty.
  final String? hintText;

  /// Supporting text shown below the field.
  final String? helperText;

  /// Validates the field's value and returns an error message, or `null`.
  final FormFieldValidator<String>? validator;

  /// Called whenever the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the field (e.g. presses done).
  final ValueChanged<String>? onFieldSubmitted;

  /// The keyboard type to display.
  final TextInputType? keyboardType;

  /// The action button to show on the keyboard.
  final TextInputAction? textInputAction;

  /// How input text should be capitalized.
  final TextCapitalization textCapitalization;

  /// Autofill hints that help the platform suggest values.
  final Iterable<String>? autofillHints;

  /// Formatters applied to the input as the user types.
  final List<TextInputFormatter>? inputFormatters;

  /// An optional widget shown before the input.
  final Widget? prefixIcon;

  /// An optional widget shown after the input.
  final Widget? suffixIcon;

  /// Whether the field accepts input.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Whether to show input suggestions.
  final bool enableSuggestions;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Whether to show a button that toggles password visibility.
  final bool enablePasswordVisibilityToggle;

  /// The maximum number of characters allowed.
  final int? maxLength;

  /// The maximum number of lines for the input.
  final int? maxLines;

  /// Whether to append a required marker (`*`) to the label.
  final bool isRequired;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

final class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool canTogglePassword =
        widget.obscureText && widget.enablePasswordVisibilityToggle;
    final bool obscureText = widget.obscureText && !_isPasswordVisible;

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autofillHints: widget.autofillHints,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      obscureText: obscureText,
      maxLength: widget.maxLength,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      decoration: InputDecoration(
        label: _RequiredLabel(
          label: widget.label,
          isRequired: widget.isRequired,
        ),
        hintText: widget.hintText,
        helperText: widget.helperText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            (canTogglePassword
                ? IconButton(
                    tooltip: obscureText ? 'Show password' : 'Hide password',
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null),
      ),
    );
  }
}

final class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel({required this.label, required this.isRequired});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    if (!isRequired) {
      return Text(label);
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <InlineSpan>[
          TextSpan(text: label),
          TextSpan(
            text: ' *',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
  }
}
