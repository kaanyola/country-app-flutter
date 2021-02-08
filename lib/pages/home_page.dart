import 'package:country_app2/models/country_model.dart';
import 'package:country_app2/pages/details_page.dart';
import 'package:country_app2/services/country_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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
    return buildContainer(context);
  }

  Container buildContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF303F9F), Color(0xFF3F51B5)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: _countryListScreened.length == 0
              ? Center(
                  child: LottieBuilder.network(
                  "https://assets7.lottiefiles.com/datafiles/80KSTPWWFB6US4g/data.json",
                  height: MediaQuery.of(context).size.height * 0.08,
                ))
              : buildColumn(context)),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Center(child: Text('Countries App')),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Theme(
            data: ThemeData(
                primaryColor: Color(0xFFBDBDBD),
                primaryColorDark: Color(0xFFBDBDBD)),
            child: buildTextFormField(),
          ),
        ),
        buildSizedBox(context),
        buildExpanded(),
      ],
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      onChanged: (value) {
        setState(() {
          countryName = value.trim();
          _countryListScreened = _countryList
              .where((i) =>
                  i.name.toLowerCase().contains(countryName.toLowerCase()) ||
                  i.nativeName
                      .toLowerCase()
                      .contains(countryName.toLowerCase()))
              .toList();
        });
      },
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFBDBDBD)),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          hintText: 'Enter country name',
          prefixIcon: Icon(Icons.search, color: Colors.white),
          hintStyle: TextStyle(color: Colors.white)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  SizedBox buildSizedBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Color(0xFFBDBDBD),
        ),
        itemCount: _countryListScreened.length,
        itemBuilder: (context, index) => buildCountryCard(index),
      ),
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
        elevation: 0,
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
