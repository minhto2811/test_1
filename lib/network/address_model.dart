
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AddressModel welcomeFromJson(String str) => AddressModel.fromJson(json.decode(str));

String welcomeToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  String title;
  String id;
  Address address;
  Position position;

  AddressModel({
    required this.title,
    required this.id,
    required this.address,
    required this.position,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    title: json["title"],
    id: json["id"],
    address: Address.fromJson(json["address"]),
    position: Position.fromJson(json["position"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "address": address.toJson(),
    "position": position.toJson(),
  };
}

class Address {
  String label;
  String countryCode;
  String countryName;
  String? county;
  String? city;
  String? postalCode;

  Address({
    required this.label,
    required this.countryCode,
    required this.countryName,
    required this.county,
    required this.city,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    label: json["label"],
    countryCode: json["countryCode"],
    countryName: json["countryName"],
    county: json["county"],
    city: json["city"],
    postalCode: json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "countryCode": countryCode,
    "countryName": countryName,
    "county": county,
    "city": city,
    "postalCode": postalCode,
  };

  @override
  String toString() {
    return 'Address{label: $label, countryCode: $countryCode, countryName: $countryName, county: $county, city: $city, postalCode: $postalCode}';
  }
}

class Position {
  double lat;
  double lng;

  Position({
    required this.lat,
    required this.lng,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
