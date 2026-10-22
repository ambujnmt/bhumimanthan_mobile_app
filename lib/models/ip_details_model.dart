// class IpDetailsModel {
//   final int? ipVersion;
//   final String? ipAddress;
//   final double? latitude;
//   final double? longitude;
//   final String? countryName;
//   final String? countryCode;
//   final String? capital;
//   final List<int> phoneCodes;
//   final List<String> timeZones;
//   final String? zipCode;
//   final String? cityName;
//   final String? regionName;
//   final String? regionCode;
//   final String? continent;
//   final String? continentCode;
//   final List<String> currencies;
//   final List<String> languages;
//   final String? asn;
//   final String? asnOrganization;
//   final bool? isProxy;

//   const IpDetailsModel({
//     this.ipVersion,
//     this.ipAddress,
//     this.latitude,
//     this.longitude,
//     this.countryName,
//     this.countryCode,
//     this.capital,
//     this.phoneCodes = const [],
//     this.timeZones = const [],
//     this.zipCode,
//     this.cityName,
//     this.regionName,
//     this.regionCode,
//     this.continent,
//     this.continentCode,
//     this.currencies = const [],
//     this.languages = const [],
//     this.asn,
//     this.asnOrganization,
//     this.isProxy,
//   });

//   factory IpDetailsModel.fromJson(Map<String, dynamic> json) {
//     return IpDetailsModel(
//       ipVersion: (json['ipVersion'] as num?)?.toInt(),
//       ipAddress: json['ipAddress'] as String?,
//       latitude: (json['latitude'] as num?)?.toDouble(),
//       longitude: (json['longitude'] as num?)?.toDouble(),
//       countryName: json['countryName'] as String?,
//       countryCode: json['countryCode'] as String?,
//       capital: json['capital'] as String?,
//       phoneCodes:
//           (json['phoneCodes'] as List<dynamic>?)
//               ?.map((e) => (e as num).toInt())
//               .toList() ??
//           [],
//       timeZones:
//           (json['timeZones'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           [],
//       zipCode: json['zipCode']?.toString(),
//       cityName: json['cityName'] as String?,
//       regionName: json['regionName'] as String?,
//       regionCode: json['regionCode'] as String?,
//       continent: json['continent'] as String?,
//       continentCode: json['continentCode'] as String?,
//       currencies:
//           (json['currencies'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           [],
//       languages:
//           (json['languages'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           [],
//       asn: json['asn']?.toString(),
//       asnOrganization: json['asnOrganization'] as String?,
//       isProxy: json['isProxy'] as bool?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'ipVersion': ipVersion,
//       'ipAddress': ipAddress,
//       'latitude': latitude,
//       'longitude': longitude,
//       'countryName': countryName,
//       'countryCode': countryCode,
//       'capital': capital,
//       'phoneCodes': phoneCodes,
//       'timeZones': timeZones,
//       'zipCode': zipCode,
//       'cityName': cityName,
//       'regionName': regionName,
//       'regionCode': regionCode,
//       'continent': continent,
//       'continentCode': continentCode,
//       'currencies': currencies,
//       'languages': languages,
//       'asn': asn,
//       'asnOrganization': asnOrganization,
//       'isProxy': isProxy,
//     };
//   }
// }

class IpDetailsModel {
  final String? ip;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? state;
  final String? country;
  final String? timezone;
  final dynamic matchedCity;

  const IpDetailsModel({
    this.ip,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.country,
    this.timezone,
    this.matchedCity,
  });

  factory IpDetailsModel.fromJson(Map<String, dynamic> json) {
    return IpDetailsModel(
      ip: json['ip'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      timezone: json['timezone'] as String?,
      matchedCity: json['matched_city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'state': state,
      'country': country,
      'timezone': timezone,
      'matched_city': matchedCity,
    };
  }
}
