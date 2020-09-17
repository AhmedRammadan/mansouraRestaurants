import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/user/restaurantDetails.dart';

import '../general.dart';
import 'restaurantFamousCard.dart';

class FamousRestaurants extends StatelessWidget {
  List<Restaurant> restaurants = List();
  bool isLading = true;


  FamousRestaurants(this.restaurants, this.isLading);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      //height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate("Famous restaurants"),
              style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: isLading
                    ? [_ladingWidget(), _ladingWidget(), _ladingWidget()]
                    : restaurants.map((Restaurant restaurant) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RestaurantDetails(restaurant)));
                            },
                            child: RestaurantFamousCard(
                              restaurant: restaurant,
                            ));
                      }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _ladingWidget() {
  return Container(
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(logo)),
        color: Colors.grey.withOpacity(.3),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: myCircularProgressIndicator());
}
/*
     InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestaurantDetails()));
                      },
                      child: RestaurantFamousCard()),
 */
