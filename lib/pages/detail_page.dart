import 'package:flutter/material.dart';
import '../models/comic.dart';
import 'reader_page.dart';

class DetailPage extends StatelessWidget {
  final Comic comic;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailPage({
    Key? key,
    required this.comic,
    required this.isFavorite,
    required this.onToggleFavorite,
  }) : super(key: key);

  String getSynopsis(String title) {
    final t = title.toLowerCase();
    if (t.contains('omniscient')) {
      return "Kim Dokja adalah satu-satunya orang yang membaca webnovel misterius hingga tamat. Ketika dunia berubah sesuai novel tersebut, ia menjadi satu-satunya orang yang tahu apa yang akan terjadi selanjutnya. Ia harus bertahan hidup di dunia yang dikuasai oleh skenario mematikan.";
    } else if (t.contains('eleceed')) {
      return "Jiwoo adalah remaja dengan kecepatan super yang menyelamatkan hewan dan orang-orang di sekitarnya. Ia dilatih oleh Kayden, seorang awakener legendaris yang terjebak dalam tubuh kucing. Mereka bersama menghadapi organisasi jahat dan pengguna kekuatan lainnya.";
    } else if (t.contains('solo leveling')) {
      return "Sung Jin-Woo, yang dikenal sebagai hunter terlemah, secara misterius memperoleh kekuatan dari 'sistem' yang memungkinkannya naik level dan menjadi jauh lebih kuat. Dari yang diremehkan, ia berubah menjadi hunter terkuat di dunia, menghadapi berbagai dungeon mematikan.";
    } else if (t.contains('reincarnator')) {
      return "Ketika umat manusia berada di ambang kepunahan karena invasi makhluk lain, seorang pria memutuskan untuk kembali ke masa lalu menggunakan alat khusus demi mengubah takdir. Ia membangun kekuatan dan sekutu untuk menyelamatkan masa depan.";
    } else if (t.contains('how to live as a villain')) {
      return "Seorang pria biasa tiba-tiba diculik ke dunia fantasi dan dipaksa berperan sebagai villain. Dengan kecerdikan dan keuletannya, ia harus bertahan dan memanipulasi sistem dunia baru itu demi bertahan hidup dan mencapai puncak kekuasaan.";
    } else if (t.contains('reality quest')) {
      return "Ha Do-wan dipaksa memainkan game brutal setelah koma karena bullying. Dalam dunia virtual ini, ia harus menyelesaikan misi-misi penuh bahaya untuk bisa kembali ke dunia nyata. Namun batas antara realitas dan dunia virtual mulai kabur.";
    } else if (t.contains('world after the fall')) {
      return "Setelah munculnya Tower of Nightmares, umat manusia gagal mempertahankannya. Hanya satu pria yang menolak kembali ke dunia semula dan bertahan sendiri, lalu membentuk dunia baru dari reruntuhan peradaban manusia.";
    } else if (t.contains("lazy boss")) {
      return "Sebuah dungeon dipenuhi oleh petarung elit dan monster kuat, namun boss terakhirnya adalah makhluk pemalas. Ternyata di balik kemalasannya tersembunyi kekuatan tak terhingga yang bisa menghancurkan siapa pun.";
    } else {
      return "Tidak ada sinopsis yang tersedia untuk komik ini.";
    }
  }

  List<String> generateImagePaths(String title, int pageCount) {
    String baseTitle = title.toLowerCase().replaceAll(' ', '_');
    return List.generate(
      pageCount,
      (index) => 'assets/images/${baseTitle}_${index + 1}.jpg',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final synopsis = getSynopsis(comic.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: onToggleFavorite,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              comic.imagePath,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(comic.title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          _infoRow("Status", "Berjalan"),
          _infoRow("Genre", "Action, Fantasy"),
          _infoRow("Tipe", "Manhwa"),
          _infoRow("Studio", "Beragam Studio"),
          _infoRow("Rating", "7.0 ★"),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReaderPage(
                    title: comic.title,
                    imagePaths: generateImagePaths(comic.title, 5),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.menu_book),
            label: const Text("Baca Sekarang"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              shadowColor: Colors.deepPurpleAccent.withAlpha(150),
            ),
          ),
          const SizedBox(height: 24),
          Text("Sinopsis", style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            synopsis,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}