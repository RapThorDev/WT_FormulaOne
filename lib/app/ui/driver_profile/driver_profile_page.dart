import 'package:age_calculator/age_calculator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:f1_application/app/component/background/background_bottom.dart';
import 'package:f1_application/app/component/background/background_top.dart';
import 'package:f1_application/app/component/loading/full_page_loading.dart';
import 'package:f1_application/generated/assets.dart';
import 'package:f1_application/lib/datamanagement/repository/google_image_repository.dart';
import 'package:f1_application/lib/datamanagement/repository/grid_repository.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/app/ui/driver_profile/component/driver_code.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f1_application/util/countries.dart' as country;

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({Key? key}) : super(key: key);

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  @override
  void initState() {
    super.initState();
    Driver? selectedDriver = Provider.of<GridRepository>(context, listen: false).getSelectedDriver;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GoogleImageRepository>(context, listen: false).fetchGoogleImage(selectedDriver!.lastName);
    });
  }

  double flagWidth = 65;

  Widget separator(
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

  Widget drawName(String firstName, String lastName) {
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

  Widget drawGoogleImage() {
    final googleImageRepository = Provider.of<GoogleImageRepository>(context);

    if (googleImageRepository.isGoogleImageFetching) {
      return const FullPageLoading();
    }

    String? imageUrl = googleImageRepository.getGoogleImageUrl;
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

  Widget drawDriverProfile() {


    final gridRepository = Provider.of<GridRepository>(context, listen: false);
    Driver? selectedDriver = gridRepository.getSelectedDriver;

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
                      drawName(selectedDriver!.firstName,
                          selectedDriver!.lastName),
                      Flag.fromCode(
                        country.Countries.getByNationality(
                            selectedDriver!.nationality)["flagsCode"],
                        width: flagWidth,
                        height: 50,
                      )
                    ],
                  ),
                ),
                separator(
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
                      selectedDriver!.code.isNotEmpty
                          ? DriverCode(driverCode: selectedDriver!.code)
                          : Container(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            selectedDriver!.dateOfBirth,
                            style: textStyle.copyWith(fontSize: 24),
                          ),
                          Text(
                            "(age ${AgeCalculator.age(DateTime.parse(selectedDriver!.dateOfBirth)).years})",
                            style: textStyle.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      selectedDriver!.permanentNumber.isNotEmpty
                          ? Text(
                        selectedDriver!.permanentNumber,
                        style: textStyle.copyWith(fontSize: 24),
                      )
                          : Container(),
                    ],
                  ),
                ),
                separator(
                    width: screenSize.width * 0.925,
                    color: const Color(0xff000000),
                    verticalMargin: 20),
                drawGoogleImage(),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const BackgroundBottom(),
          const BackgroundTop(title: ""),
          drawDriverProfile(),
        ],
      ),
    );
  }
}
