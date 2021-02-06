import 'dart:async';
import 'dart:convert';
import 'package:country_app2/models/country_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://restcountries.eu/rest/v2/all";

Future<List<CountryModel>> fetchCountries() async {
  final response = await http.get(baseUrl);

  if (response.statusCode == 200) {
    var jsonBody = json.decode(response.body);
    if (jsonBody is List) {
      return jsonBody.map((e) => CountryModel.fromJson(e)).toList();
    }
  }
}
