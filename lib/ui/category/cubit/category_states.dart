import '../../../models/SourceResponse.dart';

abstract class CategoryStates {}

class CategoryLoadingState extends CategoryStates {}

class CategoryErrorState extends CategoryStates {
  String? errorMessage;

  CategoryErrorState({required this.errorMessage});
}

class CategorySuccessState extends CategoryStates {
  List<Source>? sourcesList;

  CategorySuccessState({required this.sourcesList});
}
