import 'package:f1_application/provider/formula_one_provider.dart';
import 'package:f1_application/screen/DriverProfileScreen.dart';
import 'package:f1_application/screen/GridScreen.dart';
import 'package:f1_application/screen/SeasonsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen_routes.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  FormulaOneProvider formulaOneProvider = FormulaOneProvider(preferences);

  return runApp(MyApp(preferences, formulaOneProvider));
}

class MyApp extends StatefulWidget {

  final SharedPreferences preferences;
  final FormulaOneProvider formulaOneProvider;

  const MyApp(this.preferences, this.formulaOneProvider, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.formulaOneProvider)
      ],
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: MaterialApp(
          title: "Formula 1 ",
          routes: {
            ScreenRoutes.seasons.screenRoute: (context) => SeasonsScreen(title: ScreenRoutes.seasons.screenName),
            ScreenRoutes.grid.screenRoute: (context) => const GridScreen(),
            ScreenRoutes.driverProfile.screenRoute: (context) => const DriverProfileScreen(),
          },
        ),
      ),
    );
  }
}