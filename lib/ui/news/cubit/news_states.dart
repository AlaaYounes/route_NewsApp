import 'package:route_news_app/models/NewsResponse.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsErrorState extends NewsStates {
  String? errorMessage;

  NewsErrorState({required this.errorMessage});
}

class NewsSuccessState extends NewsStates {
  List<News>? newsList;

  NewsSuccessState({required this.newsList});
}

class NewsSearchSuccessState extends NewsStates {
  List<News>? newsList;

  NewsSearchSuccessState({required this.newsList});
}

class NewsSelectTabState extends NewsStates {
  int selectedIndex = 0;

  NewsSelectTabState(this.selectedIndex);
}
