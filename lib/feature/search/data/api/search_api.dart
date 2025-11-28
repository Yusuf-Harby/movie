import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/search/data/models/search_result_model.dart';

class SearchApiServcies {
  static final String searhEndpoint = "/3/search/movie";

  static Future<ApiResult<SearchModel>> getSearchMovie(String query) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, searhEndpoint, {
        'api_key': ApiConstants.apiKey,
        'query': query,
      });

      final response = await http.get(url);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode <= 299) {
        return ApiSuccess(SearchModel.fromJson(json));
      } else {
        return ApiError("Error From Server");
      }
    } catch (e) {
      return ApiError(e.toString());
    }
  }
}
