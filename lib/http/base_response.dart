
import 'package:dio/dio.dart';

class BaseResponse {
  // 通用参数，可根据实际业务修改
  late int code;
  late String message;
  late dynamic data;
  // 业务请求是否成功
  late bool success;
  // Dio 返回的原始 Response 数据
  Response? ores;

  BaseResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.success,
    required this.ores,
  });

  BaseResponse.fromJson(dynamic json) {
    code = json?['errorCode'] ?? -1;
    message = json?['errorMsg'] ?? '';
    data = json?['data'] ?? '';
    success = code == 0 ? true : false;
  }
}