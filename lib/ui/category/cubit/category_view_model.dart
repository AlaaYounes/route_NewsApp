import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/domain/source/useCase/get-source-useCase.dart';
import 'package:route_news_app/ui/category/cubit/category_states.dart';

class CategoryViewModel extends Cubit<CategoryStates> {
  GetSourcesUseCase getSourcesUseCase;

  CategoryViewModel(this.getSourcesUseCase) : super(CategoryLoadingState());

  getSources(String categoryId, String language) async {
    try {
      var response = await getSourcesUseCase.invoke(categoryId, language);
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
