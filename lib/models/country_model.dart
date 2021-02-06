class CountryModel {
  String name;
  String capital;
  String region;
  String subregion;
  int population;
  String demonym;
  String nativeName;
  String flag;
  List<Currencies> currencies;
  List<String> borders;
  List<Languages> languages;

  CountryModel(
      {this.name,
      this.capital,
      this.region,
      this.subregion,
      this.population,
      this.demonym,
      this.nativeName,
      this.flag,
      this.currencies,
      this.borders,
      this.languages});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    capital = json['capital'];
    region = json['region'];
    subregion = json['subregion'];
    population = json['population'];
    demonym = json['demonym'];
    nativeName = json['nativeName'];
    flag = json['flag'];
    if (json['currencies'] != null) {
      currencies = new List<Currencies>();
      json['currencies'].forEach((v) {
        currencies.add(new Currencies.fromJson(v));
      });
    }
    borders = json['borders'].cast<String>();
    if (json['languages'] != null) {
      languages = new List<Languages>();
      json['languages'].forEach((v) {
        languages.add(new Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['capital'] = this.capital;
    data['region'] = this.region;
    data['subregion'] = this.subregion;
    data['population'] = this.population;
    data['demonym'] = this.demonym;
    data['nativeName'] = this.nativeName;
    data['flag'] = this.flag;
    if (this.currencies != null) {
      data['currencies'] = this.currencies.map((v) => v.toJson()).toList();
    }
    data['borders'] = this.borders;
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currencies {
  String code;
  String name;
  String symbol;

  Currencies({this.code, this.name, this.symbol});

  Currencies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}

class Languages {
  String iso6391;
  String iso6392;
  String name;
  String nativeName;

  Languages({this.iso6391, this.iso6392, this.name, this.nativeName});

  Languages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso639_1'];
    iso6392 = json['iso639_2'];
    name = json['name'];
    nativeName = json['nativeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso639_1'] = this.iso6391;
    data['iso639_2'] = this.iso6392;
    data['name'] = this.name;
    data['nativeName'] = this.nativeName;
    return data;
  }
}
