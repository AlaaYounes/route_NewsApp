import 'package:flutter/material.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/utils/theme.dart';

class TabItem extends StatelessWidget {
  Source source;
  bool isSelected;

  TabItem({required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected == true ? MyTheme.primaryColor : MyTheme.whiteColor,
          border: isSelected == false
              ? Border.all(color: MyTheme.primaryColor, width: 2)
              : Border.all(color: Colors.transparent),
        ),
        child: Text(
          source.name ?? '',
          style: isSelected == true
              ? Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: MyTheme.whiteColor)
              : Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: MyTheme.primaryColor),
        ),
      ),
    );
  }
}
