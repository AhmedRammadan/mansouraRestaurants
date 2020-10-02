import 'dart:convert';
import 'package:http/http.dart' as http;
import '../general.dart';

class Category {
  String categoryId,categoryNameAR,categoryNameEN,categoryImage;

  Category({this.categoryId, this.categoryNameAR,this.categoryNameEN, this.categoryImage});

  factory Category.fromJson(json){
    return Category(
      categoryId: json['category_id'],
      categoryNameAR: json['category_name_ar'].toString().replaceAll("amp;", ''),
      categoryNameEN: json['category_name_en'].toString().replaceAll("amp;", ''),
      categoryImage: json['category_image'],
    );
  }

}
Future<List<Category>> fetchCategoriesData() async {
  List<Category> categories = List();
  http.Response response = await http
      .post("$domain/categories/read.php", body: {"categories": "categories"});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['categories'];
  for (var item in data) {
    categories.add( Category.fromJson(item));
  }
  return categories;
}
