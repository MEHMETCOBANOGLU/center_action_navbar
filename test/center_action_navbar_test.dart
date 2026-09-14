import 'package:center_action_navbar/center_action_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const items = [
    CenterActionNavbarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    CenterActionNavbarItem(
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
      label: 'Modules',
    ),
    CenterActionNavbarItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Messages',
    ),
    CenterActionNavbarItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: const SizedBox.expand(), bottomNavigationBar: child),
    );
  }

  testWidgets('renders without throwing on minimal usage', (tester) async {
    await tester.pumpWidget(
      wrap(
        CenterActionNavbar(
          currentIndex: 0,
          items: items,
          onTap: (_) {},
        ),
      ),
    );

    expect(find.byType(CenterActionNavbar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders navigation item labels when selected', (tester) async {
    await tester.pumpWidget(
      wrap(
        CenterActionNavbar(
          currentIndex: 0,
          items: items,
          onTap: (_) {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('calls onTap with the correct index', (tester) async {
    int? tapped;
    await tester.pumpWidget(
      wrap(
        CenterActionNavbar(
          currentIndex: 0,
          items: items,
          onTap: (index) => tapped = index,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await tester.pump();

    expect(tapped, 1);
  });

  testWidgets('calls onCenterActionTap when center button is pressed',
      (tester) async {
    var centerTapped = false;
    await tester.pumpWidget(
      wrap(
        CenterActionNavbar(
          currentIndex: 0,
          items: items,
          onTap: (_) {},
          centerAction: const Icon(Icons.add, key: Key('center-action')),
          onCenterActionTap: () => centerTapped = true,
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('center-action')));
    await tester.pump();

    expect(centerTapped, isTrue);
  });

  testWidgets('shows active icon for the selected item', (tester) async {
    await tester.pumpWidget(
      wrap(
        CenterActionNavbar(
          currentIndex: 2,
          items: items,
          onTap: (_) {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.chat_bubble), findsOneWidget);
    expect(find.byIcon(Icons.chat_bubble_outline), findsNothing);
    expect(find.text('Messages'), findsOneWidget);
  });

  testWidgets('updates selected item when currentIndex changes',
      (tester) async {
    var index = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: Text('index:$index'),
              bottomNavigationBar: CenterActionNavbar(
                currentIndex: index,
                items: items,
                onTap: (value) => setState(() => index = value),
              ),
            );
          },
        ),
      ),
    );

    expect(find.byIcon(Icons.home), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(index, 3);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('renders all provided item icons in idle state', (tester) async {
    await tester.pumpWidget(
      wrap(
        CenterActionNavbar(
          currentIndex: 0,
          items: items,
          onTap: (_) {},
        ),
      ),
    );

    expect(find.byIcon(Icons.home), findsOneWidget); // selected active
    expect(find.byIcon(Icons.grid_view_outlined), findsOneWidget);
    expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });
}
