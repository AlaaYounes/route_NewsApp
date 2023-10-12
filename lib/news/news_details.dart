import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/news/view_full_article.dart';
import 'package:route_news_app/utils/theme.dart';

class NewsDetails extends StatelessWidget {
  static String routeName = 'News-details';
  News news;

  NewsDetails({required this.news});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/main_background.png',
            ),
            fit: BoxFit.cover),
        color: MyTheme.whiteColor,
      ),
      width: double.infinity,
      height: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: news.urlToImage!,
                placeholder: (context, url) => CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news.author ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                news.content ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: MyTheme.greyColor),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewArticle(url: news.url ?? '')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View full article',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                    Icon(Icons.arrow_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
