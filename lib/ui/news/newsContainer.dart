import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:route_news_app/domain/news/useCase/get-news-useCase.dart';
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/ui/news/cubit/news_states.dart';
import 'package:route_news_app/ui/news/cubit/news_view_model.dart';
import 'package:route_news_app/ui/news/news_details.dart';
import 'package:route_news_app/ui/news/news_item.dart';
import 'package:route_news_app/utils/theme.dart';

class NewsContainer extends StatefulWidget {
  Source source;

  NewsContainer({required this.source});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  NewsViewModel viewModel =
      NewsViewModel(getNewsUseCase: injectGetNewsUseCase());
  static const pageSize = 20;
  var pageKey = 0;
  final PagingController<int, News> pagingController =
      PagingController(firstPageKey: 0);

  void initState() {
    super.initState();
    viewModel.getNews(sourceId: widget.source.id);
    // pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage();
    // });
  }

  // Future<void> _fetchPage() async {
  //   pageKey++;
  //   print(pageKey);
  //   try {
  //     final newsItems = await ApiManager.getNewsBySourceId(
  //         sourceId: widget.source.id!, page: pageKey, pageSize: pageSize);
  //     viewModel.state.newsList = newsItems.articles!;
  //     final isLastPage = viewModel.newsList!.length < pageSize;
  //     if (isLastPage) {
  //       pagingController.appendLastPage(viewModel.newsList!);
  //     } else {
  //       final nextPageKey = pageKey;
  //       pagingController.appendPage(viewModel.newsList!, nextPageKey);
  //     }
  //   } catch (error) {
  //     pagingController.error = error;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    viewModel.getNews(sourceId: widget.source.id);
    return BlocConsumer<NewsViewModel, NewsStates>(
      bloc: viewModel,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: MyTheme.primaryColor,
            ),
          );
        } else if (state is NewsErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.errorMessage!),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.getNews(sourceId: widget.source.id);
                },
                child: Text('try again'),
              ),
            ],
          );
        } else if (state is NewsSuccessState) {
          return ListView.builder(
            itemCount: state.newsList!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: NewsItem(news: state.newsList![index]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewsDetails(news: state.newsList![index])));
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: MyTheme.primaryColor,
            ),
          );
        }
      },
    );
    //   ChangeNotifierProvider(
    //   create: (context) => viewModel,
    //   child: Consumer<NewsViewModel>(
    //     builder: (context, viewModel, child) {
    //       if(viewModel.errorMessage != null){
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(viewModel.errorMessage!),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 viewModel.getNews(sourceId: widget.source.id);
    //               },
    //               child: Text('try again'),
    //             ),
    //           ],
    //         );
    //       }
    //       else if(viewModel.newsList == null){
    //         return Center(
    //             child: CircularProgressIndicator(
    //               color: MyTheme.primaryColor,
    //             ));
    //       }
    //       else {
    //         //  return PagedListView<int, News>(
    //         //   pagingController: pagingController,
    //         //   builderDelegate: PagedChildBuilderDelegate<News>(
    //         //     itemBuilder: (context, item, index) {
    //         //       if (item.source! == widget.source) {
    //         //         return SizedBox();
    //         //       }
    //         //       return Padding(
    //         //         padding: const EdgeInsets.all(10.0),
    //         //         child: InkWell(
    //         //           child: NewsItem(news: item),
    //         //           onTap: () {
    //         //             print(item.source!.id);
    //         //             print(widget.source!.id);
    //         //             Navigator.push(
    //         //               context,
    //         //               MaterialPageRoute(
    //         //                 builder: (context) => NewsDetails(news: item),
    //         //               ),
    //         //             );
    //         //           },
    //         //         ),
    //         //       );
    //         //     },
    //         //   ),
    //         // );
    //         return ListView.builder(
    //
    //               itemCount: viewModel.newsList!.length,
    //               itemBuilder: (context, index) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: InkWell(
    //                     child: NewsItem(news: viewModel.newsList![index]),
    //                     onTap: () {
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) =>
    //                                   NewsDetails(news: viewModel.newsList![index])));
    //                     },
    //                   ),
    //                 );
    //               },
    //             );
    //       }
    //     },
    //
    //   ),
    // );

    // FutureBuilder<NewsResponse>(
    //     future: ApiManager.getNewsBySourceId(sourceId: widget.source.id ?? ''),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //             child: CircularProgressIndicator(
    //           color: Theme.of(context).primaryColor,
    //         ));
    //       } else if (snapshot.hasError) {
    //         return Column(
    //           children: [
    //             Text('Something went wrong'),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             ElevatedButton(
    //               onPressed: () {},
    //               child: Text('try again'),
    //             ),
    //           ],
    //         );
    //       } else if (snapshot.data?.status != 'ok') {
    //         return Column(
    //           children: [
    //             Text('Something went wrong'),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             ElevatedButton(
    //               onPressed: () {},
    //               child: Text('try again'),
    //             ),
    //           ],
    //         );
    //       }
    //       var newsList = snapshot.data!.articles ?? [];
    //       return PagedListView<int, News>(
    //         pagingController: pagingController,
    //         builderDelegate: PagedChildBuilderDelegate<News>(
    //           itemBuilder: (context, item, index) {
    //             if (item.source! == widget.source) {
    //               return SizedBox();
    //             }
    //             return Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: InkWell(
    //                 child: NewsItem(news: item),
    //                 onTap: () {
    //                   print(item.source!.id);
    //                   print(widget.source!.id);
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => NewsDetails(news: item),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //
    //       // return ListView.builder(
    //       //
    //       //   itemCount: newsList.length,
    //       //   itemBuilder: (context, index) {
    //       //     return Padding(
    //       //       padding: const EdgeInsets.all(10.0),
    //       //       child: InkWell(
    //       //         child: NewsItem(news: newsList[index]),
    //       //         onTap: () {
    //       //           Navigator.push(
    //       //               context,
    //       //               MaterialPageRoute(
    //       //                   builder: (context) =>
    //       //                       NewsDetails(news: newsList[index])));
    //       //         },
    //       //       ),
    //       //     );
    //       //   },
    //       // );
    //     });
  }

  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
