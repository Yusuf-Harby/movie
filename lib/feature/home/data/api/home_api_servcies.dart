import 'dart:convert';

import 'package:movie/core/constants/api_constants.dart';
import 'package:movie/core/network/api_result.dart';
import 'package:http/http.dart' as http;
import 'package:movie/feature/home/data/model/reccomended_movie_model.dart';
import 'package:movie/feature/home/data/model/releases_movie_model.dart';
import 'package:movie/feature/home/data/model/top_movie_model.dart';

abstract class HomeApiServcies {
  static final String _releaseEndPoint = "/3/movie/upcoming";
  static final String _recommendedEndPoint = "/3/movie/top_rated";
  static final String _topEndPoint = "/3/movie/popular";

  static Future<ApiResult<TopMovieModel>> getTopMovies() async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, _topEndPoint, {
        'api_key': ApiConstants.apiKey,
      });
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode <= 299) {
        return ApiSuccess(TopMovieModel.fromJson(json));
      } else {
        return ApiError("Error From Server");
      }
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  static Future<ApiResult<ReleasesMovieModel>> getReleasesMovies() async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, _releaseEndPoint, {
        'api_key': ApiConstants.apiKey,
      });
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode <= 299) {
        return ApiSuccess(ReleasesMovieModel.fromJson(json));
      } else {
        return ApiError("Error From Server");
      }
    } catch (e) {
      return ApiError(e.toString());
    }
  }

  static Future<ApiResult<RecommendedMovieModel>> getRecommendedMovies() async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, _recommendedEndPoint, {
        'api_key': ApiConstants.apiKey,
      });
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode <= 299) {
        return ApiSuccess(RecommendedMovieModel.fromJson(json));
      } else {
        return ApiError("Error From Server");
      }
    } catch (e) {
      return ApiError(e.toString());
    }
  }
}
