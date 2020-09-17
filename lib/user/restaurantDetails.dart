import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/models/comment.dart';
import 'package:mansourarestaurants/models/maps.dart';
import 'package:mansourarestaurants/models/numbers.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/headRestaurantDetails.dart';
import 'package:mansourarestaurants/widget/restaurantMenu.dart';
import 'package:mansourarestaurants/widget/restaurantReviews.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../lang/app_localizations.dart';

import '../general.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import 'CommentsRestaurant.dart';
import 'MenuRestaurant.dart';
import 'drawer.dart';

class RestaurantDetails extends StatefulWidget {
  Restaurant restaurant;

  RestaurantDetails(this.restaurant);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
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
      drawer: userDrawer(),
      bottomNavigationBar: SocialMedia2(),
      body: RefreshIndicator(
        key: _refreshIndicatorkey,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 50, right: 2, left: 10),
                  child: MyAppbar(context, _key, false)),
              Container(
                height: MediaQuery.of(context).size.height / 1.35,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: MediaQuery.of(context).size.height / 4.5,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 15,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _item(
                                index: 0,
                                title: appLocalizations.translate("Connection"),
                                icon: Icons.call,
                                index2: 1,
                                title2: appLocalizations.translate("Map"),
                                icon2: Icons.location_on),
                            _item(
                                index: 2,
                                title: appLocalizations.translate("Complaints"),
                                icon: Icons.info_outline,
                                index2: 3,
                                title2: appLocalizations.translate("Comments"),
                                icon2: Icons.comment),
                            //  _item(index: 4, title: "الشكاوي", icon: Icons.call,haveAntherB: false),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MenuRestaurant(widget.restaurant)));
                              },
                              child: Container(
                                width: 320,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                        width: 30,
                                        height: 30,
                                        //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        margin: EdgeInsets.only(
                                            bottom: 5, left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: AppLocalizations.of(
                                                          context)
                                                      .locale
                                                      .languageCode ==
                                                  "en"
                                              ? BorderRadius.only(
                                                  topLeft: Radius.circular(50),
                                                  bottomLeft:
                                                      Radius.circular(50))
                                              : BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(50),
                                                  topRight:
                                                      Radius.circular(50)),
                                          color: accentColor,
                                        ),
                                        child: Icon(
                                          Icons.assignment,
                                          size: 15,
                                        )),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2),
                                        margin: EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: AppLocalizations.of(
                                                          context)
                                                      .locale
                                                      .languageCode ==
                                                  "en"
                                              ? BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(50),
                                                  topRight: Radius.circular(50))
                                              : BorderRadius.only(
                                                  topLeft: Radius.circular(50),
                                                  bottomLeft:
                                                      Radius.circular(50)),
                                          color: textColor,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              appLocalizations
                                                  .translate("Menu"),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: accentColor,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      height: MediaQuery.of(context).size.height / 3.5,
                      margin: EdgeInsets.only(
                        top: 15,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.restaurant.caver.isNotEmpty
                                  ? NetworkImage(
                                      "$domainImages/restaurant/caver/${widget.restaurant.caver}")
                                  : AssetImage("assets/final-002.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 12),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        "${widget.restaurant.name}",
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

  Widget _item(
      {int index,
      String title,
      IconData icon,
      bool haveAntherB = true,
      int index2,
      String title2,
      IconData icon2}) {
    return Container(
      width: 320,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _subItem(index: index, title: title, icon: icon),
          haveAntherB
              ? _subItem(index: index2, title: title2, icon: icon2)
              : Container(),
        ],
      ),
    );
  }

  Widget _subItem({int index, String title, IconData icon}) {
    return InkWell(
      onTap: () {
        print(index);
        switch (index) {
          case 0:
            if (widget.restaurant.numbers.isNotEmpty)
              numbersDeliveryAlert(
                  context: context, numbers: widget.restaurant.numbers);
            break;
          case 1:
            if (widget.restaurant.maps.isNotEmpty)
              mpaAlert(context: context, maps: widget.restaurant.maps);
            break;
          case 2:
            if (widget.restaurant.numbers.isNotEmpty)
              numbersComplaintAlert(
                  context: context, numbers: widget.restaurant.numbers);
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CommentsRestaurant(widget.restaurant)));
            break;
        }
      },
      child: Container(
        //  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                width: 30,
                height: 30,
                //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius:
                      AppLocalizations.of(context).locale.languageCode == "en"
                          ? BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))
                          : BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50)),
                  color: accentColor,
                ),
                child: Icon(
                  icon,
                  size: 15,
                )),
            Container(
              width: 100,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius:
                    AppLocalizations.of(context).locale.languageCode == "en"
                        ? BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50))
                        : BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50)),
                color: textColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "$title",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: accentColor,
                    size: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                child: Text(
                  AppLocalizations.of(context).translate("close"),
                  style: TextStyle(fontFamily: "", fontSize: 15),
                ))
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
                  title: Text(
                    number.name,
                    style: TextStyle(fontFamily: "", fontSize: 15),
                  ),
                  trailing: Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 18,
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

  Future<void> numbersComplaintAlert({
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
                child: Text(
                  AppLocalizations.of(context).translate("close"),
                  style: TextStyle(fontFamily: "", fontSize: 15),
                ))
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: numbers.map((Numbers number) {
              if (number.numberType == "complaint") {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    launchURL(number.phoneNumber);
                  },
                  title: Text(
                    number.name,
                    style: TextStyle(fontFamily: "", fontSize: 15),
                  ),
                  trailing: Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 18,
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
                child: Text(
                  AppLocalizations.of(context).translate("close"),
                  style: TextStyle(fontFamily: "", fontSize: 15),
                ))
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: maps.map((Maps map) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  MapsLauncher.launchCoordinates(double.parse(map.latitude),
                      double.parse(map.longitude), map.name);
                },
                title: Text(
                  map.name,
                  style: TextStyle(fontFamily: "", fontSize: 15),
                ),
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

class RestaurantDetails2 extends StatefulWidget {
  Restaurant restaurant;

  RestaurantDetails2(this.restaurant);

  @override
  _RestaurantDetailsState2 createState() => _RestaurantDetailsState2();
}

class _RestaurantDetailsState2 extends State<RestaurantDetails2> {
  BoxDecoration boxDecoration = BoxDecoration(
      color: accentColor,
      border: Border.all(color: accentColor),
      borderRadius: BorderRadius.circular(15));
  bool isMenu = true;
  Comment comment = Comment(star: '3');
  TextEditingController controller = TextEditingController();
  List<Comment> Comments = List();
  bool isLadingComments = true;

  _getComments() async {
    if (connected) {
      Comments = await fetchCommentData(resturantId: widget.restaurant.id);
      isLadingComments = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getComments();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                HeadRestaurantDetails(widget.restaurant),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: accentColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (!isMenu) isMenu = !isMenu;
                          });
                        },
                        child: Container(
                          decoration: isMenu ? boxDecoration : null,
                          width: isMenu
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${appLocalizations.translate("Menu")}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                color: isMenu ? textColor : Colors.black),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isMenu) isMenu = !isMenu;
                          });
                        },
                        child: Container(
                          decoration: !isMenu ? boxDecoration : null,
                          width: !isMenu
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.width / 3,
                          child: Text(
                            '${appLocalizations.translate("Reviews")}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                color: !isMenu ? textColor : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isMenu
                    ? RestaurantMenu(widget.restaurant.id)
                    : RestaurantReviews(Comments, isLadingComments),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: isMenu
                  ? Container()
                  : Container(
                      height: 120,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                          color: Colors.white,
                          border: Border.all(color: accentColor),
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(8.0),
                      //  margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RatingBar(
                            onRatingUpdate: (double value) {
                              print(value);
                              comment.star = value.toString();
                            },
                            itemSize: 20,
                            initialRating: double.parse(comment.star),
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.only(right: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: TextField(
                                controller: controller,
                                onChanged: (value) {
                                  comment.comment = value;
                                },
                              )),
                          InkWell(
                            onTap: () async {
                              comment.resturantId = widget.restaurant.id;
                              progress(context: context, isLoading: true);
                              bool result = await comment.createComment();
                              if (result) {
                                setState(() {
                                  controller.clear();
                                  comment.star = '3';
                                  Comments.insert(0, comment);
                                });
                              }
                              progress(context: context, isLoading: false);
                            },
                            child: Container(
                              decoration: boxDecoration,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                'Send',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
