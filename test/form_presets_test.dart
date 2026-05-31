import 'package:flutter/material.dart';
import 'package:flutter_app_utilities/flutter_app_utilities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFormValidators', () {
    test('validates email addresses', () {
      final FormFieldValidator<String> validator = AppFormValidators.email();

      expect(validator(''), 'Email is required');
      expect(validator('not-email'), 'Enter a valid email address');
      expect(validator('person@example.com'), isNull);
    });

    test('validates password strength', () {
      final FormFieldValidator<String> validator = AppFormValidators.password();

      expect(validator(''), 'Password is required');
      expect(validator('short'), 'Password must be at least 8 characters');
      expect(
        validator('lowercase1'),
        'Password must include an uppercase letter',
      );
      expect(
        validator('PASSWORD1'),
        'Password must include a lowercase letter',
      );
      expect(validator('Password'), 'Password must include a number');
      expect(validator('Password1'), isNull);
    });

    test('validates matching confirmation password', () {
      final FormFieldValidator<String> validator =
          AppFormValidators.confirmPassword(password: () => 'Password1');

      expect(validator(''), 'Confirm your password');
      expect(validator('Different1'), 'Passwords do not match');
      expect(validator('Password1'), isNull);
    });

    test('validates phone and otp fields', () {
      expect(AppFormValidators.phone()('123'), 'Enter a valid phone number');
      expect(AppFormValidators.phone()('+1 555 123 4567'), isNull);
      expect(AppFormValidators.otp()('123'), 'Enter the 6 digit code');
      expect(AppFormValidators.otp()('123456'), isNull);
    });
  });

  testWidgets('AppTextFormField.email is ready for email validation', (
    WidgetTester tester,
  ) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(key: formKey, child: AppTextFormField.email()),
        ),
      ),
    );

    final TextField renderedField = tester.widget<TextField>(
      find.byType(TextField),
    );
    expect(renderedField.decoration?.label, isNotNull);

    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Email is required'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'person@example.com');
    expect(formKey.currentState!.validate(), isTrue);
  });

  testWidgets(
    'AppTextFormField.password hides text and can toggle visibility',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AppTextFormField.password())),
      );

      TextField field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isTrue);
      expect(find.byTooltip('Show password'), findsOneWidget);

      await tester.tap(find.byTooltip('Show password'));
      await tester.pump();

      field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isFalse);
      expect(find.byTooltip('Hide password'), findsOneWidget);
    },
  );

  testWidgets('AppTextFormField.confirmPassword validates controller value', (
    WidgetTester tester,
  ) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController passwordController = TextEditingController(
      text: 'Password1',
    );

    addTearDown(passwordController.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: AppTextFormField.confirmPassword(
              passwordController: passwordController,
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Different1');
    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Passwords do not match'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Password1');
    expect(formKey.currentState!.validate(), isTrue);
  });
}
