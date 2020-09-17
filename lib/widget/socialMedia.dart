import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/user/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../general.dart';

class SocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              _launchURL(url: "https://wa.me/+201022621200");
            },
            child: Image.asset(
              "assets/WhatsApp.png",
              height: 25,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              _launchURL(
                  url:
                      "https://m.facebook.com/Mansoura-restaurants-%D9%85%D8%B7%D8%A7%D8%B9%D9%85-%D8%A7%D9%84%D9%85%D9%86%D8%B5%D9%88%D8%B1%D8%A9-114471523577207/");
            },
            child: Image.asset(
              "assets/Facebook.png",
              height: 25,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              _launchURL(
                  url:
                      "https://instagram.com/mansourarestaurants?igshid=1mlba4qdk9qvd");
            },
            child: Image.asset(
              "assets/Instagram.png",
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMedia2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Stack(
        children: <Widget>[
          SocialMedia(),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserHome()));
              },
              child: Container(
                width: 70,
                height: 25,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: textColor),
                child: Text(
                  AppLocalizations.of(context).translate("Home"),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

_launchURL({url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
