import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/data/repository/local/local_ride_preferences_repository.dart';
import 'package:week_3_blabla_project/firebase_options.dart';
import 'data/repository/mock/mock_locations_repository.dart';
import 'data/repository/mock/mock_rides_repository.dart';
import 'service/locations_service.dart';
import 'service/rides_service.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/providers/ride_prefs_provider.dart';
import 'ui/theme/theme.dart';

Future<void> main() async {
  // 1 - Initialize the services
  LocationsService.initialize(MockLocationsRepository());
  RidesService.initialize(MockRidesRepository());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2- Run the UI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RidePreferencesProvider(
            repository: LocalRidePreferencesRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const Scaffold(body: RidePrefScreen()),
      ),
    );
  }
}
