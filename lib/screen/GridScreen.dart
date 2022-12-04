import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:f1_application/model/driver.dart';
import 'package:f1_application/model/season.dart';
import 'package:f1_application/provider/formula_one_provider.dart';
import 'package:f1_application/tools/BuildBlur.dart';
import 'package:f1_application/widget/BackgroundBottom.dart';
import 'package:f1_application/widget/BackgroundTop.dart';
import 'package:f1_application/widget/DriverCard.dart';
import 'package:f1_application/widget/FullPageLoading.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f1_application/countries.dart' as country;


class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FormulaOneProvider>(context, listen: false).fetchGrid();
    });
  }

  late AutoCompleteTextField searchTextField;
  TextEditingController searchController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<DriverModel>> key = GlobalKey();

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
    Size screenSize = MediaQuery
        .of(context)
        .size;

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
    final formulaOneProvider = Provider.of<FormulaOneProvider>(context);

    if (formulaOneProvider.isGridFetching) {
      return const FullPageLoading();
    }

    SeasonModel selectedSeason = formulaOneProvider.getSelectedSeason;
    List<DriverModel> driverList = formulaOneProvider.getDriverList;

    List<DriverModel> currentDrivers = [];
    for (var driverId in selectedSeason.driverIds) {
      currentDrivers.add(
          driverList.firstWhere((driver) => driver.id == driverId));
    }

    if (currentDrivers.isEmpty) {
      return Container();
    }

    List<Widget> driverCardsAndSummary = [];
    Map<String, int> summary = {};

    for (var driver in currentDrivers) {
      driverCardsAndSummary.add(DriverCard(driver: driver));

      if (!summary.containsKey(driver.nationality)) {
        summary[driver.nationality] = 1;
      } else {
        summary[driver.nationality] = summary[driver.nationality]! + 1;
      }
    }

    List<Widget> nations = sortAndMakeNationList(summary);

    if (searchController.text.isEmpty) {
      driverCardsAndSummary.add(drawSummary(nations));
    }

    driverCardsAndSummary.add(const SizedBox(height: 30,));

    return Column(
      children: driverCardsAndSummary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formulaOneProvider = Provider.of<FormulaOneProvider>(context, listen: false);

    SeasonModel selectedSeason = formulaOneProvider.getSelectedSeason;
    List<DriverModel> seasonDrivers = selectedSeason.driverIds.map((e) =>
        formulaOneProvider.getDriverList.firstWhere((element) => element.id == e))
        .toList(growable: false);

    Size screenSize = MediaQuery.of(context).size;

    searchTextField = AutoCompleteTextField<DriverModel>(
      itemSubmitted: (item) {
        setState(() {
          searchController.text = item.getFullName;
        });
      },
      key: key,
      suggestions: seasonDrivers,
      itemBuilder: (context, item) {
        return ListTile(
          title: Text(item.getFullName),
          subtitle: Text(
            "${item.dateOfBirth} ${item.nationality}"
          ),
          onTap: () {
            formulaOneProvider.setSearchedDriver(item);
          },
        );
      },
      itemSorter: (a, b) {
        return a.lastName.compareTo(b.lastName);
      },
      itemFilter: (item, query) {
        return item.getSearchableParams.toLowerCase().contains(query.toLowerCase());
      },
      style: const TextStyle(
          color: Color(0xff000000),
          fontSize: 16.00
      ),
      decoration: const InputDecoration(
        suffixIcon: SizedBox(
          width: 85.00,
          height: 60.00,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        filled: true,
        hintText: "Driver name, nationality or year of birth date",
        hintStyle: TextStyle(color: Color(0xff252525)),
      ),
      controller: searchController,
    );

    DriverModel? searchedDriver = formulaOneProvider.getSearchedDriver;

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
                    searchTextField,
                    searchedDriver == null ?
                    drawDriversAndSummary() : DriverCard(driver: searchedDriver)
                  ],
                ),
              ),
            ),
          ),
          BackgroundTop(title: "${selectedSeason.getShortYear} Grid"),
        ],
      ),
    );
  }
}
