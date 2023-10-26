import 'package:route_news_app/data/repository/source/dataSource/source-remote-dataSource-impl.dart';
import 'package:route_news_app/domain/source/repository/source-repository-contract.dart';
import 'package:route_news_app/models/SourceResponse.dart';

class SourceRepositoryImpl implements SourceRepositoryContract {
  SourceRemoteDataSourceContract remoteDataSourceContract;

  SourceRepositoryImpl({required this.remoteDataSourceContract});

  @override
  Future<SourceResponse?> getSources(String categoryId, String language) async {
    var response =
        await remoteDataSourceContract.getSources(categoryId, language);
    return response;
  }
}

SourceRepositoryContract injectSourceRepositoryContract() {
  return SourceRepositoryImpl(
      remoteDataSourceContract: injectSourceRemoteDataSourceContract());
}
