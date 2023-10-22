import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:route_news_app/category/cubit/category_states.dart';
import 'package:route_news_app/category/cubit/category_view_model.dart';
import 'package:route_news_app/models/category_model.dart';
import 'package:route_news_app/tabs/tabContainer.dart';
import 'package:route_news_app/utils/config_provider.dart';
import 'package:route_news_app/utils/theme.dart';

class CategoryDetails extends StatefulWidget {
  static String routeName = 'Category_Details';
  var configProvider;
  Category? category;

  CategoryDetails({this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryViewModel viewModel = CategoryViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.configProvider = Provider.of<ConfigProvider>(context, listen: false);
    viewModel.getSources(widget.category!.id!, widget.configProvider.language);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryViewModel, CategoryStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryColor,
              ),
            );
          } else if (state is CategoryErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage!),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.getSources(
                          widget.category!.id!, widget.configProvider.language);
                    },
                    child: Text('try again'),
                  ),
                ],
              ),
            );
          } else if (state is CategorySuccessState) {
            return TabContainer(sourcesList: state.sourcesList!);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.primaryColor,
              ),
            );
          }
        });

    //   ChangeNotifierProvider(
    //   create: (context) => viewModel,
    //   child: Consumer<CategoryViewModel>(
    //       builder: (context, viewModel, child){
    //     if (viewModel.errorMessage != null) {
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(viewModel.errorMessage!),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 viewModel.getSources(widget.category!.id!, widget.configProvider.language);
    //               },
    //               child: Text('try again'),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else if (viewModel.sourcesList == null) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: Theme.of(context).primaryColor,
    //         ),
    //       );
    //     } else {
    //       return TabContainer(sourcesList: viewModel.sourcesList!);
    //     }
    //   }),
    // );
  }
}
