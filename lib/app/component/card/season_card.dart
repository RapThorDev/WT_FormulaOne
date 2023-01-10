import 'package:f1_application/generated/assets.dart';
import 'package:f1_application/lib/model/season.dart';
import 'package:f1_application/app/ui/grid/grid_page.dart';
import 'package:f1_application/lib/service/season/season_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:f1_application/util/intent_action.dart';


class SeasonCard extends StatelessWidget {
  const SeasonCard({Key? key, required this.season}) : super(key: key);

  final Season season;

  String getImagePath(String yearString) {
    int year = int.parse(yearString);

    if (year >= 2018) {
      return Assets.imagesF1Logo;
    } else if (year >= 1993) {
      return Assets.imagesF1Logo1993;
    } else if (year >= 1987) {
      return Assets.imagesF1Logo1987;
    } else if (year >= 1985) {
      return Assets.imagesF1Logo1985;
    } else {
      return Assets.imagesRectangle1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    const Radius radius = Radius.circular(15);

    const BorderRadiusGeometry leftRounded = BorderRadius.horizontal(left: radius);
    const BorderRadiusGeometry rightRounded = BorderRadius.horizontal(right: radius);

    const List<BoxShadow> boxShadows = [
      BoxShadow(
          color: Color(0xaa000000),
          offset: Offset(5, 5),
          blurRadius: 10
      )
    ];

    const BoxDecoration cardBodyDecoration = BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(0.5, 2),
            end: Alignment(1, 0),
            colors: <Color>[Color(0xff000000), Color(0x00000000)]),
        borderRadius: leftRounded
    );

    const TextStyle fontStyle = TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'OleoScript',
        fontWeight: FontWeight.w700,
        height: 1);

    double width = screenWidth * 0.9;
    double height = 115;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Provider.of<SeasonService>(context, listen: false).setSelectedSeason(season);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GridScreen()));
              },
              child: SizedBox(
                width: width * 0.8,
                height: height,
                child: Stack(children: <Widget>[
                  Positioned(
                      child: Container(
                        width: width * 0.85,
                        height: height,
                        decoration: cardBodyDecoration.copyWith(
                            image: DecorationImage(
                                image: AssetImage(getImagePath(season.year)),
                                fit: BoxFit.fitWidth),
                            boxShadow: boxShadows
                        ),
                      )),
                  Positioned(
                      child: Container(
                        width: width * 0.8,
                        height: height,
                        decoration: cardBodyDecoration,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              width > 500 ? season.year : season.shortYear,
                              textAlign: TextAlign.right,
                              style: fontStyle.copyWith(fontSize: 102, height: 0.3),
                            ),
                            const SizedBox(width: 10,),
                            Text(
                              'season',
                              textAlign: TextAlign.left,
                              style: fontStyle.copyWith(fontSize: 40),
                            )
                          ],
                        ),
                      )),
                ]),
              ),
            ),
            GestureDetector(
              onTap: () async {
                IntentAction.openUrl(season.wikiURL);
              },
              child: Container(
                  width: width * 0.1,
                  height: height,
                  decoration: const BoxDecoration(
                      borderRadius: rightRounded,
                      color: Color.fromRGBO(54, 158, 191, 1),
                      boxShadow: boxShadows
                  ),
                  child: Center(
                    child: Transform.rotate(
                      angle: -90 * (math.pi / 180),
                      child: Text(
                        'INFO',
                        textAlign: TextAlign.center,
                        style: fontStyle.copyWith(fontSize: 12, fontFamily: "Formula1"),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
