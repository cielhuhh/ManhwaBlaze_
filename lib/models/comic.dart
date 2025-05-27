class Comic {
  final String title;
  final String description;
  final String imagePath;
  final int chapterCount;
  final List<String> imageUrls;

  Comic({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.chapterCount,
    required this.imageUrls,
  });
}