import 'package:flutter/material.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("contact us")),
      ),
      backgroundColor: accentColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset(
              logo,
              height: MediaQuery.of(context).size.width / 2,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8),
              child: Text(
                AppLocalizations.of(context).translate("desc"),
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).translate("contact us"),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 25,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _launchURL(
                        url: "https://wa.me/01008281513");
                  },
                  child: Image.asset(
                    "assets/whatsapp.png",
                    height: 40,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL(
                        url: "https://www.instagram.com/mansourarestaurants/");
                  },
                  child: Image.asset(
                    "assets/instagram.png",
                    height: 40,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL(
                        url: "https://www.facebook.com/mansoura.restaurants.1");
                  },
                  child: Image.asset(
                    "assets/facebook.png",
                    height: 40,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Image.asset(
                "assets/contact_us.png",
                height: MediaQuery.of(context).size.width / 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL({url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
