import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/category.dart';
import 'package:mansourarestaurants/models/menu.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/user/Restaurant.dart';
import 'package:mansourarestaurants/user/drawer.dart';
import 'package:mansourarestaurants/user/searchScreen.dart';
import 'package:mansourarestaurants/widget/categoriesCard.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/showImage.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';

import '../general.dart';

class RestaurantHomeScreen extends StatefulWidget {
  @override
  _RestaurantHomeScreenState createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();
  List<Menu> menus = List();
  bool isLading = true;
  int _current = 0;

  _getMenus() async {
    if (connected) {
      menus = await fetchMenuData(resturantId: globalRestaurant.id);
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
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    counter = 0;
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: accentColor,
      key: _key,
      drawer: userDrawer(),
      bottomNavigationBar: SocialMedia(),
      body: RefreshIndicator(
        key: _refreshIndicatorkey,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50, right: 10, left: 10),
            child: Column(
              children: <Widget>[
                MyAppbar2(context, _key, true),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  height: MediaQuery.of(context).size.height - 155,
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height / 13,
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            
                          },
                          child: Container(
                            child: Image.asset("assets/Group 6.png"),
                            height: 40,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 250,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 215,
                          child: isLading
                              ? Container(
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(logo)),
                                  ),
                                  child: myCircularProgressIndicator(),
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  //padding: const EdgeInsets.all(4.0),
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  children: menus.map((Menu menu) {
                                    counter++;
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
                                        alignment: Alignment.bottomCenter,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Colors.black.withOpacity(.5),
                                          child: ListTile(
                                            title: Text(
                                              "$counter",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ""),
                                            ),
                                            trailing: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  ackAlert(
                                                      title: " حذف ",
                                                      context: context,
                                                      content:
                                                          "هل تريد حذف رقم  ",
                                                      textButton1: "نعم",
                                                      textButton: "لا",
                                                      antherButton: true,
                                                      fun: () async {
                                                        Navigator.pop(context);
                                                        progress(
                                                            context: context,
                                                            isLoading: true);
                                                        bool result =
                                                            await deleteMenu(
                                                                menuId: menu
                                                                    .menuId);
                                                        progress(
                                                            context: context,
                                                            isLoading: false);
                                                        if (result) {
                                                          menus.remove(menu);
                                                          setState(() {});
                                                        }
                                                      });
                                                }),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  '$domainImages/restaurant/menu/${menu.menuImage}',
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                    );
                                  }).toList(),
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
      ),
    );
  }
}
