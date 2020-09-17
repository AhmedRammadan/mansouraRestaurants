import 'package:flutter/material.dart';
import 'package:mansourarestaurants/models/category.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/models/sliderModel.dart';
import 'package:mansourarestaurants/user/categoriesScreen.dart';
import 'package:mansourarestaurants/user/restaurantDetails.dart';
import 'package:mansourarestaurants/widget/categoriesCard.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import '../widget/allRestaurants.dart';
import '../widget/famousRestaurants.dart';
import '../general.dart';
import '../lang/app_localizations.dart';
import '../widget/mySlider.dart';
import 'Restaurant.dart';
import 'drawer.dart';
import 'searchScreen.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();
  Category category = Category();
  TextEditingController controller = TextEditingController();
  List<Category> categories = List();
  bool isLading = true;

  _getCategories() async {
    if (connected) {
      categories = await fetchCategoriesData();
      isLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _onRefresh() async {
    isLading = true;
    if (this.mounted) {
      setState(() {});
    }
    return await _getCategories().then((onValue) {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                MyAppbar(context, _key, true),
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
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                            ),
                            child: Text(
                                appLocalizations
                                    .translate("Find your restaurant"),
                                style: TextStyle(
                                    color: accentColor, fontSize: 18)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => SearchScreen(
                                                    category: Category(
                                                        categoryNameAR: "",
                                                        categoryNameEN: ""),
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: accentColor,
                                                borderRadius: appLocalizations
                                                            .locale
                                                            .languageCode ==
                                                        "en"
                                                    ? BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10))
                                                    : BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10))),
                                            child: Text(
                                              "OK",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 5, left: 5),
                                            child: Image.asset(
                                              "assets/Mag Glass.png",
                                              height: 15,
                                            ),
                                          ),
                                          Text(
                                            appLocalizations
                                                .translate("Search"),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    progress2(context: context, isLoading: true);
                                   Restaurant restaurant =
                                        await fetchRestaurantsByRandom();
                                    progress2(
                                        context: context, isLoading: false);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RestaurantScreen(restaurant)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: accentColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/dice.png',
                                          height: 15,
                                        ),
                                        Text(
                                          appLocalizations.translate("Puzzled"),
                                          style: TextStyle(
                                            color: textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 225,
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
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.0,
                                    //padding: const EdgeInsets.all(4.0),
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    children:
                                        categories.map((Category category) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        SearchScreen(
                                                            category:
                                                                category)));
                                          },
                                          child: CategoriesCard(category));
                                    }).toList(),
                                  ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
