import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/card/season_card.dart';
import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeasonsScreen extends StatefulWidget {
  const SeasonsScreen({super.key, required this.title});

  final String title;

  @override
  State<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SeasonRepository>(context, listen: false).fetchSeasons();
    });
  }

  late double screenWidth;
  late double screenHeight;

  Widget seasonCardsColumn(BuildContext context) {
    final seasonRepository = Provider.of<SeasonRepository>(context);

    if (seasonRepository.isSeasonsFetching || seasonRepository.getSeasonList == null) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Widget> seasonCards = [];

    for (var element in seasonRepository.getSeasonList!) {
      seasonCards.add(SeasonCard(season: element));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seasonCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Stack(
        children: <Widget>[
          const BackgroundBottom(),
          Positioned(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.20,
                      ),
                      seasonCardsColumn(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const BackgroundTop(title: "Seasons"),
        ],
      ),
    );
  }
}
