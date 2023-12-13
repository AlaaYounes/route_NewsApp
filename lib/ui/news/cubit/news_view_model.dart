import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/domain/news/useCase/get-news-useCase.dart';
import 'package:route_news_app/domain/news/useCase/search-for-news-useCase.dart';
import 'package:route_news_app/ui/news/cubit/news_states.dart';

class NewsViewModel extends Cubit<NewsStates> {
  GetNewsUseCase? getNewsUseCase;
  SearchForNewsUseCase? searchForNewsUseCase;

  NewsViewModel({this.getNewsUseCase, this.searchForNewsUseCase})
      : super(NewsLoadingState());
  int selectedIndex = 0;

  getNews({String? sourceId}) async {
    try {
      emit(NewsLoadingState());
      var response = await getNewsUseCase?.invoke(sourceId!);
      if (response!.status == 'error') {
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
      emit(NewsInitialState());
      var response = await searchForNewsUseCase?.invoke(searchKey);
      if (response!.status == 'error') {
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
    emit(NewsSelectTabState(selectedIndex));
  }
}
