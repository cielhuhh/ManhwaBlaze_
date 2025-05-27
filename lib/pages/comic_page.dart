import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/comic.dart';
import '../pages/detail_page.dart';
import '../widgets/comic_card.dart';
import '../widgets/shimmer_comic_card.dart';

class ComicPage extends StatefulWidget {
  @override
  _ComicPageState createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  final List<Comic> comics = [
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

  List<Comic> filteredComics = [];
  Set<String> favoriteTitles = {};
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    filteredComics = comics;
    searchController.addListener(_onSearchChanged);

    // Simulasi loading
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredComics = comics
            .where((comic) => comic.title.toLowerCase().contains(query))
            .toList();
      });
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

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteTitles = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Cari komik...',
            hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
            border: InputBorder.none,
          ),
          style: TextStyle(color: textColor),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.deepPurple,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: ShimmerComicCard(),
              ),
            )
          : filteredComics.isEmpty
              ? Center(
                  child: Text(
                    'Komik tidak ditemukan.',
                    style: TextStyle(color: textColor),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredComics.length,
                  itemBuilder: (context, index) {
                    final comic = filteredComics[index];
                    final isFavorite = favoriteTitles.contains(comic.title);

                    return ComicCard(
                      comic: comic,
                      isFavorite: isFavorite,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              comic: comic,
                              isFavorite: isFavorite,
                              onToggleFavorite: () => _toggleFavorite(comic.title),
                            ),
                          ),
                        );
                      },
                      onFavoriteTap: () => _toggleFavorite(comic.title),
                    );
                  },
                ),
    );
  }
}