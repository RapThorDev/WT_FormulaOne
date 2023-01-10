import 'package:f1_application/app/ui/driver_profile/driver_profile_page.dart';
import 'package:f1_application/app/ui/grid/grid_page.dart';
import 'package:f1_application/app/ui/seasons/seasons_page.dart';
import 'package:f1_application/lib/service/driver_profile/driver_profile_service.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:f1_application/lib/service/season/season_service.dart';
import 'package:f1_application/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SeasonService seasonService = SeasonService();
  GridService gridService = GridService();
  DriverProfileService driverProfileService = DriverProfileService();

  return runApp(MyApp(seasonService, gridService, driverProfileService));
}

class MyApp extends StatefulWidget {


  final SeasonService seasonService;
  final GridService gridService;
  final DriverProfileService driverProfileService;

  const MyApp(this.seasonService, this.gridService, this.driverProfileService, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.seasonService),
        ChangeNotifierProvider(create: (context) => widget.gridService),
        ChangeNotifierProvider(create: (context) => widget.driverProfileService),
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