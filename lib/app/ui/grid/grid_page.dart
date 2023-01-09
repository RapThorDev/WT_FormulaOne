import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/card/driver_card.dart';
import 'package:f1_application/app/component/loading/full_page_loading.dart';
import 'package:f1_application/app/ui/grid/components/nation.dart';
import 'package:f1_application/app/ui/grid/components/summary.dart';
import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:f1_application/util/build_blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController searchTextController = TextEditingController();
  String searchTextString = "";

  @override
  void initState() {
    super.initState();
    Season? season = Provider.of<SeasonRepository>(context, listen: false).getSelectedSeason;
    if (season != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GridRepository>(context, listen: false).fetchGrid(season);
      });
    }
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final seasonRepository = Provider.of<SeasonRepository>(context, listen: false);
    Season? selectedSeason = seasonRepository.getSelectedSeason;

    return Material(
      child: Stack(
        children: <Widget>[
          const BackgroundBottom(),
          Positioned(
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenSize.height * 0.25,),
                    _searchField(),
                    _drivers(),
                    _summary()
                  ],
                ),
              ),
            ),
          ),
          BackgroundTop(title: "${selectedSeason?.shortYear} Grid"),
        ],
      ),
    );
  }

  Widget _nations() {
    final gridRepository = Provider.of<GridRepository>(context);

    if (gridRepository.isGridFetching) {
      return Container();
    }

    final gridService = GridService(gridRepository);

    List<Widget> nationList = [];

    gridService.nationsSummary().forEach((key, value) {
      nationList.add(Nation(key, value));
    });

    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: nationList,
      );
  }

  Widget _summary() {
    final gridRepository = Provider.of<GridRepository>(context);

    final gridService = GridService(gridRepository);

    if (
    gridRepository.isGridFetching
    || searchTextString.isNotEmpty
    || gridService.drivers.isEmpty
    ) {
      return Container();
    }

    return Summary(_nations());
  }

  Widget _drivers() {
    final gridRepository = Provider.of<GridRepository>(context);

    if (gridRepository.isGridFetching) {
      return const FullPageLoading();
    }

    final gridService = GridService(gridRepository);

    if (gridService.drivers.isEmpty) {
      return const SizedBox(
        child: Text(
          "In this season not found any driver\n"
              "Come back later",
        ),
      );
    }

    List<Widget> driverCards = [];

    if (searchTextString.isEmpty) {
      driverCards = gridService.drivers.map((driver) => DriverCard(driver: driver)).toList();
    } else {
      driverCards = gridService.relevantDriversByExpression(searchTextString).map((Driver driver) => DriverCard(driver: driver)).toList();
    }

    if (driverCards.isEmpty) {
      return const SizedBox(height: 30.00, child: Text("Not found anything"));
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: driverCards
    );

  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: searchTextController,
        decoration: const InputDecoration(
          hintText: "Name, nationality or year of the birth date",
          border: OutlineInputBorder(),
          labelText: "Search",
          floatingLabelAlignment: FloatingLabelAlignment.center,
          focusColor: Color(0xff880000),
          fillColor: Color(0xff880000),
        ),
        onChanged: (String value) {
          setState(() {
            searchTextString = value;
          });
        },
      ),
    );
  }

}
