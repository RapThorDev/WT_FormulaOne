import 'package:f1_application/app/ui/driver_profile/driver_profile_page.dart';
import 'package:f1_application/app/ui/grid/grid_page.dart';
import 'package:f1_application/app/ui/seasons/seasons_page.dart';
import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:f1_application/lib/service/driver_profile/driver_profile_service.dart';
import 'package:f1_application/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SeasonRepository seasonRepository = SeasonRepository();
  GridRepository gridRepository = GridRepository();
  DriverProfileService driverProfileService = DriverProfileService();

  return runApp(MyApp(seasonRepository, gridRepository, driverProfileService));
}

class MyApp extends StatefulWidget {

  final SeasonRepository seasonRepository;
  final GridRepository gridRepository;

  final DriverProfileService driverProfileService;

  const MyApp(this.seasonRepository, this.gridRepository, this.driverProfileService, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.seasonRepository),
        ChangeNotifierProvider(create: (context) => widget.gridRepository),
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