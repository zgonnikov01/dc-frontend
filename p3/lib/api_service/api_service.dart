// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'api_service_models.dart';

class ApiService {
  final String url = 'https://backend.dc-api.ru';
  //final String url = 'http://backend.dc-api.ru';
  //final String url = 'http://127.0.0.1:8000';

  Future<Map<String, CardDataModel>?> getCardsData(DateTime start, DateTime end,
      String sector, String city, String store) async {
    try {
      if (sector == "Все секторы") {
        sector = "";
      }
      if (city == "Все города") {
        city = "";
      }
      if (store == "Все магазины") {
        store = "";
      }
      const storage = FlutterSecureStorage();
      final String token = await storage.read(key: 'jwt') ?? '';
      var response = await http.get(
        Uri.parse('$url/get_sales_data/all?' +
            '&date_time_start=' +
            start.toUtc().toString() +
            '&date_time_end=' +
            end.toUtc().toString() +
            '&sector=$sector&city=$city&store=$store'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        Map<String, CardDataModel> _model =
            cardDataModelFromJson(decodedResponse);

        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<String?> getToken(String email, String password) async {
    try {
      var response = await http.post(Uri.parse('$url/token'),
          body: {'username': email, 'password': password});

      if (response.statusCode == 200) {
        //String decodedResponse = utf8.decode(response.bodyBytes);
        final String token = tokenFromJson(response.body).accessToken;
        const storage = FlutterSecureStorage();
        await storage.write(key: 'jwt', value: token);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<CardGraphDataModel?> getCardsGraph(String category, DateTime start,
      DateTime end, String sector, String city, String store) async {
    try {
      if (sector == "Все секторы") {
        sector = "";
      }
      if (city == "Все города") {
        city = "";
      }
      if (store == "Все магазины") {
        store = "";
      }
      const storage = FlutterSecureStorage();
      final String token = await storage.read(key: 'jwt') ?? '';
      var response = await http.get(
        Uri.parse('$url/get_card_graph?' +
            '&category=' +
            (category == '' ? '' : '%') +
            utf8
                .encode(category)
                .map((x) => x.toRadixString(16))
                .toList()
                .join('%')
                .toUpperCase() +
            '&date_time_start=' +
            start.toUtc().toString() +
            '&date_time_end=' +
            end.toUtc().toString() +
            '&sector=$sector&city=$city&store=$store'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      // var response =
      //     await http.get(Uri.parse('https://dc-api.ru/get_sales_data/all'));
      if (response.statusCode == 200) {
        String decodedResponse = response.body;
        CardGraphDataModel _model = cardGraphDataModelFromJson(decodedResponse);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<AvailableSources?> getAvailableSources() async {
    try {
      const storage = FlutterSecureStorage();
      final String token = await storage.read(key: 'jwt') ?? '';
      var response = await http.get(
        Uri.parse('$url/get_available'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        String decodedResponse = utf8.decode(response.bodyBytes);
        AvailableSources sources = availableSourcesFromJson(decodedResponse);
        sources.cities.insert(0, "Все города");
        sources.sectors.insert(0, "Все секторы");
        sources.stores.insert(0, "Все магазины");
        return sources;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
