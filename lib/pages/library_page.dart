import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pustaka'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Referensi & Sumber Aset',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            '• Gambar komik diambil dari sumber daring resmi dan digunakan hanya untuk tujuan edukasi.',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(height: 12),
          Text(
            '• Informasi dan sinopsis setiap manhwa ditulis berdasarkan konten asli dari situs resmi penerbit.',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(height: 12),
          Text(
            '• Aplikasi ini dibuat untuk tujuan pembelajaran Flutter dan tidak dimaksudkan untuk distribusi komersial.',
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
          ),
        ],
      ),
    );
  }
}