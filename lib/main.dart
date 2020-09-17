import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mansourarestaurants/general.dart';

import 'backend/savaUserData.dart';
import 'intro.dart';
import 'lang/LocaleHelper.dart';
import 'lang/app_localizations.dart';
import 'splash.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizations appLocalizations = AppLocalizations(Locale("ar"));

  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    iniLang();
  }

  iniLang() async {
    Locale locale = await getProviderLangSharedPref();
    print("locale.languageCode : ${locale.languageCode}");
    appLocalizations = AppLocalizations(locale);
    helper.onLocaleChanged(locale);
    this.setState(() {});
  }

  onLocaleChange(Locale locale) {
    setState(() {
      appLocalizations = AppLocalizations(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'GE_DINAR_ONE_MEDIUM',accentColor: textColor,),
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: appLocalizations.locale,
      home: Splash(),

      title: 'مطاعم المنصورة',
    );
  }
}
