import 'package:flutter/material.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';
const String logo = 'assets/final-05.png';
//const url = "http://192.168.64.2/mansoura-restaurants.com";
const url = "https://mansoura-restaurants.com";
const String domain = '$url/system/app';
const String domainImages = '$url/upload';
const packageName = 'com.mansourarestaurants';
const Color accentColor = Color(0xffffcb05);
const Color textColor = Color(0xff5c1649);
bool connected = false;
Restaurant globalRestaurant =Restaurant();
launchURL(phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}




 showToastMSG(msg){
  return Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: accentColor,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
Future<void> ackAlert(
    {BuildContext context,
    String title,
    String content,
    bool antherButton = false,
    String textButton,
    String textButton1,
    Function fun}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,style: TextStyle(fontFamily: ""),),
        content: Text(content,style: TextStyle(fontFamily: ""),),
        actions: <Widget>[
          FlatButton(
            child: Text(textButton),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          antherButton
              ? FlatButton(
                  child: Text(textButton1),
                  onPressed: fun,
                )
              : Container(),
        ],
      );
    },
  );
}

Future<void> notConnected({BuildContext context}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('الانترنت'),
            Icon(
              Icons.signal_wifi_off,
            ),
          ],
        ),
        content: Text('لا يوجد اتصال بالانترنت'),
        actions: <Widget>[
          FlatButton(
            child: Text('الغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> done({BuildContext context}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 70,
              ),
            ),
            Text(
              'Thank You',
              textAlign: TextAlign.center,
              style: TextStyle(color: accentColor, fontSize: 25),
            ),
            Text(
              'We will communicate with you',
              textAlign: TextAlign.center,
              style: TextStyle(color: accentColor),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

shareApp() async {
  var appUrl = '';
  if (Platform.isAndroid) {
    appUrl = "https://play.google.com/store/apps/details?id=$packageName";
  } else if (Platform.isIOS) {
    appUrl = "https://apps.apple.com/us/app/zoom-cloud-meetings/id546505307";
  }
  Share.share(appUrl);
}

progress({BuildContext context, bool isLoading}) {
  if (isLoading) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        );
      },
    );
  } else {
    Navigator.pop(context);
  }
}
progress2({BuildContext context, bool isLoading}) {
  if (isLoading) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Image.asset("assets/dice.gif"),
          ),
        );
      },
    );
  } else {
    Navigator.pop(context);
  }
}

Widget myCircularProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(accentColor),
  ));
}

Widget notConnectedWidget({context, Function fun}) {
  return InkWell(
    onTap: fun,
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/not_connected.png'),
          Text('Internet connection was interrupted'),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xffFF6969),
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () async {
                // connected =await isConnected();
              },
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        'try again',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<bool> setTokenMSG({
  String parentId,
  String token,
}) async {
  http.Response response =
      await http.post('$domain/app/student/token_msg_update.php', body: {
    "parent_id": parentId,
    "token_msg": token,
  });
  var utf = utf8.decode(response.bodyBytes);
  var data = json.decode(utf);
  print('........setTokenMSG');
  print(data);
  if (data['status']) {
    return true;
  }
  return false;
}
