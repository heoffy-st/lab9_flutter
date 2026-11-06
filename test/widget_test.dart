import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:post_explorer/presentation/screens/posts_page.dart';
import 'package:post_explorer/presentation/state/post_state.dart';

import 'support/fake_post_repository.dart';

void main() {
  late FakePostRepository repository;

  setUp(() {
    repository = FakePostRepository();
  });

  Widget createTestWidget() {
    return ChangeNotifierProvider(
      create: (_) => PostState(repository: repository),
      child: const MaterialApp(home: PostsPage()),
    );
  }

  testWidgets('PostsPage displays application title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Post Explorer'), findsOneWidget);
  });

  testWidgets('PostsPage displays posts from repository', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Testing'), findsOneWidget);
    expect(find.text('Dart Programming'), findsOneWidget);
    expect(find.text('Mobile Development'), findsOneWidget);
  });

  testWidgets('Search filters posts by title', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Flutter');

    await tester.pumpAndSettle();

    expect(find.text('Flutter Testing'), findsOneWidget);
    expect(find.text('Dart Programming'), findsNothing);
    expect(find.text('Mobile Development'), findsNothing);
  });
}
