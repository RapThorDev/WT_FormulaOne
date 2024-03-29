import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/card/season_card.dart';
import 'package:f1_application/app/ui/seasons/seasons_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeasonsScreen extends StatefulWidget {
  const SeasonsScreen({super.key, required this.title});

  final String title;

  @override
  State<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen> {
  late Size _screenSize;
  SeasonViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = Provider.of<SeasonViewModel>(context, listen: false);
      _viewModel!.fetchSeasons();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      setState(() {
        _viewModel = Provider.of<SeasonViewModel>(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    double screenHeight = _screenSize.height;

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
                      _seasonCardsColumn()
                    ],
                  ),
                ),
              ),
            ),
          ),
          BackgroundTop(title: widget.title),
        ],
      ),
    );
  }

  Widget _seasonCardsColumn() {
    if (_viewModel!.isSeasonsFetching) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Widget> seasonCards = _viewModel!.seasons.map((season) => SeasonCard(season: season)).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seasonCards,
    );
  }
}
