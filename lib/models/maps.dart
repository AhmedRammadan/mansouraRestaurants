import 'dart:convert';
import 'package:http/http.dart' as http;
import '../general.dart';

class Maps{
  String mapId,name,resturantId,latitude,longitude;

  Maps({this.mapId, this.name, this.resturantId, this.latitude, this.longitude});

  factory Maps.fromJson(json){
    return Maps(
      mapId: json['map_id'],
      name: json['name'].toString().replaceAll("amp;", ''),
      resturantId: json['resturant_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
  create() async {
    http.Response response =
    await http.post("$domain/map/create.php", body: {
      'resturant_id': globalRestaurant.id,
      'name': this.name,
      'latitude': this.latitude,
      'longitude': this.longitude,
    });
    var res = json.decode(response.body);
    print(res);
    if (!res['error']) {
      return true;
    }
    return false;
  }
}
List<Maps> getMaps(json){
  List<Maps> maps = List();
  List data = json['maps'];
  for(var item in data){
    maps.add(Maps.fromJson(item));
  }
  return maps;
}
Future<List<Maps>> fetchMapsData({String resturantId}) async {
  List<Maps> maps = List();
  http.Response response = await http
      .post("$domain/map/read.php", body: {"resturant_id": resturantId});
  print(response.body);
  var res = json.decode(response.body);
  print(res);
  List data = res['Maps'];
  for (var item in data) {
    maps.insert(0, Maps.fromJson(item));
  }
  return maps;
}
Future<bool> deleteMap({String map_id}) async {
  http.Response response =
  await http.post("$domain/map/delete.php", body: {"map_id": map_id});
  print(response.body);
  var res = json.decode(response.body);
  print(res);

  if (!res['error']) {
    return true;
  } else {
    return false;
  }
}
