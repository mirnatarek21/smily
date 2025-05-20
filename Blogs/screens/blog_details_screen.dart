// /lib/screens/blog_details_screen.dart

import 'package:flutter/material.dart';
import 'package:smily/constants.dart';

class BlogDetailsScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String content;

  const BlogDetailsScreen({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.6),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
