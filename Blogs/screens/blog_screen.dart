// /lib/screens/blogs_screen.dart

import 'package:flutter/material.dart';
import '../data/blog_data.dart';
import '../data/blog_contents.dart';
import 'blog_details_screen.dart';
import '../widgets/blog_card.dart';

class BlogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المدونة')),
      body: ListView.builder(
        itemCount: blogData.length,
        itemBuilder: (context, index) {
          final blog = blogData[index];
          return BlogCard(
            title: blog.title,
            imagePath: blog.imagePath,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlogDetailsScreen(
                    title: blogContents[index].title,
                    imagePath: blogContents[index].imagePath,
                    content: blogContents[index].content,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
