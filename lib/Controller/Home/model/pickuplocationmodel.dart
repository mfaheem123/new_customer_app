// To parse this JSON data, do
//
//     final pickUpLocationModel = pickUpLocationModelFromJson(jsonString);

import 'dart:convert';

LocationModel pickUpLocationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String pickUpLocationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  bool? status;
  String? source;
  int? count;
  List<Result>? result;

  LocationModel({
    this.status,
    this.source,
    this.count,
    this.result,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    status: json["status"],
    source: json["source"],
    count: json["count"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "source": source,
    "count": count,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? name;
  String? postcode;
  double? lat;
  double? lon;

  Result({
    this.name,
    this.postcode,
    this.lat,
    this.lon,
  });


  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    postcode: json["postcode"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "postcode": postcode,
    "lat": lat,
    "lon": lon,
  };


}
