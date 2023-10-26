import 'package:flutter/material.dart';
import 'package:route_news_app/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  int? index;
  Category category;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomRight: index! % 2 == 0 ? Radius.circular(15) : Radius.zero,
          bottomLeft: index! % 2 != 0 ? Radius.circular(15) : Radius.zero,
        ),
        color: category.color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            category.image!,
            height: 120,
          ),
          Text(
            category.title!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
