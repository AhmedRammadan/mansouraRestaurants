import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/models/comment.dart';

import '../general.dart';

class RestaurantReviews extends StatelessWidget {
  bool isLadingComments;
  List<Comment> Comments = List();
  RestaurantReviews(this.Comments,this.isLadingComments);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: isLadingComments
            ? _ladingWidget()
            : Comments.isEmpty
                ? Container()
                : ListView(
                    children: Comments.map((Comment comment) {
                      return reviewCard(comment);
                    }).toList(),
                  ));
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
}

Widget reviewCard(Comment comment) {
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
        RatingBar(
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
        Text(
          "${comment.comment}",
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
