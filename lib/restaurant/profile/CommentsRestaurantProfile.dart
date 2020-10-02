import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/comment.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/restaurant/drawer.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';

class CommentsRestaurantProfile extends StatefulWidget {
  Restaurant restaurant;

  CommentsRestaurantProfile(this.restaurant);

  @override
  _CommentsRestaurantProfileState createState() =>
      _CommentsRestaurantProfileState();
}

class _CommentsRestaurantProfileState extends State<CommentsRestaurantProfile> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorkey =
      GlobalKey<RefreshIndicatorState>();
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

  Future<void> _onRefresh() async {
    if (this.mounted) {
      setState(() {});
    }
    return await _getComments().then((onValue) {});
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
              height: MediaQuery.of(context).size.height - 115,
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
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: isLadingComments
                                ? _ladingWidget()
                                : Comments.isEmpty
                                    ? Container()
                                    : ListView(
                                        children:
                                            Comments.map((Comment comment) {
                                          return reviewCard(comment);
                                        }).toList(),
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
                        horizontal: MediaQuery.of(context).size.width / 12),
                    // padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      appLocalizations.translate("Comments"),
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
            itemSize: 15,
            initialRating: double.parse(comment.star),
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.only(right: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
          InkWell(
            onTap: () {
              print(comment.star);
            },
            child: Text(
              "${comment.comment}",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
