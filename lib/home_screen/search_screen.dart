import 'package:flutter/material.dart';
import 'package:route_news_app/models/NewsResponse.dart';
import 'package:route_news_app/news/news_details.dart';
import 'package:route_news_app/news/news_item.dart';
import 'package:route_news_app/utils/api_manager.dart';
import 'package:route_news_app/utils/theme.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
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
              controller: searchController = TextEditingController(),
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
                    ApiManager.searchForNews(searchController.text);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.search,
                    color: MyTheme.primaryColor,
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: MyTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder<NewsResponse>(
          future: ApiManager.searchForNews(searchController.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ),
              );
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
            var newsList = snapshot.data?.articles ?? null;
            return ListView.builder(
              itemCount: newsList!.length,
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
        ),
      ),
    );
  }
}
