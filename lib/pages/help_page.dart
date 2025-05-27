import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(
            'Panduan Penggunaan Aplikasi',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          _buildHelpItem(
            context,
            icon: Icons.home,
            title: 'Beranda',
            description:
                'Menampilkan daftar komik manhwa. Kamu bisa mencari judul komik di kolom pencarian dan menandai favorit.',
          ),
          _buildHelpItem(
            context,
            icon: Icons.favorite,
            title: 'Favorit',
            description:
                'Menampilkan daftar komik yang kamu tandai sebagai favorit. Gunakan ikon hati untuk menambah atau menghapus dari favorit.',
          ),
          _buildHelpItem(
            context,
            icon: Icons.library_books,
            title: 'Pustaka',
            description: 'Halaman ini memuat koleksi bacaan yang pernah kamu buka.',
          ),
          _buildHelpItem(
            context,
            icon: Icons.more_horiz,
            title: 'Lainnya',
            description:
                'Berisi menu tambahan seperti Pengaturan, Tentang Kami, Bantuan, dan Feedback.',
          ),
          _buildHelpItem(
            context,
            icon: Icons.nightlight_round,
            title: 'Mode Gelap/Terang',
            description:
                'Kamu bisa mengubah tampilan aplikasi menjadi mode gelap atau terang dari halaman Pengaturan.',
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = theme.colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: baseColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: baseColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: baseColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
