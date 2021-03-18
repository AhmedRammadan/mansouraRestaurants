import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/sliderModel.dart';

import 'general.dart';
import 'user/home.dart';
import 'widget/showImage.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  int _current = 0;
  List<SliderModel> sliders = List();
  bool slidersIsLading = true;

  _getSlider() async {
    if (connected) {
      sliders = await fetchSliderData();
      slidersIsLading = false;
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getSlider();
  }

  CarouselSlider _carouselSlider() => CarouselSlider(
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        items: sliders.map((SliderModel sliderModel) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowImage(
                    url: '$domainImages/slider/${sliderModel.name}',
                  ),
                ),
              );
            },
            child: Container(
              child: FadeInImage.assetNetwork(
                placeholder: logo,
                fit: BoxFit.fill,
                image: '$domainImages/slider/${sliderModel.name}',
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: textColor,
              ),
            ),
          );
        }).toList(),
        height: MediaQuery.of(context).size.height - 40,
        aspectRatio: 0,
        viewportFraction: .999,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: Duration(seconds: 10),
        scrollDirection: Axis.horizontal,
      );
  Widget _loadingWidget() {
    return Stack(
      children: [
        Align(
          child: Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height - 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo)),
              color: textColor,
            ),
          ),
          alignment: Alignment.center,
        ),
        Align(
          child: Container(
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            slidersIsLading ? _loadingWidget() : _carouselSlider(),
            Container(
              color: textColor,
              child: Row(
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserHome()));
                      },
                      child: AppLocalizations.of(context).locale.languageCode ==
                              "en"
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("Skip"),
                                  style: TextStyle(
                                      color: accentColor, fontSize: 15),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/Group 1.png",
                                  height: 15,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  "assets/Group 1.png",
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("Skip"),
                                  style: TextStyle(
                                      color: accentColor, fontSize: 18),
                                ),
                              ],
                            ),
                    ),
                  ),
                  slidersIsLading
                      ? Container()
                      : Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: sliders.map((url) {
                                  int index = sliders.indexOf(url);
                                  return Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? accentColor //Color.fromRGBO(0, 0, 0, 0.9)
                                            : Colors
                                                .white //Color.fromRGBO(0, 0, 0, 0.4),
                                        ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
