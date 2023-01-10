
import 'package:f1_application/lib/service/grid/grid_service.dart';
import 'package:f1_application/lib/model/driver.dart';
import 'package:f1_application/app/ui/driver_profile/driver_profile_page.dart';
import 'package:f1_application/util/build_blur.dart';
import 'package:f1_application/util/intent_action.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:f1_application/util/countries.dart' as country;
import 'package:provider/provider.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({
    super.key,
    required this.driver
  });

  final Driver driver;


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double cardWidth = screenSize.width * 0.9;
    double cardHeight = 120;

    double firstNameFontSize = cardHeight * 0.13;
    double lastNameFontSize = firstNameFontSize * 1.5;
    double birthOfDateFontSize = cardHeight * 0.12;
    Size flagSize = Size(cardHeight * 0.2, cardHeight * 0.2);

    TextStyle textStyle = const TextStyle(
      color: Color(0xffffffff),
      fontFamily: 'Formula1',
    );

    return GestureDetector(
      onTap: () {
        Provider.of<GridService>(context, listen: false).setSelectedDriver(driver);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DriverProfileScreen()));
      },
      child: Container(
          width: cardWidth,
          height: cardHeight,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
              children: <Widget>[
                // Background
                Align(
                  alignment: Alignment.center,
                  child: buildBlur(
                    child: Container(
                        width: cardWidth*0.9,
                        height: cardHeight,
                        decoration: const BoxDecoration(
                          borderRadius : BorderRadius.all(Radius.circular(15)),
                          boxShadow : [BoxShadow(
                              color: Color(0xaa000000),
                              offset: Offset(5, 5),
                              blurRadius: 10,
                          )],
                          color : Color(0x88000000),
                        )
                    ),
                  ),
                ),
                // Name
                Positioned(
                    top: cardHeight * 0.1,
                    left: cardWidth * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.firstName,
                          textAlign: TextAlign.left,
                          style: textStyle.copyWith(fontSize: firstNameFontSize)
                        ),
                        Text(
                          driver.lastName,
                          textAlign: TextAlign.left,
                            style: textStyle.copyWith(fontSize: lastNameFontSize)
                        ),
                      ],
                    )
                ),
                // INFO Button
                Positioned(
                    bottom: cardHeight * 0.1,
                    right: cardWidth * 0.1,
                    child: GestureDetector(
                      onTap: () async {
                        IntentAction.openUrl(driver.wikiURL);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: cardWidth * 0.3,
                        decoration: const BoxDecoration(
                          borderRadius : BorderRadius.all(Radius.circular(10)),
                          color : Color(0xff369ebf),
                        ),
                        child: Text(
                          'INFO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xffffffff),
                            fontFamily: 'Formula1',
                            fontSize: lastNameFontSize,
                          ),
                        ),
                      ),
                    )
                ),
                // Separator
                Align(
                  alignment: Alignment.center,
                    child: Container(
                      width: cardWidth * 0.85,
                      height: 2,
                      color: const Color(0xffff0000),
                    )
                ),
                // Born date & Flag
                Positioned(
                    bottom: cardHeight * 0.1,
                    left: cardWidth * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.dateOfBirth,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0xffffffff),
                            fontFamily: 'Formula1',
                            fontSize: birthOfDateFontSize,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 0
                          ),
                        ),
                        Flag.fromCode(
                            country.Countries.getByNationality(driver.nationality)["flagsCode"],
                            height: flagSize.height,
                            width: flagSize.width,
                          )
                      ],
                    )
                ),
              ]
          )
      ),
    );
  }
}
