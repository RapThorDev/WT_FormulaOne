import 'package:f1_application/app/ui/driver_profile/driver_profile_page.dart';
import 'package:f1_application/app/ui/grid/grid_page.dart';
import 'package:f1_application/app/ui/seasons/seasons_page.dart';
import 'package:f1_application/lib/datamanagement/repository/google_image_repository.dart';
import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:f1_application/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  GoogleImageRepository googleImageRepository = GoogleImageRepository();
  SeasonRepository seasonRepository = SeasonRepository();
  GridRepository gridRepository = GridRepository();

  return runApp(MyApp(googleImageRepository, seasonRepository, gridRepository));
}

class MyApp extends StatefulWidget {

  final GoogleImageRepository googleImageRepository;
  final SeasonRepository seasonRepository;
  final GridRepository gridRepository;

  const MyApp(this.googleImageRepository, this.seasonRepository, this.gridRepository, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.googleImageRepository),
        ChangeNotifierProvider(create: (context) => widget.seasonRepository),
        ChangeNotifierProvider(create: (context) => widget.gridRepository),
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