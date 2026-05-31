import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tool_kit/flutter_tool_kit.dart';

void main() {
  testWidgets('NoInternetScreen shows default copy and retry action', (
    WidgetTester tester,
  ) async {
    int retryCount = 0;

    await tester.pumpWidget(
      MaterialApp(home: NoInternetScreen(onRetry: () => retryCount += 1)),
    );

    expect(find.text('No internet connection'), findsOneWidget);
    expect(
      find.text('Check your Wi-Fi or mobile data, then try again.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(retryCount, 1);
  });

  testWidgets('NoServerConnectionScreen supports support action', (
    WidgetTester tester,
  ) async {
    int supportCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: NoServerConnectionScreen(
          contactSupportLabel: 'Contact support',
          onContactSupport: () => supportCount += 1,
        ),
      ),
    );

    expect(find.text('Server connection failed'), findsOneWidget);
    expect(find.text('Contact support'), findsOneWidget);

    await tester.tap(find.text('Contact support'));
    await tester.pump();

    expect(supportCount, 1);
  });

  testWidgets('PermissionScreen customizes permission copy and actions', (
    WidgetTester tester,
  ) async {
    int requestCount = 0;
    int settingsCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: PermissionScreen(
          permissionName: 'Camera',
          onPrimaryAction: () => requestCount += 1,
          onOpenSettings: () => settingsCount += 1,
        ),
      ),
    );

    expect(find.text('Camera permission needed'), findsOneWidget);
    expect(
      find.text('Enable Camera permission to continue using this feature.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Allow permission'));
    await tester.pump();
    await tester.tap(find.text('Open settings'));
    await tester.pump();

    expect(requestCount, 1);
    expect(settingsCount, 1);
  });

  testWidgets('AppIssueScreen can be embedded without a Scaffold', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppIssueScreen(
            title: 'Offline',
            message: 'Reconnect and try again.',
            icon: Icons.wifi_off,
            wrapWithScaffold: false,
          ),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Offline'), findsOneWidget);
  });
}
