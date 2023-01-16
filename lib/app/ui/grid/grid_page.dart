import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/card/driver_card.dart';
import 'package:f1_application/app/component/loading/full_page_loading.dart';
import 'package:f1_application/app/ui/grid/components/summary.dart';
import 'package:f1_application/app/ui/grid/grid_view_model.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GridScreen extends StatefulWidget {
  const GridScreen({super.key, this.season});

  final Season? season;

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController searchTextController = TextEditingController();
  String searchTextString = "";
  GridViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = Provider.of<GridViewModel>(context, listen: false);
      _viewModel!.fetchGrid(int.parse(widget.season!.year));
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      setState(() {
        _viewModel = Provider.of<GridViewModel>(context);
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
          BackgroundTop(title: "${widget.season!.shortYear} Grid"),
        ],
      ),
    );
  }

  Widget _summary() {
    if (
    _viewModel!.isGridFetching
    || searchTextString.isNotEmpty
    || _viewModel!.drivers.isEmpty
    ) {
      return Container();
    }

    return const Summary();
  }

  Widget _drivers() {
    if (_viewModel!.isGridFetching) {
      return const FullPageLoading();
    }

    if (_viewModel!.errorReason != null) {
      return SizedBox(
        child: Text(
          "Error: ${_viewModel!.errorReason}"
        ),
      );
    }

    if (_viewModel!.drivers.isEmpty) {
      return const SizedBox(
        child: Text(
          "In this season not found any driver\n"
              "Come back later",
        ),
      );
    }

    List<Widget> driverCards = [];

    if (searchTextString.isEmpty) {
      driverCards = _viewModel!.drivers.map((driver) => DriverCard(driver: driver)).toList();
    } else {
      driverCards = _viewModel!.relevantDriversByExpression(searchTextString).map((Driver driver) => DriverCard(driver: driver)).toList();
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
