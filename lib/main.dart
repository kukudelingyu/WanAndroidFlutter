

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wananzhuo_flutter/artical/article_page.dart';
import 'package:wananzhuo_flutter/collection/collection_page.dart';
import 'package:wananzhuo_flutter/mine/mind_page.dart';
import 'package:wananzhuo_flutter/recommend/recommend_page.dart';

void main() {
  runApp(const ArticleApp());
}

class ArticleApp extends StatelessWidget {
  const ArticleApp({super.key});

  Widget _builder(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text(
          "文章",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ArticlePage(),
      bottomNavigationBar: _createBottomNavigationBar(context),
    );
  }
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        routes: {
          "/recommendPage": (context) {
            return RecommendPage();
          },
          "/collectionPage": (context) {
            return CollectionPage();
          },
          "/minePage": (context) {
            return MinePage();
          },
        },
        home: Builder(builder: _builder,),
      );
  }

}

Widget _createBottomNavigationBar(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      minHeight: 50,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _createFirstBar(),
        _createRecommendBar(context),
        _createCollectionBar(context),
        _createMineBar(context),
      ],
    ),
  );
}

Widget _createFirstBar() {
  return Container(
    child: GestureDetector(
      onTap: _firstClick,
      child: Text("首页"),
    ),
  );
}

_firstClick() {
  print('首页点击');
}

/// 精选
Widget _createRecommendBar(BuildContext context) {
  return InkWell(
    child: Text("精选"),
    onTap: () {
      Navigator.pushNamed(context, "/recommendPage");
    },
  );
}

/// 收藏
Widget _createCollectionBar(context) {
  return InkWell(
    child: Text("收藏"),
    onTap: () {
      Navigator.pushNamed(context, "/collectionPage");
    },
  );
}

/// 我的
Widget _createMineBar(context) {
  return Container(
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/minePage");
      },
      child: Text("我的"),
    ),
  );
}
