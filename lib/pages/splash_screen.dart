import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  Future<void> _updatePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: isDark ? Colors.deepPurple[700] : Colors.deepPurple,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          _buildSwitchTile(
            title: 'Mode Gelap',
            subtitle: 'Aktifkan tampilan gelap',
            value: _isDarkMode,
            onChanged: (val) {
              setState(() {
                _isDarkMode = val;
              });
              _updatePreference('isDarkMode', val);
              // TODO: Terapkan tema global jika digunakan state management
            },
            textColor: textColor,
          ),
          const Divider(),
          _buildSwitchTile(
            title: 'Notifikasi',
            subtitle: 'Aktifkan pemberitahuan update',
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() {
                _notificationsEnabled = val;
              });
              _updatePreference('notifications', val);
            },
            textColor: textColor,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restore, color: Colors.deepPurple),
            title: Text('Reset Data',
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
            subtitle: Text('Hapus semua data favorit dan pengaturan',
                style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 13)),
            onTap: _resetData,
            trailing: const Icon(Icons.delete_forever, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required Color textColor,
  }) {
    return SwitchListTile(
      title: Text(title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
      subtitle:
          Text(subtitle, style: TextStyle(color: textColor.withOpacity(0.8))),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.deepPurple,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }

  Future<void> _resetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil direset.')),
    );
    setState(() {
      _isDarkMode = false;
      _notificationsEnabled = true;
    });
  }
}