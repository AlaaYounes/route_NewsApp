import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/models/category_model.dart';
import 'package:route_news_app/tabs/tabContainer.dart';
import 'package:route_news_app/tabs/tabItem.dart';
import 'package:route_news_app/utils/api_manager.dart';
import 'package:route_news_app/utils/config_provider.dart';

class CategoryDetails extends StatelessWidget {
  static String routeName = 'Category_Details';
  List<TabItem> tabsList = [];
  Category? category;

  CategoryDetails({this.category});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/main_background.png'), fit: BoxFit.cover),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: FutureBuilder<SourceResponse>(
          future: ApiManager.getSources(
              category?.id ?? '', configProvider.language),
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
                    child: Text(snapshot.data?.message ?? ''),
                  ),
                ],
              );
            }
            var sourcesList = snapshot.data?.sources ?? [];
            return TabContainer(sourcesList: sourcesList);
          },
        ),
      ),
    );
  }
}
