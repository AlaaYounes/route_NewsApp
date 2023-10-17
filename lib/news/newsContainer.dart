import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/news/news_details.dart';
import 'package:route_news_app/news/news_item.dart';
import 'package:route_news_app/utils/api_manager.dart';
import 'package:route_news_app/utils/config_provider.dart';

class NewsContainer extends StatefulWidget {
  Source source;

  NewsContainer({required this.source});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  static const pageSize = 20;
  List<News> newsList = [];
  var pageKey = 0;
  final PagingController<int, News> pagingController =
      PagingController(firstPageKey: 0);

  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage();
    });
  }

  Future<void> _fetchPage() async {
    pageKey++;
    print(pageKey);
    try {
      final newsItems = await ApiManager.getNewsBySourceId(
          sourceId: widget.source.id!, page: pageKey, pageSize: pageSize);
      newsList = newsItems.articles!;
      final isLastPage = newsList.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newsList);
      } else {
        final nextPageKey = pageKey;
        pagingController.appendPage(newsList, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return FutureBuilder<NewsResponse>(
        future: ApiManager.getNewsBySourceId(sourceId: widget.source.id ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text('Something went wrong'),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('try again'),
                ),
              ],
            );
          } else if (snapshot.data?.status != 'ok') {
            return Column(
              children: [
                Text('Something went wrong'),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('try again'),
                ),
              ],
            );
          }
          var newsList = snapshot.data!.articles ?? [];
          return PagedListView<int, News>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<News>(
              itemBuilder: (context, item, index) {
                if (item.source! == widget.source) {
                  return SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    child: NewsItem(news: item),
                    onTap: () {
                      print(item.source!.id);
                      print(widget.source!.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetails(news: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );

          // return ListView.builder(
          //
          //   itemCount: newsList.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: InkWell(
          //         child: NewsItem(news: newsList[index]),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) =>
          //                       NewsDetails(news: newsList[index])));
          //         },
          //       ),
          //     );
          //   },
          // );
        });
  }

  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
