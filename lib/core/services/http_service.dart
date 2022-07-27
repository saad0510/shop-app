import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../enums/http_code.dart';
import '../errors/http_exception.dart';

class HttpService {
  final String baseUrl;
  final Duration timeout;

  HttpService({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 5),
  });

  Future<dynamic> get(String path) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      final response = await http.get(uri).timeout(timeout);
      _handleErrors(response);
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  void _handleErrors(http.Response response) {
    final url = response.request?.url;

    switch (response.statusCode) {
      case HttpCodes.OK:
      case HttpCodes.Accepted:
      case HttpCodes.Created:
        return;

      case HttpCodes.BadRequest:
        throw BadRequestException("$url");

      case HttpCodes.Unauthorized:
      case HttpCodes.Forbidden:
        throw UnauthorizedException("$url");

      case HttpCodes.NotFound:
        throw BadRequestException("$url");

      case HttpCodes.InternalServerError:
      case HttpCodes.ServiceUnavailable:
      case HttpCodes.GatewayTimeout:

      default:
        throw HttpException('UnknownException', response.statusCode, "$url");
    }
  }
}
