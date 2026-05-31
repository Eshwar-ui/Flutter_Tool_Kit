import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tool_kit/flutter_tool_kit.dart';

void main() {
  testWidgets('MinTouchTarget enforces accessible minimum size', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: MinTouchTarget(child: SizedBox(width: 8, height: 8)),
        ),
      ),
    );

    final Size size = tester.getSize(find.byType(MinTouchTarget));

    expect(size.width, greaterThanOrEqualTo(AppTouchTargets.min));
    expect(size.height, greaterThanOrEqualTo(AppTouchTargets.min));
  });

  testWidgets('BusyButtonGuard prevents duplicate submissions while busy', (
    WidgetTester tester,
  ) async {
    final Completer<void> completer = Completer<void>();
    int submitCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: BusyButtonGuard(
          onPressed: () async {
            submitCount += 1;
            await completer.future;
          },
          builder:
              (BuildContext context, bool isBusy, VoidCallback? onPressed) {
                return ElevatedButton(
                  onPressed: onPressed,
                  child: Text(isBusy ? 'Saving' : 'Save'),
                );
              },
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.tap(find.text('Saving'));
    await tester.pump();

    expect(submitCount, 1);

    completer.complete();
    await tester.pumpAndSettle();

    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('AppSnack shows feedback message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () => AppSnack.success(context, 'Saved'),
                child: const Text('Show'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump();

    expect(find.text('Saved'), findsOneWidget);
  });

  testWidgets('ConfirmActionDialog returns true when confirmed', (
    WidgetTester tester,
  ) async {
    bool? result;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () async {
                result = await ConfirmActionDialog.show(
                  context,
                  title: 'Delete item?',
                  message: 'This action cannot be undone.',
                  confirmLabel: 'Delete',
                  isDestructive: true,
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(result, isTrue);
  });

  testWidgets('AppTextFieldShell shows required label and validation text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppTextFieldShell(
            label: 'Email',
            isRequired: true,
            errorText: 'Email is required',
            counterText: '0/50',
            child: TextField(),
          ),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.text(' *'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('0/50'), findsOneWidget);
  });

  testWidgets('AccessibleIconButton exposes semantic label', (
    WidgetTester tester,
  ) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccessibleIconButton(
            semanticLabel: 'Close dialog',
            onPressed: () {},
            icon: const Icon(Icons.close),
          ),
        ),
      ),
    );

    expect(
      tester.getSemantics(find.byType(AccessibleIconButton)),
      matchesSemantics(
        label: 'Close dialog',
        hasTapAction: true,
        isButton: true,
        hasEnabledState: true,
        isEnabled: true,
      ),
    );

    handle.dispose();
  });

  testWidgets('StickyBottomActionBar lays out primary and secondary actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(child: SizedBox()),
              StickyBottomActionBar(
                secondary: OutlinedButton(onPressed: null, child: Text('Back')),
                child: FilledButton(onPressed: null, child: Text('Continue')),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('StateView failure can show retry action', (
    WidgetTester tester,
  ) async {
    int retryCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StateView<int>(
            state: const ViewState<int>.failure('Network error'),
            onRetry: () => retryCount += 1,
            dataBuilder: (BuildContext context, int value) {
              return Text('$value');
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Retry'));
    await tester.pump();

    expect(retryCount, 1);
  });
}
