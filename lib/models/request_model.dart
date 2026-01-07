import 'dart:convert';

import 'package:drive_resq/models/location_model.dart';


class RequestModel {
  final String? id;
  final String? description;
  final String? vehicleInfo;
  final String? status;
  final LocationModel? location;
  final LocationModel? mechanicLocation;
  final String? phone;
  final List<String> images;

  RequestModel({
    this.id,
    this.description,
    this.vehicleInfo,
    this.status,
    this.location,
    this.mechanicLocation,
    this.phone,
    required this.images,
  });

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    LocationModel? parseLocation(dynamic value) {
      if (value == null) return null;

      if (value is String) {
        try {
          final decoded = jsonDecode(value);
          return LocationModel.fromMap(
            Map<String, dynamic>.from(decoded),
          );
        } catch (_) {
          return null;
        }
      }

      if (value is Map) {
        return LocationModel.fromMap(
          Map<String, dynamic>.from(value),
        );
      }

      return null;
    }

    return RequestModel(
      id: map['id']?.toString(),
      description: map['description'],
      vehicleInfo: map['vehicle_info'],
      status: map['status'],
      location: parseLocation(map['location']),
      mechanicLocation: parseLocation(map['mechanic_location']),
      phone: map['phone'],
      images: map['images'] != null
          ? List<String>.from(map['images'])
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'vehicle_info': vehicleInfo,
      'status': status,
      'location': location?.toMap(),
      'mechanic_location': mechanicLocation?.toMap(),
      'phone': phone,
      'images': images,
    };
  }
}
