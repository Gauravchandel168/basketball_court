import 'dart:convert';
/// quantity : 0

BuyPrizesRequestModel buyPrizesRequestModelFromJson(String str) => BuyPrizesRequestModel.fromJson(json.decode(str));
String buyPrizesRequestModelToJson(BuyPrizesRequestModel data) => json.encode(data.toJson());
class BuyPrizesRequestModel {
  BuyPrizesRequestModel({
      num? quantity,}){
    _quantity = quantity;
}

  BuyPrizesRequestModel.fromJson(dynamic json) {
    _quantity = json['quantity'];
  }
  num? _quantity;
BuyPrizesRequestModel copyWith({  num? quantity,
}) => BuyPrizesRequestModel(  quantity: quantity ?? _quantity,
);
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = _quantity;
    return map;
  }

}