import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/models/SourceResponse.dart';

class ApiManager {
  /*
  33eacd736a304aac849338932f26826a
  https://newsapi.org/v2/top-headlines/sources?apiKey=9eb4b145df4b4e2da1d7d615c360ac21
  https://newsapi.org/v2/everything?q=bitcoin&apiKey=9eb4b145df4b4e2da1d7d615c360ac21
   */
  static String baseUrl = 'newsapi.org';
  static String sourceApi = '/v2/top-headlines/sources';
  static String newsApi = '/v2/everything';

  static Future<SourceResponse> getSources(
      String categoryId, String language) async {
    Uri url = Uri.https(
      baseUrl,
      sourceApi,
      {
        'apiKey': '9eb4b145df4b4e2da1d7d615c360ac21',
        'category': categoryId,
        'language': language,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> getNewsBySourceId({
    String sourceId = '',
    int? page,
    int pageSize = 20,
  }) async {
    Uri url = Uri.https(
      baseUrl,
      newsApi,
      {
        'apiKey': '9eb4b145df4b4e2da1d7d615c360ac21',
        'sources': sourceId,
        'page': '$page',
        'pageSize': '$pageSize'
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return NewsResponse.fromJson(json);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<NewsResponse> searchForNews(String searchKey) async {
    Uri url = Uri.https(
      baseUrl,
      newsApi,
      {
        'apiKey': '9eb4b145df4b4e2da1d7d615c360ac21',
        'q': searchKey,
      },
    );
    try {
      var response = await http.get(url);
      String bodyString = response.body;
      var json = jsonDecode(bodyString);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}

/// Convert Object => Json called (Serialization)
/// Convert Json => Object called (Deserialization)
