import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';
import 'package:mansourarestaurants/general.dart';
import 'package:mansourarestaurants/lang/app_localizations.dart';
import 'package:mansourarestaurants/models/category.dart';
import 'package:mansourarestaurants/models/numbers.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';

class AddNumberScreen extends StatefulWidget {
  @override
  _AddNumberScreenState createState() => _AddNumberScreenState();
}

class _AddNumberScreenState extends State<AddNumberScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextEditingController cName = TextEditingController();
  TextEditingController cNumber = TextEditingController();
  Numbers numbers = Numbers(name: "", phoneNumber: "");

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: accentColor,
      bottomNavigationBar:   Container(margin: EdgeInsets.only(top: 10), child: SocialMedia()),
      body: SingleChildScrollView(
        child:    Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4,left: 20,right: 20 ),
          decoration: BoxDecoration(
              color: textColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          // height: MediaQuery.of(context).size.height - 80,
          child: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(
                  children: <Widget>[
                    myTextInput(
                      controller: cName,
                      textInputType: TextInputType.text,
                      hintText: appLocalizations.translate(
                          "name phone"),
                    ),
                    myTextInput(
                      controller: cNumber,
                      textInputType: TextInputType.text,
                      hintText: appLocalizations.translate(
                          "phone number"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        appLocalizations.translate("type"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(12))),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: numbers.numberType,
                        items: [
                          "delivery",
                          "complaint",
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(
                              value,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          numbers.numberType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              if (validation()) {
                                numbers.name = cName.text;
                                numbers.phoneNumber = cNumber.text;
                                progress(context: context, isLoading: true);
                                await numbers.create();
                                progress(
                                    context: context, isLoading: false);
                                Navigator.pop(context, true);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.width / 5,
                                  vertical: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                appLocalizations.translate(
                                    "Register now"), // "سجل الان",
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  message(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        AppLocalizations.of(context).translate(msg),
      ),
    ));
  }

  bool validation() {
    if (cName.text.isEmpty) {
      message("name is required");
      return false;
    } else if (cNumber.text.isEmpty) {
      message("Phone Number Is Required");
      return false;
    }
    return true;
  }

  Widget myTextInput(
      {TextEditingController controller,
      String hintText,
      TextInputType textInputType,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: textInputType,
          style: TextStyle(
            fontFamily: "",
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(
              fontFamily: "",
              color: Colors.grey,
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
                left: 14.0, right: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
