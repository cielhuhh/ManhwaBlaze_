// lib/utils/shared_prefs.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const _favoritesKey = 'favorites';
  static const _themeKey = 'isDarkMode';

  /// Simpan daftar favorit
  static Future<void> saveFavorites(List<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, favorites);
  }

  /// Ambil daftar favorit
  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  /// Simpan status tema (true = gelap)
  static Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  /// Ambil status tema
  static Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // default = terang
  }
}
