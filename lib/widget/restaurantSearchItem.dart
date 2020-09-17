import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/restaurant.dart';

class RestaurantSearchItem extends StatelessWidget {
  Restaurant restaurant;

  RestaurantSearchItem(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.fromBorderSide(BorderSide(color: textColor)),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            height: 60,
            width: 110,
            decoration: BoxDecoration(
                borderRadius:
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15))
                        : BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(
                        "$domainImages/restaurant/logo/${restaurant.logo}"),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Container(
              alignment:
                  AppLocalizations.of(context).locale.languageCode == "en"
                      ? Alignment.topLeft
                      : Alignment.topRight,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${restaurant.name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  /* Flexible(
                      child: Text(
                        AppLocalizations.of(context).locale.languageCode == "en"
                            ? "${restaurant.categoryNameEN.toLowerCase()}"
                            : "${restaurant.categoryNameAR.toLowerCase()}",
                        style: TextStyle(color: accentColor ,),
                      ),
                    ),*/
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
            ),
          )
        ],
      ),
    );
  }
}
