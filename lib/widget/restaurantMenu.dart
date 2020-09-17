import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/models/menu.dart';
import 'package:mansourarestaurants/models/sliderModel.dart';
import 'package:mansourarestaurants/widget/showImage.dart';

import '../general.dart';

class RestaurantMenu extends StatefulWidget {
  String resturantId;

  RestaurantMenu(this.resturantId);

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  List<Menu>menus = List();
  bool isLading = true;

  _getMenus() async {
    if (connected) {
      menus = await fetchMenuData(resturantId: widget.resturantId);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLading
          ? _ladingWidget()
          :menus.isEmpty ?Container(): CarouselSlider(
        items: menus.map((Menu menu) {
          return InkWell(
            onTap: (){
              Navigator
                  .push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShowImage(
                        url: '$domainImages/restaurant/menu/${menu.menuImage}',
                      ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
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
        height:  MediaQuery.of(context).size.height / 2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
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
      height:  MediaQuery.of(context).size.height / 2,
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
