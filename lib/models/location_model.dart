part of 'models.dart';

// To parse this JSON data, do
//
//     final mapLocation = mapLocationFromJson(jsonString);

MapLocation mapLocationFromJson(String str) {
  print(str);
  return MapLocation.fromJson(json.decode(str));
}
    

String mapLocationToJson(MapLocation data) => json.encode(data.toJson());

class MapLocation {
  List<Candidate> candidates;
  String status;

  MapLocation({
    required this.candidates,
    required this.status,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) => MapLocation(
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
        "status": status,
      };
}

class Candidate {
  String formattedAddress;
  Geometry geometry;
  String name;

  Candidate({
    required this.formattedAddress,
    required this.geometry,
    required this.name,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "name": name,
      };
}

class Geometry {
  Location location;
  Viewport? viewport;

  Geometry({
    required this.location,
    this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport?.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}
