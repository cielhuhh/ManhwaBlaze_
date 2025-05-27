import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
  }

  void _toggleTheme(bool value) async {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() => isDarkMode = value);

    if (value) {
      themeNotifier.setDarkMode();
      await prefs.setBool('isDarkMode', true);
    } else {
      themeNotifier.setLightMode();
      await prefs.setBool('isDarkMode', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: isDark ? Colors.deepPurple[700] : Colors.deepPurple,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            title: const Text('Mode Gelap'),
            subtitle: const Text('Aktifkan tampilan gelap untuk kenyamanan mata'),
            trailing: Switch.adaptive(
              value: isDarkMode,
              onChanged: _toggleTheme,
              activeColor: Colors.deepPurple,
            ),
          ),
          const Divider(height: 32),
          ListTile(
            title: const Text('Notifikasi'),
            subtitle: const Text('Fitur belum tersedia'),
            trailing: Icon(Icons.notifications_none, color: isDark ? Colors.white54 : Colors.black54),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Notifikasi belum tersedia')),
              );
            },
          ),
        ],
      ),
    );
  }
}