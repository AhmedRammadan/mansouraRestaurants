import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/user/restaurantDetails.dart';
import 'package:mansourarestaurants/widget/restaurantSearchItem.dart';

import '../general.dart';
import 'restaurantCard.dart';

class AllRestaurants extends StatelessWidget {
  List<Restaurant> restaurants = List();
  bool isLading = true;


  AllRestaurants(this.restaurants, this.isLading);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate("Browse restaurants"),
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
               // height: MediaQuery.of(context).size.height / 3.3,
                width: MediaQuery.of(context).size.width,
                child: isLading
                    ? _loading()
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                    children: restaurants.map((Restaurant restaurant) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RestaurantDetails(restaurant)));
                          },
                          child: RestaurantCard(restaurant));
                    }).toList()
                ),
              ),
            ],
          )),
    );
  }

  Widget _loading() {
    return Column(
      children: <Widget>[
        loadingRestaurantSearchItem(),
        loadingRestaurantSearchItem(),
        loadingRestaurantSearchItem(),
        loadingRestaurantSearchItem(),
        loadingRestaurantSearchItem(),
        loadingRestaurantSearchItem(),
        loadingRestaurantSearchItem(),
      ],
    );
  }

  Widget loadingRestaurantSearchItem() {
    return Card(
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/final-005.png",
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                myCircularProgressIndicator(),
                RatingBar(
                  itemSize: 20,
                  initialRating: 3,
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
        ],
      ),
    );
  }

}


/*
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/user/restaurantDetails.dart';

import '../general.dart';
import 'restaurantCard.dart';

class AllRestaurants extends StatefulWidget {
  @override
  _AllRestaurantsState createState() => _AllRestaurantsState();
}

class _AllRestaurantsState extends State<AllRestaurants> {
  List<Restaurant> restaurants = List();
  bool isLading = true;

  _getRestaurants() async {
    if (connected) {
     // restaurants = await fetchRestaurants("no");
      restaurants = await fetchAllRestaurants();
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate("Browse restaurants"),
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3.3,
                width: MediaQuery.of(context).size.width,
                child: isLading
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(logo)),
                          color: Colors.grey.withOpacity(.3),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: myCircularProgressIndicator())
                    : GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: restaurants.map((Restaurant restaurant) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantDetails(restaurant)));
                              },
                              child: RestaurantCard(restaurant));
                        }).toList()),
              ),
            ],
          )),
    );
  }
}

 */