import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/ride_pref.dart';
import '../../providers/ride_prefs_provider.dart';
import '../../providers/async_value.dart';
import '../../theme/theme.dart';

import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  void onRidePrefSelected(
      BuildContext context, RidePreference newPreference) async {
    context.read<RidePreferencesProvider>().setCurrentPreference(newPreference);

    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RidePreferencesProvider>();
    final currentRidePreference = provider.currentPreference;
    final pastPreferences = provider.pastPreferences;

    return Stack(
      children: [
        // 1 - Background  Image
        BlaBackground(),

        // 2 - Foreground content
        Column(
          children: [
            SizedBox(height: BlaSpacings.m),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            SizedBox(height: 100),
            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(16), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 2.1 Display the Form to input the ride preferences
                  RidePrefForm(
                    initialPreference: currentRidePreference,
                    onSubmit: (preference) =>
                        onRidePrefSelected(context, preference),
                  ),
                  SizedBox(height: BlaSpacings.m),

                  // 2.2 Handle different states of past preferences
                  SizedBox(
                    height: 200,
                    child: _buildPastPreferencesList(pastPreferences, context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPastPreferencesList(
      AsyncValue<List<RidePreference>> pastPreferences, BuildContext context) {
    switch (pastPreferences.state) {
      case AsyncValueState.loading:
        return Center(
          child: Text(
            'Loading...',
            style: TextStyle(color: BlaColors.textLight),
          ),
        );
      case AsyncValueState.error:
        return Center(
          child: Text(
            'No connection. Try later',
            style: TextStyle(color: BlaColors.textLight),
          ),
        );
      case AsyncValueState.success:
        final preferences = pastPreferences.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: preferences.length,
          itemBuilder: (ctx, index) => RidePrefHistoryTile(
            ridePref: preferences[index],
            onPressed: () => onRidePrefSelected(context, preferences[index]),
          ),
        );
    }
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
