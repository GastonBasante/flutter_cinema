class MovieProvidersResponse {
  final int id;
  final Map<String, Result> results;

  MovieProvidersResponse({required this.id, required this.results});

  factory MovieProvidersResponse.fromJson(Map<String, dynamic> json) =>
      MovieProvidersResponse(
        id: json["id"],
        results: Map.from(
          json["results"],
        ).map((k, v) => MapEntry<String, Result>(k, Result.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": Map.from(
      results,
    ).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Result {
  final String link;
  final List<Flatrate>? flatrate;

  Result({required this.link, required this.flatrate});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    link: json["link"],
    flatrate: json["flatrate"] == null
        ? []
        : List<Flatrate>.from(
            json["flatrate"].map((x) => Flatrate.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "flatrate": flatrate != null
        ? List<dynamic>.from(flatrate!.map((x) => x.toJson()))
        : [],
  };
}

class Flatrate {
  final String logoPath;
  final int providerId;
  final String providerName;
  final int displayPriority;

  Flatrate({
    required this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory Flatrate.fromJson(Map<String, dynamic> json) => Flatrate(
    logoPath: json["logo_path"],
    providerId: json["provider_id"],
    providerName: json["provider_name"],
    displayPriority: json["display_priority"],
  );

  Map<String, dynamic> toJson() => {
    "logo_path": logoPath,
    "provider_id": providerId,
    "provider_name": providerName,
    "display_priority": displayPriority,
  };
}

// enum LogoPath {
//     DP_R8_R13_Z_W_DE_UR0_QKZ_WIDRD_MXA56_JPG,
//     PBP_MK2_JMCO_NN_QWX5_J_GP_XNGFO_WTP_JPG
// }

// final logoPathValues = EnumValues({
//     "/dpR8r13zWDeUR0QkzWidrdMxa56.jpg": LogoPath.DP_R8_R13_Z_W_DE_UR0_QKZ_WIDRD_MXA56_JPG,
//     "/pbpMk2JmcoNnQwx5JGpXngfoWtp.jpg": LogoPath.PBP_MK2_JMCO_NN_QWX5_J_GP_XNGFO_WTP_JPG
// });

// enum ProviderName {
//     NETFLIX,
//     NETFLIX_STANDARD_WITH_ADS
// }

// final providerNameValues = EnumValues({
//     "Netflix": ProviderName.NETFLIX,
//     "Netflix Standard with Ads": ProviderName.NETFLIX_STANDARD_WITH_ADS
// });

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
