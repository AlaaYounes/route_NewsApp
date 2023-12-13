import 'package:route_news_app/data/repository/news/repository/news-repository-impl.dart';
import 'package:route_news_app/domain/news/repository/news-repository-contract.dart';
import 'package:route_news_app/models/NewsResponse.dart';

class SearchForNewsUseCase {
  NewsRepositoryContract repositoryContract;

  SearchForNewsUseCase({required this.repositoryContract});

  Future<NewsResponse> invoke(String searchKey) {
    return repositoryContract.searchForNews(searchKey);
  }
}

SearchForNewsUseCase injectSearchForNewsUseCase() {
  return SearchForNewsUseCase(
      repositoryContract: injectNewsRepositoryContract());
}
