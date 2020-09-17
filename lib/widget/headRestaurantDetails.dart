import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/maps.dart';
import 'package:mansourarestaurants/models/numbers.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../general.dart';

class HeadRestaurantDetails extends StatelessWidget {
  Restaurant restaurant;

  HeadRestaurantDetails(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        "$domainImages/restaurant/logo/${restaurant.logo}"),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${restaurant.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? "${restaurant.categoryNameEN}"
                        : "${restaurant.categoryNameAR}",
                    style: TextStyle(color: textColor),
                  ),
                  Text(
                    "${AppLocalizations.of(context).translate("Delivery time")} : ${restaurant.deliveryTime} ${AppLocalizations.of(context).translate("minute")}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${AppLocalizations.of(context).translate("from")} ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${restaurant.startTime}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${AppLocalizations.of(context).translate("to")} ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${restaurant.startTime}",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (restaurant.numbers.isNotEmpty)
                    numbersDeliveryAlert(
                        context: context, numbers: restaurant.numbers);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: accentColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.call),
                        Text(
                          '${AppLocalizations.of(context).translate("Call")}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  if(restaurant.maps.isNotEmpty)
                  mpaAlert(context: context, maps: restaurant.maps);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: accentColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text(
                          '${AppLocalizations.of(context).translate("Location")}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  if (restaurant.numbers.isNotEmpty)
                    numbersDeliveryAlert(
                        context: context, numbers: restaurant.numbers);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: accentColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.report),
                        Text(
                          '${AppLocalizations.of(context).translate("Report")}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> numbersDeliveryAlert({
  BuildContext context,
  List<Numbers> numbers,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context).translate("close")))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: numbers.map((Numbers number) {
            if (number.numberType == "delivery") {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  launchURL(number.phoneNumber);
                },
                title: Text(number.name),
                trailing: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
              );
            } else {
              return Container();
            }
          }).toList(),
        ),
      );
    },
  );
}

Future<void> numbersReportAlert({
  BuildContext context,
  List<Numbers> numbers,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context).translate("close")))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: numbers.map((Numbers number) {
            if (number.numberType != "delivery") {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  launchURL(number.phoneNumber);
                },
                title: Text(number.name),
                trailing: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
              );
            } else {
              return Container();
            }
          }).toList(),
        ),
      );
    },
  );
}

Future<void> mpaAlert({
  BuildContext context,
  List<Maps> maps,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context).translate("close")))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: maps.map((Maps map) {
            return ListTile(
              onTap: () {
                Navigator.pop(context);
                MapsLauncher.launchCoordinates(
                    double.parse(map.latitude), double.parse(map.longitude), map.name);
              },
              title: Text(map.name),
              trailing: Icon(
                Icons.location_on,
                color: Colors.green,
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}
