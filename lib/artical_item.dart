
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'entity_article_dart.dart';

class ArticleItem extends StatefulWidget {

  Datas? datas;
  ArticleItem(this.datas, {super.key});

  @override
  State<StatefulWidget> createState() => ArticleItemState(datas);
}

class ArticleItemState extends State<ArticleItem> {

  Datas? datas;
  ArticleItemState(this.datas);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Text(datas!.title!, style: TextStyle(color: Colors.red),),
    );
  }

}