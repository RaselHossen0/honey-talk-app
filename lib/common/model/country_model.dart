class CountryModel {
  final int? id;
  final String? name;
  final String? iso3;
  final String? iso2;
  final String? numericCode;
  final String? phoneCode;
  final String? capital;
  final String? currency;
  final String? currencyName;
  final String? currencySymbol;
  final String? tld;
  final String? native;
  final String? region;
  final String? regionId;
  final String? subregion;
  final String? subregionId;
  final String? nationality;
  final List<Timezone>? timezones;
  final Translations? translations;
  final String? latitude;
  final String? longitude;
  final String? emoji;
  final String? emojiU;
  final List<State>? states;

  CountryModel({
    this.id,
    this.name,
    this.iso3,
    this.iso2,
    this.numericCode,
    this.phoneCode,
    this.capital,
    this.currency,
    this.currencyName,
    this.currencySymbol,
    this.tld,
    this.native,
    this.region,
    this.regionId,
    this.subregion,
    this.subregionId,
    this.nationality,
    this.timezones,
    this.translations,
    this.latitude,
    this.longitude,
    this.emoji,
    this.emojiU,
    this.states,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        numericCode: json["numeric_code"],
        phoneCode: json["phone_code"],
        capital: json["capital"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        tld: json["tld"],
        native: json["native"],
        region: json["region"],
        regionId: json["region_id"],
        subregion: json["subregion"],
        subregionId: json["subregion_id"],
        nationality: json["nationality"],
        timezones: json["timezones"] == null ? [] : List<Timezone>.from(json["timezones"]!.map((x) => Timezone.fromJson(x))),
        translations: json["translations"] == null ? null : Translations.fromJson(json["translations"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
        states: json["states"] == null ? [] : List<State>.from(json["states"]!.map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "numeric_code": numericCode,
        "phone_code": phoneCode,
        "capital": capital,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "tld": tld,
        "native": native,
        "region": region,
        "region_id": regionId,
        "subregion": subregion,
        "subregion_id": subregionId,
        "nationality": nationality,
        "timezones": timezones == null ? [] : List<dynamic>.from(timezones!.map((x) => x.toJson())),
        "translations": translations?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "emoji": emoji,
        "emojiU": emojiU,
        "states": states == null ? [] : List<dynamic>.from(states!.map((x) => x.toJson())),
      };
}

class State {
  final int? id;
  final String? name;
  final String? stateCode;
  final String? latitude;
  final String? longitude;
  final dynamic type;
  final List<City>? cities;

  State({
    this.id,
    this.name,
    this.stateCode,
    this.latitude,
    this.longitude,
    this.type,
    this.cities,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        stateCode: json["state_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
        cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_code": stateCode,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  final int? id;
  final String? name;
  final String? latitude;
  final String? longitude;

  City({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Timezone {
  final String? zoneName;
  final int? gmtOffset;
  final String? gmtOffsetName;
  final String? abbreviation;
  final String? tzName;

  Timezone({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        zoneName: json["zoneName"],
        gmtOffset: json["gmtOffset"],
        gmtOffsetName: json["gmtOffsetName"],
        abbreviation: json["abbreviation"],
        tzName: json["tzName"],
      );

  Map<String, dynamic> toJson() => {
        "zoneName": zoneName,
        "gmtOffset": gmtOffset,
        "gmtOffsetName": gmtOffsetName,
        "abbreviation": abbreviation,
        "tzName": tzName,
      };
}

class Translations {
  final String? kr;
  final String? ptBr;
  final String? pt;
  final String? nl;
  final String? hr;
  final String? fa;
  final String? de;
  final String? es;
  final String? fr;
  final String? ja;
  final String? it;
  final String? cn;
  final String? tr;

  Translations({
    this.kr,
    this.ptBr,
    this.pt,
    this.nl,
    this.hr,
    this.fa,
    this.de,
    this.es,
    this.fr,
    this.ja,
    this.it,
    this.cn,
    this.tr,
  });

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
        kr: json["kr"],
        ptBr: json["pt-BR"],
        pt: json["pt"],
        nl: json["nl"],
        hr: json["hr"],
        fa: json["fa"],
        de: json["de"],
        es: json["es"],
        fr: json["fr"],
        ja: json["ja"],
        it: json["it"],
        cn: json["cn"],
        tr: json["tr"],
      );

  Map<String, dynamic> toJson() => {
        "kr": kr,
        "pt-BR": ptBr,
        "pt": pt,
        "nl": nl,
        "hr": hr,
        "fa": fa,
        "de": de,
        "es": es,
        "fr": fr,
        "ja": ja,
        "it": it,
        "cn": cn,
        "tr": tr,
      };
}
