import 'dart:convert';

import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:movie/feature/details/data/models/movie_details_model.dart';
import "package:http/http.dart" as http;
import 'package:movie/feature/details/data/models/related_movie_details_model.dart';



class DetailsApi {
  static const String _unhandledResponseCodeErrorMsg = "Unhandled Response Code:";
  static const String _movieDetailsEndpoint = '/3/movie/%i';
  static const String _similarMoviesEndpoint = '/3/movie/%i/similar';
  static const String _apiParamKeyName = 'api_key';

  static Future<ApiResult<T>> _handleReturnResult<T>(
    String endPoint,
    int movieId,
    T Function(Map<String, dynamic>) jsonConverter,
  ) async {
    try {
      endPoint = endPoint.replaceAll("%i", movieId.toString());
      Uri urlData = Uri.https(
        ApiConstants.baseUrl,
        endPoint,
        {_apiParamKeyName: ApiConstants.apiKey},
      );
      final response = await http.get(urlData);
      int statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 300) {
        final result = jsonDecode(response.body);
        return ApiSuccess(jsonConverter(result));
      }
      return ApiError("$_unhandledResponseCodeErrorMsg $statusCode");
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  static Future<ApiResult<MovieDetailsModel>> getMovieDetails(int movieId) async {
    return await _handleReturnResult<MovieDetailsModel>(
      _movieDetailsEndpoint,
      movieId,
      MovieDetailsModel.fromJson,
    );
  }

  static Future<ApiResult<RelatedMovieDetailsModel>> getRelatedMoviesToMovie(
    int movieId,
  ) async {
    return await _handleReturnResult<RelatedMovieDetailsModel>(
      _similarMoviesEndpoint,
      movieId,
      RelatedMovieDetailsModel.fromJson,
    );
  }

}
