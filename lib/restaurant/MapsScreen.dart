import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/models/comment.dart';
import 'package:mansourarestaurants/models/maps.dart';
import 'package:mansourarestaurants/models/numbers.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../lang/app_localizations.dart';
import '../general.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import 'addMapScreen.dart';
import 'addNumberScreen.dart';
import 'drawer.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenRestaurantState createState() =>
      _MapsScreenRestaurantState();
}

class _MapsScreenRestaurantState extends State<MapsScreen> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
  GlobalKey<RefreshIndicatorState>();
  BoxDecoration boxDecoration = BoxDecoration(
      color: accentColor,
      border: Border.all(color: accentColor),
      borderRadius: BorderRadius.circular(15));

  List<Maps> maps = List();
  bool isLadingComments = true;

  _getMaps() async {
    isLadingComments = true;
    if (connected) {
      maps.clear();
      maps = await fetchMapsData(resturantId: globalRestaurant.id);
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
    _getMaps();
  }

  Future<void> _onRefresh() async {
    if (this.mounted) {
      setState(() {});
    }
    return await _getMaps().then((onValue) {});
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
                margin: EdgeInsets.only(top: 20, right: 2, left: 10),
                child: MyAppbar(context, _key, false)),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 115,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      padding: EdgeInsets.only(
                        top: 5,
                      ),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 1.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddMapScreen())).then((value) => value !=null && value ?_getMaps():(){});
                            },
                            child: Container(
                              child: Card(
                                  elevation: 4,
                                  child: Image.asset("assets/Group 6.png")),
                              height: 40,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 250,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: isLadingComments
                                ? _ladingWidget()
                                : maps.isEmpty
                                ? Container()
                                : Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListView(
                                children: maps.map((Maps map) {
                                  return reviewCard(map);
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery
                            .of(context)
                            .size
                            .width / 12),
                    // padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      appLocalizations.translate("Map"),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontFamily: ""),
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
    return ListView(
      children: <Widget>[
        Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
        Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: Colors.grey.withOpacity(.3),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: myCircularProgressIndicator()),
      ],
    );
  }

  Widget reviewCard(Maps map) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 4,
          spreadRadius: 1,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            onTap: () {
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
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                ackAlert(
                    title: " حذف ",
                    context: context,
                    content: "هل تريد حذف رقم  ",
                    textButton1: "نعم",
                    textButton: "لا",
                    antherButton: true,
                    fun: () async {
                      Navigator.pop(context);
                      progress(context: context, isLoading: true);
                      bool result =
                      await deleteMap(map_id: map.mapId);
                      progress(context: context, isLoading: false);
                      if (result) {
                        maps.remove(map);
                        setState(() {});
                      }
                    });
              })
        ],
      ),
    );
  }
}
