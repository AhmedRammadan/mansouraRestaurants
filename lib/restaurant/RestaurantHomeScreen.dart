import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/comment.dart';
import 'package:mansourarestaurants/restaurant/Comments.dart';
import 'package:mansourarestaurants/restaurant/MapsScreen.dart';
import 'package:mansourarestaurants/restaurant/menuScreen.dart';
import 'package:mansourarestaurants/restaurant/numbersScreen.dart';
import 'package:mansourarestaurants/user/Restaurant.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import '../general.dart';
import 'profile/RestaurantProfile.dart';
import 'drawer.dart';

class RestaurantHomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: accentColor,
      key: _key,
      drawer: RestaurantDrawer(),
      bottomNavigationBar: SocialMedia(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, right: 10, left: 10),
          child: Column(
            children: <Widget>[
              MyAppbar2(context, _key, true),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                height: MediaQuery.of(context).size.height - 155,
                child: Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height / 13,
                    child: ListView(
                      children: [
                        Card(
                          child: ListTile(     onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestaurantProfileScreen(globalRestaurant)));
                          },
                            title: Text(appLocalizations.translate("Profile")),
                            trailing: Icon(Icons.restaurant_menu),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));
                            },
                            title: Text(appLocalizations.translate("Menu")),
                            trailing: Icon(Icons.fastfood),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NumbersScreen()));
                            },
                            title:
                                Text(appLocalizations.translate("Connection")),
                            trailing: Icon(Icons.call),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapsScreen()));
                            },
                            title: Text(appLocalizations.translate("Map")),
                            trailing: Icon(Icons.map),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Comments()));
                            },
                            title: Text(appLocalizations.translate("Comments")),
                            trailing: Icon(Icons.comment),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
