import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wananzhuo_flutter/entity_article_dart.dart';
import 'package:wananzhuo_flutter/entity_banner_list.dart';
import 'package:banner_view/banner_view.dart';
import 'package:wananzhuo_flutter/http/api.dart';
import 'package:wananzhuo_flutter/http/dio_utils.dart';

import 'artical_item.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<StatefulWidget> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  final _scrollController = ScrollController();

  var isLoading = false;

  var articles = [];

  var banners = [];

  var listTotalSize = 0;

  var curPage = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      // 最大滑动范围
      var maxScrollValue = _scrollController.position.maxScrollExtent;
      // 获取当前位置的像素
      var curPixel = _scrollController.position.pixels;

      if (curPixel == maxScrollValue && articles.length < listTotalSize) {
        _getArticleList(true);
      }
    });
    _pullToRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Offstage(
            offstage: !isLoading,
            child: const Center(child: CircularProgressIndicator()),
          ),
          Offstage(
            offstage: isLoading,
            child: RefreshIndicator(
              onRefresh: _pullToRefresh,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, i) => _itemBuilder(i),
                controller: _scrollController,
              ),
            ),
          )
        ],
      );
  }

  Future<void> _pullToRefresh() async {
    isLoading = true;
    Iterable<Future> futures = [_getArticleList(),_getBanners()];
    await Future.wait(futures);
    isLoading = false;
    setState(() {});
    return;
  }

  _getArticleList([bool updateUi = false]) async {
    var response = await HttpUtils.instance.get(Api.articleList);
    if (response.success) {
      EntityArticleDart dart = EntityArticleDart.fromJson(response.data);
      listTotalSize = dart.total! as int;
      if(curPage == 0) {
        articles.clear();
      }
      print("数据获取成功----------------------------------------------------------------map=${response.data}");
      if(dart.datas != null) {
        curPage++;
        articles = dart.datas!;
        print("数据设置成功----------------------------------------------------------------");
      }
      if(updateUi) {
        setState(() {});
      }
    }
  }

  _getBanners() async {
    var response = await HttpUtils.instance.get(Api.bannerList);
    if(response.success) {
      banners = response.data!;
    }
  }

  Widget? _bannerView() {
    var list = banners.map((e) {
      return Image.network(e["imagePath"] ?? "", fit: BoxFit.cover);
    }).toList();
    print("e.type-------------------------${list}");
    return list.isEmpty ? null : BannerView(
      list,
      intervalDuration: const Duration(seconds: 3),
    );
  }

  Widget _itemBuilder(int index) {
    if(index == 0) {
      return Container(
        alignment: Alignment.center,
        height: 180.0,
        child: _bannerView(),
      );
    }
    var itemData = articles[index -1];
    return ArticleItem(itemData);
  }
}
