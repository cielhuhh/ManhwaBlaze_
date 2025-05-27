import 'package:flutter/material.dart';

class ReaderPage extends StatefulWidget {
  final String title;
  final List<String> imagePaths;

  const ReaderPage({
    Key? key,
    required this.title,
    required this.imagePaths,
  }) : super(key: key);

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  bool isNightMode = false;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleNightMode() {
    setState(() {
      isNightMode = !isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = isNightMode ? Colors.black : Colors.white;
    final textColor = isNightMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          widget.title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isNightMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
              size: 28,
            ),
            tooltip: isNightMode ? 'Mode Terang' : 'Mode Gelap',
            onPressed: _toggleNightMode,
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return InteractiveViewer(
                maxScale: 4.0,
                child: Container(
                  color: bgColor,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.imagePaths[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),

          // Page indicator bottom center
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isNightMode ? Colors.white24 : Colors.black26,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Halaman ${_currentPage + 1} / ${widget.imagePaths.length}',
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}