import 'package:flutter/material.dart';
import 'package:flutter_app_utilities/flutter_app_utilities.dart';

void main() {
  runApp(const ToolkitExampleApp());
}

/// The root widget for the flutter_app_utilities example app.
final class ToolkitExampleApp extends StatelessWidget {
  /// Creates the example app.
  const ToolkitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ToolkitExampleScreen(),
    );
  }
}

/// A sample screen showcasing the form fields and screens provided by the
/// package.
final class ToolkitExampleScreen extends StatefulWidget {
  /// Creates the example screen.
  const ToolkitExampleScreen({super.key});

  @override
  State<ToolkitExampleScreen> createState() => _ToolkitExampleScreenState();
}

final class _ToolkitExampleScreenState extends State<ToolkitExampleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter App Utilities')),
      body: SafeScrollable(
        bottomAction: StickyBottomActionBar(
          child: FilledButton(
            onPressed: _handleSubmit,
            child: const Text('Create account'),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Reusable login and signup fields',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextFormField.name(),
              const SizedBox(height: AppSpacing.md),
              AppTextFormField.email(),
              const SizedBox(height: AppSpacing.md),
              AppTextFormField.password(controller: _passwordController),
              const SizedBox(height: AppSpacing.md),
              AppTextFormField.confirmPassword(
                passwordController: _passwordController,
              ),
              const SizedBox(height: AppSpacing.xl),
              const NoInternetScreen(wrapWithScaffold: false),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      AppSnack.success(context, 'Form is valid');
    }
  }
}
