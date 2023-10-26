import 'package:route_news_app/models/NewsResponse.dart';

abstract class NewsRepositoryContract {
  Future<NewsResponse> getNews(String sourceId);

  Future<NewsResponse> searchForNews(String searchKey);
}

abstract class NewsRemoteDataSourceContract {
  Future<NewsResponse> getNews(String sourceId);

  Future<NewsResponse> searchForNews(String searchKey);
}
