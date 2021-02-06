import 'package:country_app2/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPage extends StatelessWidget {
  final CountryModel country;
  static TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 25,
  );

  const DetailPage({Key key, @required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B1D76), Colors.purple])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(
            country.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SvgPicture.network(
                country.flag,
                width: MediaQuery.of(context).size.width,
              ),
              Text("Capital City: " + country.capital, style: _textStyle),
              Text("People: " + country.demonym, style: _textStyle),
              Text("Population: " + country.population.toString(),
                  style: _textStyle),
              Text("Native Name: " + country.nativeName, style: _textStyle),
              country.currencies[0].symbol == null
                  ? Text("Currency: " + country.currencies[0].name,
                      style: _textStyle)
                  : Text(
                      "Currency: " +
                          country.currencies[0].name +
                          "(" +
                          country.currencies[0].symbol +
                          ")",
                      style: _textStyle),
              Text("Region: " + country.region, style: _textStyle),
              Text("Subregion: " + country.subregion, style: _textStyle),
              Text("Language: " + country.languages[0].name, style: _textStyle),
              country.borders.length == 0
                  ? Text("Borders: There are no borders", style: _textStyle)
                  : Text("Borders: " + listToString(country.borders),
                      style: _textStyle),
            ],
          ),
        ),
      ),
    );
  }

  String listToString(List<String> l) {
    String s = l.join(', ');
    return s;
  }
}
