import 'dart:convert';
import 'package:http/http.dart' as http;
import '../general.dart';

class Numbers{
  String numberId,name,resturantId,numberType,phoneNumber;

  Numbers({this.numberId, this.name, this.resturantId, this.numberType ="delivery", this.phoneNumber});


  factory Numbers.fromJson(json){
    return Numbers(
      numberId: json['number_id'],
      name: json['name'].toString().replaceAll("amp;", ''),
      resturantId: json['resturant_id'],
      numberType: json['number_type'],
      phoneNumber: json['phone_number'],
    );
  }
  create() async {
    http.Response response =
    await http.post("$domain/number/create.php", body: {
      'resturant_id': globalRestaurant.id,
      'name': this.name,
      'phone_number': this.phoneNumber,
      'number_type': this.numberType,
    });
    var res = json.decode(response.body);
    print(res);
    if (!res['error']) {
      return true;
    }
    return false;
  }
}
List<Numbers> getNumbers(json){
  List<Numbers> maps = List();
  List data = json['numbers'];
  for(var item in data){
    maps.add(Numbers.fromJson(item));
  }
  return maps;
}
Future<List<Numbers>> fetchNumbersData({String resturantId}) async {
  List<Numbers> numbers = List();
  http.Response response = await http
      .post("$domain/number/read.php", body: {"resturant_id": resturantId});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['Number'];
  for (var item in data) {
    numbers.insert(0, Numbers.fromJson(item));
  }
  return numbers;
}
Future<bool> deleteNumber({String numberId}) async {
  http.Response response =
  await http.post("$domain/number/delete.php", body: {"number_id": numberId});
  print(response.body);
  var res = json.decode(response.body);
  print(res);

  if (!res['error']) {
    return true;
  } else {
    return false;
  }
}
