import 'package:dio/dio.dart';

class BaseRepository {
  final Dio _dio;

  BaseRepository(this._dio);

  Future<ApiResponse> getRequest(String url, {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(url, queryParameters: queryParameters);
    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse> postRequest(String url, dynamic data) async {
    final response = await _dio.post(url, data: data);
    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse> postMultipartRequest(String url, FormData formData) async {
    final response = await _dio.post(
      url,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return ApiResponse.fromJson(response.data);
  }
}

class ApiResponse {
  final String status;
  final String message;
  final dynamic object;
  final Map<String, dynamic> data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.object,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status']?.toString() ?? "",
      message: json['message']?.toString() ?? "",
      object: json['object'] ?? json['data'],
      data: json,
    );
  }
}
