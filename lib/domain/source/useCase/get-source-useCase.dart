import 'package:route_news_app/data/repository/source/repository/source-repository-impl.dart';
import 'package:route_news_app/domain/source/repository/source-repository-contract.dart';

import '../../../models/SourceResponse.dart';

class GetSourcesUseCase {
  SourceRepositoryContract repositoryContract;

  GetSourcesUseCase({required this.repositoryContract});

  Future<SourceResponse?> invoke(String categoryId, String language) {
    return repositoryContract.getSources(categoryId, language);
  }
}

GetSourcesUseCase injectGetSourcesUseCase() {
  return GetSourcesUseCase(
      repositoryContract: injectSourceRepositoryContract());
}
