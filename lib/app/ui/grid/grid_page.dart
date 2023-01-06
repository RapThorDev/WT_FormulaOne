import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/card/driver_card.dart';
import 'package:f1_application/app/component/loading/full_page_loading.dart';
import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/datamanagement/repository/season_repository.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/util/build_blur.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f1_application/util/countries.dart' as country;


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
    SeasonModel? season = Provider.of<SeasonRepository>(context, listen: false).getSelectedSeason;
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

  List<Widget> sortAndMakeNationList(Map<String, int> nations) {
    List<Widget> nationList = [];


    var sortedKeys = nations.keys.toList(growable: false)
      ..sort((k1, k2) => nations[k2]!.compareTo(nations[k1]!.toInt()));
    var sortedSummary = { for (var k in sortedKeys) k: nations[k]};

    Size screenSize = MediaQuery
        .of(context)
        .size;
    Size flagSize = const Size(45, 45);


    sortedSummary.forEach((key, value) {
      nationList.add(
          Container(
            width: screenSize.width * 0.9,
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flag.fromCode(
                  country.Countries.getByNationality(key)["flagsCode"],
                  height: flagSize.height,
                  width: flagSize.width,
                ),
                Text(
                  "${country.Countries.getByNationality(key)["name"]}",
                  style: const TextStyle(
                      fontSize: 26,
                      color: Color(0xffffffff),
                      shadows: [
                        Shadow(color: Color(0xff000000),
                            offset: Offset(2, 2),
                            blurRadius: 5),
                        Shadow(color: Color(0x88000000),
                            offset: Offset(1, 1),
                            blurRadius: 7),
                        Shadow(color: Color(0x22000000),
                            offset: Offset(0, 0),
                            blurRadius: 10),
                      ]
                  ),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                      fontSize: 28,
                      color: Color(0xffffffff),
                      shadows: [
                        Shadow(color: Color(0xff000000),
                            offset: Offset(2, 2),
                            blurRadius: 5),
                        Shadow(color: Color(0x88000000),
                            offset: Offset(1, 1),
                            blurRadius: 7),
                        Shadow(color: Color(0x22000000),
                            offset: Offset(0, 0),
                            blurRadius: 10),
                      ]
                  ),
                ),
              ],
            ),
          )
      );
    });

    return nationList;
  }

  Widget drawSummary(List<Widget> nations) {
    Size screenSize = MediaQuery.of(context).size;

    return
      Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            width: screenSize.width * 0.9,
            height: 2,
            color: const Color(0xff000000),
          ),
          const SizedBox(
            height: 20,
          ),
          buildBlur(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: Color(0x88000000)
              ),
              child: Column(
                children: [
                  const Text(
                    "Summary",
                    style: TextStyle(
                        fontFamily: "OleoScript",
                        fontSize: 92,
                        color: Color(0xffffffff),
                        shadows: [
                          Shadow(color: Color(0xff000000),
                              offset: Offset(2, 2),
                              blurRadius: 5),
                          Shadow(color: Color(0x88000000),
                              offset: Offset(1, 1),
                              blurRadius: 7),
                          Shadow(color: Color(0x22000000),
                              offset: Offset(0, 0),
                              blurRadius: 10),
                        ]
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: nations,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }

  Widget drawDriversAndSummary() {
    final seasonRepository = Provider.of<SeasonRepository>(context);
    final gridRepository = Provider.of<GridRepository>(context);

    if (gridRepository.isGridFetching) {
      return const FullPageLoading();
    }

    SeasonModel? selectedSeason = seasonRepository.getSelectedSeason;
    List<DriverModel>? driverList = gridRepository.getGridDriverList;

    if (selectedSeason == null) return const SizedBox(child: Text("Not found selected season"),);
    if (driverList == null) return const SizedBox(child: Text("Not found Grid driver list"),);

    List<DriverModel> currentDrivers = [];
    for (var driverId in selectedSeason.driverIds) {
      currentDrivers.add(
          driverList.firstWhere((driver) => driver.id == driverId));
    }

    if (currentDrivers.isEmpty) return const SizedBox(child: Text("In this season not found any driver\nCome back later", textAlign: TextAlign.center,),);

    List<Widget> driverCardsAndSummary = [];
    Map<String, int> summary = {};

    for (var driver in currentDrivers) {
      if (searchTextString.isNotEmpty) {
        if (driver.getSearchableParams.contains(searchTextString.toLowerCase())) {
          driverCardsAndSummary.add(DriverCard(driver: driver));
        }
      } else {
        driverCardsAndSummary.add(DriverCard(driver: driver));
      }

      if (!summary.containsKey(driver.nationality)) {
        summary[driver.nationality] = 1;
      } else {
        summary[driver.nationality] = summary[driver.nationality]! + 1;
      }
    }

    List<Widget> nations = sortAndMakeNationList(summary);

    if (searchTextString.isEmpty) {
      driverCardsAndSummary.add(drawSummary(nations));
    }

    if (driverCardsAndSummary.isEmpty) {
      driverCardsAndSummary.add(const SizedBox(height: 30.00, child: Text("Not found anything"),));
    } else {
      driverCardsAndSummary.add(const SizedBox(height: 30,));
    }

    return Column(
      children: driverCardsAndSummary,
    );
  }

  Widget searchField() {
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final seasonRepository = Provider.of<SeasonRepository>(context, listen: false);
    SeasonModel? selectedSeason = seasonRepository.getSelectedSeason;

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
                    searchField(),
                    drawDriversAndSummary()
                  ],
                ),
              ),
            ),
          ),
          BackgroundTop(title: "${selectedSeason?.getShortYear} Grid"),
        ],
      ),
    );
  }
}
