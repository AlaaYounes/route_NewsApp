import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/repository/news/dataSource/news-remote-dataSource-impl.dart';
import 'package:route_news_app/repository/news/repository/news-repository-contract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract {
  NewsRemoteDataSourceContract remoteSourceDataSourceContract;

  NewsRepositoryImpl({required this.remoteSourceDataSourceContract});

  @override
  Future<NewsResponse> getNews(String sourceId) async {
    return await remoteSourceDataSourceContract.getNews(sourceId);
  }

  @override
  Future<NewsResponse> searchForNews(String searchKey) async {
    return await remoteSourceDataSourceContract.searchForNews(searchKey);
  }
}

injectNewsRepositoryContract() {
  return NewsRepositoryImpl(
      remoteSourceDataSourceContract: injectNewsRemoteDataSourceContract());
}
