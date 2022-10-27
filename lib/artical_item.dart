
import 'package:flutter/cupertino.dart';
import 'package:wananzhuo_flutter/entity_article_dart.dart';

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
      child: Text(datas!.desc!),
    );
  }

}