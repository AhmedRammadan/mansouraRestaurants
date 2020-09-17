import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/backend/savaUserData.dart';
import 'package:mansourarestaurants/contact_us.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/LocaleHelper.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/loginData/loginScreen.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import 'package:url_launcher/url_launcher.dart';

import 'addRestaurant.dart';

class userDrawer extends StatefulWidget {
  @override
  _userDrawerState createState() => _userDrawerState();
}

class _userDrawerState extends State<userDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor,
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.width / 2.5,
                child: Image.asset(
                  logo,
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.width / 2.5 + 40,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: textColor, borderRadius: BorderRadius.circular(25)),
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height / 1.68,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _item(
                        index: 1,
                        text: AppLocalizations.of(context)
                            .translate("contact us"),
                        isImage: true),
                    _item(
                        index: 0,
                        text: AppLocalizations.of(context)
                            .translate("addRestaurant"),
                        icon: Icons.restaurant),
                    // _item(
                    //     index: 4,
                    //     text: AppLocalizations.of(context).translate("login"),
                    //     icon: Icons.exit_to_app),
                    _item(
                        index: 3,
                        text:
                            AppLocalizations.of(context).translate("shareApp"),
                        icon: Icons.share),
                    _item(
                        index: 2,
                        text: AppLocalizations.of(context).translate("lang"),
                        icon: Icons.language),
                  ],
                ),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                alignment: Alignment.center,
                child: SocialMedia(),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                alignment:
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? Alignment.bottomRight
                        : Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? "assets/Shape.png"
                        : "assets/Layer 12.png",
                    height: 30,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _item({int index, String text, IconData icon, bool isImage = false}) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: InkWell(
        onTap: () async {
          //Navigator.pop(context);
          switch (index) {
            case 0:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddRestaurant()));
              break;
            case 1:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ContactUs()));
              break;
            case 2:
              if (AppLocalizations.of(context).locale.languageCode == "en") {
                helper.onLocaleChanged(new Locale("ar"));
                await saveProviderLangSharedPref(languageCode: "ar");
              } else {
                helper.onLocaleChanged(new Locale("en"));
                await saveProviderLangSharedPref(languageCode: "en");
              }
              setState(() {});
              break;
            case 3:
              shareApp();
              break;
            case 4:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
              break;
          }
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                borderRadius:
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))
                        : BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                color: accentColor,
              ),
              child: isImage
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/Layer 9.png"),
                    )
                  : Icon(icon),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
