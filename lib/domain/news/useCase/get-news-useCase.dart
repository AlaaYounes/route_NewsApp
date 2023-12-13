import 'package:route_news_app/data/repository/news/repository/news-repository-impl.dart';
import 'package:route_news_app/domain/news/repository/news-repository-contract.dart';
import 'package:route_news_app/models/NewsResponse.dart';

class GetNewsUseCase {
  NewsRepositoryContract repositoryContract;

  GetNewsUseCase({required this.repositoryContract});

  Future<NewsResponse> invoke(String sourceId) {
    return repositoryContract.getNews(sourceId);
  }
}

GetNewsUseCase injectGetNewsUseCase() {
  return GetNewsUseCase(repositoryContract: injectNewsRepositoryContract());
}
