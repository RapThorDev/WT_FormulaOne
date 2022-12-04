
import 'package:age_calculator/age_calculator.dart';
import 'package:f1_application/generated/assets.dart';
import 'package:f1_application/model/driver.dart';
import 'package:f1_application/provider/formula_one_provider.dart';
import 'package:f1_application/widget/BackgroundBottom.dart';
import 'package:f1_application/widget/BackgroundTop.dart';
import 'package:f1_application/widget/DriverCode.dart';
import 'package:f1_application/widget/FullPageLoading.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f1_application/countries.dart' as country;



class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({Key? key}) : super(key: key);

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FormulaOneProvider>(context, listen: false).fetchGoogleImage();
    });
  }

  Widget drawSeparate({required Color color, required double verticalMargin, required double width, double height = 2}) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(vertical: verticalMargin),
          decoration: BoxDecoration(
            color: color
          ),
        ),
      ],
    );
  }

  Widget drawName(String firstName, String lastName) {
    TextStyle textStyle = const TextStyle(
      color: Color(0xff000000),
      fontFamily: "Formula1",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          firstName,
          style: textStyle.copyWith(fontSize: 24),
        ),
        Text(
          lastName,
          style: textStyle.copyWith(fontSize: 48),
        )
      ],
    );
  }

  Widget drawGoogleImage() {
    final formulaOneProvider = Provider.of<FormulaOneProvider>(context);

    if (formulaOneProvider.isGoogleImageFetching) {
      return const FullPageLoading();
    }

    String imageUrl = formulaOneProvider.getGoogleImageUrl;
    double screenWidth = MediaQuery.of(context).size.width;

    if (imageUrl.isEmpty) {
      return Image.asset(Assets.imagesDefault, width: screenWidth * 0.9, fit: BoxFit.fitWidth,);
    }

    return Image.network(imageUrl, width: screenWidth * 0.9, fit: BoxFit.fitWidth,);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final formulaOneProvider = Provider.of<FormulaOneProvider>(context, listen: false);
    DriverModel driver = formulaOneProvider.getSelectedDriver;

    TextStyle textStyle = TextStyle(fontFamily: "Formula1");

    return Material(
      child: Stack(
        children: [
          const BackgroundBottom(),
          const BackgroundTop(title: ""),
          Align(
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
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          drawName(driver.firstName, driver.lastName),
                          Flag.fromCode(country.Countries.getByNationality(driver.nationality)["flagsCode"], width: 65, height: 50,)
                        ],
                      ),
                    ),
                    drawSeparate(width: screenSize.width * 0.925, color: const Color(0xff000000), verticalMargin: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          driver.code.isNotEmpty ? DriverCode(driverCode: driver.code) : Container(),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                driver.dateOfBirth,
                                style: textStyle.copyWith(fontSize: 24),
                              ),
                              Text(
                                "(age ${AgeCalculator.age(DateTime.parse(driver.dateOfBirth)).years})",
                                style: textStyle.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          driver.permanentNumber.isNotEmpty
                              ? Text(
                                  driver.permanentNumber,
                            style: textStyle.copyWith(fontSize: 24),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    drawSeparate(width: screenSize.width * 0.925, color: const Color(0xff000000), verticalMargin: 20),
                    drawGoogleImage(),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
