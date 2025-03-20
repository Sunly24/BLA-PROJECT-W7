import 'package:flutter/material.dart';
import '../../model/ride/ride_pref.dart';
import '../../repository/ride_preferences_repository.dart';

class RidePreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;

  List<RidePreference> _pastPreferences = [];

  final RidePreferencesRepository repository;

  RidePreferencesProvider({required this.repository}) {
    // For now past preferences are fetched only 1 time
    // Your code
    _pastPreferences = repository.getPastPreferences();
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

  void addPastPreference(RidePreference preference) {
    // Your code
    if (!_pastPreferences.contains(preference)) {
      _pastPreferences.add(preference);
      repository.addPreference(preference);
    }
  }

  // History is returned from newest to oldest preference
  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();
}
