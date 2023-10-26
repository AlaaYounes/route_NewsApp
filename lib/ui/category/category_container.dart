import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_news_app/models/category_model.dart';
import 'package:route_news_app/ui/category/category_item.dart';

class CategoryContainer extends StatelessWidget {
  Function onCategoryItemClicked;

  CategoryContainer({required this.onCategoryItemClicked});

  @override
  Widget build(BuildContext context) {
    List<Category> categoriesList = Category.getCategories(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.pick_sen,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // category details.
                  onCategoryItemClicked(categoriesList[index]);
                },
                child:
                    CategoryItem(category: categoriesList[index], index: index),
              ),
              itemCount: categoriesList.length,
            ),
          ),
        ],
      ),
    );
  }
}
