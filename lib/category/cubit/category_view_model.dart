import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/category/cubit/category_states.dart';

import '../../repository/source/repository/source-repository-contract.dart';

class CategoryViewModel extends Cubit<CategoryStates> {
  SourceRepositoryContract repositoryContract;

  CategoryViewModel(this.repositoryContract) : super(CategoryLoadingState());

  getSources(String categoryId, String language) async {
    try {
      var response = await repositoryContract.getSources(categoryId, language);
      if (response?.status == 'error') {
        emit(CategoryErrorState(errorMessage: response!.message));
      } else {
        emit(CategorySuccessState(sourcesList: response!.sources));
      }
    } catch (e) {
      emit(CategoryErrorState(errorMessage: 'Error while loading sources'));
    }
  }
}
