import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/ride/ride_pref.dart';
import '../../dto/ride_preference_dto.dart';
import '../../repository/ride_preferences_repository.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    try {
      // Get SharedPreferences instance
      final prefs = await SharedPreferences.getInstance();

      // Get the string list form the key
      final prefsList = prefs.getStringList(_preferencesKey) ?? [];
      // Convert the string list to a list of RidePreferences – Using map()
      return prefsList
          .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      // Handle any errors that might occur
      print("Error getting past preferences: $e");
      return [];
    }
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Call getPastPreferences()
      final preferences = await getPastPreferences();

      // Add the new preference to the list
      preferences.add(preference);

      // Save the new list as a string list
      await prefs.setStringList(
        _preferencesKey,
        preferences
            .map((pref) => jsonEncode(RidePreferenceDto.toJson(pref)))
            .toList(),
      );
    } catch (e) {
      // Handle any errors that might occur
      print("Error adding preference: $e");
    }
  }
}
