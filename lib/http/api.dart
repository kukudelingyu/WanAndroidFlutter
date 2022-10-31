import 'package:flutter/foundation.dart';

class Api {
  static const baseUrl = kDebugMode ? 'https://www.wanandroid.com/' : 'https://www.wanandroid.com/';

  // 文章列表
  static const articleList = 'article/list/1/json';

  // 首页banner
  static const bannerList = 'banner/json';
}