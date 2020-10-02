import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/menu.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/restaurant/drawer.dart';
import 'package:mansourarestaurants/widget/showImage.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';

class MenuRestaurantProfile extends StatefulWidget {
  Restaurant restaurant;

  MenuRestaurantProfile(this.restaurant);

  @override
  _MenuRestaurantProfileState createState() => _MenuRestaurantProfileState();
}

class _MenuRestaurantProfileState extends State<MenuRestaurantProfile> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();
  List<Menu> menus = List();
  bool isLading = true;
  int _current = 0;

  _getMenus() async {
    if (connected) {
      menus = await fetchMenuData(resturantId: widget.restaurant.id);
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
    _getMenus();
  }

  Future<void> _onRefresh() async {
    if (this.mounted) {
      setState(() {});
    }
    return await _getMenus().then((onValue) {});
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
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30, right: 2, left: 10),
                child: MyAppbar(context, _key, false)),
            Container(
              height: MediaQuery.of(context).size.height - 125,
              //    margin: EdgeInsets.symmetric(vertical: 5),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        padding: EdgeInsets.only(
                            top: 18, bottom: 5, left: 5, right: 5),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 145,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: isLading
                            ? _ladingWidget()
                            : menus.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2, right: 2, bottom: 15),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: menus.map((Menu menu) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ShowImage(
                                                  url:
                                                      '$domainImages/restaurant/menu/${menu.menuImage}',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  '$domainImages/restaurant/menu/${menu.menuImage}',
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                  ),
                  Container(
                    height: 25,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 12),
                    //   padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      appLocalizations.translate("Menu"),
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
    );
  }

  Widget _ladingWidget() {
    return CarouselSlider(
      items: [
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
      ],
      height: MediaQuery.of(context).size.height / 2,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      //  autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    );
  }
}
