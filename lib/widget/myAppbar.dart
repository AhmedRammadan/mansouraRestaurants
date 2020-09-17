import 'package:flutter/material.dart';
import 'package:mansourarestaurants/intro.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';

import '../general.dart';

Widget MyAppbar(context, GlobalKey<ScaffoldState> _key, bool isHomeScreen) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      IconButton(
          icon: Icon(
            Icons.menu,
            color: textColor,
            size: 35,
          ),
          onPressed: () {
            _key.currentState.openDrawer();
          }),
      Image.asset(
        "assets/Group 5.png",
        height: 40,
      ),
      Container(
        alignment: Alignment.topRight,
        // margin: EdgeInsets.only(left: 10, top: 10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
            if (isHomeScreen) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => IntroScreen()));
            }
          },
          child: Image.asset(
            AppLocalizations.of(context).locale.languageCode == "en"
                ? "assets/Shape.png"
                : "assets/Layer 12.png",
            height: 30,
          ),
        ),
      ),
    ],
  );
  return AppBar(
    elevation: 0,
    leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: textColor,
          size: 40,
        ),
        onPressed: () {
          _key.currentState.openDrawer();
        }),
    backgroundColor: accentColor,
    centerTitle: true,
    title: Image.asset(
      "assets/Group 5.png",
      height: 50,
    ),
    actions: <Widget>[
      Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(left: 10, top: 10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => IntroScreen()));
          },
          child: Image.asset(
            "assets/Layer 12.png",
            height: 40,
          ),
        ),
      ),
    ],
  );
}

Widget MyAppbar2(context, GlobalKey<ScaffoldState> _key, bool isHomeScreen) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      IconButton(
          icon: Icon(
            Icons.menu,
            color: textColor,
            size: 35,
          ),
          onPressed: () {
            _key.currentState.openDrawer();
          }),
      Image.asset(
        "assets/Group 5.png",
        height: 40,
      ),
      Container(
        height: 30,
        alignment: Alignment.topRight,
      ),
    ],
  );

}
