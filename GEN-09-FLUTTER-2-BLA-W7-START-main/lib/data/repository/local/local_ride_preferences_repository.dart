import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/ride/ride_pref.dart';
import '../../dto/ride_preference_dto.dart';
import '../../repository/ride_preferences_repository.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  final SharedPreferences prefs;

  LocalRidePreferencesRepository({required this.prefs});

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Get the string list form the key
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    // Convert the string list to a list of RidePreferences – Using map()
    // Convert the string list to a list of RidePreferences – Using map()
    return prefsList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)).toDomain())
        .toList();
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    // Call getPastPreferences()
    final preferences = await getPastPreferences();

    // Add the new preference to the list
    preferences.add(preference);

    // Save the new list as a string list
    await prefs.setStringList(
      _preferencesKey,
      preferences
          .map(
              (pref) => jsonEncode(RidePreferenceDto.fromDomain(pref).toJson()))
          .toList(),
    );
  }
}
