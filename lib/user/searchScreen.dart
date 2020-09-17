import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/models/category.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/restaurantSearchItem.dart';
import 'Restaurant.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import '../general.dart';
import '../lang/app_localizations.dart';
import 'drawer.dart';

class SearchScreen extends StatefulWidget {
  Category category;

  SearchScreen({this.category});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();
  List<Restaurant> restaurants = List();
  bool isLading = true;
  String _words = '';
  String _hint = '';

  _getRestaurantsByCategoryId() async {
    print("_getRestaurantsByCategoryId");
    print("_getRestaurantsByCategoryId");
    if (connected) {
      print(_words);
      restaurants =
          await fetchRestaurantsByCategoryID(widget.category.categoryId);
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  _getRestaurantsByRestaurantName() async {
    print("_getRestaurantsByRestaurantName");
    print("_getRestaurantsByRestaurantName");
    if (connected) {
      isLading = true;
      if (this.mounted) {
        setState(() {});
      }
      print(_words);
      restaurants = await fetchRestaurantsByRestaurantName(
          widget.category.categoryId, _words);
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  _getRestaurantsBySearch() async {
    print("_getRestaurantsBySearch");
    print("_getRestaurantsBySearch");
    if (connected && _words.isNotEmpty) {
      setState(() {
        restaurants.clear();
        isLading = true;
      });
      restaurants = await fetchRestaurantsBySearch(_words);
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  _getAllRestaurants() async {
    if (connected) {
      isLading = true;
      if (this.mounted) {
        setState(() {});
      }
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
    if (widget.category.categoryNameAR.isEmpty) {
      _getAllRestaurants();
    } else {
      _words =
          "${widget.category.categoryNameAR} ${widget.category.categoryNameEN}";
      _hint =
          "${widget.category.categoryNameAR} ${widget.category.categoryNameEN}";
      _getRestaurantsByCategoryId();
    }
  }

  Future<void> _onRefresh() async {
    isLading = true;
    if (this.mounted) {
      setState(() {});
    }
    return await _getAllRestaurants().then((onValue) {});
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
          child: Container(
            margin: EdgeInsets.only(top: 35, right: 2, left: 10),
            child: Column(
              children: <Widget>[
                //  MyAppbar(context, _key, false),

                AppLocalizations.of(context).locale.languageCode == "en"
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(child: _search()),
                          Container(
                            alignment: Alignment.topRight,
                            // margin: EdgeInsets.only(left: 10, top: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                AppLocalizations.of(context)
                                            .locale
                                            .languageCode ==
                                        "en"
                                    ? "assets/Shape.png"
                                    : "assets/Layer 12.png",
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            // margin: EdgeInsets.only(left: 10, top: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Image.asset(
                                AppLocalizations.of(context)
                                            .locale
                                            .languageCode ==
                                        "en"
                                    ? "assets/Shape.png"
                                    : "assets/Layer 12.png",
                                height: 30,
                              ),
                            ),
                          ),
                          Expanded(child: _search()),
                        ],
                      ),

                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        height: MediaQuery.of(context).size.height - 150,
                        margin: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            right: 15,
                            left: 15,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 300,
                          child: isLading
                              ? _loading()
                              : restaurants.isEmpty
                                  ? Container()
                                  : ListView(
                                      children: restaurants
                                          .map((Restaurant restaurant) {
                                      return InkWell(
                                          onTap: () {
                                            /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RestaurantDetails(
                                                            restaurant)));*/
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RestaurantScreen(
                                                            restaurant)));
                                          },
                                          child:
                                              RestaurantSearchItem(restaurant));
                                    }).toList()),
                        ),
                      ),
                      widget.category.categoryNameAR.isEmpty
                          ? Container()
                          : Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 10),
                              padding: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                color: textColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                appLocalizations.locale.languageCode == "en"
                                    ? "${widget.category.categoryNameEN.toLowerCase()}"
                                    : "${widget.category.categoryNameAR.toLowerCase()}",
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
                    image: AssetImage("assets/final-005.png"),
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
                  myCircularProgressIndicator(),
                ],
              ),
            ),
          )
        ],
      ),
    );
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

  Widget _search() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextField(
        //controller: _controller,
        onSubmitted: (input) {
          setState(() {
            setState(() {
              _words = input;
              if (widget.category.categoryNameAR.isEmpty) {
                _getRestaurantsBySearch();
              } else if (_words.isNotEmpty) {
                _getRestaurantsByRestaurantName();
              } else {
                _getAllRestaurants();
              }
            });
          });
        },
        onChanged: (input) {
          _words = input;
        },
        style: TextStyle(fontSize: 10, color: textColor),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
          /* icon:   Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.only(
                right: 5, left: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.only(
                    topRight:
                    Radius.circular(10),
                    bottomRight:
                    Radius.circular(10))),
            child: Text(
              "OK",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: accentColor,
                  fontSize: 20),
            ),
          ),*/
          suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: accentColor,
              ),
              onPressed: () {
                if (widget.category.categoryNameAR.isEmpty) {
                  _getRestaurantsBySearch();
                } else if (_words.isNotEmpty) {
                  _getRestaurantsByRestaurantName();
                } else {
                  _getAllRestaurants();
                }
              }),
          border: InputBorder.none,
          //labelText: "بحث",
          labelText: _hint,
          labelStyle: TextStyle(color: textColor),
          hintStyle: TextStyle(color: textColor),
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
        ),
      ),
    );
  }
}
