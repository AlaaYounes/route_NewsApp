import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:route_news_app/utils/config_provider.dart';
import 'package:route_news_app/utils/theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              configProvider.changeLanguage('en');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.english,
                    style: configProvider.isEnglish()
                        ? Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18, color: MyTheme.primaryColor)
                        : Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18)),
                Visibility(
                  visible: configProvider.isEnglish() ? true : false,
                  child: Icon(
                    Icons.check,
                    color: MyTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              configProvider.changeLanguage('ar');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.arabic,
                    style: configProvider.isEnglish()
                        ? Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18)
                        : Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18, color: MyTheme.primaryColor)),
                Visibility(
                  visible: configProvider.isEnglish() ? false : true,
                  child: Icon(
                    Icons.check,
                    color: MyTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
