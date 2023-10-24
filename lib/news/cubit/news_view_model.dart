import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/news/cubit/news_states.dart';
import 'package:route_news_app/repository/news/repository/news-repository-contract.dart';

class NewsViewModel extends Cubit<NewsStates> {
  NewsRepositoryContract repositoryContract;

  NewsViewModel(this.repositoryContract) : super(NewsLoadingState());
  int selectedIndex = 0;

  getNews({String? sourceId}) async {
    try {
      emit(NewsLoadingState());
      var response = await repositoryContract.getNews(sourceId!);
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
      emit(NewsInitialState());
      var response = await repositoryContract.searchForNews(searchKey);
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
