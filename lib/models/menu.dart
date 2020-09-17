import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../general.dart';

class Menu {
  String menuId, menuName, menuImage;

  Menu({this.menuId, this.menuName, this.menuImage});

  factory Menu.fromJson(json) {
    return Menu(
      menuId: json['menu_id'],
      menuName: json['resturant_id'],
      menuImage: json['menu_image'],
    );
  }
}

Future<List<Menu>> fetchMenuData({String resturantId}) async {
  List<Menu> menus = List();
  http.Response response = await http
      .post("$domain/menu/read.php", body: {"resturant_id": resturantId});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['menus'];
  for (var item in data) {
    menus.add(Menu.fromJson(item));
  }
  return menus;
}

Future<bool> uploadMenu({String resturantId, File image}) async {
  String menuBase64Image = base64Encode(image.readAsBytesSync());
  String menuImage = image.path.split('/').last;

  http.Response response = await http.post("$domain/menu/create.php", body: {
    "resturant_id": resturantId,
    "menuBase64Image": menuBase64Image,
    "menu_image": menuImage,
  });
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  if (!res['error']) {
    return true;
  }
  return false;
}

Future<bool> deleteMenu({String menuId}) async {
  http.Response response =
      await http.post("$domain/menu/delete.php", body: {"menu_id": menuId});
  print(response.body);
  var res = json.decode(response.body);
  print(res);

  if (!res['error']) {
    return true;
  } else {
    return false;
  }
}
