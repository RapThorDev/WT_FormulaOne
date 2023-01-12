import 'package:f1_application/app/ui/driver_profile/driver_profile_page.dart';
import 'package:f1_application/app/ui/driver_profile/driver_profile_view_model.dart';
import 'package:f1_application/app/ui/grid/grid_page.dart';
import 'package:f1_application/app/ui/grid/grid_view_model.dart';
import 'package:f1_application/app/ui/seasons/seasons_page.dart';
import 'package:f1_application/app/ui/seasons/seasons_view_model.dart';
import 'package:f1_application/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SeasonViewModel seasonViewModel = SeasonViewModel();
  GridViewModel gridViewModel = GridViewModel();
  DriverProfileViewModel driverProfileViewModel = DriverProfileViewModel();

  return runApp(MyApp(seasonViewModel, gridViewModel, driverProfileViewModel));
}

class MyApp extends StatefulWidget {


  final SeasonViewModel seasonViewModel;
  final GridViewModel gridViewModel;
  final DriverProfileViewModel driverProfileViewModel;

  const MyApp(this.seasonViewModel, this.gridViewModel, this.driverProfileViewModel, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.seasonViewModel),
        ChangeNotifierProvider(create: (context) => widget.gridViewModel),
        ChangeNotifierProvider(create: (context) => widget.driverProfileViewModel),
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