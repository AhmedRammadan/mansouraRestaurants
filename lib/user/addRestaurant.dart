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
import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:mansourarestaurants/widget/socialMedia.dart';

class AddRestaurant extends StatefulWidget {
  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Restaurant restaurant = Restaurant();

  TextEditingController cRestaurantName = TextEditingController();
  TextEditingController cRestaurantDesc = TextEditingController();
  TextEditingController cMangerName = TextEditingController();
  TextEditingController cMangerNumber = TextEditingController();
  TextEditingController cMangerEmail = TextEditingController();
  TextEditingController cMangerPassword = TextEditingController();
  TextEditingController cDeliveryNumber = TextEditingController();
  TextEditingController cReport = TextEditingController();
  List<Category> categores = List();

  getCategores() async {
    categores = await fetchCategoriesData();
    if (categores.isNotEmpty) {
      restaurant.category = categores.first;
    }
    setState(() {});
  }

  @override
  void initState() {
    getCategores();
    restaurant.meunFiles = List();
    super.initState();
  }

  Widget dropdownButtonCategory() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(top: 8.0),
        child: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: DropdownButton<Category>(
              value: restaurant.category,
              isExpanded: true,
              onChanged: (Category value) async {
                restaurant.category = value;
                print(restaurant.category.categoryNameAR);

                setState(() {});
              },
              items: categores
                  .map<DropdownMenuItem<Category>>((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context).locale.languageCode == "en"
                          ? category.categoryNameEN
                          : category.categoryNameAR,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: accentColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 35, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: textColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 5),
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () async {
                                String path = await FilePicker.getFilePath(
                                    type: FileType.image);

                                if (path != null) {
                                  File file = File(path);
                                  if (file != null) {
                                    restaurant.logoFile = file;
                                    setState(() {});
                                  }
                                }
                              },
                              child: restaurant.logoFile == null
                                  ? Image.asset(
                                      "assets/Group 6.png",
                                      height: 40,
                                    )
                                  : Image.file(
                                      restaurant.logoFile,
                                      height: 40,
                                    ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              appLocalizations.translate("Add logo"),
                              // "اضف شعار المطعم",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        appLocalizations.locale.languageCode == "en"
                            ? "assets/Shape.png"
                            : "assets/Layer 12.png",
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: appLocalizations.locale.languageCode != "en"
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))
                      : BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
              // height: MediaQuery.of(context).size.height - 80,
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () async {
                                  String path = await FilePicker.getFilePath(
                                      type: FileType.image);

                                  if (path != null) {
                                    File file = File(path);
                                    if (file != null) {
                                      restaurant.caverFile = file;
                                      setState(() {});
                                    }
                                  }
                                },
                                child: restaurant.caverFile == null
                                    ? Image.asset(
                                        "assets/Group 6.png",
                                        height: 40,
                                      )
                                    : Image.file(
                                        restaurant.caverFile,
                                        height: 40,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                appLocalizations.translate("Add background"),
                                // "اضف خلفية المطعم",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        myTextInput(
                          controller: cRestaurantName,
                          textInputType: TextInputType.text,
                          hintText: appLocalizations.translate(
                              "The name of the restaurant"), //"اسم المطعم",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8.0),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            appLocalizations.translate("Choose the category"),
                            //  "ساعات العمل",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        dropdownButtonCategory(),
                        myTextInput(
                          controller: cRestaurantDesc,
                          textInputType: TextInputType.text,
                          hintText: appLocalizations.translate(
                              "Description of the restaurant"), //"اسم صاحب المطعم",
                        ),
                        myTextInput(
                          controller: cMangerName,
                          textInputType: TextInputType.text,
                          hintText: appLocalizations.translate(
                              "The name of the restaurant owner"), //"اسم صاحب المطعم",
                        ),
                        myTextInput(
                          controller: cMangerNumber,
                          textInputType: TextInputType.phone,
                          hintText: appLocalizations.translate(
                              "The owner's number"), //"رقم صاحب المطعم",
                        ),
                        myTextInput(
                          controller: cMangerEmail,
                          textInputType: TextInputType.emailAddress,
                          hintText: appLocalizations
                              .translate("email"), //"رقم صاحب المطعم",
                        ),
                        myTextInput(
                          obscureText: true,
                          controller: cMangerPassword,
                          textInputType: TextInputType.visiblePassword,
                          hintText: appLocalizations
                              .translate("password"), //"رقم صاحب المطعم",
                        ),
                        myTextInput(
                          controller: cDeliveryNumber,
                          textInputType: TextInputType.phone,
                          hintText: appLocalizations
                              .translate("Delivery number"), //"رقم الدلفري",
                        ),
                        myTextInput(
                          controller: cReport,
                          textInputType: TextInputType.phone,
                          hintText: appLocalizations
                              .translate("Complaint number"), //"رقم الشكاوي",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            appLocalizations.translate("Delivery time"),
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
                            value: restaurant.deliveryTime,
                            items: deliveryTimes.map((String value) {
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
                              restaurant.deliveryTime = value;
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
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  appLocalizations.translate("work hours"),
                                  //  "ساعات العمل",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      appLocalizations.translate("from"),
                                      //  "من",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: DropdownButton<String>(
                                        value: restaurant.startTime,
                                        items: times.map((String value) {
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
                                          restaurant.startTime = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    Text(
                                      appLocalizations.translate("to"),
                                      // "الي",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: DropdownButton<String>(
                                        value: restaurant.endTime,
                                        items: times.map((String value) {
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
                                          restaurant.endTime = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  getLocation();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    restaurant.addressInMap.isEmpty
                                        ? appLocalizations
                                            .translate("Address on the map")
                                        : restaurant.addressInMap,
                                    //"العنوان علي الخريطة",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () async {
                                        String path =
                                            await FilePicker.getFilePath(
                                                type: FileType.image);
                                        if (path != null) {
                                          File file = File(path);
                                          if (file != null) {
                                            restaurant.meunFiles.add(file);
                                            setState(() {});
                                          }
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/Group 6.png",
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      appLocalizations
                                          .translate("Add the menu photos"),
                                      //  "اضف صور المنيو",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              restaurant.meunFiles == null ||
                                      restaurant.meunFiles.isEmpty
                                  ? Container()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: restaurant.meunFiles
                                            .map((File myImage) =>
                                                imageItem(myImage: myImage))
                                            .toList(),
                                      ),
                                    ),
                              InkWell(
                                onTap: () async {
                                  if (validation()) {
                                    restaurant.name = cRestaurantName.text;
                                    restaurant.desc = cRestaurantDesc.text;
                                    restaurant.ownerName = cMangerName.text;
                                    restaurant.ownerNumber = cMangerNumber.text;
                                    restaurant.ownerEmail = cMangerEmail.text;
                                    restaurant.ownerPassword =
                                        cMangerPassword.text;
                                    restaurant.deliveryNumber =
                                        cDeliveryNumber.text;
                                    restaurant.complaintNumber = cReport.text;
                                    progress(context: context, isLoading: true);
                                    await restaurant.create();
                                    progress(
                                        context: context, isLoading: false);
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
            Container(margin: EdgeInsets.only(top: 10), child: SocialMedia()),
          ],
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
    if (restaurant.logoFile == null) {
      message("Logo is required");
      return false;
    } else if (restaurant.caverFile == null) {
      message("Background is required");
      return false;
    } else if (cRestaurantName.text.isEmpty) {
      message("Restaurant name is required");
      return false;
    } else if (cRestaurantDesc.text.isEmpty) {
      message("Restaurant description is required");
      return false;
    } else if (cMangerName.text.isEmpty) {
      message("Director's name is required");
      return false;
    } else if (cMangerNumber.text.isEmpty) {
      message("The manager's phone number is required");
      return false;
    } else if (cMangerEmail.text.isEmpty) {
      message("Email is required");
      return false;
    } else if (cMangerPassword.text.isEmpty) {
      message("Password is required");
      return false;
    } else if (cDeliveryNumber.text.isEmpty) {
      message("Delivery number is required");
      return false;
    } else if (cReport.text.isEmpty) {
      message("Complaints number is required");
      return false;
    } else if (restaurant.addressInMap.isEmpty) {
      message("Address is required on the map");
      return false;
    } else if (restaurant.meunFiles.isEmpty) {
      message("Menu photos are required to be attached");
      return false;
    }
    return true;
  }

  getLocation() async {
    try {
      progress(context: context, isLoading: true);
      PermissionStatus permissionStatus = await Location().hasPermission();
      if (permissionStatus == PermissionStatus.GRANTED) {
        await Location()
            .getLocation()
            .then((LocationData currentLocation) async {
          restaurant.latitude = currentLocation.latitude.toString();
          restaurant.longitude = currentLocation.longitude.toString();

          restaurant.addressInMap = await findAddresses(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude);

          print(currentLocation.latitude);
          print(currentLocation.longitude);
        });
        setState(() {});
      } else {
        await Location().getLocation();
        await Location()
            .getLocation()
            .then((LocationData currentLocation) async {
          restaurant.latitude = currentLocation.latitude.toString();
          restaurant.longitude = currentLocation.longitude.toString();

          restaurant.addressInMap = await findAddresses(
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

  Widget imageItem({File myImage}) {
    return Container(
      //height: 100,
      width: 100,
      margin: EdgeInsets.only(left: 2),
      //padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        //image: DecorationImage(image: AssetImage('assets/profile.png')),
        image: DecorationImage(image: FileImage(myImage)),
      ),
      alignment: Alignment.topLeft,
      child: InkWell(
        child: Icon(
          Icons.clear,
          color: Colors.red,
        ),
        onTap: () {
          restaurant.meunFiles.remove(myImage);
          setState(() {});
        },
      ),
    );
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

  List<String> times = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "24:00",
  ];
  List<String> deliveryTimes = [
    "00:5",
    "00:10",
    "00:15",
    "00:20",
    "00:25",
    "00:30",
    "00:35",
    "00:40",
    "00:45",
    "00:50",
    "00:55",
    "00:60",
  ];

  Widget dropdownButtonStartTime() {
    return DropdownButton<String>(
      value: restaurant.startTime,
      //isExpanded: true,
      onChanged: (String value) async {
        restaurant.startTime = value;
        setState(() {});
      },
      items: times.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget dropdownButtonEndTime() {
    return DropdownButton<String>(
      value: restaurant.endTime,
      //isExpanded: true,
      onChanged: (String value) async {
        restaurant.endTime = value;
        setState(() {});
      },
      items: times.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget dropdownButtonDeliveryTime() {
    return DropdownButton<String>(
      value: restaurant.deliveryTime,
      //isExpanded: true,
      onChanged: (String value) async {
        restaurant.deliveryTime = value;
        setState(() {});
      },
      items: deliveryTimes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            '$value ${AppLocalizations.of(context).translate("minute")}',
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
            ),
          ),
        );
      }).toList(),
    );
  }
}
