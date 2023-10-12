import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/news/news_details.dart';
import 'package:route_news_app/news/news_item.dart';
import 'package:route_news_app/utils/api_manager.dart';
import 'package:route_news_app/utils/config_provider.dart';

class NewsContainer extends StatelessWidget {
  Source source;

  NewsContainer({required this.source});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsBySourceId(source.id ?? ''),
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
        var newsList = snapshot.data?.articles ?? [];
        return ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                child: NewsItem(news: newsList[index]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewsDetails(news: newsList[index])));
                },
              ),
            );
          },
        );
      },
    );
  }
}
