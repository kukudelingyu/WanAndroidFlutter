
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 首页-精选
class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("精选"),
      ),
    );
  }
}
