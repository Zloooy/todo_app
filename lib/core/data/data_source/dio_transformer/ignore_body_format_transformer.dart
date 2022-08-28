import 'package:dio/dio.dart';

class IgnoreBodyFormatTransformer extends DefaultTransformer {
  static String _jsonMimeType = 'application/json';
  static String _emptyObject = '{}';

  @override
  Future<Object?> transformResponse(
      RequestOptions options, ResponseBody response) async {
    ResponseBody responseToReturn;
    if (response.statusCode == 200) {
      responseToReturn = response;
    } else {
      response.headers[Headers.contentTypeHeader] = [_jsonMimeType];
      responseToReturn = new ResponseBody.fromString(
          _emptyObject, response.statusCode,
          headers: response.headers);
    }
    return await super.transformResponse(options, responseToReturn);
  }
}
