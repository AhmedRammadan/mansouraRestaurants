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
import 'package:mansourarestaurants/models/maps.dart';
import 'package:mansourarestaurants/models/numbers.dart';
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';

class AddMapScreen extends StatefulWidget {
  @override
  _AddMapScreenState createState() => _AddMapScreenState();
}

class _AddMapScreenState extends State<AddMapScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextEditingController cName = TextEditingController();
  TextEditingController cLatitude = TextEditingController();
  TextEditingController cLongitude = TextEditingController();
  Maps maps = Maps(name: "", latitude: "", longitude: "");

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: accentColor,
      bottomNavigationBar:
          Container(margin: EdgeInsets.only(top: 10), child: SocialMedia()),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4, left: 20, right: 20),
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
                      hintText: appLocalizations.translate("name phone"),
                    ),
                    myTextInput(
                      controller: cLatitude,
                      textInputType: TextInputType.text,
                      hintText: appLocalizations
                          .translate("Latitude"),
                    ),
                    myTextInput(
                      controller: cLongitude,
                      textInputType: TextInputType.text,
                      hintText: appLocalizations
                          .translate("Longitude"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        appLocalizations.translate("Or you can enter your current location using GPS"),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                      child: ListTile(
                        onTap: () {
                          getLocation();
                        },
                        title: Text(
                          "${maps.name.isEmpty?"GPS":maps.name}" ,
                          style: TextStyle(fontFamily: "", fontSize: 15),
                        ),
                        trailing: Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                      ),
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
                                maps.name = cName.text;
                                maps.latitude = cLatitude.text;
                                maps.longitude = cLongitude.text;
                                progress(context: context, isLoading: true);
                                await maps.create();
                                progress(context: context, isLoading: false);
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
                                appLocalizations
                                    .translate("Register now"), // "سجل الان",
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

  getLocation() async {
    try {
      progress(context: context, isLoading: true);
      PermissionStatus permissionStatus = await Location().hasPermission();
      if (permissionStatus == PermissionStatus.GRANTED) {
        await Location()
            .getLocation()
            .then((LocationData currentLocation) async {
          cLatitude = TextEditingController(text: currentLocation.latitude.toString());
          cLongitude = TextEditingController(text: currentLocation.longitude.toString());
         cName  = TextEditingController(text: await findAddresses(
             latitude: currentLocation.latitude,
             longitude: currentLocation.longitude));

          print(currentLocation.latitude);
          print(currentLocation.longitude);
        });
        setState(() {});
      } else {
        await Location().getLocation();
        await Location()
            .getLocation()
            .then((LocationData currentLocation) async {
          maps.latitude = currentLocation.latitude.toString();
          maps.longitude = currentLocation.longitude.toString();

          maps.name = await findAddresses(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude);

          print(currentLocation.latitude);
          print(currentLocation.longitude);
        });
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      print('currentLocation = null;');
    }

    setState(() {});
    progress(context: context, isLoading: false);
  }

  Future<String> findAddresses({double latitude, double longitude}) async {
    try {
      final coordinates = new Coordinates(latitude, longitude);
      List<Address> addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      //print("${addresses[0].addressLine}");

      /*for (var item in addresses) {
    print("${item.addressLine}");
  }*/
      return addresses[0].addressLine;
    } catch (e) {
      return '';
    }
  }

  message(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        AppLocalizations.of(context).translate(msg),
      ),
    ));
  }

  bool validation() {
    if (cName.text.isEmpty && maps.name.isEmpty) {
      message("name is required");
      return false;
    } else if (cLatitude.text.isEmpty && maps.latitude.isEmpty) {
      message("Latitude is required");
      return false;
    } else if (cLongitude.text.isEmpty && maps.longitude.isEmpty) {
      message("Longitude is required");
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
