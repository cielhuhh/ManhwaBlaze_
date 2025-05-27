import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/favorite_page.dart';
import 'pages/library_page.dart';
import 'pages/more_page.dart';
import 'providers/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ManhwaBlaze',
      themeMode: themeNotifier.themeMode,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    FavoritePage(),
    LibraryPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: isDarkMode ? Colors.white60 : Colors.grey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Pustaka'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Lainnya'),
        ],
      ),
    );
  }
}