import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewArticle extends StatefulWidget {
  String url;

  ViewArticle({required this.url});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  @override
  void initState() {
    super.initState();
    viewArticle(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future<void> viewArticle(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
