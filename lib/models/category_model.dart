import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_news_app/utils/theme.dart';

class Category {
  String? id;
  String? title;
  Color? color;
  String? image;

  Category(
      {required this.id,
      required this.title,
      required this.color,
      required this.image});

  static List<Category> getCategories(context) {
    return [
      Category(
          id: 'sports',
          title: AppLocalizations.of(context)!.sports,
          color: MyTheme.redColor,
          image: 'assets/sports.png'),
      Category(
          id: 'general',
          title: AppLocalizations.of(context)!.general,
          color: MyTheme.navyBlueColor,
          image: 'assets/Politics.png'),
      Category(
          id: 'health',
          title: AppLocalizations.of(context)!.health,
          color: MyTheme.pinkColor,
          image: 'assets/health.png'),
      Category(
          id: 'business',
          title: AppLocalizations.of(context)!.business,
          color: MyTheme.brownColor,
          image: 'assets/business.png'),
      Category(
          id: 'technology',
          title: AppLocalizations.of(context)!.technology,
          color: MyTheme.blueColor,
          image: 'assets/technology.png'),
      Category(
          id: 'science',
          title: AppLocalizations.of(context)!.science,
          color: MyTheme.blackColor,
          image: 'assets/science.png'),
      Category(
          id: 'entertainment',
          title: AppLocalizations.of(context)!.entertainment,
          color: MyTheme.yellowColor,
          image: 'assets/entertainment.png'),
    ];
  }
}
