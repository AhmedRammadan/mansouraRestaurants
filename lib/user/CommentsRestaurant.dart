import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mansourarestaurants/models/comment.dart';
import 'package:mansourarestaurants/models/maps.dart';
import 'package:mansourarestaurants/models/numbers.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../lang/app_localizations.dart';
import '../general.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/widget/myAppbar.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';
import 'drawer.dart';

class CommentsRestaurant extends StatefulWidget {
  Restaurant restaurant;

  CommentsRestaurant(this.restaurant);

  @override
  _CommentsRestaurantState createState() => _CommentsRestaurantState();
}

class _CommentsRestaurantState extends State<CommentsRestaurant> {
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
      drawer: userDrawer(),
      bottomNavigationBar: SocialMedia2(),
      body: RefreshIndicator(
        key: _refreshIndicatorkey,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30, right: 2, left: 10),
                  child: MyAppbar(context, _key, false)),
              Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(vertical: 10),
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
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              //padding: EdgeInsets.only(bottom: 0),
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/Group 4.png"),
                                      fit: BoxFit.fill)),
                              child: InkWell(
                                  onTap: () {
                                    print("sdfdsf");
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: RatingBar(
                                          onRatingUpdate: (double value) {
                                            print(value);
                                            comment.star = value.toString();
                                          },
                                          itemSize: 15,
                                          initialRating:
                                              double.parse(comment.star),
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemPadding:
                                              EdgeInsets.only(right: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: textColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: textColor,
                                                  width: 2.0,
                                                ),
                                              ),
                                              labelStyle:
                                                  TextStyle(color: textColor),
                                            ),
                                            controller: controller,
                                            onChanged: (value) {
                                              comment.comment = value;
                                            },
                                          )),
                                      InkWell(
                                        onTap: () async {
                                          comment.resturantId =
                                              widget.restaurant.id;
                                          progress(
                                              context: context,
                                              isLoading: true);
                                          bool result =
                                              await comment.createComment();
                                          if (result) {
                                            setState(() {
                                              controller.clear();
                                              comment.star = '3';
                                              Comments.insert(0, comment);
                                            });
                                          }
                                          progress(
                                              context: context,
                                              isLoading: false);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 140,
                                          child: Text(
                                            appLocalizations.translate("send"),//    "ارسال",
                                            style: TextStyle(
                                                color: Colors.white,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  /* Container(
                                  alignment: Alignment.center,
                                  height:40,
                                  width: 140,
                                  child: Text(
                                    "ارسال",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                ),*/
                                  ),
                            )
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
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: ""
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            onTap: (){
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
