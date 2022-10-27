import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wananzhuo_flutter/article_page.dart';

void main() {
  runApp(const ArticleApp());
}

class ArticleApp extends StatelessWidget {
  const ArticleApp({super.key});
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold (
          appBar: AppBar(
            title: const Text(
                "文章",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ArticlePage(),
        ),
      );
  } //2070028639

}
