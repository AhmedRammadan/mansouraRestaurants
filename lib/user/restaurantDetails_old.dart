import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/models/comment.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/headRestaurantDetails.dart';
import 'package:mansourarestaurants/widget/restaurantMenu.dart';
import 'package:mansourarestaurants/widget/restaurantReviews.dart';
import '../lang/app_localizations.dart';

import '../general.dart';

class RestaurantDetails extends StatefulWidget {
  Restaurant restaurant;

  RestaurantDetails(this.restaurant);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
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
        child:Stack(children: <Widget>[
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
                  : RestaurantReviews(Comments,isLadingComments),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:
            isMenu
                ? Container()
                : Container(
              height:120,
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
                    initialRating: double.parse(comment.star) ,
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
                      if(result){
                        setState(() {
                          controller.clear();
                          comment.star = '3';
                          Comments.insert(0,comment);
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
        ],),
      ),
    );
  }
}
