import 'package:route_news_app/domain/news/repository/news-repository-contract.dart';
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/utils/api_manager.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSourceContract {
  ApiManager apiManager;

  NewsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<NewsResponse> getNews(String sourceId) async {
    var response = await apiManager.getNewsBySourceId(sourceId: sourceId);
    return response;
  }

  @override
  Future<NewsResponse> searchForNews(String searchKey) async {
    var response = await apiManager.searchForNews(searchKey);
    return response;
  }
}

NewsRemoteDataSourceContract injectNewsRemoteDataSourceContract() {
  return NewsRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
