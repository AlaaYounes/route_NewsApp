import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_news_app/domain/news/useCase/search-for-news-useCase.dart';
import 'package:route_news_app/ui/news/cubit/news_states.dart';
import 'package:route_news_app/ui/news/cubit/news_view_model.dart';
import 'package:route_news_app/ui/news/news_details.dart';
import 'package:route_news_app/ui/news/news_item.dart';
import 'package:route_news_app/utils/theme.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NewsViewModel viewModel =
      NewsViewModel(searchForNewsUseCase: injectSearchForNewsUseCase());

  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.searchForNews(searchController.text);
  }

  @override
  @override
  var searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/main_background.png'), fit: BoxFit.cover),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                fillColor: MyTheme.whiteColor,
                filled: true,
                hintText: 'Search article',
                hintStyle: Theme.of(context).textTheme.bodySmall,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    borderSide: BorderSide(color: Colors.white)),
                suffixIcon: IconButton(
                  onPressed: () {
                    viewModel.searchForNews(searchController.text);
                  },
                  icon: Icon(
                    Icons.search,
                    color: MyTheme.primaryColor,
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    searchController.text = '';
                  },
                  icon: Icon(
                    Icons.close,
                    color: MyTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<NewsViewModel, NewsStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ),
              );
            } else if (state is NewsErrorState) {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('News is not found.'),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              );
            } else if (state is NewsSearchSuccessState) {
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Search for something.'),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              );
            }
          },
        ),

        // FutureBuilder<NewsResponse>(
        //   future:
        //       ApiManager.getNewsBySourceId(searchKey: searchController.text),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(
        //           color: MyTheme.primaryColor,
        //         ),
        //       );
        //     } else if (snapshot.hasError) {
        //       return Column(
        //         children: [
        //           Text('Something went wrong'),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           ElevatedButton(
        //             onPressed: () {},
        //             child: Text('try again'),
        //           ),
        //         ],
        //       );
        //     } else if (snapshot.data?.status != 'ok') {
        //       return Column(
        //         children: [
        //           Text('Something went wrong'),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           ElevatedButton(
        //             onPressed: () {},
        //             child: Text('try again'),
        //           ),
        //         ],
        //       );
        //     }
        //     var newsList = snapshot.data?.articles ?? null;
        //     return ListView.builder(
        //       itemCount: newsList!.length,
        //       itemBuilder: (context, index) {
        //         return Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: InkWell(
        //             child: NewsItem(news: newsList[index]),
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           NewsDetails(news: newsList[index])));
        //             },
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
