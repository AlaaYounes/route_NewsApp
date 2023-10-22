import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/news/cubit/news_states.dart';
import 'package:route_news_app/news/cubit/news_view_model.dart';
import 'package:route_news_app/news/newsContainer.dart';
import 'package:route_news_app/tabs/tabItem.dart';

class TabContainer extends StatefulWidget {
  List<Source> sourcesList;

  TabContainer({required this.sourcesList});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int selectedIndex = 0;
  NewsViewModel viewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    // var newsProvider = Provider.of<NewsViewModel> (context);

    if (widget.sourcesList.isEmpty) {
      return SizedBox();
    }
    return BlocBuilder<NewsViewModel, NewsStates>(
        bloc: viewModel,
        builder: (BuildContext context, state) {
          return DefaultTabController(
            length: widget.sourcesList.length,
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    viewModel.selectTab(index);
                    selectedIndex = viewModel.selectedIndex;
                    print(viewModel.selectedIndex);
                    print(selectedIndex);
                  },
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  tabs: widget.sourcesList
                      .map((source) => TabItem(
                          source: source,
                          isSelected: selectedIndex ==
                                  widget.sourcesList.indexOf(source)
                              ? true
                              : false))
                      .toList(),
                ),
                Expanded(
                  child: NewsContainer(
                    source: widget.sourcesList[selectedIndex],
                  ),
                ),
              ],
            ),
          );
        });

    //   DefaultTabController(
    //   length: widget.sourcesList.length,
    //   child: Column(
    //     children: [
    //       TabBar(
    //         onTap: (index)=> newsProvider.selectTab(index),
    //         isScrollable: true,
    //         indicatorColor: Colors.transparent,
    //         tabs: widget.sourcesList
    //             .map(
    //               (source) => TabItem(
    //                   source: source,
    //                   isSelected: newsProvider.selectedIndex ==
    //                           widget.sourcesList.indexOf(source) ? true : false)).toList(),
    //       ),
    //       Expanded(
    //         child: NewsContainer(
    //           source: widget.sourcesList[newsProvider.selectedIndex],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
