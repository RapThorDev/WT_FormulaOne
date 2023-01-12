import 'package:age_calculator/age_calculator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/loading/full_page_loading.dart';
import 'package:f1_application/generated/assets.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/app/ui/driver_profile/component/driver_code.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f1_application/util/countries.dart' as country;

import 'driver_profile_view_model.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({Key? key, this.driver}) : super(key: key);

  final Driver? driver;

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  double flagWidth = 65;
  DriverProfileViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = Provider.of<DriverProfileViewModel>(context, listen: false);
      _viewModel!.fetchDriverProfileImage(widget.driver!.lastName);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      setState(() {
        _viewModel = Provider.of<DriverProfileViewModel>(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const BackgroundBottom(),
          const BackgroundTop(title: ""),
          _driverProfile(),
        ],
      ),
    );
  }

  Widget _separator(
      {required Color color,
        required double verticalMargin,
        required double width,
        double height = 2}) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(vertical: verticalMargin),
          decoration: BoxDecoration(color: color),
        ),
      ],
    );
  }

  Widget _driverName(String firstName, String lastName) {
    TextStyle textStyle = const TextStyle(
      color: Color(0xff000000),
      fontFamily: "Formula1",
    );

    double screenWidth = MediaQuery.of(context).size.width;
    double nameMaxWidth = screenWidth * 0.9 - flagWidth;

    return SizedBox(
      width: nameMaxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AutoSizeText(
            firstName,
            maxLines: 1,
            style: textStyle.copyWith(fontSize: 24),
          ),
          AutoSizeText(
            lastName,
            maxLines: 1,
            style: textStyle.copyWith(fontSize: 48),
          )
        ],
      ),
    );
  }

  Widget _driverProfileImage() {
    if (_viewModel!.isDriverProfileFetching) {
      return const FullPageLoading();
    }

    String? imageUrl = _viewModel!.imageUrl;
    double screenWidth = MediaQuery.of(context).size.width;

    if (imageUrl == null || imageUrl.isEmpty) {
      return Image.asset(
        Assets.imagesDefault,
        width: screenWidth * 0.9,
        fit: BoxFit.fitWidth,
      );
    }

    return Image.network(
      imageUrl,
      width: screenWidth * 0.9,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _driverProfile() {
    Size screenSize = MediaQuery.of(context).size;

    TextStyle textStyle = TextStyle(fontFamily: "Formula1");

    return Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _driverName(widget.driver!.firstName,
                          widget.driver!.lastName),
                      Flag.fromCode(
                        country.Countries.getByNationality(
                            widget.driver!.nationality)["flagsCode"],
                        width: flagWidth,
                        height: 50,
                      )
                    ],
                  ),
                ),
                _separator(
                    width: screenSize.width * 0.925,
                    color: const Color(0xff000000),
                    verticalMargin: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.driver!.code.isNotEmpty
                          ? DriverCode(driverCode: widget.driver!.code)
                          : Container(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.driver!.dateOfBirth,
                            style: textStyle.copyWith(fontSize: 24),
                          ),
                          Text(
                            "(age ${AgeCalculator.age(DateTime.parse(widget.driver!.dateOfBirth)).years})",
                            style: textStyle.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      widget.driver!.permanentNumber.isNotEmpty
                          ? Text(
                        widget.driver!.permanentNumber,
                        style: textStyle.copyWith(fontSize: 24),
                      )
                          : Container(),
                    ],
                  ),
                ),
                _separator(
                    width: screenSize.width * 0.925,
                    color: const Color(0xff000000),
                    verticalMargin: 20),
                _driverProfileImage(),
              ],
            ),
          ),
        ));
  }
}
