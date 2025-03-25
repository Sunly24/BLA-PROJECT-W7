import '../../model/location/locations.dart';
import '../../model/ride/ride_pref.dart';
import 'location_dto.dart';

class RidePreferenceDto {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  RidePreferenceDto({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

  factory RidePreferenceDto.fromJson(Map<String, dynamic> json) {
    return RidePreferenceDto(
      departure: LocationDto.fromJson(json['departure']),
      departureDate: DateTime.parse(json['departureDate']),
      arrival: LocationDto.fromJson(json['arrival']),
      requestedSeats: json['requestedSeats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departure': LocationDto.toJson(departure),
      'departureDate': departureDate.toIso8601String(),
      'arrival': LocationDto.toJson(arrival),
      'requestedSeats': requestedSeats,
    };
  }

  factory RidePreferenceDto.fromDomain(RidePreference preference) {
    return RidePreferenceDto(
      departure: preference.departure,
      departureDate: preference.departureDate,
      arrival: preference.arrival,
      requestedSeats: preference.requestedSeats,
    );
  }

  RidePreference toDomain() {
    return RidePreference(
      departure: departure,
      departureDate: departureDate,
      arrival: arrival,
      requestedSeats: requestedSeats,
    );
  }
}
