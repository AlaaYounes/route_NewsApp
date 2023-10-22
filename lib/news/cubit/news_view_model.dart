import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/news/cubit/news_states.dart';
import 'package:route_news_app/utils/api_manager.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsViewModel() : super(NewsLoadingState());
  int selectedIndex = 0;

  getNews({String? sourceId, String? searchKey}) async {
    try {
      var response = await ApiManager.getNewsBySourceId(sourceId: sourceId!);
      if (response.status == 'error') {
        emit(NewsErrorState(errorMessage: response.message));
      } else {
        emit(NewsSuccessState(newsList: response.articles));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: 'Error loading news.'));
    }
  }

  searchForNews(String searchKey) async {
    try {
      var response = await ApiManager.searchForNews(searchKey);
      if (response.status == 'error') {
        emit(NewsErrorState(errorMessage: response.message));
      } else {
        emit(NewsSearchSuccessState(newsList: response.articles));
      }
    } catch (e) {
      emit(NewsErrorState(errorMessage: 'Error loading news.'));
    }
  }

  void selectTab(index) {
    selectedIndex = index;
    emit(NewsSelectTabState());
  }
}
