import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ulash_blog/blog_post_screen.dart';
import 'dart:io';

import 'create_newblog_screen.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uzbek Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> blogs = [];

  void addBlog(String title, String content, File? image) {
    setState(() {
      blogs.add({"title": title, "content": content, "image": image});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Uzbek Blogs'),
      ),
      body: blogs.isEmpty
          ? const Center(child: Text('No blogs yet. Create one!'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: blogs[index]['image'] != null
                  ? Image.file(blogs[index]['image']!, width: 50, height: 50, fit: BoxFit.cover)
                  : null,
              title: Text(blogs[index]['title']),
              subtitle: Text(blogs[index]['content']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailScreen(blog: blogs[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateBlogScreen(),
            ),
          );
          if (result != null && result is Map<String, dynamic>) {
            addBlog(result['title'], result['content'], result['image']);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



