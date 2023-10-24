import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/repository/source/repository/source-repository-contract.dart';
import 'package:route_news_app/utils/api_manager.dart';

class SourceRemoteDataSourceImpl implements SourceRemoteDataSourceContract {
  ApiManager apiManager;

  SourceRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<SourceResponse?> getSources(String categoryId, String language) async {
    var response = await apiManager.getSources(categoryId, language);
    return response;
  }
}

SourceRemoteDataSourceContract injectSourceRemoteDataSourceContract() {
  return SourceRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
