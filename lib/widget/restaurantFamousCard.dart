import 'package:flutter/material.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import '../models/restaurant.dart';

class RestaurantFamousCard extends StatelessWidget {
  Restaurant restaurant;

  RestaurantFamousCard({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        width: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                      image: NetworkImage("$domainImages/restaurant/logo/${restaurant.logo}"),
                      fit: BoxFit.cover)),
            ),
            Flexible(
                child: Text(
                  "${restaurant.name}",
                  style: TextStyle(fontSize: 18),
                )),
            Flexible(
                child: Text(
                  AppLocalizations.of(context).locale.languageCode == "en"
                      ? "${restaurant.categoryNameEN}"
                      : "${restaurant.categoryNameAR}",
                  style: TextStyle(
                      color: textColor, fontSize: 18),
                )),
          ],
        ),
      ),
    );

  }
}
