import 'dart:ui';

import 'package:mansourarestaurants/models/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLogout() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isLogin', false);
  await sharedPreferences.setString('id', "");
  await sharedPreferences.setString('position', "");
  await sharedPreferences.setString('name', "");
  await sharedPreferences.setString('desc', "");
  await sharedPreferences.setString('logo', "");
  await sharedPreferences.setString('caver', "");
  await sharedPreferences.setString('rate', "");
  await sharedPreferences.setString('startTime', "");
  await sharedPreferences.setString('endTime', "");
  await sharedPreferences.setString('deliveryTime', "");
  await sharedPreferences.setString('categoryID', "");
  await sharedPreferences.setString('categoryNameEN', "");
  await sharedPreferences.setString('categoryNameAR', "");
  await sharedPreferences.setString('ownerEmail', "");
  await sharedPreferences.setString('ownerPassword', "");
  await sharedPreferences.setString('ownerName', "");
  await sharedPreferences.setString('ownerNumber', "");
  await sharedPreferences.setString('isActivate', "");
  await sharedPreferences.setString('isFamous', "");
  await sharedPreferences.setString('createDate', "");
  return true;
}

Future<bool> isLogin() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool('isLogin') == null
      ? false
      : sharedPreferences.getBool('isLogin');
}


Future<Restaurant> saveRestaurantDataSharedPref(Restaurant restaurant) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool('isLogin', true);
  sharedPreferences.setString('id', restaurant.id);
  sharedPreferences.setString('position', restaurant.position);
  sharedPreferences.setString('name', restaurant.name);
  sharedPreferences.setString('desc', restaurant.desc);
  sharedPreferences.setString('logo', restaurant.logo);
  sharedPreferences.setString('caver', restaurant.caver);
  sharedPreferences.setString('rate', restaurant.rate);
  sharedPreferences.setString('startTime', restaurant.startTime);
  sharedPreferences.setString('endTime', restaurant.endTime);
  sharedPreferences.setString('deliveryTime', restaurant.deliveryTime);
  sharedPreferences.setString('categoryID', restaurant.categoryID);
  sharedPreferences.setString('categoryNameEN', restaurant.categoryNameEN);
  sharedPreferences.setString('categoryNameAR', restaurant.categoryNameAR);
  sharedPreferences.setString('ownerEmail', restaurant.ownerEmail);
  sharedPreferences.setString('ownerPassword', restaurant.ownerPassword);
  sharedPreferences.setString('ownerName', restaurant.ownerName);
  sharedPreferences.setString('ownerNumber', restaurant.ownerNumber);
  sharedPreferences.setString('isActivate', restaurant.isActivate);
  sharedPreferences.setString('isFamous', restaurant.isFamous);
  sharedPreferences.setString('createDate', restaurant.createDate);
  return restaurant ;
}

Future<Restaurant> getRestaurantDataSharedPref() async {
  Restaurant restaurant= Restaurant();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  restaurant.id =   sharedPreferences.getString('id');
  restaurant.position =   sharedPreferences.getString('position');
  restaurant.name =   sharedPreferences.getString('name');
  restaurant.desc =   sharedPreferences.getString('desc');
  restaurant.logo =   sharedPreferences.getString('logo');
  restaurant.caver =   sharedPreferences.getString('caver');
  restaurant.rate =   sharedPreferences.getString('rate');
  restaurant.startTime =   sharedPreferences.getString('startTime');
  restaurant.endTime =   sharedPreferences.getString('endTime');
  restaurant.deliveryTime =   sharedPreferences.getString('deliveryTime');
  restaurant.categoryID =   sharedPreferences.getString('categoryID');
  restaurant.categoryNameEN =   sharedPreferences.getString('categoryNameEN');
  restaurant.categoryNameAR =   sharedPreferences.getString('categoryNameAR');
  restaurant.ownerEmail =   sharedPreferences.getString('ownerEmail');
  restaurant.ownerPassword =   sharedPreferences.getString('ownerPassword');
  restaurant.ownerName =   sharedPreferences.getString('ownerName');
  restaurant.ownerNumber =   sharedPreferences.getString('ownerNumber');
  restaurant.isActivate =   sharedPreferences.getString('isActivate');
  restaurant.isFamous =   sharedPreferences.getString('isFamous');
  return restaurant;

}

Future<Locale> getProviderLangSharedPref() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString('languageCode') == null
      ? Locale("ar")
      : Locale(sharedPreferences.getString('languageCode'));
}

Future<void> saveProviderLangSharedPref({languageCode}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('languageCode', languageCode);
}
