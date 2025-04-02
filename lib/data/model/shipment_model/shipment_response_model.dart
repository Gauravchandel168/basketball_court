import 'dart:convert';

/// message : "string"
/// shipments : [{"address":{"city":"string","country":"string","name":"string","phoneNumber":"string","postalCode":"string","state":"string","street":"string"},"createdAt":"string","id":"string","item":{"id":"string","imageURL":"string","name":"string","quantity":0},"shipmentMonth":"string","shippingStatus":{"carrier":"string","deliveredAt":"string","estimatedDeliveryDate":"string","status":"string","trackingNumber":"string"},"updatedAt":"string","userId":"string"}]

ShipmentResponseModel shipmentResponseModelFromJson(String str) =>
    ShipmentResponseModel.fromJson(json.decode(str));
String shipmentResponseModelToJson(ShipmentResponseModel data) =>
    json.encode(data.toJson());

class ShipmentResponseModel {
  ShipmentResponseModel({
    String? message,
    List<Shipments>? shipments,
  }) {
    _message = message;
    _shipments = shipments;
  }

  ShipmentResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    if (json['shipments'] != null) {
      _shipments = [];
      json['shipments'].forEach((v) {
        _shipments?.add(Shipments.fromJson(v));
      });
    }
  }
  String? _message;
  List<Shipments>? _shipments;
  ShipmentResponseModel copyWith({
    String? message,
    List<Shipments>? shipments,
  }) =>
      ShipmentResponseModel(
        message: message ?? _message,
        shipments: shipments ?? _shipments,
      );
  String? get message => _message;
  List<Shipments>? get shipments => _shipments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_shipments != null) {
      map['shipments'] = _shipments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// address : {"city":"string","country":"string","name":"string","phoneNumber":"string","postalCode":"string","state":"string","street":"string"}
/// createdAt : "string"
/// id : "string"
/// item : {"id":"string","imageURL":"string","name":"string","quantity":0}
/// shipmentMonth : "string"
/// shippingStatus : {"carrier":"string","deliveredAt":"string","estimatedDeliveryDate":"string","status":"string","trackingNumber":"string"}
/// updatedAt : "string"
/// userId : "string"

Shipments shipmentsFromJson(String str) => Shipments.fromJson(json.decode(str));
String shipmentsToJson(Shipments data) => json.encode(data.toJson());

class Shipments {
  Shipments({
    Address? address,
    String? createdAt,
    String? id,
    Item? item,
    String? shipmentMonth,
    ShippingStatus? shippingStatus,
    String? updatedAt,
    String? userId,
  }) {
    _address = address;
    _createdAt = createdAt;
    _id = id;
    _item = item;
    _shipmentMonth = shipmentMonth;
    _shippingStatus = shippingStatus;
    _updatedAt = updatedAt;
    _userId = userId;
  }

  Shipments.fromJson(dynamic json) {
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _createdAt = json['createdAt'];
    _id = json['id'];
    _item = json['item'] != null ? Item.fromJson(json['item']) : null;
    _shipmentMonth = json['shipmentMonth'];
    _shippingStatus = json['shippingStatus'] != null
        ? ShippingStatus.fromJson(json['shippingStatus'])
        : null;
    _updatedAt = json['updatedAt'];
    _userId = json['userId'];
  }
  Address? _address;
  String? _createdAt;
  String? _id;
  Item? _item;
  String? _shipmentMonth;
  ShippingStatus? _shippingStatus;
  String? _updatedAt;
  String? _userId;
  Shipments copyWith({
    Address? address,
    String? createdAt,
    String? id,
    Item? item,
    String? shipmentMonth,
    ShippingStatus? shippingStatus,
    String? updatedAt,
    String? userId,
  }) =>
      Shipments(
        address: address ?? _address,
        createdAt: createdAt ?? _createdAt,
        id: id ?? _id,
        item: item ?? _item,
        shipmentMonth: shipmentMonth ?? _shipmentMonth,
        shippingStatus: shippingStatus ?? _shippingStatus,
        updatedAt: updatedAt ?? _updatedAt,
        userId: userId ?? _userId,
      );
  Address? get address => _address;
  String? get createdAt => _createdAt;
  String? get id => _id;
  Item? get item => _item;
  String? get shipmentMonth => _shipmentMonth;
  ShippingStatus? get shippingStatus => _shippingStatus;
  String? get updatedAt => _updatedAt;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['id'] = _id;
    if (_item != null) {
      map['item'] = _item?.toJson();
    }
    map['shipmentMonth'] = _shipmentMonth;
    if (_shippingStatus != null) {
      map['shippingStatus'] = _shippingStatus?.toJson();
    }
    map['updatedAt'] = _updatedAt;
    map['userId'] = _userId;
    return map;
  }
}

/// carrier : "string"
/// deliveredAt : "string"
/// estimatedDeliveryDate : "string"
/// status : "string"
/// trackingNumber : "string"

ShippingStatus shippingStatusFromJson(String str) =>
    ShippingStatus.fromJson(json.decode(str));
String shippingStatusToJson(ShippingStatus data) => json.encode(data.toJson());

class ShippingStatus {
  ShippingStatus({
    String? carrier,
    String? deliveredAt,
    String? estimatedDeliveryDate,
    String? status,
    String? trackingNumber,
  }) {
    _carrier = carrier;
    _deliveredAt = deliveredAt;
    _estimatedDeliveryDate = estimatedDeliveryDate;
    _status = status;
    _trackingNumber = trackingNumber;
  }

  ShippingStatus.fromJson(dynamic json) {
    _carrier = json['carrier'];
    _deliveredAt = json['deliveredAt'];
    _estimatedDeliveryDate = json['estimatedDeliveryDate'];
    _status = json['status'];
    _trackingNumber = json['trackingNumber'];
  }
  String? _carrier;
  String? _deliveredAt;
  String? _estimatedDeliveryDate;
  String? _status;
  String? _trackingNumber;
  ShippingStatus copyWith({
    String? carrier,
    String? deliveredAt,
    String? estimatedDeliveryDate,
    String? status,
    String? trackingNumber,
  }) =>
      ShippingStatus(
        carrier: carrier ?? _carrier,
        deliveredAt: deliveredAt ?? _deliveredAt,
        estimatedDeliveryDate: estimatedDeliveryDate ?? _estimatedDeliveryDate,
        status: status ?? _status,
        trackingNumber: trackingNumber ?? _trackingNumber,
      );
  String? get carrier => _carrier;
  String? get deliveredAt => _deliveredAt;
  String? get estimatedDeliveryDate => _estimatedDeliveryDate;
  String? get status => _status;
  String? get trackingNumber => _trackingNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['carrier'] = _carrier;
    map['deliveredAt'] = _deliveredAt;
    map['estimatedDeliveryDate'] = _estimatedDeliveryDate;
    map['status'] = _status;
    map['trackingNumber'] = _trackingNumber;
    return map;
  }
}

/// id : "string"
/// imageURL : "string"
/// name : "string"
/// quantity : 0

Item itemFromJson(String str) => Item.fromJson(json.decode(str));
String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    String? id,
    String? imageURL,
    String? name,
    num? quantity,
  }) {
    _id = id;
    _imageURL = imageURL;
    _name = name;
    _quantity = quantity;
  }

  Item.fromJson(dynamic json) {
    _id = json['id'];
    _imageURL = json['imageURL'];
    _name = json['name'];
    _quantity = json['quantity'];
  }
  String? _id;
  String? _imageURL;
  String? _name;
  num? _quantity;
  Item copyWith({
    String? id,
    String? imageURL,
    String? name,
    num? quantity,
  }) =>
      Item(
        id: id ?? _id,
        imageURL: imageURL ?? _imageURL,
        name: name ?? _name,
        quantity: quantity ?? _quantity,
      );
  String? get id => _id;
  String? get imageURL => _imageURL;
  String? get name => _name;
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['imageURL'] = _imageURL;
    map['name'] = _name;
    map['quantity'] = _quantity;
    return map;
  }
}

/// city : "string"
/// country : "string"
/// name : "string"
/// phoneNumber : "string"
/// postalCode : "string"
/// state : "string"
/// street : "string"

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    String? city,
    String? country,
    String? name,
    String? phoneNumber,
    String? postalCode,
    String? state,
    String? street,
  }) {
    _city = city;
    _country = country;
    _name = name;
    _phoneNumber = phoneNumber;
    _postalCode = postalCode;
    _state = state;
    _street = street;
  }

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _country = json['country'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _postalCode = json['postalCode'];
    _state = json['state'];
    _street = json['street'];
  }
  String? _city;
  String? _country;
  String? _name;
  String? _phoneNumber;
  String? _postalCode;
  String? _state;
  String? _street;
  Address copyWith({
    String? city,
    String? country,
    String? name,
    String? phoneNumber,
    String? postalCode,
    String? state,
    String? street,
  }) =>
      Address(
        city: city ?? _city,
        country: country ?? _country,
        name: name ?? _name,
        phoneNumber: phoneNumber ?? _phoneNumber,
        postalCode: postalCode ?? _postalCode,
        state: state ?? _state,
        street: street ?? _street,
      );
  String? get city => _city;
  String? get country => _country;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get postalCode => _postalCode;
  String? get state => _state;
  String? get street => _street;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['country'] = _country;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['postalCode'] = _postalCode;
    map['state'] = _state;
    map['street'] = _street;
    return map;
  }
}
