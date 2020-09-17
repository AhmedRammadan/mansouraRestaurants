import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../general.dart';
import '../models/sliderModel.dart';
import 'showImage.dart';

class HomeSlider extends StatelessWidget {
  List<SliderModel> sliders = List();
  bool isLading = true;


  HomeSlider(this.sliders, this.isLading);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/5,
      child: isLading
          ? _ladingWidget()
          : CarouselSlider(
              items: sliders.map((SliderModel sliderModel) {
                return InkWell(
                  onTap: (){
                    Navigator
                        .push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowImage(
                              url: '$domainImages/slider/${sliderModel.name}',
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          '$domainImages/slider/${sliderModel.name}',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }).toList(),
              height: 200,
              // MediaQuery.of(context).size.height / 3.5,
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
      height: 200,
      // MediaQuery.of(context).size.height / 3.5,
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
