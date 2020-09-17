class Numbers{
  String numberId,name,resturantId,numberType,phoneNumber;

  Numbers({this.numberId, this.name, this.resturantId, this.numberType, this.phoneNumber});

  factory Numbers.fromJson(json){
    return Numbers(
      numberId: json['number_id'],
      name: json['name'],
      resturantId: json['resturant_id'],
      numberType: json['number_type'],
      phoneNumber: json['phone_number'],
    );
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