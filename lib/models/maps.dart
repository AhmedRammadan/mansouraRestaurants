class Maps{
  String mapId,name,resturantId,latitude,longitude;

  Maps({this.mapId, this.name, this.resturantId, this.latitude, this.longitude});

  factory Maps.fromJson(json){
    return Maps(
      mapId: json['map_id'],
      name: json['name'],
      resturantId: json['resturant_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
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