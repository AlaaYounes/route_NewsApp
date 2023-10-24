import 'package:route_news_app/models/SourceResponse.dart';

abstract class SourceRepositoryContract {
  Future<SourceResponse?> getSources(String categoryId, String language);
}

abstract class SourceRemoteDataSourceContract {
  Future<SourceResponse?> getSources(String categoryId, String language);
}
