import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _controller = TextEditingController();
  bool _submitted = false;

  void _submitFeedback() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _submitted = true;
      });
      // Simulasi pengiriman
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _controller.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black87;
    final buttonTextColor = Colors.white; // fix agar selalu kontras

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: isDark ? Colors.deepPurple.shade700 : Colors.deepPurple,
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Berikan masukan atau saran untuk pengembangan aplikasi.',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Tulis feedback Anda di sini...',
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _submitFeedback,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    '➤ Kirim',
                    style: TextStyle(
                      color: buttonTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_submitted)
              const Text(
                'Feedback telah dikirim!',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
