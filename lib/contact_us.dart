import 'package:flutter/material.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/socialMedia.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                AppLocalizations.of(context)
                    .locale
                    .languageCode ==
                    "en"
                    ? "assets/Shape.png"
                    : "assets/Layer 12.png",
                height: 30,
              ),
            ),
          )
          ,
        ],
        elevation: 0,
        backgroundColor: accentColor,
        centerTitle: true,
        title: Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(left: 10, top: 10),
          child: Image.asset(
            "assets/Group 5 2.png",
          ),
        ),
      ),
      backgroundColor: accentColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(
              logo,
              height: MediaQuery.of(context).size.width / 2,
            ),
            SocialMedia(),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Group 77.png"),
                  fit: BoxFit.fill,
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ],
        ),
      ),
    );
  }
}
