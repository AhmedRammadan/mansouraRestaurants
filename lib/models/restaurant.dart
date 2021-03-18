import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mansourarestaurants/models/numbers.dart';
import 'dart:convert';

import '../general.dart';
import 'category.dart';
import 'maps.dart';
import 'menu.dart';

class Restaurant {
  String id;
  String position;
  String name;
  String desc;
  String logo;
  String caver;
  File logoFile;
  File caverFile;
  String rate;
  String startTime;
  String endTime;
  String deliveryTime;
  String categoryID;
  String categoryNameEN;
  String categoryNameAR;
  String ownerEmail;
  String ownerPassword;
  String ownerName;
  String isActivate;
  String ownerNumber;
  String visitorNum;
  String isFamous;
  String createDate;
  List<Numbers> numbers;
  List<Maps> maps;
  List<File> meunFiles;
  Category category;
  String deliveryNumber;
  String complaintNumber;
  String latitude;
  String longitude;
  String addressInMap;

  Restaurant(
      {this.id = '',
      this.position = '',
      this.name = '',
      this.desc = '',
      this.logo = '',
      this.caver = '',
      this.rate = '',
      this.startTime = '01:00',
      this.endTime = '01:00',
      this.deliveryTime = '00:5',
      this.categoryID = '',
      this.categoryNameEN = '',
      this.categoryNameAR = '',
      this.ownerEmail = '',
      this.ownerPassword = '',
      this.ownerName = '',
      this.ownerNumber = '',
      this.visitorNum = '',
      this.isActivate = '',
      this.isFamous = '',
      this.createDate = '',
      this.numbers,
      this.category,
      this.deliveryNumber = '',
      this.complaintNumber = '',
      this.latitude = '',
      this.longitude = '',
      this.addressInMap = '',
      this.maps});

  factory Restaurant.fromJson2(json) {
    return Restaurant(
      id: json['resturant_id'],
      position: json['position'],
      name: json['resturant_name'],
      desc: json['resturant_desc'],
      logo: json['resturant_logo'],
      caver: json['resturant_caver'],
      rate: json['resturant_rate'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      deliveryTime: json['delivery_time'],
      categoryID: json['category_id'],
      categoryNameEN: json['category_name_en'],
      categoryNameAR: json['category_name_ar'],
      ownerEmail: json['owner_email'],
      ownerPassword: json['owner_password'],
      ownerName: json['owner_name'],
      ownerNumber: json['owner_number'],
      visitorNum: json['visitor_num'],
      isActivate: json['is_activate'],
      isFamous: json['is_famous'],
      createDate: json['create_date'],
    );
  }

  factory Restaurant.fromJson(json) {
    String name = json['resturant_name'].toString().replaceAll("amp;", '');
    String desc = json['resturant_desc'].toString().replaceAll("amp;", '');
    return Restaurant(
      id: json['resturant_id'],
      position: json['position'],
      name: name,
      desc: desc,
      logo: json['resturant_logo'],
      caver: json['resturant_caver'],
      rate: json['resturant_rate'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      deliveryTime: json['delivery_time'],
      categoryID: json['category_id'],
      categoryNameEN:
          json['category_name_en'].toString().replaceAll("amp;", ''),
      categoryNameAR:
          json['category_name_ar'].toString().replaceAll("amp;", ''),
      ownerEmail: json['owner_email'],
      ownerPassword: json['owner_password'],
      ownerName: json['owner_name'].toString().replaceAll("amp;", ''),
      ownerNumber: json['owner_number'].toString().replaceAll("amp;", ''),
      visitorNum: json['visitor_num'].toString().replaceAll("amp;", ''),
      isActivate: json['is_activate'],
      isFamous: json['is_famous'],
      createDate: json['create_date'],
      numbers: getNumbers(json['numbers']),
      maps: getMaps(json['maps']),
    );
  }
   visitor() async {
    http.Response response =
    await http.post("$domain/restaurant/vistorNumber.php", body: {"resturant_id": this.id});
    print(response.body);
    var res = json.decode(response.body);
if(response.statusCode==200){
  this.visitorNum = res['visitor_num'];
}
return ;
  }


  create() async {
    String logoBase64Image = base64Encode(this.logoFile.readAsBytesSync());
    String logoName = this.logoFile.path.split('/').last;

    String caverBase64Image = base64Encode(this.caverFile.readAsBytesSync());
    String caverName = this.caverFile.path.split('/').last;

    http.Response response =
        await http.post("$domain/restaurant/create.php", body: {
      'resturant_name': this.name,
      'resturant_desc': this.desc,
      'logoName': logoName,
      'logoBase64Image': logoBase64Image,
      'caverName': caverName,
      'caverBase64Image': caverBase64Image,
      'start_time': this.startTime,
      'end_time': this.endTime,
      'delivery_time': this.deliveryTime,
      'category_id': this.category.categoryId,
      'owner_name': this.ownerName,
      'owner_number': this.ownerNumber,
      'visitor_num': this.visitorNum,
      'delivery_number': this.deliveryNumber,
      'complaint_number': this.complaintNumber,
      'map_name': this.addressInMap,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'owner_email': this.ownerEmail,
      'owner_password': this.ownerPassword,
    });
    print(response.body);
    if (response.statusCode == 201) {
      var res = json.decode(response.body);
      var resturantId = res['last_resturant_id'];
      for (File file in this.meunFiles) {
        await uploadMenu(resturantId: resturantId, image: file);
      }
      print("Image Uploaded");
      return true;
    } else {
      print("Upload Failed");
      return false;
    }
  }
}

Future<List<Restaurant>> fetchAllRestaurants() async {
  List<Restaurant> restaurants = List();
  http.Response response = await http
      .post("$domain/restaurant/read.php", body: {"restaurant": "restaurant"});
  print(response.body);
  var res = json.decode(response.body);
 // print(res);
  List data = res['restaurant'];
  for (var item in data) {
    Restaurant restaurant = Restaurant.fromJson(item);
    print(restaurant.position);
    restaurants.add(restaurant);
  }
  return restaurants;
}

Future<List<Restaurant>> fetchRestaurants(String isFamous) async {
  List<Restaurant> restaurants = List();
  http.Response response = await http.post(
      "$domain/restaurant/readRestaurantIsFamous.php",
      body: {"is_famous": isFamous});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['restaurant'];
  for (var item in data) {
    Restaurant restaurant = Restaurant.fromJson(item);
    print(restaurant.position);
    restaurants.add(restaurant);
  }
  return restaurants;
}

Future<List<Restaurant>> fetchRestaurantsByCategoryID(
    String category_id) async {
  List<Restaurant> restaurants = List();
  http.Response response =
      await http.post("$domain/restaurant/readByCategoryId.php", body: {
    "category_id": category_id,
  });
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['restaurant'];
  for (var item in data) {
    Restaurant restaurant = Restaurant.fromJson(item);
    print(restaurant.position);
    restaurants.add(restaurant);
  }
  return restaurants;
}

Future<List<Restaurant>> fetchRestaurantsByRestaurantName(
    String category_id, String word) async {
  List<Restaurant> restaurants = List();
  http.Response response = await http
      .post("$domain/restaurant/readByRestaurantIsNameAndCat_ID.php", body: {
    "category_id": category_id,
    "word": word,
  });
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['restaurant'];
  for (var item in data) {
    Restaurant restaurant = Restaurant.fromJson(item);
    print(restaurant.position);
    restaurants.add(restaurant);
  }
  return restaurants;
}

Future<List<Restaurant>> fetchRestaurantsBySearch(String word) async {
  List<Restaurant> restaurants = List();
  http.Response response =
      await http.post("$domain/restaurant/search.php", body: {"word": word});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['restaurant'];
  for (var item in data) {
    Restaurant restaurant = Restaurant.fromJson(item);
    print(restaurant.position);
    restaurants.add(restaurant);
  }
  return restaurants;
}

Future<Restaurant> fetchRestaurantsByRandom() async {
  Restaurant restaurant = Restaurant();
  http.Response response =
      await http.post("$domain/restaurant/rand.php", body: {"rand": "rand"});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  restaurant = Restaurant.fromJson(res['restaurant'][0]);
  return restaurant;
}
