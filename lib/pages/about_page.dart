import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final bgColor = isDark ? Colors.grey[900] : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.book, size: 64, color: Colors.deepPurple),
                  const SizedBox(height: 12),
                  Text(
                    'ManhwaBlaze',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Versi 1.0.0',
                    style: TextStyle(color: textColor.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Tentang Kami',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ManhwaBlaze adalah aplikasi baca manhwa digital yang dikembangkan untuk memberikan pengalaman membaca yang menyenangkan dan interaktif bagi para penggemar komik Korea. Dengan fitur favorit, tema gelap/terang, dan antarmuka modern, kami berharap Anda menikmati setiap halaman cerita.',
              style: TextStyle(color: textColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              'Pengembang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dikembangkan oleh Ciel sebagai bagian dari proyek Flutter. Semua aset gambar digunakan hanya untuk keperluan pengembangan pribadi/akademik.',
              style: TextStyle(color: textColor),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}