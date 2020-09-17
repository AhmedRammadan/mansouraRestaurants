import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/restaurant/RestaurantHomeScreen.dart';
import 'backend/savaUserData.dart';
import 'intro.dart';
import 'lang/LocaleHelper.dart';
import 'lang/app_localizations.dart';
import 'user/home.dart';
import 'package:intro_slider/intro_slider.dart';

import 'widget/socialMedia.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  StreamSubscription<ConnectivityResult> subscription;
  bool result = false;

  @override
  void initState() {
    super.initState();
    isConnected();
    _isLogin();
    // loadData();
  }

  _isLogin() async {
    result = await isLogin();
    if (result) {
      globalRestaurant = await getRestaurantDataSharedPref();
      loadData();
    }
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => RestaurantHomeScreen()));
    });
  }

  isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("sdafdfasfdfa________true");
      connected = true;
      setState(() {

      });
    } else {
      connected = false;
    }
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        connected = false;
      } else if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        connected = true;
      }
      print(connected);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: accentColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(logo),
          ),
          SocialMedia(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.topRight,
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: InkWell(
          onTap: () {
            if (result) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RestaurantHomeScreen()));
            } else {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => IntroScreen()));
            }
          },
          child: Image.asset(
            "assets/Shape.png",
            height: 35,
          ),
        ),
      ),
    );
  }
}
