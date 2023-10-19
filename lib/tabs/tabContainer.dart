import 'package:flutter/material.dart';
import 'package:route_news_app/models/SourceResponse.dart';
import 'package:route_news_app/news/newsContainer.dart';
import 'package:route_news_app/tabs/tabItem.dart';

class TabContainer extends StatefulWidget {
  List<Source> sourcesList;

  TabContainer({required this.sourcesList});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.sourcesList.isEmpty) {
      return SizedBox();
    }
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            isScrollable: true,
            indicatorColor: Colors.transparent,
            tabs: widget.sourcesList
                .map((source) => TabItem(
                source: source,
                isSelected:
                selectedIndex == widget.sourcesList.indexOf(source)
                    ? true
                    : false))
                .toList(),
          ),
          Expanded(
            child: NewsContainer(
              source: widget.sourcesList[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
