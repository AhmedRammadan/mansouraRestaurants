import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  Restaurant restaurant;

  RestaurantCard(this.restaurant);

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations= AppLocalizations.of(context);
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: NetworkImage(
                        "$domainImages/restaurant/logo/${restaurant.logo}"),
                    fit: BoxFit.cover)),
            alignment: Alignment.bottomCenter,
            child: restaurant.isFamous == "Yes"
                ? Container(
                    alignment: Alignment.bottomCenter,
                    color: accentColor,
                    width: 110,
                    height: 20,
                    child: Text(
                      "${appLocalizations.translate("Famous")}",
                      style: TextStyle(color: textColor),
                    ))
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${restaurant.name}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                /*  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${restaurant.name}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: restaurant.isFamous == "Yes"
                          ? Icon(
                              Icons.star,
                              color: Colors.yellow,
                            )
                          : Container(),
                    )
                  ],
                ),*/
                Text(
                  AppLocalizations.of(context).locale.languageCode == "en"
                      ? "${restaurant.categoryNameEN}"
                      : "${restaurant.categoryNameAR}",
                  style: TextStyle(fontSize: 20, color: accentColor),
                ),
                RatingBar(
                  itemSize: 20,
                  initialRating: double.parse(restaurant.rate),
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.only(right: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/general.dart';
import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  Restaurant restaurant;

  RestaurantCard(this.restaurant);

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
        width: 130,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5,left: 5),
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(
                          "$domainImages/restaurant/logo/${restaurant.logo}"),
                      fit: BoxFit.cover)),
              child: restaurant.isFamous=="Yes"?Icon(Icons.star,color: Colors.yellow,):Container(),
              alignment: Alignment.topLeft,
            ),
            Flexible(
                child: Text(
              "${restaurant.name}",
              style: TextStyle(fontSize: 18),
            )),
            Flexible(
                child: Text(
              "${restaurant.categoryName}",
              style: TextStyle(color: textColor, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }
}
*/
