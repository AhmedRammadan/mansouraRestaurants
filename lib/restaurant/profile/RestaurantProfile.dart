import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import '../../general.dart';
import '../../lang/app_localizations.dart';
import 'RestaurantProfileDetails.dart';
import '../drawer.dart';

class RestaurantProfileScreen extends StatefulWidget {
  Restaurant restaurant;

  RestaurantProfileScreen(this.restaurant);

  @override
  _RestaurantProfileScreenState createState() => _RestaurantProfileScreenState();
}

class _RestaurantProfileScreenState extends State<RestaurantProfileScreen> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    if (this.mounted) {
      setState(() {});
    }
    //   return await _getAllRestaurants().then((onValue) {});
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: accentColor,
      key: _key,
      drawer: RestaurantDrawer(),
      bottomNavigationBar: SocialMedia(),
      body: RefreshIndicator(
        key: _refreshIndicatorkey,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 50, right: 2, left: 10),
                  child: MyAppbar(context, _key, false)),
              /*    Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => SearchScreen(
                              category: Category(
                                  categoryNameAR: '', categoryNameEN: ''),
                            )));
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(right: 5, left: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: textColor,
                              borderRadius:
                                  appLocalizations.locale.languageCode == "en"
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))
                                      : BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                          child: Text(
                            "OK",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: accentColor, fontSize: 20),
                          ),
                        ),

                       Padding(
                      padding: EdgeInsets.only(right: 10,left: 10),
                      child: Image.asset(
                          "assets/Mag Glass.png",
                          height: 20,
                        ),
                        ),
                         Text(
                            appLocalizations.translate("Search"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.withOpacity(.5),
                                fontSize: 15),
                          ),

                      ],
                    ),
                  ),
                ),
              ),*/
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      height: MediaQuery.of(context).size.height - 150,
                      margin: EdgeInsets.only(
                        top: 15,
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 300,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: widget.restaurant.caver.isNotEmpty
                                          ? NetworkImage(
                                          "$domainImages/restaurant/caver/${widget.restaurant.caver}")
                                          : AssetImage("assets/final-002.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height /  3.2,
                                left: 0,
                                right: 0,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height / 11,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height / 2.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(25)),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 4.5,
                                left: 0,
                                right: 0,
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                              .size
                                              .width /
                                              3.3,
                                        ),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "$domainImages/restaurant/logo/${widget.restaurant.logo}"),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            height: MediaQuery.of(context).size.height/4.5,
                                            margin: EdgeInsets.only(
                                              top: 15,
                                              left: 5,
                                              right: 5,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: <Widget>[
                                                  _item(
                                                      title: appLocalizations
                                                          .translate(
                                                          "Appointments"),
                                                      // d: "${AppLocalizations.of(context).translate("from")} ${widget.restaurant.startTime}  ${AppLocalizations.of(context).translate("to")} ${widget.restaurant.endTime}"),
                                                      d: "${widget.restaurant.startTime} : ${widget.restaurant.endTime}"),
                                                  _item(
                                                      title: appLocalizations
                                                          .translate("Delivery"),
                                                      d: "${widget.restaurant.deliveryTime} ${AppLocalizations.of(context).translate("minute")}"),
                                                  widget.restaurant.desc
                                                      .isNotEmpty
                                                      ? _item(
                                                      title: appLocalizations
                                                          .translate(
                                                          "Description"),
                                                      d: "${widget.restaurant.desc}",
                                                      isDesc: true)
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RestaurantProfileDetails(
                                                              widget
                                                                  .restaurant)));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,

                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(25),
                                                color: textColor,
                                              ),
                                              child: Text(
                                                appLocalizations.translate(
                                                    "Visit restaurant"),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 12),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        widget.restaurant.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item({String title, String d, bool isDesc = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius:
                  AppLocalizations.of(context).locale.languageCode == "en"
                      ? BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))
                      : BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topRight: Radius.circular(5)),
              color: textColor,
            ),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontFamily: ""),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius:
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5))
                        : BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                color: accentColor,
              ),
              child: Text(
                "$d",
                style: TextStyle(color: Colors.white, fontFamily: ""),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loading() {
    return ListView(
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
