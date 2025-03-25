import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {
  // Static method to convert domain model to JSON
  static Map<String, dynamic> toJson(RidePreference model) {
    return {
      'departure': {
        'name': model.departure.name,
        'country': model.departure.country.name,
      },
      'departureDate': model.departureDate.toIso8601String(),
      'arrival': {
        'name': model.arrival.name,
        'country': model.arrival.country.name,
      },
      'requestedSeats': model.requestedSeats,
    };
  }

  // Static method to convert JSON to domain model
  static RidePreference fromJson(Map<String, dynamic> json) {
    final departureJson = json['departure'] as Map<String, dynamic>;
    final arrivalJson = json['arrival'] as Map<String, dynamic>;

    return RidePreference(
      departure: LocationDto.fromJson(departureJson),
      departureDate: DateTime.parse(json['departureDate']),
      arrival: LocationDto.fromJson(arrivalJson),
      requestedSeats: json['requestedSeats'],
    );
  }
}
