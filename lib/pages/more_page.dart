import 'package:flutter/material.dart';
import 'about_page.dart';
import 'feedback_page.dart';
import 'settings_page.dart';
import 'help_page.dart';


class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lainnya'),
        backgroundColor: isDarkMode ? Colors.deepPurple[700] : Colors.deepPurple,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'Tentang Kami',
            subtitle: 'Informasi tentang aplikasi dan pembuat',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
            textColor: textColor,
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.feedback_outlined,
            title: 'Feedback',
            subtitle: 'Kirim masukan dan saran',
            onTap: () {
            Navigator.push(
            context,
             MaterialPageRoute(builder: (context) => const FeedbackPage()),
             );
            },
            textColor: textColor,
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            subtitle: 'Sesuaikan aplikasi sesuai keinginan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            textColor: textColor,
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: 'Bantuan',
            subtitle: 'Panduan penggunaan aplikasi',
            onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpPage()),
             );
            },
            textColor: textColor,
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.logout,
            title: 'Keluar',
            subtitle: 'Keluar dari aplikasi',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Keluar belum tersedia')),
              );
            },
            textColor: textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color textColor,
  }) {
    return Material(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[850]
          : Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: Colors.deepPurple.withOpacity(0.3),
        highlightColor: Colors.deepPurple.withOpacity(0.1),
        child: ListTile(
          leading: Icon(icon, color: Colors.deepPurple),
          title: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: textColor.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      ),
    );
  }
}