import 'dart:convert';

Map<String, CardDataModel> cardDataModelFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, CardDataModel>(k, CardDataModel.fromJson(v)));

String cardDataModelToJson(Map<String, CardDataModel> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CardDataModel {
  CardDataModel({
    required this.fact,
    required this.plan,
    required this.pred,
  });

  int fact;
  double plan;
  double pred;

  factory CardDataModel.fromJson(Map<String, dynamic> json) => CardDataModel(
        fact: json["fact"],
        plan: json["plan"]?.toDouble(),
        pred: json["pred"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "plan": plan,
        "pred": pred,
      };
}

CardGraphDataModel cardGraphDataModelFromJson(String str) =>
    CardGraphDataModel.fromJson(json.decode(str));

String cardGraphDataModelToJson(CardGraphDataModel data) =>
    json.encode(data.toJson());

class CardGraphDataModel {
  CardGraphDataModel({
    required this.dates,
    required this.fact,
    required this.plan,
    required this.pred,
  });

  List<String> dates;
  List<int> fact;
  List<dynamic> plan;
  List<dynamic> pred;

  factory CardGraphDataModel.fromJson(Map<String, dynamic> json) =>
      CardGraphDataModel(
        dates: List<String>.from(json["dates"].map((x) => x)),
        fact: List<int>.from(json["fact"].map((x) => x)),
        plan: List<dynamic>.from(json["plan"].map((x) => x)),
        pred: List<dynamic>.from(json["pred"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "dates": List<dynamic>.from(dates.map((x) => x)),
        "fact": List<dynamic>.from(fact.map((x) => x)),
        "plan": List<dynamic>.from(plan.map((x) => x)),
        "pred": List<dynamic>.from(pred.map((x) => x)),
      };
}
// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.accessToken,
  });

  String accessToken;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}

AvailableSources availableSourcesFromJson(String str) =>
    AvailableSources.fromJson(json.decode(str));

String availableSourcesToJson(AvailableSources data) =>
    json.encode(data.toJson());

class AvailableSources {
  List<String> sectors;
  List<String> cities;
  List<String> stores;

  AvailableSources({
    required this.sectors,
    required this.cities,
    required this.stores,
  });

  factory AvailableSources.fromJson(Map<String, dynamic> json) =>
      AvailableSources(
        sectors: List<String>.from(json["sectors"].map((x) => x)),
        cities: List<String>.from(json["cities"].map((x) => x)),
        stores: List<String>.from(json["stores"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sectors": List<dynamic>.from(sectors.map((x) => x)),
        "cities": List<dynamic>.from(cities.map((x) => x)),
        "stores": List<dynamic>.from(stores.map((x) => x)),
      };
}
