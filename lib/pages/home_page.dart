import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/comic.dart';
import '../pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Comic> filteredComics = [];
  Set<String> favoriteTitles = {};
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isLoading = true;

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

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    filteredComics = comics;
    searchController.addListener(_onSearchChanged);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredComics = comics
            .where((comic) => comic.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
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
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Widget _buildSearchBar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Cari komik...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    _onSearchChanged();
                  },
                )
              : null,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[900] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black87),
        onChanged: (_) => _onSearchChanged(),
      ),
    );
  }

  Widget _buildComicCardModern(Comic comic, bool isFavorite) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            comic: comic,
            isFavorite: isFavorite,
            onToggleFavorite: () => _toggleFavorite(comic.title),
          ),
        ),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  comic.imagePath,
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      comic.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      comic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () => _toggleFavorite(comic.title),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : filteredComics.isEmpty
                  ? Center(child: Text('Komik tidak ditemukan.'))
                  : ListView.builder(
                      itemCount: filteredComics.length,
                      itemBuilder: (context, index) {
                        final comic = filteredComics[index];
                        final isFavorite = favoriteTitles.contains(comic.title);
                        return _buildComicCardModern(comic, isFavorite);
                      },
                    ),
        ),
      ],
    );
  }
}
