import 'package:center_action_navbar/center_action_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CenterActionNavbarExampleApp());
}

/// Demo application for [CenterActionNavbar].
class CenterActionNavbarExampleApp extends StatelessWidget {
  /// Creates the example app.
  const CenterActionNavbarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Center Action Navbar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 145, 0),
        ),
      ),
      home: const ExampleHomePage(),
    );
  }
}

/// Home page that hosts the navbar and simple tab bodies.
class ExampleHomePage extends StatefulWidget {
  /// Creates the example home page.
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _currentIndex = 0;

  static const _titles = ['Home', 'Modules', 'Messages', 'Profile'];

  static const _items = [
    CenterActionNavbarItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    CenterActionNavbarItem(
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view_rounded,
      label: 'Modules',
    ),
    CenterActionNavbarItem(
      icon: Icons.chat_bubble_outline_rounded,
      activeIcon: Icons.chat_bubble_rounded,
      label: 'Messages',
      badge: 3,
    ),
    CenterActionNavbarItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final title in _titles) _ExamplePage(title: title),
        ],
      ),
      bottomNavigationBar: CenterActionNavbar(
        currentIndex: _currentIndex,
        items: _items,
        centerAction: const Icon(Icons.add_rounded),
        centerActionTooltip: 'Create',
        onCenterActionTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Center action tapped'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 1200),
            ),
          );
        },
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class _ExamplePage extends StatelessWidget {
  const _ExamplePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
