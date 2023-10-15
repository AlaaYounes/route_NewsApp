import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_news_app/category/category_container.dart';
import 'package:route_news_app/category/category_details.dart';
import 'package:route_news_app/home_screen/search_screen.dart';
import 'package:route_news_app/models/category_model.dart';
import 'package:route_news_app/settings/settings.dart';
import 'package:route_news_app/utils/theme.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'Home_Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    bool visibleSearch = false;
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
          title: Text(title!),
          actions: [
            Visibility(
              visible: selectedCategory != null ? true : false,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: Icon(Icons.search),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * .6,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .16,
                width: double.infinity,
                color: MyTheme.primaryColor,
                child: Center(
                  child: Text(
                    'News App',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onSideItemClicked(0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: selectedIndex == 0
                            ? MyTheme.primaryColor
                            : MyTheme.blackColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.categories,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: selectedIndex == 0
                                    ? MyTheme.primaryColor
                                    : MyTheme.blackColor),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onSideItemClicked(1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: selectedIndex == 1
                            ? MyTheme.primaryColor
                            : MyTheme.blackColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.settings,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: selectedIndex == 1
                                    ? MyTheme.primaryColor
                                    : MyTheme.blackColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: selectedIndex == 1
            ? Settings(onSideItemClicked: onSideItemClicked)
            : selectedCategory == null
                ? CategoryContainer(
                    onCategoryItemClicked: onCategoryItemClicked,
                  )
                : CategoryDetails(
                    category: selectedCategory!,
                  ),
      ),
    );
  }

  Category? selectedCategory = null;
  String? title = 'Categories';

  void onCategoryItemClicked(Category category) {
    selectedCategory = category;
    title = category.title!;
    setState(() {});
  }

  int? selectedIndex = 0;

  void onSideItemClicked(int index) {
    selectedIndex = index;
    title = index == 0 ? 'Categories' : 'Settings';
    selectedCategory = null;
    Navigator.pop(context);

    setState(() {});
  }
}
