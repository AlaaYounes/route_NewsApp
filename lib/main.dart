import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:route_news_app/category/category_details.dart';
import 'package:route_news_app/home_screen/home_screen.dart';
import 'package:route_news_app/settings/settings.dart';
import 'package:route_news_app/utils/bloc_observer.dart';
import 'package:route_news_app/utils/config_provider.dart';
import 'package:route_news_app/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => ConfigProvider(),
      ),
      // ChangeNotifierProvider(
      //   create: (BuildContext context) => NewsViewModel(),
      // ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        CategoryDetails.routeName: (context) => CategoryDetails(),
        Settings.routeName: (context) => Settings(),
      },
      theme: MyTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(configProvider.language),
    );
  }
}
