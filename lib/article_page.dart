import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wananzhuo_flutter/entity_article_dart.dart';
import 'package:wananzhuo_flutter/entity_banner_list.dart';
import 'package:banner_view/banner_view.dart';

import 'artical_item.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<StatefulWidget> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  final _scrollController = ScrollController();

  var isLoading = false;

  List<Datas> articles = [];

  List<BannerData> banners = [];

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
    Iterable<Future> futures = [_getArticleList(), _getBanners()];
    await Future.wait(futures);
    isLoading = false;
    setState(() {});
    return;
  }

  _getArticleList([bool updateUi = false]) async {
    var dio = Dio();
    Response<EntityArticleDart> response = await dio.get<EntityArticleDart>("https://www.wanandroid.com/article/list/1/json");
    if (response.statusCode == 200) {
      EntityArticleDart? entity = response.data;
      listTotalSize = entity?.data?.total == null ? 0 : (entity!.data!.total as int);
      if(curPage == 0) {
        articles.clear();
      }
      if(entity?.data?.datas != null) {
        curPage++;
        articles = entity!.data!.datas!;
      }
      if(updateUi) {
        setState(() {});
      }
    }
  }

  _getBanners() async {
    var dio = Dio();
    Response<EntityBannerList> response = await dio.get<EntityBannerList>("https://www.wanandroid.com/banner/json");
    if(response.statusCode == 200 && response.data?.data != null) {
      EntityBannerList? entity = response.data;
      banners = entity!.data!;
    }
  }

  Widget? _bannerView() {
    var list = banners.map((e) => Image.network(e.url == null ? "" : e.url!, fit: BoxFit.cover)).toList();
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
