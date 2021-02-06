import 'package:country_app2/models/country_model.dart';
import 'package:country_app2/pages/details_page.dart';
import 'package:country_app2/services/country_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<CountryModel> _countryList = [];
  List<CountryModel> _countryListScreened = [];
  String countryName;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final countries = await fetchCountries();
    setState(() {
      _countryList = countries;
      _countryListScreened = countries;
    });
  }

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
            title: Center(child: Text('Countries App')),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      countryName = value.trim();
                      _countryListScreened = _countryList
                          .where((i) =>
                              i.name
                                  .toLowerCase()
                                  .contains(countryName.toLowerCase()) ||
                              i.nativeName
                                  .toLowerCase()
                                  .contains(countryName.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter country name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _countryListScreened.length,
                  itemBuilder: (context, index) => buildCountryCard(index),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildCountryCard(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    country: _countryListScreened[index],
                  )),
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 1,
        child: ListTile(
          title: Text(
            _countryListScreened[index].name,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Colors.white),
          ),
          leading: SvgPicture.network(
            _countryListScreened[index].flag,
            width: 50,
          ),
        ),
      ),
    );
  }
}
