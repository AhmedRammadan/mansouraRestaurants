import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mansourarestaurants/backend/savaUserData.dart';
import '../../general.dart';
import '../restaurant.dart';

class Login {
  String restaurantName;
  String password;
  String error;

  Login({this.restaurantName = '', this.password = ''});

  Future<bool> setLogin() async {
    http.Response response = await http.post("$domain/restaurant/login.php", body: {
      "emailORPhoneNumber": this.restaurantName,
      "password": this.password,
    });
    print(response.body);
    var res = json.decode(response.body);
    if (!res['error']) {
      Restaurant restaurant = Restaurant.fromJson2(res['restaurant_info']);
      globalRestaurant= await saveRestaurantDataSharedPref(restaurant);
      return true;
    } else {
      this.error = res['message'];
      return false;
    }
  }
}
