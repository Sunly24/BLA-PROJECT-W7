import 'package:flutter/material.dart';
import '../../model/ride/ride_pref.dart';
import '../../repository/ride_preferences_repository.dart';
import 'async_value.dart';

class RidePreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;

  late AsyncValue<List<RidePreference>> pastPreferences;

  final RidePreferencesRepository repository;

  void _fetchPastPreferences() async {
    // 1- Handle loading
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      // 2 Fetch data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();
      // 3 Handle success
      pastPreferences = AsyncValue.success(pastPrefs);
      // 4 Handle error
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }

  RidePreferencesProvider({required this.repository}) {
    // For now past preferences are fetched only 1 time
    // Your code
    _fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference preference) {
    // Your code
    if (_currentPreference != preference) {
      _currentPreference = preference;
      addPastPreference(preference);
      notifyListeners();
    }
  }

  void addPastPreference(RidePreference preference) async {
    // Your code
    if (!pastPreferences.data!.contains(preference)) {
      pastPreferences.data!.add(preference);
      await repository.addPreference(preference);
    }
  }

  // History is returned from newest to oldest preference
  List<RidePreference> get preferencesHistory =>
      pastPreferences.data!.reversed.toList();
}
