import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/comic.dart';
import '../pages/detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Set<String> favoriteTitles = {};

  final List<Comic> allComics = [
    Comic(
      title: 'Solo Leveling',
      description: 'Sung Jin-Woo, hunter terlemah...',
      imagePath: 'assets/images/solo leveling.png',
      chapterCount: 51,
      imageUrls: ['assets/images/solo leveling.png'],
    ),
    Comic(
      title: 'Omniscient Reader Viewpoint',
      description: 'Kim Dokja satu-satunya pembaca...',
      imagePath: 'assets/images/omniscient.jpg',
      chapterCount: 48,
      imageUrls: ['assets/images/omniscient.jpg'],
    ),
    Comic(
      title: 'Eleceed',
      description: 'Jiwoo dan Kayden bertarung...',
      imagePath: 'assets/images/eleceed.jpg',
      chapterCount: 37,
      imageUrls: ['assets/images/eleceed.jpg'],
    ),
    Comic(
      title: 'Reincarnator',
      description: 'Seorang pria kembali ke masa lalu...',
      imagePath: 'assets/images/reincarnator.jpg',
      chapterCount: 42,
      imageUrls: ['assets/images/reincarnator.jpg'],
    ),
    Comic(
      title: 'How to Live as a Villain',
      description: 'Diculik ke dunia lain...',
      imagePath: 'assets/images/how to live as a villain.jpg',
      chapterCount: 33,
      imageUrls: ['assets/images/how to live as a villain.jpg'],
    ),
    Comic(
      title: 'Reality Quest',
      description: 'Ha Do-wan menjalani game brutal...',
      imagePath: 'assets/images/reality quest.jpg',
      chapterCount: 40,
      imageUrls: ['assets/images/reality quest.jpg'],
    ),
    Comic(
      title: 'The World After the Fall',
      description: 'Pria terakhir yang menolak kembali...',
      imagePath: 'assets/images/the world after the fall.jpg',
      chapterCount: 45,
      imageUrls: ['assets/images/the world after the fall.jpg'],
    ),
    Comic(
      title: "The Unbeatable Dungeon's Lazy Boss Monster",
      description: 'Sang boss dungeon pemalas...',
      imagePath: 'assets/images/the unbeatable dungeons lazy boss monster any similar.jpg',
      chapterCount: 30,
      imageUrls: ['assets/images/the unbeatable dungeons lazy boss monster any similar.jpg'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteTitles = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  void _toggleFavorite(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteTitles.contains(title)) {
        favoriteTitles.remove(title);
      } else {
        favoriteTitles.add(title);
      }
      prefs.setStringList('favorites', favoriteTitles.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final favoriteComics = allComics.where((comic) => favoriteTitles.contains(comic.title)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Saya'),
      ),
      body: favoriteComics.isEmpty
          ? Center(
              child: Text(
                'Belum ada komik favorit.',
                style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
              ),
            )
          : ListView.builder(
              itemCount: favoriteComics.length,
              itemBuilder: (context, index) {
                final comic = favoriteComics[index];
                final isFavorite = favoriteTitles.contains(comic.title);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        comic.imagePath,
                        width: 60,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(comic.title),
                    subtitle: Text(comic.description),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.redAccent : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(comic.title),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            comic: comic,
                            isFavorite: isFavorite,
                            onToggleFavorite: () => _toggleFavorite(comic.title),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}